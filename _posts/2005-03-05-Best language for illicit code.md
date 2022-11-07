---
title: "Best language for illicit code"
tags: my-life
comments:
  - link: https://twitter.com/fulldecent/status/XXX
    name: '@fulldecent'
    text: The official Twitter thread
---

So public safety comes into my room last night while I'm sleeping with a fanfare of the head of public safety, head of network security and 10+ other people. One is standing by to turn off the circuit breaker, and they're ready to seize my computer. So I sat with them in the living room to answer some questions. Here is the conversation between the network security guy (herein: NSG) and myself:

> <span style="color:blue">NSG:</span> We're here to talk to you about illicit computer usage<br>
> <span style="color:red">ME:</span> Oh wow, what specifically?<br>
> <span style="color:blue">NSG:</span> According to some information on one of your websites, we have reason to believe that you have gained unauthorized access to some of our servers and/or network equipment.<br>
> <span style="color:red">ME:</span> And why is that?<br>
> <span style="color:blue">NSG:</span> Apparently you have the ability to see if any given student is at their computer at the time<br>
> <span style="color:red">ME:</span> Hmm, yes I do<br>
> <span style="color:blue">NSG:</span> So it seems like you have illegally accessed our router table to get this information<br>
> <span style="color:red">ME:</span> Why don't I pull up the site so we can be clear on what you're talking about<br>
> <span style="color:blue">NSG:</span> Ok<br>
> <span style="color:red">ME:</span> (typing)<br>
> <span style="color:orange">Computer:</span> Please enter a student's name to see if they are online and where they are:?<br>
> <span style="color:red">ME:</span> Is this what you're talking about?<br>
> <span style="color:blue">NSG:</span> Yes<br>
> <span style="color:red">ME:</span> (type type type)<br>
> <span style="color:orange">Computer:</span> [[student]] has 2 computer logged in on campus at [[location]]<br>
> <span style="color:blue">NSG:</span> Yeah, how are you doing that?<br>
> <span style="color:red">ME:</span> Do you know PHP?<br>
> <span style="color:blue">NSG:</span> Sort of (that's IT speak for: "not really, but I get paid for it")<br>
> <span style="color:red">ME:</span> (type type typearoo) here's how I get the IP address<br>
> <span style="color:orange">Computer:</span> `$ip=gethostbyname("STUDENTNAME.student.villanova.edu")`<br>
> <span style="color:blue">NSG:</span> Hmm...<br>
> <span style="color:red">ME:</span> Any more questions?<br>
> <span style="color:blue">NSG:</span> Um... well apparently you also know what classes all the students are in, how do you do that?<br>
> <span style="color:red">ME:</span> Do you know what LDAP is?<br>
> <span style="color:blue">NSG:</span> Yes, I administer LDAP<br>
> <span style="color:red">ME:</span> Hmm...<br>
> <span style="color:red">ME:</span> (typing typing)<br>
> <span style="color:orange">Computer:</span> `$ ldapsearch -h ldap.villanova.edu -b o=villanova.edu uniqueMember=[[STUDENT'S DN]]`<br>
> <span style="color:red">ME:</span> All this information is public, do I need to hit enter?<br>
> <span style="color:blue">NSG:</span> No, that's not necessary<br>
> <span style="color:red">ME:</span> Any more problems?<br>
> <span style="color:blue">NSG:</span> Um... well it appears that you're running a wireless router on campus and that's not allowed<br>
> <span style="color:red">ME:</span> OK -<br>
> <span style="color:blue">NSG:</span> OK... I guess that's it<br>
(Exeunt fanfare stage left)<br>

So the moral of the story is, if you're doing anything cool on a computer that someone else might think is illicit, make sure you use short, simple, easy to understand code. because if I wrote the host lookup in <a href="http://www.muppetlabs.com/~breadbox/bf/">brainf***</a>, that would have taken some time to explain.