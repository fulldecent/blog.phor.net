---
title: "Security case study: Hashes for popular router passwords"
tags: ["security"]
old-link: https://privacylog.blogspot.com/2009/11/hashes-for-popular-router-passwords.html
comments:
  - link: https://privacylog.blogspot.com/2009/11/hashes-for-popular-router-passwords.html#comment-2467102220897117998
    name: Anonymous
    text: These are not even hashes, just plain base64, completely reversible...
  - link: https://privacylog.blogspot.com/2009/11/hashes-for-popular-router-passwords.html#comment-8415597228116597223
    name: William Entriken
    text: Correct. Just posting the list to be googlable if anyone doesn't want to bother.
---

The full list [is here](https://phor.net/fun/routerpasswords-base64).

| Base64 | Plaintext |
|--------|--|
| YWRtaW46cGFzc3dvcmQ= | admin:password |
| YWRtaW46UGFzc3dvcmQ= | admin:Password |
| YWRtaW46YWRtaW4= | admin:admin |
| YWRtaW46 | admin: |

So what's the case study result? Don't trust security by obscurity. And always use salt with your hashes.
