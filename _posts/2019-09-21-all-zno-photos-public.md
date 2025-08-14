---
title: "Zno customer uploaded photos are public, again"
tags: ["security", "zero-day"]
old-link: https://privacylog.blogspot.com/2019/09/zno-user-uploaded-photos-are-publicly.html
---

This is a 0-day announcement showing how photos that are presumably private and uploaded to Zno for printing can be publicly accessed.

## Nature of bug

Photos which are uploaded to the photo printing website can be accessed by the public.

## Steps required

- Access the URL <https://upload.zno.com/upload/servlet/ProofBookCoverServlet?projectId=XXXXXX> where XXXXXX is some six-digit number.

At this point you will be viewing a photo uploaded to the photo printing service by a random customer.

## Enumeration

It would be possible to automate this process to download many photos from Zno customers.

## Tools used to discover bug

I have viewed the URLs accessed while using the Zno website.

## Test date

September 2019

## Disclosure schedule

- 2018-04-01: Discovery
- 2019-09-13: Verified discovery still valid
- 2019-09-14: Notified vendor by email at&nbsp;<support@zno.com> with 7-day release schedule
- 2019-09-21: Disclosed publicly on Privacy Log
- 2020-07-10: Confirmed vulnerability still active
