---
title: "School is canceled"
tags: ["my-life"]
comments:
  - link: https://twitter.com/fulldecent/status/1575908254693359616
    name: '@fulldecent'
    text: The official X thread
  - link: http://pinknblack.blogspot.com/2004/04/villanova.html
    name: Villamova
    text: "Another Wildcat's analysis of this night"
  - link: https://villanovan.com/16784/uncategorized/hacker-attempts-class-cancellation-via-e-mail/
    name: The Villanovan
    text: Hacker attempts class cancellation via e-mail
updates:
 - date: 2009-08-29
   changes: Added full text of the second email
 - date: 2013-12-20
   changes: Disclosed everything I know
old-link: https://fulldecent.blogspot.com/2004/09/123838-anthony-romano-will-123838-full.html
---

In the middle of the night, I learned about a mysterious and FAKE message canceling class for all Villanovans:

> <span style="color:blue">Anthony Romano:</span> will<br>
> <span style="color:red">Full Decent:</span> I'm not away... I'm idle!<br>
> <span style="color:blue">Anthony Romano:</span> will<br>
> <span style="color:blue">Anthony Romano:</span> will<br>
> <span style="color:blue">Anthony Romano:</span> will<br>
> <span style="color:blue">Anthony Romano:</span> will<br>
> <span style="color:red">Full Decent:</span> yo<br>
> <span style="color:blue">Anthony Romano:</span> did you spoof that email?<br>
> <span style="color:red">Full Decent:</span> &gt;-)<br>
> <span style="color:blue">Anthony Romano:</span> yes or no<br>
> <span style="color:blue">Anthony Romano:</span> I wont tell anyone<br>
> <span style="color:blue">Anthony Romano:</span> I just want to know<br>
> <span style="color:red">Full Decent:</span> what difference does it make?<br>
> <span style="color:blue">Anthony Romano:</span> well if its fake I have to constantly check my emai<br>
> <span style="color:blue">Anthony Romano:</span> to see if he found out<br>
> <span style="color:blue">Anthony Romano:</span> and uncanceled class<br>
> <span style="color:blue">Anthony Romano:</span> if its real, I can go home and sleep all day<br>
> <span style="color:red">Full Decent:</span> then that would suck if I didn't tell you<br>
> <span style="color:blue">Anthony Romano:</span> :/<br>
> <span style="color:red">Full Decent:</span> how much would that information nbe worth to you?<br>
> <span style="color:blue">Anthony Romano:</span> oh geez<br>
> <span style="color:blue">Anthony Romano:</span> dont be a dick

(Update 2009-08-29) Then a little bit later, a second email from the school president went out:

> From: Edmund Dobbin<br />
> To: students@villanova.edu<br />
> Subject:<br />
> Sent: April 20, 2004 2:40 am<br />
> <br />
> Dear students,<br />
> <br />
> Please be aware that I did not send the message sent to all students last night. THERE WILL BE CLASS ON TUESDAY APRIL 20, 2004. The message was sent by some hackers, and not myself.<br />
> <br />
> I apologize for any inconvenience this may have caused,<br />
> Edmond Dobbin O.S.A.<br />
> <br />
> 442651724acc96ad90bbf6f07a79566f

(Update 2013-12-20) And all the context.

{: .margin-note}

The president has access to mail all students/faculty/staff at once.

It turns out that the Villanova email system required you to login to access your emails. But no password was required to *send* emails (IP-address based SMTP authentication) from certain physical locations. That means anybody could send emails as anybody, including the university president.

I presented a post-mortem of this to my cryptography class, the slides are still at https://docs.google.com/presentation/d/1qND8ihiCSufuqDTC__EobFzJ_h3RpxrdzDPcqgSVZE8

I found out that the original, malicious email was sent by somebody using guest login at Falvey Library who set up an email account using Thunderbird, setting the "from" address as the president... which of course has send access to the "all students" email list. The second email was sent using a more crude telnet session to the SMTP server, which obviously did not support spell check!

Recently, Villanova fixed this problem by switching email hosting and SPF to Gmail.

ℹ️ The `442651724acc96ad90bbf6f07a79566f` part of the message is an MD5 hash of something like "Will and Chris sent this" so that we could later take ownership of this favor. Unfortunately (?) that was a long night and we forgot the unencrypted message.

⚠️ Yes, although we were the "good guys" here, doing something like this can get you ten years in jail nowadays. For another story on police/security trying to throw the book at you, see how we hacked in and changed our grades at Villanova https://fulldecent.blogspot.com/2005/03/so-public-safety-comes-into-my-room.html

I do not admit to any crimes here and this blog post may be fiction.