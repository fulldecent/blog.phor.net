---
title: "How to add iPhone presence indicator on your website"
tags: 
  - how-to
old-link: https://fulldecent.blogspot.com/2008/06/iphone-presence-indicator-for-your.html
---

You can add presence indication to your website, i.e. it tells people whether your phone is on or not. This works for any phone that can check mail on a automatically.

Procedure:

1. Set up a mail server (`apt-get install solid-pop3d`)
2. Create a user on the system and set up your phone to access that mailbox
3. Have your website poll a file that the mail server will touch (/var/lib/solid-pop3d/bulletins/)

Example:

<https://phor.net/personal>

Notes:

1. Make sure your filesystem supports atime for /var

2. `update-rc.d solid-pop3d defaults`

3. Sample code:

   ```php
   $stat = stat('/var/lib/solid-pop3d/bulletins/');
   if (time() - $stat[8] > 20*60)
     echo 'My iPhone is off (it was last on '.reltime($stat[8]).')';
   else
     echo 'My iPhone is currently on';
   ```
