---
title: "TD Ameritrade privacy case study: selling your position information to a third party"
tags:
  - privacy
old-link: https://privacylog.blogspot.com/2008/09/td-ameritrade-sells-your-position.html
---

Here is some pretty conclusive evidence that TD Ameritrade is sharing your account positions information to News Corporation for profit...

First, login to your TD Ameritrade account and you will find a chart like this:

![TD Ameritrade pie chart](/assets/images/2008-09-19-td-ameritrade-sells-your-position.webp)

This specific chart is displayed on my screen via the following HTML code:

```html
https://chart.bigcharts.com/custom/ameritrade2/piechart/heat-med.img?&amp;data=0.51+0.28+0.20+0.01&amp;legend=AAPL+5.09%|VGSTX|SCMWY+4.56%|+*CASH*&amp;color=00FF00+CCCCCC+00CC00+99FFFF
```

This image is served by BigCharts.com. Now, as you can see, BigCharts.com <a href="https://whois.domaintools.com/bigcharts.com">is owned by</a> Dow Jones and Co., which <a href="https://en.wikipedia.org/wiki/Dow_Jones">is owned by</a> News Corporation.

Because of the URL you see above, and the basic mechanism of how webpages work, TD Ameritrade is causing your computer to tell News Corp your portfolio contents, then their server is delivering a picture to you which displays a pie chart on the web page. Now, if your computer logs into any other website News Corp owns (they have a lot), they can connect that identity to your stock portfolio.

The correct way to implement this type of image display is as follows: the client logs into the TD website, TD requests the chart from News Corp without including any of your identifying information, TD sends the resulting chart to you. (With an Apache web server this is done with one line of code and is called a "reverse proxy").

I have been in contact with the president's office of TD and they have no interest in implementing this approach, stating that the privacy policy justifies sending your portfolio information and personal identifying information to News Corp. Nowhere in the <a href="https://www.tdameritrade.com/privacy.html">privacy policy</a> (<a href="https://web.archive.org/web/20080124182511/www.tdameritrade.com/privacy.html">permalink</a>) does it say "we will give away your financial information to third parties for no reason at all". In fact, that policy doesn't even get in to financial information. So I assume this is a fairly straightforward demonstration of them breaking the policy.

---

Notes:

I have demonstrated that TD Ameritrade is giving away information, not necessarily that they are selling it. However, since such information is valuable, I assume that is a logical continuation.

Your name is not transmitted directly to BigCharts.com, however your IP address is. This can be traced back to you personally if you use that IP address to access any other website News Corp. has access to, for example, MySpace. Even if you don't use MySpace, that IP address may be tracable to you in many other ways.

TD Ameritrade has also <a href="https://money.cnn.com/2005/04/19/technology/ameritrade/index.htm">"lost" account information in the past</a>, of course they never made specific details available.

## Timeline

* 2008-09-19: I sent a copy of this post to TD via the online help system

* 2008-09-21: I received a boiler-plate response

  > Your inquiry has been escalated. An analyst will research and respond to your concern. We appreciate your patience while awaiting their resolution.
  >
  > Sincerely,
  > Investor Services
  > TD AMERITRADE, Division of TD AMERITRADE, Inc.
  > Member FINRA/SIPC

* 2008-09-30: I have not heard back from them yet, I mailed them this quick update:
  
  > Thank you for the quick reply. If there is any information I can provide to expedite the process, don't hesitate to ask.
  >
  > Just for your information, your progress on explaining/resolving this issue, as well as our correspondence, will be posted on my blog.
  >
  > Regards,
  > WE

* 2008-10-05: This matter was referred to the SEC.

* 2008-10-15: I have been contacted by the President's office, and had the opportunity to explain this issue. It was a great conversation and I look forward to catching up on the rest of the details.

* 2008-12-29: I have been in contact with the SEC regarding this.
  
  This case has been assigned SEC File # HO130024.

* 2008-11-07: I received a letter from "Client and Regulatory Relations" at TD and replied to them and the SEC on 2008-11-26.

Also of note: I closed my account with them months ago, but they failed to actually delete my account. Last week I called to re-close my account, but not before logging in to see the issue still exists.
