---
title: "The second SHA collision"
tags:
  - security
  - zero-day
old-link: https://privacylog.blogspot.com/2019/12/the-second-sha-collision.html
comments:
  - link: https://privacylog.blogspot.com/2019/12/the-second-sha-collision.html#comment-8117894812164938956
    name: RobIII
    text: "SHA collisions are EXPECTED. Rare, of course, but expected nonetheless. So you stumbled upon one (and [a debatable one](https://news.ycombinator.com/item?id=21919559) at that). Whooptee-doo... Let us know when you can *create* one on demand."
  - link: https://privacylog.blogspot.com/2019/12/the-second-sha-collision.html#comment-1265900689692792610
    name: Aaron Toponce
    text: "The first 320 bytes you provide here are already mentioned in the original shattered.io paper. After those first 320 bytes are synchronized, the state remains synchronized if extended with identical data. AKA extension attacks. This post is just a re-posting of the discovery in the shattered.io paper. Find a collision with a different set of 320 bytes, and then you&#39;ll have something. Otherwise, this post is misleading its readers who don&#39;t dig into the shattered.io paper."
---

These are two small files which are different but have the same SHA-1 sum. And we're breaking the news here on Privacy Log.

- [File 1](https://phor.net/PUB/shat-a.bin) f92d74e3874587aaf443d1db961d4e26dde13e9c — 320 bytes
- [File 2](https://phor.net/PUB/shat-b.bin) f92d74e3874587aaf443d1db961d4e26dde13e9c — 320 bytes

## Background

Of course the first SHA-1 collision was reported by Marc Stevens, Elie Bursztein, Pierre Karpman, Ange Albertini, and Yarik Markov at <https://shattered.io>.

## What's going on here

As far as I know, this is the second and the smallest SHA-1 collision ever publicly demonstrated.

It is extracted from the preix of files presented in the original paper.

You can test it with:

```sh
shasum shat*; cmp shat*
```

Processing power used: none. No brute force processing was necessary to generate these two files based on the other files above.

## Why is this important

Some systems still use SHA-1 for security or error checking. Maybe you can use these two files to break security or cause errors. They may be more useful than the original files presented in the paper. Have fun!
