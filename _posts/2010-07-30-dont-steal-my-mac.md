---
title: Don't steal my Mac
tags: 
  - bonus 
old-link: https://fulldecent.blogspot.com/2010/07/dont-steal-my-mac.html
comments:
  - link: https://fulldecent.blogspot.com/2010/07/dont-steal-my-mac.html#comment-4794529858096537754
    name: William Entriken
    text: Do this on your iPhone too with information at https://www.tralfamadore.com/2008/08/location-tracking-using-relocatable.html
updates:
  - date: 2024-12-10
    changes: Added actual use case
---

Mac OS X 10.6 comes with CoreLocatation. Which is implemented as a command line program in [CoreLocationCLI](https://github.com/fulldecent/corelocationcli).

So... just

```sh
wget --spider "https://example.com/ping/devicename?$(~/Applications/CoreLocationCLI -once)" 2> /dev/null
```

in your crontab.

And put one of these on your server:

```php
<?php
# URL like https://example.com/ping/devicename
$file = preg_replace('/[^a-z]/', '', $_SERVER['PATH_INFO']);
$info = preg_replace('/#<>/', '', urldecode($_SERVER['QUERY_STRING']));
file_put_contents("cache/ping_$file", $_SERVER['REMOTE_ADDR']."\n$info\n");
```

RESULT: Computer phones home every few minutes to report it's physical location.

---

Actually this came in handy. When [I was kidnapped one day in Manila](https://fulldecent.blogspot.com/2017/08/i-was-kidnapped-in-manila-and-lived-to.html) this helped with tracking. Randomly. They should have not opened my computer!
