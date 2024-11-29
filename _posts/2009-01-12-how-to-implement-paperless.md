---
title: "ING Direct communication case study: how to successfully implement paperless billing"
tags: 
  - user-interface
old-link: https://privacylog.blogspot.com/2009/01/how-to-successfully-implement-paperless.html
comments:
  - link: https://privacylog.blogspot.com/2009/01/how-to-successfully-implement-paperless.html#comment-4123541618940614591
    name: Chris
    text: "ING Direct doesn't actually support eBills. Bank of America actually does an excellent job of handling ebills. They receive an actual bill from the bill provider(Comcast, Verizon, Visa, AMEX, etc.) You are given the option to pay the minimum and the date that the payment will be delivered and withdrawn from your account. Once you schedule this payment, it becomes their problem to pay on time. If the bill is paid late, they will refund your overdraft fees(since, noone keeps money in checking accounts) and the late fee charged by the vendor. As for guaranteeing arrival, I don't ever check my paper mail, I get 2 emails for each ebill, one from Bank of America, and one from the vendor, sometimes it is annoying, but having that double notice provides a safety reminder. With eBills, there is no reason to \"leave a bill on the desk\", just schedule it for the future. You know when the bill is due, and when the money will be in your account, just schedule it and forget it. The bank is going to screw you in court anyway, you probably agreed to use their arbitrator, and waived all your rights when you opened your account anyway. Real bills require stamps and a trip to a mailbox or post office, the opposite of convenience, and I work in a post office. As for the ads and useless links: https://adblockplus.org/en/installation . Ads are a solved problem that no longer affect humans."
  - link: https://privacylog.blogspot.com/2009/01/how-to-successfully-implement-paperless.html#comment-6714968229432111698
    name: William Entriken
    text: Your solution does seem to solve all of the problems with e-bills. Of course that depends on having a BOA account, but maybe others do this. Then, I suppose, the applicability of these things woud be limited to e-statements, the periodic account updates you receive from banks, brokers, loans which don't require payment.
---

I have seen paperless billing implemented poorly many times... which is a shame because a little time invested in the IT department could save a lot of time and money in the mailing department.

There's a lot of things you can do with a real (paper) bill that you can't do with an e-bill. When banks realize this and compensate for shortcomings, customers will be more willing to accept e-bills.

1. You can be confident in the arrival of a real bill. 

    When an e-bill is released, the bank sends you an email. If the you do not receive the email, or you don't open it, the bank should promise the to MAIL A PAPER COPY. Then you can be 100% sure you will get the bill.

2. Before you pay a bill, you can keep it on your desk, as a reminder to pay.
     
    Banks should keep your e-bills available on a website and should show you whether you have viewed the bill or not. The bank should also allow you to mark the e-bill as "unread". This is similar to an email inbox, and mimics the function of the real bill on the desk:

    ![Paperless billing screenshot](assets/images/2009-01-12-how-to-successfully-implement-paperless.jpg)

3. Real bills are legal evidence in court.

    ... and this is comforting to know. A PDF e-bill file can be edited to make your balance $10 million and this is 100% indistinguishable from a legitemate bank e-bill (when printed). Banks should provide verifiable digital signatures (PDF signature, or PGP). Not all customers will understand how this technology works, but the bank need only briefly explain the technology and that this computer file is a legal and verifiable document.

4. Real bills are convenient.

    ... you open the envelope and WHAM, there it is. There's no logging in. There's no user names. Banks should offer to send e-bills as a direct email attachment. Naturally, these attachments would be encrypted. And since computer encryption is only for advanced users, this should be only be an option. I would recommend: upload a public key and attachments are mailed to you, encrypted against that key.

---

Here are two examples poorly execution of e-bill systems: ING Direct and Chase:

![ING Direct e-bill screenshot](assets/images/2009-01-12-how-to-successfully-implement-paperless-2.jpg)

![Chase e-bill screenshot](assets/images/2009-01-12-how-to-successfully-implement-paperless-3.jpg)

---

The lessons are from these failures are:

- e-bills are saving the banks LOTS of money. Don't litter these pages with ads or useless links.
- e-bills are not the standard and require user buy-in. Make it easy and inviting to use. Don't require users to cancel paper billing to try the e-bill feature.
