---
title: "Google Tasks interface case study"
tags: 
  - user-interface
old-link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html
comments:
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-1266984756256625365
    name: William Entriken
    text: "Do you I website where I can paste source code and it spits out color coded source code. Then I can view source and use that HTML in Blogger?"
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-2060840064657776386
    name: Unknown
    text: "Hi, could you help me with what &quot;/Au&quot; does in sed?"
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-5487480985337868919
    name: William Entriken
    text: "Original line of code: AUTH=$(sed -n &#39;/Au/s/A/a/p&#39; token)<br /><br />Sure, since sed is in -n (non-print mode), this matches lines with /Au/ and then /p (prints) them, as opposed to printing every line with an A in it.<br /><br />Of course a more straightforward approach is just s/Auth/auth/p which does the same thing. I&#39;ll put that in the post."
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-5980874342536393858
    name: Dmitry Panov
    text: "Is there any way to access https://mail.google.com/tasks/ig using oAuth or any other method that does not require asking the user to provide their password?"
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-6630544480703234066
    name: William Entriken
    text: "Nope, we&#39;re all waiting for that. This post of course is just a workaround. Feel free to vote on that feature at https://code.google.com/p/gdata-issues/issues/detail?id=987"
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-2242072845428836004
    name: Anonymous
    text: "Link is now: https://code.google.com/a/google.com/p/apps-api-issues/issues/detail?id=985"
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-1836539023307212689
    name: Anonymous
    text: "Hi.<br />I have implemented this code in Java and when I run it no Android simulator I get:<br />P3P: CP=&quot;This is not a P3P policy! See https://www.google.com/support/accounts/bin/answer.py?hl=en&amp;answer=151657<br /><br />Can you advise please?"
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-8998431398257638939
    name: William Entriken
    text: "Hi Anonymous. Is this Java code available for inspection?"
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-504787483224176182
    name: Anonymous
    text: "URI uri = new URI(&quot;https://www.google.com/accounts/ClientLogin?Email=user@gmail.com&amp;Passwd=pass&amp;source=privacylog&amp;service=goanna_mobile&quot;);   <br />   HttpPost post = new HttpPost(uri);<br />   HttpClient client = new DefaultHttpClient();<br />   HttpResponse response1 = client.execute(post);<br /><br />   InputStreamReader isr = new  InputStreamReader(response1.getEntity().getContent(),&quot;UTF-8&quot;);<br />   <br />   char buff[] = new char[ (int) response1.getEntity().getContentLength()];<br />   int n;<br />   StringBuffer sb = new StringBuffer();<br />   while ((n = isr.read(buff, 0, (int)response1.getEntity().getContentLength() - 1)) &gt; 0) {<br />    sb.append(buff, 0, n);<br />   }<br />   String a = sb.toString();  <br />   String arr[] = a.split(&quot;\n&quot;);<br />   String auth[] = arr[2].split(&quot;=&quot;); <br />   isr.close();<br />   <br />   URI uri1 = new URI(&quot;https://mail.google.com/tasks/ig&quot;);   <br />   HttpGet post1 = new HttpGet(uri1);     <br />   post1.addHeader(&quot;Authorization&quot;,&quot;GoogleLogin auth=&quot; + auth[1].trim());   <br />   HttpResponse response = client.execute(post1);<br />      <br />   isr = new  InputStreamReader(response.getEntity().getContent(),&quot;UTF-8&quot;);   <br />   buff = new char[ (int) response.getEntity().getContentLength()]; <br />   sb = new StringBuffer();<br />   while ((n = isr.read(buff, 0, (int)response.getEntity().getContentLength() - 1)) &gt; 0) {<br />    sb.append(buff, 0, n);<br />   }<br />   a = sb.toString();  //as String is easy ...  but with <br />   isr.close();<br /><br /><br />In response header i get the above message."
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-8317443337365296651
    name: William Entriken
    text: "I believe this is an implementation-specific problem. See https://groovy.329449.n5.nabble.com/Httpbuider-issues-td396109.html<br /><br />I couldn&#39;t find an Android Simulator out there, but low level problems like this might be investigated with ethereal.<br /><br />It doen&#39;t affect you, but there&#39;s a new version of this post at https://privacylog.blogspot.com/2010/09/updated-google-tasks-api.html"
updates:
  - date: 2010-08-12
    changes: "Made code a litte more readable, thanks to a note from Sandstrp, see comments."
---

New version at <https://privacylog.blogspot.com/2010/09/updated-google-tasks-api.html>

Here is the API for Google Tasks. It only supports your default list and it's read-only. And for free, it emails your task list to you. <b>(This mail WILL go to your spam folder)</b>

```sh
#!/bin/bash
cd $HOME
curl 

curl <https://www.google.com/accounts/ClientLogin> \
-d Email=<YOURUSERNAME@gmail.com> \
-d Passwd=YOURPASS \
-d source=privacylog \
-d service=goanna_mobile > token

AUTH=$(sed -n 's/Auth=/auth=/p' token)
HEADER="Authorization: GoogleLogin $AUTH"
URL="<https://mail.google.com/tasks/ig>"
curl --header "$HEADER" "$URL" > tasks

grep -o "\"\(name\|task_date\|notes\)\":\"[^\"]*\"" tasks > list

mail -s "Your tasks" <YOURUSERNAME@gmail.com> > list

rm token tasks list

If you want to have that to run daily at 7am, save that script to ~/googletasks.sh and run: <br>

```sh
chmod 700 ~/googletasks.sh
crontab -l > ~/tmpcron
echo "0 7 * * * $HOME/googletasks.sh" >> ~/tmpcron
crontab ~/tmpcron
rm ~/tmpcron

Update 2010-08-12: Made code a litte more readable, thanks to a note from Sandstrp, see comments.
