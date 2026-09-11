---
title: "A semantic sidecar for the C ABI"
tags: ["programming"]
comments: []
---

The C ABI is the lingua franca of compiled software. Every language that wants to call a shared library — Python, Rust, Go, Swift, Java via JNI — ultimately speaks C calling conventions. But the C ABI only describes *mechanics*: which registers hold arguments, how the stack is laid out, how structs are aligned. It says nothing about *semantics*: who owns a pointer, how errors are signaled, when memory should be freed.

This gap causes real bugs, and closing it doesn't require a new ABI. It requires a machine-readable sidecar that travels with the library binary.

## What the C ABI actually is

It's a calling convention. Arguments go into registers or the stack in a defined order. Return values come back in `rax` (or `r0`, etc.). Structs are laid out with defined alignment and padding. Each OS and architecture has its own variant — System V AMD64 for Linux and macOS x86-64, the Windows x64 convention, AAPCS for ARM.

This is fine. The mechanics work. Nobody needs to replace them.

## What the C ABI does not express

**Ownership.** A function returns `char*`. Must the caller free it? With `free()`? With a library-specific destructor? Or is it a borrowed pointer into some internal buffer that the caller must not touch? The ABI has no opinion. Neither does the function signature. You read the docs — if they exist.

In practice there are at least five ownership modes, not just two:

1. Caller owns, callee borrows (most common — "I'm lending you this, don't free it")
2. Caller transfers ownership to callee ("it's yours now, you free it")
3. Callee allocates, caller receives ownership (return values)
4. Shared ownership (reference counted — multiple owners, last one frees)
5. Static/global (nobody frees it, it lives forever)

**Destructors.** Even if you know who owns a pointer, you need to know *how* to free it. `free()` might be wrong — the memory might come from a custom allocator, a pool, or another language's runtime. So you need either a universal convention that all memory uses a single shared allocator, or a destructor callback paired with each transferred pointer.

This is what COM solved in 1993 with `IUnknown::Release()` — every object carries a vtable with its own destructor. It works, but it's heavyweight and language-specific.

**Error conventions.** Some functions return -1 for error. Some return NULL. Some set `errno`. Some use HRESULT. Some take an out-parameter. The ABI doesn't standardize this, and probably shouldn't — error handling philosophy differs by language. But the *contract for a specific function* should be machine-readable, not buried in prose documentation.

**Nullability.** Can this `char*` be NULL? The type doesn't tell you.

**Struct evolution.** Add a field to a struct and you break every consumer that was compiled against the old layout. The Windows API solved this decades ago with `cbSize` fields — the struct carries its own size so the callee can detect which version it received. But this is a convention, not something the ABI enforces.

**Sum types in returns.** A function might return either a valid pointer or an error code. C programmers shoehorn this into `intptr_t` or use tag structs. If the ABI supported tuple returns (and some do — System V AMD64 can return two values in `rax` + `rdx`), sum types become natural: return (tag, value) where the tag says which interpretation is valid.

## Why not just write a new ABI?

Because the C ABI is entrenched in a way that makes replacement nearly impossible. Consider:

Python's C extension ecosystem — NumPy, pandas, pycryptodome, thousands of others — compiles against CPython's C API, which sits on top of the C ABI. A project like RustPython (a Python interpreter written in Rust) can't load these extensions because its internal object layout differs from CPython's. It's not technically impossible to build a compatibility shim — PyPy proved this with `cpyext` — but every C API call crosses a translation boundary, costing 3−5× overhead.

This is the same dynamic that killed Python 4. The Python 2 to 3 migration took roughly a decade (2008–2020). The core team has said "never again." Instead, Python evolves within the 3.x line, and the C API is being gradually narrowed via the stable ABI (PEP 384) so that internals can eventually change without breaking extensions.

Swift shipped a stable ABI in version 5.0, and it's more sophisticated than C's — reference counting conventions, resilient struct layout, witness tables for generics. But it's Swift-specific, not a universal replacement.

The WebAssembly component model is the most credible candidate for a next-generation cross-language interface. It defines a portable type system with proper strings, lists, variants (sum types), and ownership semantics. But it targets Wasm runtimes, not native code.

A universal native replacement for the C ABI would need adoption from every OS, every CPU vendor, every compiler, and every existing library. That's a decades-long coordination problem, not a technical one.

## The pragmatic answer: a semantic sidecar

Instead of replacing the ABI, describe it. Ship a machine-readable metadata blob alongside (or embedded in) every shared library that captures the semantics the C ABI omits.

The format: a protobuf-encoded binary section (`.abi_semantics` in ELF, a custom segment in Mach-O) embedded directly in the library file. Before encoding, the source of truth is a JSON file that looks like this:

