---
title: "Technical notes about KDE ksmserver"
tags:
  - technical 
old-link: https://fulldecent.blogspot.com/2010/08/technical-notes-about-kde-ksmserver.html
comments:
  - link: https://fulldecent.blogspot.com/2010/08/technical-notes-about-kde-ksmserver.html#comment-2136523330522637038
    name: Anonymous
    text: uhm ... ettrich? he didn't touch that thing for close to 10 years ...
  - link: https://fulldecent.blogspot.com/2010/08/technical-notes-about-kde-ksmserver.html#comment-6551060087545286741
    name: William Entriken
    text: Thank you. Post updated to reflect a "<10 years" definition of "currently maintained by".
---

Hello all, here are some notes from working on KDE bugs [60894](https://bugs.kde.org/show_bug.cgi?id=60894) and [62157](https://bugs.kde.org/show_bug.cgi?id=62157) on contract with Google. ksmserver is an important part of KDE software currently maintained by Lubos Lunak and that made it difficult for me as an outsider to make large changes. I am including here notes regarding code I wrote in [branches/work/kdebase_appgroups](https://websvn.kde.org/branches/work/kdebase_appgroups/) and [branches/work/soc_ksm/](https://websvn.kde.org/branches/work/soc_ksm/) while working under Lubos.

### WHERE DO I SAVE STATE DATA?

On Thursday 13 July 2006 18:01, Full Decent wrote:

> kwin starts in `KSMServer::init()`
> the session to restore is later chosen in `KSMServer::autoStart1Done()`
>
> kwin can be saved when an appGroup is closed and would lose the window
> placement for those windows.
>
> for these 2 reasons, I think kwin should not save information in
> config/session/kwin_* and should instead save this information in
> config/kwin_windowplacements for all sessions together.
>
> we had also discussed adding calls to kwin: `saveWindowPlacements( StringList )`, `discardWindowPlacements( QStringList )`
>
> This will remove some functionality. For example, if you crash and
> then choose to resume last logout, the window placements will be those
> from the autosave, not the last logout.
>
> This is not only about crashing but e.g. also about having several sessions saved and "randomly" selecting one of them to restore.
>
> do you think this is the best way to go?

Every session must be able to be restored as it was, so for the normal cases config/session/kwin_* needs to be used. I guess app groups can use a separate file when they need separate API anyway.<br>
<br>

### HOW DOES PENDING SHUTDOWN WORK? ###<br>

Protection timeout is there for the case when an application doesn't respond to save request in time. Since Konqueror generally works fine that could mean that you send the request incorrectly or you don't handle the protection timeout correctly. Since I see quite some error messages about XSMP errors the incorrect sending of requests seems likely.

Also, other things I noticed while checking the sources:

- KWin is not session restored, so window positions are not restored. We
  already talked about this. Related to this is also the fact that the wm is
  just started as startApplication( wm ) instead of the old startApplication(
  wmCommands ), so it doesn’t get the -session argument
- you changed (well, removed) pendingShutdown* code that was in shutdown().
  That’s wrong. The code is there so that if a shutdown request comes before
  the session is fully restored, the shutdown is done properly when kmserver
  finally enters the Idle state. If you remove these vars, it can no longer
  work properly.
- ”//why not just KWin::turnOffFocusStealing() and then treat kwin as
  normal?” - because this is not only about focus stealing prevention. KWin
  needs to be the very first one while saving because it also needs to save
  e.g. window stacking that might change later during save (because of “do you
  want to save changed file?” type dialogs)
- the kdWarning() in cancelShutdown() is intentionally kdWarning() and not
  kdDebug() - kdWarning() is visible even in normal non-debug release builds
  and many apps are buggy and cancel shutdown when they should not
- when the window manager unregisters (e.g. after “kwin –replace”), clientWM
  is not reset

### WHY DOES KWIN SHUTDOWN FIRST

> I'm not sure exactly how kwin works, but I assume it keeps track of
> information about windows and when the window closes, it discards that
> information. I think adding two functions to kwin: stopDiscarding()
> and resumeDiscarding() will fix this. Just before shutting down or
> closing an appGroup, ksmserver will tell kwin to stopDiscarding() and
> any clients that shut down will be kept in kwin's memory. Ksmserver
> will call resumeDiscarding() when appGroup closing is finished or if
> the shutdown was cancelled and any clients that quit will be handled
> normally.

KWin keeps information about windows, but only existing ones, that's not how session management works. For session management when saving all info about windows is saved to the session config file and when restoring it's read again and matched against new windows. Making KWin not discard such data for destroyed windows would probably require a big overhaul and I don't think that'd work very well anyway - what if KWin exits e.g. at session shutdown?<br>

### X

> > I want to remove sessionGroup and defaultSession() from KSMServer and
> > instead only rely on sessionName -- I think this will reduce
> > duplication and confusion. Is there reason this is a bad idea?

No, looks good.

### isWM() function

> > I want to replace isWM() with getWM() and getInactiveWM() to avoid
> > duplication and confusion. I think this change is very
> > uncontrovercial, but I'd still like to ask you if you think that is
> > inappropriate?

I suppose getWM() may simplify some of the loops. Although the name sounds a bit inappropriate, maybe clientWM(). I have no idea what you mean with getInactiveWM().

### Various notes

> [ RE older branches/work/ksmserver4_entriken code in SVN ]<br>

> Please let me know what you think about the DBus call, and there is
> anything I can do before this is committable.

Looking at the sources, it looks fine, with some things listed below. However, it seems session management in trunk is currently generally broken (applications crash when saving session) and as such I actually cannot really test the branch. Could you have a look at that please?

startup.cpp: // WE: how can there be multiple WM's?

- With non-xinerama multihead there's one WM per screen. Which also in turn
means that the clientWM() changes are wrong, I haven't realize this sooner.
shutdown.cpp: // WE: maybe it would be better here to ensure that the session is not saved and abort immediately
- Huh? See bug #100935.

shutdown.cpp: // WE: Is this necessary? I thought once kwin saves changes during SmsSaveYourself, that's the end of it

- Yes, it is. Again, use svn annotate to find the bugreport that lead to this.
