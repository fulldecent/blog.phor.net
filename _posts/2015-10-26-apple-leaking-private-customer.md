---
title: "Apple leaking private customer information over insecure HTTP"
tags:
  - privacy
old-link: https://privacylog.blogspot.com/2015/10/apple-leaking-private-customer.html
---

EMBARGO: This article was written 2015-10-26 and immediately reported to Apple. Actually published 2017-09-06.

UPDATE 2017-09-06: Added timeline. Also I want to clarify that "leaking" means "accidentally lose" according to Google Dictionary. Some modern use of this word seems to imply "intentional disclosure", that is not the meaning I intend.

On the Apple Store website, customer details are leaked over insecure HTTP. Following is a screenshot showing that the customer's complete address is displayed on the page. A ZIP+4 is usually enough to translate to a full address.

![Leak example](/assets/images/2015-10-26-apple-leaking-private-customer.webp)

Here is the same page loaded without cookies, the address is not shown.

![No cookies example](/assets/images/2015-10-26-apple-leaking-private-customer-2.webp)

Please compare this to Apple's account login page which also provides account addresses. However this page is delivered over HTTPS.

![HTTP example](/assets/images/2015-10-26-apple-leaking-private-customer-3.webp)

The attack: a potential way that this vulnerability could be abused would be a free Wi-Fi connection that redirects to the apple.com product page on your device. This rogue Wi-Fi network would then learn your personal shipping address.

## Timeline (excluding automated replies)

This is a simple problem reported here but you can be sure that the solution is not always so simple. Also, in addition to the simple solution, verification is a long process. It took much longer than I expected and I needed to stay very involved to see through to the resolution here. I am sharing this timeline so that it may be helpful for other security analysts. Your takeaways should be that A) Apple does follow on their promise to take your report seriously B) Apple does provide credit, it's not money like other vendors, but hey take what you can get C) be persistent.

* 2015-10-26: I sent this article to Apple at&nbsp;<product-security@apple.com>
* 2015-10-29: Brandon at Apple Product Security replied to confirms article was read and requests that no disclosure be made "while we investigate it further"
* 2015-11-28: I request a status update
* 2015-11-30: Brandon replies to request no disclosure be made "until our investigation is complete and any necessary updates are available"
* 2015-12-29: I write to ask if investigation is still ongoing
* 2016-01-20: Brad at Apple Product Security replies "we are currently working on a complete fix for the issue you reported" and again requests no disclosure until this is done
* 2016-06-23: I ask if this is addressed and if I should publish this blog post
* 2016-07-11: Brad asks to delay publication until they can "fully address it"
* 2017-01-24: I write that I intend to publish in 14 days because no resolution appears forthcoming
* 2017-02-13: Brad replies that this "requires a complex solution in order to address the underlying cause" and requests not to disclose
* 2017-05: Sometime in May the issue is addressed as far as I can see
* 2017-05-31: I note the issue is addressed and request credit for the discovery per Apple's policy
* 2017-06-01: Scotty thanks me for reporting it seems corrected and says they will verify then provide credit
* 2017-08-15: "Hi, how is your year 2017 going?" I'm trying to get this done
* 2017-08-15: Scotty requests a credit line so they may publish it
* 2017-08-16: I send the credit line
* 2017-08-28: "Would you please confirm that the kb article will be updated?"
* 2017-08-28: Deven confirms the credit will be posted in a future update to the Apple Notifications page
* 2017-08-29: "Thank you"
* 2017-09-05: The updated page is posted online and backdated to 2017-05-31

Here is the credit citation:

> 2017-05-31 store.apple.com
>
> A server configuration issue was addressed. We would like to acknowledge William Entriken (@fulldecent) of phor.net for reporting this issue.
>
> <https://support.apple.com/en-us/HT201536>