```json
{
  "abi_semantics": "0.1.0",
  "functions": {
    "foo_create": {
      "returns": {
        "type": "pointer",
        "ownership": "caller",
        "nullable": false,
        "destructor": "foo_destroy"
      }
    },
    "foo_process": {
      "params": {
        "ctx": { "ownership": "borrowed", "nullable": false },
        "data": { "ownership": "transferred", "destructor": "free" }
      },
      "returns": {
        "type": "struct",
        "error_convention": { "field": "status", "success_value": 0 }
      }
    },
    "foo_destroy": {
      "params": {
        "ptr": { "ownership": "transferred", "nullable": true }
      }
    }
  }
}
```

For each function: which parameters are borrowed vs. transferred, what destructor pairs with what type, how errors are signaled, which pointers can be null, and what lifetime relationships exist between parameters and return values.

## The toolchain: two pieces, no compiler changes

**Piece one: an embedder.** A standalone CLI tool that takes a compiled library and a JSON file, encodes the JSON to protobuf, and writes it into a new binary section in the library:

```
abi-annotate libfoo.so semantics.json
```

This uses standard ELF/Mach-O section manipulation — the same mechanism that `objcopy --add-section` already supports. No compiler plugin needed. No build system integration required. It's a post-link step.

A corresponding extractor reads the section back out:

```
abi-extract libfoo.so > semantics.json
```

**Piece two: a checker.** On the consumer side, a static analysis tool reads the embedded semantics and verifies that calling code respects them. Does the caller free a pointer it received with `ownership: caller`? Does it use the right destructor? Does it check the error field before accessing the return value?

This checker could be a standalone linter, a Clang plugin, a Rust `bindgen` enhancement, or — and this is the interesting part — an LLM prompt.

## Why an LLM replaces half the toolchain

Traditionally, to extract semantic annotations from source code, you'd need a Clang plugin for C, a Rust analyzer plugin for Rust, a GObject introspection scanner for GLib code, and so on. Each one is expensive to build and maintain.

An LLM can read a C header and source file and produce the JSON file. It can infer ownership from naming conventions (`create`/`destroy` pairs), from comments (`/* caller must free */`), from patterns (`if (ptr == NULL) return -1`). One prompt works for any source language.

On the consumer side, the same applies: "here is the ABI semantics JSON for libfoo, and here is my Python code that calls it via ctypes — verify I'm handling ownership and errors correctly."

This isn't a replacement for formal verification. But it's a viable minimum viable product that requires building exactly one tool (the embedder/extractor) and writing exactly one document (the JSON schema spec plus LLM guidance for producing and consuming it).

## The ABI boundary is where memory safety fails

Modern languages have largely solved memory corruption within their own boundaries. Rust's borrow checker eliminates use-after-free and double-free at compile time. Swift's ARC automates reference counting. Go's garbage collector handles deallocation entirely. But these are all *intra-language* safety mechanisms. They enforce invariants within their own compilation model. The moment you call `extern "C"`, you step outside the model.

In Rust, every FFI call is `unsafe` — not as a bureaucratic formality, but because the compiler literally cannot verify anything about what happens on the other side of the C ABI boundary.

There is real-world data behind this. Google's Android security team has been tracking memory safety vulnerabilities as they incrementally rewrite Android components from C/C++ to Rust. Their findings, published on the [Google Security Blog](https://security.googleblog.com/2024/09/eliminating-memory-safety-vulnerabilities-Android.html), show that memory safety vulnerabilities dropped as Rust adoption increased — but the *remaining* vulnerabilities clustered at the boundaries between safe and unsafe code, including FFI boundaries. The bugs didn't disappear; they migrated to the seams.

