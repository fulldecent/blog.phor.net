---
title: "Never use BCC"
tags:
  - how-to
old-link: https://fulldecent.blogspot.com/2006/12/dont-use-bcc.html
comments:
  - link: https://fulldecent.blogspot.com/2006/12/dont-use-bcc.html?showComment=1165839180000#c5302817174548080268
    name: 'Chris'
    text: |
      What about this case:
      You need to send an email to a single person, it is only relevant to them. However, in response to the message, the recipient is likely to a) respond to sender, or b) call a third party for further clarification.

      Third party is not interested in the topic of the email, and only becomes interested if recipient follows up with him instead of reply. This is a case where third party should be BCC rather than CC, since they *should* have no interest in the email.
  - link: https://fulldecent.blogspot.com/2006/12/dont-use-bcc.html?showComment=1165843140000#c5999327847066247084
    name: 'William Entriken'
    text: If the third party is not interested, why are they getting the message?
  - link: https://fulldecent.blogspot.com/2006/12/dont-use-bcc.html?showComment=1165885440000#c319809591162992495
    name: 'Chris'
    text: |
      Imagine a manager. If all is going well, they don't need to read all the interim details. If something is not going well, they will want to go back and read details before responding poorly.
  - link: https://fulldecent.blogspot.com/2006/12/dont-use-bcc.html?showComment=1194387600000#c2997258425646101426
    name: 'William Entriken'
    text: |
      **this is how i'd read the first email:**

      from: coworker_a
      to: me
      subj: work

      please do this work

      **this is how i'd read the second:**

      from: coworker_a
      to: me
      cc: boss
      subj: work

      please do this work
      ps, big brother is watching

      which effect would you rather your message have?
  - link: https://fulldecent.blogspot.com/2006/12/dont-use-bcc.html?showComment=1251589720202#c9204063561060732573
    name: 'William Entriken'
    text: |
      I've also seen the excuse: use BCC so you'll get less spam.

      Here is my reply: what is spam?

      Do you know that gmail came out in 2004 and I haven't gotten spam since?
  - link: https://fulldecent.blogspot.com/2006/12/dont-use-bcc.html?showComment=1279055436968#c3971554742918804071
    name: 'William Entriken'
    text: "I will concede one occasion where BCC is appropriate: \n\n--------\nFrom: Warren Buffet\nTo: Candidate A, Candidate B, Candidate C, Candidate D\nSubj: Succession\n\nDear Applicant,\nCongratulations, I have chosen a list of candidates to succeed me, which includes you. A candidate which is still alive by the time I am unable to run Berkshire Hathaway will be chosen at random.\n\nSincerely,\nWB\n--------\n\nWhen you need to protect your recipients' identities (not just because of spam, R.I.P. 2004) you should explicitly describe the nature and quantity of the recipient list.\n"
---

First, [what is BCC?](https://en.wikipedia.org/wiki/Blind_Carbon_Copy)

Why you shouldn't use BCC when you email groups of people.

1. If I receive mail sent to "undisclosed-recipients", I assume the worst: that you are sending something to as many people as you can, and you don't want me to know that. I immediately think that whatever the correspondence is, it is for your benefit, not mine. This is also known as spam.

   (note: this first point also applies when a mail is sent just to me, but the message is clearly a form-mail, e.g. it starts with "Dear <my full first name>,")

2. If you're inviting me to something via email and I see it is sent to "undisclosed-recipients", I assume the worst: that you are only inviting the lamest of people (plus me) and your event will ultimately suck. Not something I'm likely to attend.

3. If you are making a legitimate announcement to a group of people, you should be sending this to a mailing list, not using BCC. When I receive you message, it will look like this:

   ```
   From: the secretary
   To: list-of-selected-cool-people@exmple.com
   Subj: Pool
   
   The pool will be opening today, come check it out.
   ```

   However, if you BCC the message, this is how I will read it:

   ```
   From: the secretary
   To: undisclosed-recipients
   Subj: Pool
   
   The pool will be opening today, come check it out.
   P.S. I'm sending this email to everyone in the world. By the time you get to the pool, all the kids will have already peed in it.
   ```

   What if you really think your message is meant for the public at large? Don't use BCC? use mailing lists. Consider the correct way to do it:

   ```
   From: the secretary
   To: marketing.dept@exmple.com, sales.dept@exmple.com, hr.dept@exmple.com
   Subj: social
   
   There will be an office social event on Friday, BYOB.
   ```

   And this is how your message is read if you use BCC.

   ```
   From: the secretary
   To: undisclosed-recipients
   Subj: social
   
   There will be an office social event on Friday, BYOB.
   P.S. this message was only sent to people we think are alcoholics, if you show up with booze, you will be fired.
   ```

The only time BCC is appropriate is when forwarding the message makes it funny for the bcc'ed party:

```
From: man
To: old girlfriend
Bcc: newgirlfriend@example.com
Subj: done

gf, i'm done with you!
```

However, see how much funnier this is when you avoid BCC:

```
From: man
To: old girlfriend
Cc: newgirlfriend@example.com
Subj: done

gf, i'm done with you!
```
