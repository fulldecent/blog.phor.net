---
title: "Current notes patches diff kdesm"
tags: ["my-life", "programming"]
old-link: https://fulldecent.blogspot.com/2006/07/current-notes-patches-diff-rupd-my.html
comments:
  - link: https://x.com/fulldecent/status/1678890912863141890
    name: '@fulldecent'
    text: The official X thread
---

## Current notes

PATCHES: `diff -rupd`

MY HOME: svn+ssh://xxxx@svn.kde.org/home/kde/branches/work/soc_ksm

## Schedule/progress/todo

- [x] Get code up and working
  - [x] Got 3.5.3 stable tarball and created soc_ksm branch
- [x] Fix bugs in current sessions implementation
  - [x] WM now handled specially, code reorganized to fix State model
- [x] Auto-save sessions and recover from crashes
  - [x] Sessions autosave every 20 minutes, after a crash you get to choose what session to start. Sessions keep track of when they were last saved.
- [ ] (20060707) Create data structures to keep track of an AppGroup for each client application
- [ ] (20060707) Create DCOP calls to open or close all apps in an AppGroup (while KDE is running)
- [ ] (20060708) Create DCOP call to list all AppGroups (for integration)
  - [ ] NOTIME Think about how to save thumbnails or other useful metadata to AppGroups/sessions
  - [ ] maybe time spent using apps in AppGroup (int with karm), date last used, ...
- [ ] (20060710) Test several application that are open in different AppGroups at the same time and open and close them to make sure they work. Hopefully, it will magically work.
- [ ] (20060714) Create DCOP calls to associate/disassociate apps with AppGroups. I&apos;m not yet sure how to itentify apps, from inside and out ksmserver.
- [ ] (20060718) Create a better GUI to choose a session on startup and tie into the kcontrol module to decide whether to show the dialog.
- [ ] (20060720) Create a GUI to create/start/stop AppGroups and to associate/disassociate apps to groups. It would be nice to drag and drop apps to AppGroups.
- [ ] (20060722) Release AppGroups feature into the wild! Handle (immense) feedback. Start making contacts for the next step.<br>

There is no specific schedule yet for the remaining tasks.

- Early August - think of other application to integrate session support with like:
  - karm
  - plasma
  - workspace switche
  - task manager
  - window list
  - taskbar
- Mid August—port to KDE4 TRUNK and merge with other change made from 3.5.3 to TRUNK.
- 20060820 - Project deadline to finish
- Late August - more porting, and headaches involved with that. And bonus tasks<br>

## Bonus tasks

- [ ] Remove ellipsis if logout is not confirmed
- [ ] look in code for // at the beginning of the line
- [ ] able to start no wm
- [ ] TODO: turn the feedback widget into a list of apps to be closed
- [ ] move some ksm functionality into kinit??
- [ ] edit the README: shutdown phases, talk little about XSMP

## How to run it

```
xhost +
su kde4
Xnest :1& sleep 5; DISPLAY=:1 xterm
xterm: startkde
```

> <span style="color:blue;">[Seli]</span> I suppose you&apos;ll need that for saving session snapshots that won&apos;t be followed by a logout<br />
> <span style="color:red;">[fulld]</span> oh, apps don&apos;t support that yet?<br />
> <span style="color:blue;">[Seli]</span> but I think you won&apos;t need to do that right from the start ... simply fix what shows up when it shows up<br />
> <span style="color:blue;">[Seli]</span> you shouldn&apos;t spend the whole time just fixing bugs<br />
> <span style="color:blue;">[Seli]</span> but there are two parts, saving and shutdown<br />
> <span style="color:blue;">[Seli]</span> and many apps don&apos;t see a difference between the two<br />
> <span style="color:blue;">[Seli]</span> so they do shutdown already while saving
