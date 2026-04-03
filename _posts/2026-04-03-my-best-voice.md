---
title: "My best voice"
tags:
  - ethics
  - best-practice
---

I have not always followed this guide. That’s fine. Progress starts from documenting what works.

This guide collects the voice and style I use when the writing feels most inspired—when it launches standards, templates, and ideas that other people actually adopt and resonate with.

We are contemplative and intentional about voice because we respect the reader. When writing for a community or project, that respect extends further: it honors their interests and proposes a thoughtful place for them in the world.

My *voice* is therefore direct, practical, and opinionated, always aimed at solving real problems while respecting you—the reader—as a collaborator rather than an audience. It mixes precision where it matters with conversational warmth, draws from the spare clarity and wonder of XKCD.

My *style* is the practical toolkit that supports this: short active sentences, liberal use of lists, tables, diagrams, and clean typography that makes complex ideas immediately usable.

The sections below lay it out in detail with high-level prose patterns, low-level typography and capitalization rules, human interface best practices, and how to apply this guide in your own work or contributions.

## High-level prose patterns

My voice is direct, practical, and opinionated. I write to solve problems and to inspire others to create better things. Sentences stay short and active. I address **you**, the reader, directly because this is a conversation, not a lecture.

I emphasize best practices and production readiness. You will see phrases such as “awesome reusable modules” or “opinionated starting point” because I believe in setting high standards from day one. I use lists, tables, and diagrams liberally. They make complex ideas immediately usable.

I mix formality where precision matters (see the ERC-721 specification) with conversational warmth where ideas are forming. The common thread is clarity. I avoid fluff. If a sentence does not add value or move the reader forward, I delete it.

I draw inspiration from XKCD: profound wonder, analysis and humanity. When I put something to words, I want you to feel the same sense of possibility I felt when I first came at the problem.

**When creating a standard, template, or invitation to adopt a specification** I always start with a clear value proposition: why this particular interface deserves to exist and what real-world problem it solves for producers and consumers. Only after that do I deliver an extremely clear and valid list of behaviors.

This pattern appears throughout my work. In ERC-721 the abstract opens with the concrete benefit (“a standard API for NFTs… to track and transfer”) and immediately paints the diverse universe of use cases so readers can picture their own. The specification then uses RFC-2119 keywords (“MUST”, “SHALL”, “SHOULD”) to define exact behaviors with zero ambiguity. The same flow lives in the swift6-module-template README: value proposition first (“opinionated starting point for awesome, reusable Swift 6 modules”), followed by a bullet list of features and turnkey setup steps.

The reasoning is simple: when you invite people to plug into a community or ecosystem, you must speak in *their* language and give them a clear, respectful connection plan that considers their actual needs. Standards only deserve to be written when multiple people already adhere to them and others depend on the surface area of that interface. (See the full reasoning in “[What kinds of things should be standardized?](https://blog.phor.net/things-that-should-be-standardized)”.) The goal is interoperability that reduces waste, not contrived rules that nobody asked for. I therefore maintain the same disciplined documentation style I expect others to follow—precise, readable, and ready for production.

**Deriving authority through references and best practices** I build credibility by openly recognizing excellent work wherever I find it. I keep a consistent “references” or “best practices” section in almost every project. By naming the inspired souls whose ideas resonate with me, my voice joins a larger chorus and we become louder. You will see this in the swift6-module-template (which cites Swift project recommendations and links to its own Recipe.md), the github-pages-template, and many other repositories. The section is never an afterthought; it is how I show respect for the people who came before and invite others to stand on the same shoulders.

Examples of this full voice appear in:

- The ERC-721 abstract and motivation sections, which explain non-fungible tokens with real-world analogies and invite you to dream up new use cases.
- The swift6-module-template and github-pages-template READMEs, which list features immediately then give step-by-step instructions.
- Blog posts that turn personal reflection or technical research into actionable advice.

## Style guide

Here are the scales and chords that play in this voice.

### Use active voice

- ❌ This report was unable to be sent.
  - ❓ Did anybody specify that a report was due by a certain time?
  - ❓ Does the sender recognize their prior committment to send the report?
  - ❓ Did the sender actually start to send the report?
  - ❓ Did the sender not send the report because they forgot or some extenuating circumstance?
  - ❓ Did the sender send the report but actually the software or network failed to deliver it?
  - ❌ This note does not contribute whatsoever to improving the situation in the future.
  - ❌ This note is powerless, just like "it did not rain today" recognizes only God decides the weather.
- ✅ I failed to send this report on time.
  - ✅ The sender recognizes ("on time") that a report was due by a certain time.
  - ✅ The sender confirms ("I failed") a prior committment which they made.
  - ✅ The sender acknowledges ("failed to send") they are the reason the report was not sent on time.

Microsoft Word 95 warned you (your parents?) tirelessly about passive voice. But as corporate bullshitspeak takes over, passive sentence structure buries accountability and lowers our expectations of people we are talking with.

In east Asian and especially Filipino culture, people use passive voice in the example above to:

- Avoid shame (this is prideful and places one's image over the mission of the team 🙁)
- Avoid confrontation and create harmony (a harmony based on polite words is less valuable that one based on polite actions 🙁)

In this light, <mark>we use active voice to be humble, promote cooperation and respect the long-term relationships with our collaborators</mark>.

## Low-level typography and capitalization

Follow these rules everywhere unless a specific project (such as an academic paper) requires otherwise:

- Use uppercase letters only at the start of sentences, for proper nouns, and for initialisms. Everything else stays lowercase. (This produces clean, readable prose.)
- Do not use the Oxford comma.
- Preserve typos when formatting chat conversations exactly as shown in the blog repository style guide.
- Cite US court cases in Bluebook style.

Markdown usage follows these conventions:

- Headings use sentence case.
- Bold for emphasis.
- Italics for gentle stress, sarcasm and introduction of words with added baggage.
- Bullet lists and numbered lists for any sequence of actions or features.
- Code blocks and inline code for every technical element.
- Tables for comparisons or configuration variables.
- Emojis used sparingly (✅ for status, ℹ️ for notes) to add visual cues without clutter.
- Margin notes on the right side of blog pages when useful (via the .margin-note class).

For web documents, I maintain consistent notes about how to create slugs and images (here is [an example for this blog](https://github.com/fulldecent/blog.phor.net/blob/fb58b4b81f24962f7bbcdb76d1e19648b1131018/README.md#article-images)).

## HIG best practices (in brief)

Human interface guidelines here mean making documentation and interfaces instantly usable. The principles appear throughout my templates and standards work:

- Provide turnkey working code or examples immediately.
- Include testing, linting, and CI from day one.
- Use semantic versioning, changelogs, and clear folder structures.
- Make setup reproducible with environment variables or Docker containers.
- Test hyperlinks, structured data, and accessibility as part of every build.
- Prefer permanent, stable URLs even when content evolves.

These practices come from real-world experience shipping Swift modules, Ethereum standards, and Jekyll sites. They reduce friction for contributors and end users alike.

## How to use this guide

Every person has a voice. Document it somewhere, preferably online.

Communities and organizations (if we shall anthropomorphize them) have voices too. Document it somewhere, preferably online.

At a minimum, your copy editor will then have a basis for holding you accountable. And better, they can find if your voice has grown, and distill that insight into... a pull request against that documentation!
