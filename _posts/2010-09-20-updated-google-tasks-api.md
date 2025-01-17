---
title: "Google Tasks API case study"
tags:
  - user-interface
old-link: https://privacylog.blogspot.com/2010/09/updated-google-tasks-api.html
comments:
  - link: https://privacylog.blogspot.com/2010/09/updated-google-tasks-api.html#comment-5436550335630525755
    name: William Entriken
    text: "So now when you wake up, the coffee is already brewed and the task list is automatically printed. Put a wireless printer in the kitchen. No, I&#39;m serious."
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-1119236104878685268
    name: William Entriken
    text: "Use these lines instead because they are cross platform (sed parses escape sequences differently on Mac and Linux):\n  title=$(perl -ne &#39;die \"$1\\n\" for m/&quot;selected&quot;&gt;([^&lt;]+).*/&#39; list 2&gt;&amp;1)\n  perl -ne &#39;print \"[ ]  $1\\n\" for m/&quot;text&quot;&gt;([^&lt;]+)/&#39; list &gt;&gt; message"
  - link: https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html#comment-649013821744843694
    name: fab31
    text: "A quick python rewrite:  <https://pastebin.ca/1994952>"
  - link: https://privacylog.blogspot.com/2010/09/updated-google-tasks-api.html#comment-unknown
    name: William Entriken
    text: "Great job fab31! here is full text for posterity:\n  A quick python rewrite, can be a start to clean up & improve...\n\n```python\n#!/usr/bin/env python\nYOURUSENAME = raw_input('login:')\nYOURPASSWORD = raw_input('password:')\n\nimport re\nfrom urllib import urlencode\nimport urllib2 as urllib\n\nlogin = urllib.urlopen('https://www.google.com/accounts/ClientLogin', data=urlencode({\n  'Email'  : YOURUSENAME+'@gmail.com' ,\n  'Passwd' : YOURPASSWORD             ,\n  'source' : 'privacylog'             ,\n  'service': 'goanna_mobile'          ,\n}))\n\ntoken = login.read()\nAUTH = (line.split('=', 1)[1] for line in token.split('\\n') if line.startswith('Auth=')).next()\nHEADER = {'Authorization': 'GoogleLogin auth='+AUTH}\nURL = \"https://mail.google.com/tasks/m\"\nmain = urllib.urlopen(urllib.Request(URL, headers=HEADER))\n\ndata = main.read()\nfile('/tmp/out.html', 'w').write(data)\n\nr = re.compile('.*\"([0-9:]{20,25}:0)\"')\nr2 = re.compile('selected=\"selected\">([^<]+).*')\n#r3 = re.compile('<td +class=\"text\" *>(.*)')\nr3 = re.compile('(?ms)<input +type=\"checkbox\" +name=\"tc\" +value=\"(\\d+:\\d+:\\d+)\".*?class=\"text\"> *(.*?) *</td></tr>$')\n\nfor line in data.split('\\n'):\n  m = r.match(line)\n  if m:\n    list_id = m.groups()[0]\n    site = urllib.urlopen(urllib.Request(URL+\"?listid=\"+list_id, headers=HEADER))\n    content = site.read()\n    title = r2.findall(content)[0]\n    tasks = r3.findall(content)\n    print title.center(80)\n    for t in tasks:\n      if t:\n        print t\n    open('/tmp/tid_'+list_id, 'w').write(content)\n```"
---

This post is an update of [https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html](https://privacylog.blogspot.com/2010/07/api-for-google-tasks.html).

> **Update 2011-05-12**: The official API is now at [https://code.google.com/apis/tasks/index.html](https://code.google.com/apis/tasks/index.html) thanks to Josh for the ping.

There is no official API for Google Tasks at this time. But, below is full read-only access to all your tasks across all your lists. I'm including a simple app that sends this to you via email **(This mail WILL go to your spam folder)**. I have this running at home to automatically print out a copy of all task lists periodically.

```bash
#!/bin/bash

cd /tmp
rm -f message; touch message

curl "https://www.google.com/accounts/ClientLogin" \
-d Email=<YOURUSERNAME@gmail.com> \
-d Passwd=YOURPASSWORD \
-d source=privacylog \
-d service=goanna_mobile > token

AUTH=$(sed -n '/Au/s/A/a/p' token)
HEADER="Authorization: GoogleLogin $AUTH"
URL="https://mail.google.com/tasks/m"
curl --header "$HEADER" "$URL" > main

for list in $(grep -o '"[0-9:]{20,25}:0"' main | tr -d '"' | sort -u)
do
    curl --header "$HEADER" "$URL?listid=$list" > list
    echo >> message
    title=$(sed -n 's|.*selected="selected">&([^<]\+).*|\1|gp' list | head -n1)
    echo "### $title ###" >> message
    sed -n 's|([^<]{1,}) .*|[  ] \1|p' list >> message

    # This one below indents sub tasks but only works on Linux
    # sed -n -e 's/.*&nbsp;.*//p' -e 's|([^<]+).*|\1|p' list | sed -n -e '/./!{N;s/\n/  /}' -e '/./p' | sed 's/^/[ ]  /' >> message
done

mail -s "Weekly review" <YOURUSERNAME@gmail.com> < message

rm token main list message
```

Notes for Mac: use `*` instead of `+`.
