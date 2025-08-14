---
title: "Restricting user content—case study jiayuan.com"
tags: ["security", "best-practice"]
old-link: https://privacylog.blogspot.com/2012/09/restricting-user-content-case-study.html
---

Today we are looking at 世纪佳缘 (jiayuan.com), the largest friend match making website in China with 40 million users. Their revenue model is to allow paid users to send letters, but to read a letter you must also pay a monthly amount. You can send or receive a few letters for free and set up a profile for free.

In the last week I have 30 new messages, here's the inbox.

![Inbox](/assets/images/2012-09-15-restricting-user-content-case-study.webp)

And here is the first letter, you can see for free:

> (#1) <https://msg.jiayuan.com/showmsg.php?msg_id=Sdji0-eh7VXFAMvpIuY5h8m5oco2sN9U9UJBcWmhrHVdmNF7fw8dZhtW1GYQP-uV&amp;box_type=inbox>

![Letter 1](/assets/images/2012-09-15-restricting-user-content-case-study-2.webp)

But when you try to click on the second one...

![Letter 2](/assets/images/2012-09-15-restricting-user-content-case-study-3.webp)

Blocked, you need to pay to see this. Lots of messages and you can't see them... is this a scam or are there real people on the other side of the line? Let's poke around. Actually, this is just an iframe, so lets load it separately.

> (#2) <https://msg.jiayuan.com/shownewmsg.php?kanxin=0&amp;putong=0&amp;msg_id=IT6dG258ylJdfW6w5-qTN95jfPNZt16MxTfBIbI%2AJQb8y0nHsrO9PDsul1sGiQdt>

![Letter 2 iframe](/assets/images/2012-09-15-restricting-user-content-case-study-4.webp)

Basically the whole game here is you want to compare the URLs to see what is different so you can take the one that works (#1) and get a working URL with the content you want (#2).

> WORKS <https://msg.jiayuan.com/><span style="background-color: #b6d7a8;">showmsg</span>.php?msg_id=Sdji0-eh7VXFAMvpIuY5h8m5oco2sN9U9UJBcWmhrHVdmNF7fw8dZhtW1GYQP-uV<span style="background-color: #b6d7a8;">&amp;box_type=inbox</span><br>
> FAILS <https://msg.jiayuan.com/><span style="background-color: #ea9999;">shownewmsg</span>.php?kanxin=0&amp;putong=0&amp;msg_id=IT6dG258ylJdfW6w5-qTN95jfPNZt16MxTfBIbI%2AJQb8y0nHsrO9PDsul1sGiQdt

So let's try this:

> <https://msg.jiayuan.com/><span style="background-color: #b6d7a8;">showmsg</span>.php?kanxin=0&amp;putong=0&amp;msg_id=IT6dG258ylJdfW6w5-qTN95jfPNZt16MxTfBIbI%2AJQb8y0nHsrO9PDsul1sGiQdt<span style="background-color: #b6d7a8;">&amp;box_type=inbox</span>

![Letter 2 try](/assets/images/2012-09-15-restricting-user-content-case-study-5.webp)

Fail, OK, let's try removing that other part all together...

> <https://msg.jiayuan.com/><span style="background-color: #b6d7a8;">showmsg</span>.php?kanxin=0&amp;putong=0&amp;msg_id=IT6dG258ylJdfW6w5-qTN95jfPNZt16MxTfBIbI%2AJQb8y0nHsrO9PDsul1sGiQdt

![Letter 2 try 2](/assets/images/2012-09-15-restricting-user-content-case-study-6.webp)

This fails too... but there's a clue:

> 没有选择收件箱或发件箱
> [You forgot to specify an inbox or outbox]

Ok... let's try the outbox:

> <https://msg.jiayuan.com/><span style="background-color: #b6d7a8;">showmsg</span>.php?kanxin=0&amp;putong=0&amp;msg_id=IT6dG258ylJdfW6w5-qTN95jfPNZt16MxTfBIbI%2AJQb8y0nHsrO9PDsul1sGiQdt<span style="background-color: #b6d7a8;">&amp;box_type=outbox</span>

![Letter 2 try 3](/assets/images/2012-09-15-restricting-user-content-case-study-7.webp)

Same error. Going on a limb here... let's try the "sent" box:

> <https://msg.jiayuan.com/><span style="background-color: #b6d7a8;">showmsg</span>.php?kanxin=0&amp;putong=0&amp;msg_id=IT6dG258ylJdfW6w5-qTN95jfPNZt16MxTfBIbI%2AJQb8y0nHsrO9PDsul1sGiQdt<span style="background-color: #b6d7a8;">&amp;box_type=sent</span>

![Letter 2 try 4](/assets/images/2012-09-15-restricting-user-content-case-study-8.webp)

Bingo! I can see the letter, but it shows the page as if I had sent the letter to her. This letter is in English and she sent:

> HI, I'm wondering whether you are a real person using this website or it's a deception to lead people believe some foreigners are using this website too. But no offence either way.

A fellow sceptic out there... and the funny thing is that I have no way to reply... so she'll never know.

## Lessons learned / recommendations

* Jiayuan has real people sending messages, not auto-generated content.
* Do not format your webpage with the "sent" template or "inbox" template based on user input... the database should tell you which format to use.
* Be careful when limiting user access to the data. Here, the logic is: "if box_type == inbox then see if user has access to letter". The right approach is "if !letter.shouldBeAccessible() then throw error".
* Never give hints in your error messages. 没有选择收件箱或发件箱 makes it clear that the front-end code and backend code were written by different teams without a properly documented interface. This type of error should fail silently with "server error 224254" and log to disk because the user did not actually select the box type.

## Last words

I am sending this letter and recommendations to fix the problem to jiayuan and will keep you up-to-date on the progress
