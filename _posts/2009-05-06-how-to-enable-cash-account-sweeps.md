---
title: "Zecco case study: how to enable cash account sweeps"
tags: 
  - security	
old-link: https://privacylog.blogspot.com/2009/05/how-to-enable-cash-account-sweeps-in.html
---

This also serves as a short lesson in client-side validation/server-side validation. I could write a lot more on that topic, but not today.

First, go into the Funding and Transfers tab to set up a withdraw and choose "Available Balance":

![Funding and Transfers](/assets/images/2009-05-06-how-to-enable-cash-account-sweeps.webp)

Then, use a JavaScript console, or a client side tool to change the Frequency to "Weekly" and submit*:

![Change Frequency](/assets/images/2009-05-06-how-to-enable-cash-account-sweeps-2.webp)

This is not the most straightforward way of using the website. However, I consider this is a legitimate and useful feature. *If you don't know how to accomplish this, you are not the intended audience here, but a first hint would be for you to use Chrome and access the Developer Tools menu item.

Disclaimer:

This is not a way of using the site to be a "work-around that is considered confidential and proprietary to Zecco", nor a "reverse engineering, disassembly or decompilation embodying Zecco's confidential information".
