---
title: "Will's ZKSNARKS bibliography"
tags: ["blockchain", "list"]
old-link: https://fulldecent.blogspot.com/2019/10/wills-zksnarks-bibliography.html
---

- Cryptology ePrint Archive: Report 2013/879 - Succinct Non-Interactive Zero Knowledge for a von Neumann Architecture

  - BCTV14

  - <https://eprint.iacr.org/2013/879>

  - > Our circuit generator is the first to be *universal*: it does not need to know the program, but only a bound on its running time. Moreover, the size of the output circuit depends *additively* (rather than multiplicatively) on program size, allowing verification of larger programs.

  - > We evaluated our system for programs with up to 10,000 instructions, running for up to 32,000 machine steps, each of which can arbitrarily access random-access memory; and also demonstrated it executing programs that use *just-in-time compilation*. Our proofs are 230 bytes long at 80 bits of security, or 288 bytes long at 128 bits of security. Typical verification time is 5 milliseconds, regardless of the original program’s running time.

- What are zk-SNARKs? / Zcash

  - <https://z.cash/technology/zksnarks/>
  - Homomorphic Hiding Blind Evaluation of Polynomials The Knowledge of Coefficient Test and Assumption How to make Blind Evaluation of Polynomials Verifiable From Computations to Polynomials The Pinocchio Protocol Pairings of Elliptic Curves

- Introduction to zkSNARKs with Examples – ConsenSys Media

  - Christian Lundkvist
  - Example to prove transfer of funds, publish the hashes, ERC-20
  - <https://media.consensys.net/introduction-to-zksnarks-with-examples-3283b554fc3b>
  - ⚠️ The sending and receiving function can be combined. Just make it a hashed adding function.
  - Example: <https://github.com/ConsenSys/zero-knowledge-proofs?files=1>
  - ⚠️ Typo greater than or equal to

- Creating fake zkSNARK proofs - Kobi Gurkan - QED-it

  - <https://medium.com/qed-it/how-toxic-is-the-waste-in-a-zksnark-trusted-setup-9b250d59bdb4>

- On the Size of Pairing-based Non-interactive Arguments⋆

  - <https://eprint.iacr.org/2016/260.pdf>

- Proving Knowledge of a Hash Pre-Image with ZoKrates

  - <https://blog.decentriq.ch/proving-hash-pre-image-zksnarks-zokrates/>

- Introduction to zk-SNARKs (Part 1)

  - <https://blog.decentriq.ch/zk-snarks-primer-part-one/>
  - Eventually, this will result in an end-to-end zero-knowledge proof for a toy problem, following the Pinocchio protocol and implemented in Python.

- Explaining SNARKs Part I: Homomorphic Hidings - Zcash
  - <https://z.cash/blog/snark-explain>
  - Typo ,..,

## Hacks / issues

- Explain that somebody can publish their hashes to prove how much they sent or received from a counter party
