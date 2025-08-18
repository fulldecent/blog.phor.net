---
title: "What happens when you send a zero-day to a bank?"
tags:
  - security
old-link: https://privacylog.blogspot.com/2017/04/what-happens-when-you-send-zero-day-to.html
---

- UPDATE 2017-04-22: Corrected confusing wording, thank you Sujan. Fixed typos, thank you jacquesm, komali2, LanceH.

In October 2008, shortly after introduction of the original iPhone I wanted to know if it is possible to trade stocks using my Zecco trading account (now TradeKing). Surely this would be simple enough because Zecco executed trades through a website and iPhone has the Safari browser.

Quickly I found out that the trade is executed in a (laughably) insecure method. For your reference, here it is:

```html
<img src="https://trading.zecco.com/zecco/execOrder.nexa?action=1&quantity=1&symbol=kkd&instruction=1&price=&stopPrice=&timeInForce=2&styleSheet=OrderSent">
```

If you loaded that code from ANY web page, or if somebody sent you an email with that code (even if you never open the email) then you would be the unwitting owner of one share of Krispy Kreme Donuts placed at market order pricing.

Very quickly I realized this is bad, very bad. Anybody could include this code on a popular Myspace page (or even as a COMMENT on a popular page and have a serious impact on the financial system.)

## First contact

The next day, I phoned the Zecco office with message to Jeff Chamberlain, and Jeroen Veth to arrange a phone call.

During the week of 2008-01-06 I held phone conferences with Jeff Chamberlain (Fraud Prevention Manager), Jeroen Veth (Founder and CEO), Michael Raneri (then CTO, later promoted to CEO and now Managing Director - PwC), Phil (Penson Bank, their software vendor), Greg (VP of Engineering) Loren Cheng (NCFTA) and the United States Federal Bureau of Investigation (representing NCFTA).

On the phone call I presented that one line of code which innocuously would allow me to purchase Krispy Kreme on an iPhone. But also we discussed the ramification of their insecure implementation. Penson confirmed that this software was affecting over 100,000 North American retail branches (I will not say which). Also their engineers made it clear that unauthorized transactions like this and later shown below would not be distinguishable from other legitimate transactions.

**During our conversation, Chamberlain, Veth and Raneri made it very clear their sole intention was to prevent public disclosure of this incident, rather than actually fix the problem.**

Raneri questioned my motivation and I said that I want to give the vendor ample time to resolve the issue and then I want to publish academically. He was very threatened by this and made thinly veiled threats that the FBI or other institutions would "protect him". Then he continued with statements including "we want to hire you but you must sign this NDA first." He also recommended that I only make disclosure through FINRA, SDI, NCTFA and other private fraud threat sharing organizations for financial institutions.

**The full timeline**

- October 2008 — Vulnerability found, affecting all 100,000 Zecco clients
- Oct 2, 2008 — Phone call made to Zecco office, message sent to Jeff Chamberlain, Jeroen Veth noting a large security concern was found
- Oct 3, 2008 — Email received from Jeff Chamberlain, Michael Raneri
- Oct 4, 2008 — Complete vulnerability sent to Raneri
- Oct 6, 2008 — Phone conference with Raneri, Entriken;Complete vulnerability discussed, possible solution proposed by Raneri, Entriken demonstrates that solution does not work, Entriken offers to provide solution, Raneri declines; Raneri requires completion of NDA and offers to put Entriken in contact with Jeff Chamberlain and Loren Cheng with NCFTA for December meeting Email sent by Raneri to Gregg Kang and Francesco Matteini regarding the matter
- Oct 27, 2008 — Entriken sends executed NDA
- Dec 9, 2008 — Conference with Entriken, Raneri and Phil Offield from Penson (Zecco’s clearing firm); notes that this problem may affect other firms associated with Penson, covering millions or tens of millions of traders;Entriken notes that other vulnerabilities may exist
- Dec 10, 2008 — Entriken phone call with Ken Blotteau NCFTA Deputy Director, J. Keith Mularski (FBI) ("Master Splynter") Cyber Initiative and Resource Fusion Unit NCFTA Dane. They no longer wish to invite me as a speaker for their conference. Compromised transactions is not a priority now, only denial of service attacks are in scope.
- Jan 2009 — Entriken contacts Penson and NCFTA, Penson and NCFTA are unwilling to schedule a meeting
- Dec 15, 2009 — Entriken sent email to Jeroen Veth stating that vulnerability still exists and that he knows how to fix it.Raneri replies: “Good to hear from you [William Entriken], even if it is through Jeroen. I think we are all set on the consulting end of things.  Hope all is well with you.”
- Jan 7, 2010 — Entriken provides full details of everything discussed above to FINRA under their "Misconduct" reporting for "Firm policy/procedure" Secondary: Safekeeping/private of information" under MICHAEL PAUL RANERI. Zecco provided a filing ID of 681233 and submission date 1/7/2010 10:40 PM.
- 2017 I have yet hear from FINRA that any action has been taken. I have yet to hear from ZECCO / TradeKing that the issue has been resolved.

If you have made any transaction with ZECCO / TradeKing / Penson between 2005 and present you may wish to contact an attorney to understand if that transaction was made without your permission and under the gross negligence of the company's management.

## What would you do?

My dad was on the original call (to everyone's knowledge) and he recognized the threat that apparently the FBI would be coming to our house if I disclosed this. So I signed the NDA on 2008-10-27. In direct violation of the NDA I am also posting it publicly now in the public interest.

![NDA 1](/assets/images/2017-04-20-how-to-zero-day-a-bank.webp)

![NDA 2](/assets/images/2017-04-20-how-to-zero-day-a-bank-2.webp)

## Further reading

- **But this only affects people that are logged in, right?** Yes, however a mitigation technique exists, You surrepecticiously detect if a customer is logged in to a website (see <https://www.tomanthony.co.uk/blog/detect-visitor-social-networks/>) and then execute you attack only once when you are confident it will work.
- **What about XFRS, CORS protection, …?** This was 2008. We still had the `<blink>` tag back then.
- **Is this NDA a legal document?** Probably not, it doesn't have four corners.
- **What if Raneri is a cunt and sues you?** Well I think he has the biggest risk, there are millions of transactions that happened at his company while was CEO & CTO and he did not properly report to authorities that he could not verify their authenticity. Also, he probably failed to make this material disclosure to the buyers when he sold this company. Either way he landed as a partner at PwC and probably has better things to do.
- Jeff is in attendance at CyFin Conference per <https://wikileaks.org/hbgary-emails/emailid/18214> and later published in the Journal of Digital Forensics Security and Law.
