---
title: "Chase credit card privacy fail—email with transaction details"
tags: ["security"]
old-link: https://privacylog.blogspot.com/2015/06/chase-credit-card-privacy-fail-email.html
---

If you still use email, you are surely pinged with countless messages to notify you of updated activity on a website that it would like you to come see. Some of them are shameless clickbait, like Slashdot ("Bob sent you a message and you can't see it unless you click here.") Others are classy clickbait, like Facebook ("Sarah told you 'Thanks for the present', click here to see Sarah's page.") These messages are inconsequential and there is minimal privacy risk of sending those message over email, which is usually insecure.

Banking information is another story. Bank eStatements are sent like the Slashdot message above. You are told that a new statement is available, but you must click and login to see the statement. And this is because if they just sent you a PDF then these would get sucked up by anyone monitoring network traffic between the bank's email server, your email server, and your computer. You wouldn't want this, because there's already enough ways that your credit card numbers are getting stolen. (Digressing, I believe this is a conspiracy of the plastic industry to make banks print more cards.)

So it is very surprising to see the following email from Amazon / Chase Visa with a notice to use an updated card they have sent. In an unprecedented and insecure move, they have merged this email with a list of past merchants and purchase dates of places I have done business. Also included is the last four digits of my credit card. This is precisely enough information for someone to [call you on the phone posing as a bank](https://privacylog.blogspot.com/2010/08/why-is-financial-fraud-so-easy-in.html) and then get your full account number and mother's maiden name ("for your security").

![Email](/assets/images/2015-06-12-chase-credit-card-privacy-fail-email.webp)

Private financial banking information should only be sent to customers over an insecure medium like email if the users have explicitly requested this and have [provided an encryption certificate to the bank just for this purpose](how-to-implement-paperless).
