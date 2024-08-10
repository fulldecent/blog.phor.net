---
title: Some notes about my Google SOC project
tags: ["my-life"]
old-link: https://fulldecent.blogspot.com/2006/06/heres-some-notes-im-made-about-my.html
comments:
  - link: https://twitter.com/fulldecent/status/1668633621476028419
    name: '@fulldecent'
    text: The official X thread
---

Here&apos;s some notes I&apos;m made about my Google SOC project.

## Time

I am UTC-4, Lubos is UTC+2
Meet 6a–12p EST, and maybe after 2pm

## Compiling

1. find a version of kdelibs and kdebase that works
2. svn.kde.org:/home/kde/branches/work/kdelibs4_snapshot

> <span style="color:blue">[Seli]</span> 29.5.2006 was the day when dbus was merged in trunk, so before that trunk kdelibs_stable and kdebase should compile, if nothing else

## Debugging

Login as kde4 on a VT, run

```sh
(X :1 vt10 -terminate &amp;); sleep 5; DISPLAY=:1 xterm
```

> <span style="color:blue">[Seli]</span> that fires up another X with xterm and I run &quot;startkde&quot; from there (and configure ksmserver to ignore xterm in order to having one more each time)

## About editing other apps to work

> <span style="color:blue">[Seli]</span> I suppose you&apos;ll need that for saving session snapshots that won&apos;t be followed by a logout fulld&lt; oh, apps don&apos;t support that yet?
> <span style="color:blue">[Seli]</span> but I think you won&apos;t need to do that right from the start ... simply fix what shows up when it shows up
> <span style="color:blue">[Seli]</span> you shouldn&apos;t spend the whole time just fixing bugs
> <span style="color:blue">[Seli]</span> but there are two parts, saving and shutdown
> <span style="color:blue">[Seli]</span> and many apps don&apos;t see a difference between the two
> <span style="color:blue">[Seli]</span> so they do shutdown already while saving

## Progress

* 2006-06-23 - get (old) working code and get it running
* 2006-06-25 thru 2006-06-28 - understand how to pass messages directly to ksmserver for debugging (w/o GUI).
  * try to save some apps without shutting them down. and try to shutdown some apps w/o saving them.
  * make sure at least one app works with these 2 scenarios, for debugging.
    test this app thoroughly to have it starting up and shutting down with multiple instances.*
  * this may require adding some debug functions and interface to ksmserver
* 2006-06-29 thru 2006-07-02 - add interfaces to ksmserver to start an arbitrary session name, and to save sessions while running to arbitrary session names.
  think about how to autosave sessions.
* 2006-07-03 thru 2006-07-08 - think about data structures and file formats to keep track of multiple running concurrent sessions. think about metadata to keep for these (thumbnails, date last used..., time spent using these application**)
  implement them.
  * and add interfaces to allow saving a particular app to a particular session.
  * add interfaces to allow starting, saving, and shutting down multiple concurrent sessions.
* 2006-07-09 thru 2006-07-11 - try fixing another application to work with having multiple instances open, which are connected to different concurrent sessions which are also opening and closing independant of each other.
  * document how the application was fixed and publicize this information.
* 2006-07-12 thru 2006-07-18 - create a GUI to call interfaces that:
  * choose which session(s) to start (in the startup dialog)
  * choose which session(s) to save/close (in a new &quot;sessions&quot; dialog, and/or the logout/shutdown dialog)
  * allow you to move apps from one session to another with a drag and drop dialog?
* 2006-07-19 thru 2006-07-31 - release, debug, test, get feedback, fix bugs..., find people to get help for the next step
* 2006-08-01 thru 2006-08-10 - think of other application to integrate session support with like:
  * karm
  * plasma
  * workspace switcher
  * task manager
  * window list
  * taskbar
* 2006-08-11 thru 2006-08-20 - port to HEAD
* 2006-08-20 - deadline to finish
* 2006-08-21 thru 2006-08-25 - more porting, and headaches involved with that.