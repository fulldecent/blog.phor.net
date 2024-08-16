---
title: "Firefox zero-day: You can't leave this page (2)"
tags: ["zero-day", "security"]
comments:
 - link: https://x.com/fulldecent/status/1824510778520526923
   name: '@fulldecent'
   text: The official X thread
---

This a 0-day announcement showing web pages can prevent visitors from navigating back away from their website.

## Nature of bug

Visitors cannot navigate back using the back button, the keyboard short cut for navigating, or dedicated mouse buttons/gestures for navigating back.

## Affected software

Firefox 129.0.1 64-bit on macOS and possibly more.

## Steps required

1. Include this minimal snippet on a web page "B":

   ```html
   location.search||fetch(0).then(a=>location='?x');
   ```

2. Visit any other webpage "A".

3. Access a link on "A" to the affected page "B".

4. Attempt to navigate back to webpage "A".

## Tools used to discover bug

This was found when creating a JavaScript snippet to handle redirects for a simple replacement for A/B tests that our team used to run with Google Optimize.

## Discussion

It appears that Firefox employs hueristics or other logic to allow back navigation even when a web page is doing redirects to prevent this.

I found that the main effective element here in the minimal exploit code is the `async` function. The `fetch` function is effective for here, as well as `crypto.subtle.digest`. However some other `async` functions that we tried did not exhibit the bug, such as the most straightforward `await Promise.resolve(true)`. 

I also golfed the exploit, this may make it applicable in more contexts such as with user-generated content. Golfing is a team sport, so do share if you find a shorter vector!

## Test date

August 2024

## Disclosure timeline

* 2024-07-24 Discovery
* 2024-08-01 [Disclosure](https://bugzilla.mozilla.org/show_bug.cgi?id=1913514) to Firefox's vendor Mozilla using Bugzilla
