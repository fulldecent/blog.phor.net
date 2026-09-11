---
title: "Visa payment processing case study: network flaws"
tags:
  - security
old-link: https://privacylog.blogspot.com/2011/12/flaws-in-visas-payment-processing.html
comments:
  - link: https://privacylog.blogspot.com/2011/12/flaws-in-visas-payment-processing.html#comment-1719965291948370259
    name: Chris
    text: "This isn&#39;t limited to Visa. Visa, MC, and AMEX all only verify card number, CVV, and billing ZIP. You can use this to your advantage when making donations to organizations: Put down a fake/old address with your proper/billing ZIP code, the transaction will be authorized and processed as normal. Organization can&#39;t spam your mailing address, but transaction is processed properly."
  - link: https://privacylog.blogspot.com/2011/12/flaws-in-visas-payment-processing.html#comment-1691427819122192464
    name: William Entriken
    text: "Interesting, I&#39;ve also used this technique to trick Apple into registering me for the China iTunes Store. Then I could download QQ Music, which is basically 2010 Napster music subscription minus any cost plus real time lyrics."
---

On July 20, 2011, I went to purchase the new Macbook Air in Delaware—the home of tax free shopping. My Visa card was declined and I called to confirm the purchase. After returning home, I investigated the matter and found that my account had been put on hold due to suspicious activity. (They could have called me first, but [problems with calling credit card customers to confirm purchases](https://privacylog.blogspot.com/2010/08/why-is-financial-fraud-so-easy-in.html) is already a documented problem.)

Someone used my card for a purchase at McDonald's for $1 (probably small fries), then a $400 purchase at Target and then another $400 purchase at a different Target—all in Virginia. I was also buying lunch at Chick-fil-a and buying a MacBook in Delaware at the same time. Naturally this triggered an alert because why would anyone who has access to a Chick-fil-a also eat at a McDonald's during the same meal period?

I called Target security at the store and asked them to find a purchase under my name that day... none found. Then I asked to look up any purchase for $417.36 on that day. Within seconds they had two camera angles of the purchase, on register #27 at 1:17:10pm. (They start counting registers at #20, they don't actually have 27 registers). The security person would not send me the video, due to problems in the past with them being uploaded to YouTube, but she would let me see them if I filed a police report.

The security person confirmed that this was a swipe purchase, so obviously someone has copied my Visa card. But then the next obvious question: if there were no search results for my name, what name WAS on the card that made this purchase? The answer: there was no name, this transaction was posted as a gift card with no name. Visa later confirmed this. So the security flaw is this:

**In the processing payments on the Visa network, information on the card regarding the authorized signer and card type can be recorded and trusted by the merchant, but this information is never sent to or verified with Visa.**

In other words, the design of Visa's network allows the following types of exploits assuming the attacker has access to print credit cards.

- Copy a real credit card as a gift card and make purchases without needing ID
- Copy a real credit card and change the authorized signer to make purchases using a different ID

Naturally, this could be fixed easily by verifying ALL credit card details against a central database at the time of purchase.