The Chromium project tells a similar story. Chrome's security team has published a detailed analysis of memory safety in the browser, finding that roughly 70% of serious security bugs are memory safety issues. As they've introduced Rust and safe C++ abstractions, the attack surface concentrates at the interfaces between trust domains — and language boundaries are exactly that. Their [memory safety documentation](https://www.chromium.org/Home/chromium-security/memory-safety/) tracks this ongoing effort.

Apple has spent enormous engineering effort on the `__bridge`, `__bridge_retained`, and `__bridge_transfer` annotations specifically to document ownership transfer at the Swift/Objective-C boundary. These annotations are essentially a manual, source-level semantic sidecar — exactly the kind of metadata that should be machine-readable and embedded in the binary.

The specific failure modes at ABI boundaries are predictable:

- **Use-after-free across boundaries.** Rust frees a struct, but a C library still holds a pointer to it. Or the C library frees something, and Rust still has a reference. The borrow checker can't see across the `extern "C"` call.
- **Lifetime mismatch.** A C function returns a pointer into an internal buffer. The consumer wraps it in a safe type with no lifetime constraint. The C library invalidates the buffer on the next call. The consumer dereferences a dangling pointer with no compiler warning.
- **Double-free.** Both sides think they own the memory. Rust drops a `Box` that was allocated by `malloc` on the C side, or both sides call their respective free functions.
- **Allocator mismatch.** C allocates with `malloc`, Rust frees with its own allocator. This corrupts the heap silently and crashes later in an unrelated place.
- **Null pointer disagreement.** C returns NULL to signal an error. The consumer doesn't check and constructs a reference from it.

These are all cases where a machine-readable ownership contract — the semantic sidecar — would make the violation detectable without either side needing access to the other's source code.

## Proving it works: retroactive CVE analysis

A concrete way to validate the sidecar concept is to test it against real vulnerabilities. The methodology:

**Step 1: collect.** Gather CVEs where the root cause is a memory safety issue (use-after-free, double-free, buffer overrun, null dereference) that manifests at or near an ABI boundary. Good sources include Android security bulletins (which tag Rust/C++ boundary issues), Chrome CVEs, Python CPython extension vulnerabilities, and any project using Rust FFI to C libraries such as curl or OpenSSL bindings.

**Step 2: produce the metadata.** For each CVE, take the *producer* library's source code and use an LLM to generate the semantic JSON for the relevant functions. The LLM only sees the producer side — headers, source, and comments. It does not see the consumer code.

**Step 3: check the consumer.** Take the *consumer* code and check whether it respects the JSON contract. The checker (LLM or static analyzer) only sees the consumer code plus the JSON. It does not see the producer source.

**Step 4: adjudicate.** For each CVE, determine whether the LLM-produced JSON correctly captured the contract, whether the violation is detectable from the consumer side given only the JSON, and whether the bug was a producer-side contract violation (the library broke its own guarantees) or a consumer-side violation (the caller misused the API).

**Step 5: score.** What fraction of the CVE dataset would the sidecar have prevented?

This methodology has several strengths. It uses real bugs, not contrived examples, so there's no selection bias. It demonstrates the "two-sided blind" property — neither the producer LLM nor the consumer checker needs the other's source code; only the JSON mediates. It naturally separates producer bugs from consumer bugs, which is interesting on its own. And any CVE where the JSON couldn't have helped reveals a schema gap, which improves the spec.

The result is publishable regardless of whether full tooling is built. The finding would be: "We annotated N libraries involved in M CVEs with semantic metadata, and found that X% of ABI-boundary memory safety vulnerabilities would have been detectable by checking the consumer code against the metadata alone."

Based on the failure modes listed above, a reasonable expectation is that 80–90% of ABI-boundary memory safety bugs fall into categories the sidecar can express: ownership, destructors, nullability, and lifetime constraints. The remaining 10–20% involve concurrency, complex callback lifetime interactions, or global mutable state — cases that even source-code-level review struggles with.

## Prior art

This idea isn't entirely new. Each of these systems solved part of the problem:

- **Microsoft SAL annotations** (`_In_`, `_Out_`, `_Owns_`, `_Must_inspect_result_`): machine-readable for MSVC's static analyzer, but proprietary and C/C++-specific.
- **GObject introspection (GIR)**: XML files describing C API semantics including `transfer-ownership="full"` vs `"none"`. Used to auto-generate bindings for Python, JavaScript, and Rust. This is the closest existing realization of the sidecar idea, but it's tied to the GObject type system.
- **DWARF debug info**: describes types and memory layout in binary sections, but says nothing about ownership or error semantics.
- **WebAssembly interface types (WIT)**: rich cross-language type descriptions with ownership, but targeting Wasm, not native code.

What none of these provide is a language-agnostic, framework-agnostic annotation format for arbitrary C ABI libraries that can be embedded in the binary itself and consumed by any tool on either side of the boundary.

## The schema

A useful schema needs to cover these domains:

1. **Ownership**: borrowed, transferred, shared (refcounted), static — per parameter and return value
2. **Destructors**: which function frees which type, paired explicitly
3. **Error conventions**: per function, how failures are signaled and what the caller must check
4. **Lifetime relationships**: "this returned pointer is valid only as long as parameter 0 is alive"
5. **Nullability**: per pointer parameter and return value
6. **Struct versioning**: which fields exist at which version, size-based or tag-based evolution rules

This is small enough to specify in a single RFC-style document and expressive enough to annotate the real-world C libraries that matter: zlib, OpenSSL, SQLite, libpng, libcurl.

## Adoption without a flag day

The beauty of a sidecar is that it's purely additive. Libraries without the section work exactly as they do today. Libraries with it get better static analysis, better auto-generated bindings, and better LLM-assisted code review — but nothing breaks if the section is absent.

A library can ship both: the same old C ABI symbols for compatibility, plus the embedded semantics for tools that know how to read them. Consumers that don't understand the section ignore it. Consumers that do are safer.

This is a small enough project that one person could prove it out in a few weeks: define the JSON schema, build the embedder/extractor CLI, annotate a handful of well-known C ABI libraries (compiled from C, Rust, C++, or any other language), and demonstrate the LLM-based producer and checker. The hard part, as always, isn't the tooling — it's getting adoption.

But the coordination cost is low because there's nothing to break. You just start annotating libraries, one at a time, and the value accrues to everyone who reads the annotations.
