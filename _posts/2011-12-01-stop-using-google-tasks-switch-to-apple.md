---
title: "iCloud interface case study: how to only show reminders"
tags:
  - user-interface
old-link: https://privacylog.blogspot.com/2011/10/stop-using-google-tasks-switch-to-apple.html
comments:
  - link: https://privacylog.blogspot.com/2011/10/stop-using-google-tasks-switch-to-apple.html#comment-4346638616049646308
    name: William Entriken
    text: "Of course Apple still has one ace up the sleeve here: contact based reminders. It would pull up a reminder when you call, email or text a person. And it could alert you if that contact physically comes in close proximity of you (based on friends and family location sharing)."
  - link: https://privacylog.blogspot.com/2011/10/stop-using-google-tasks-switch-to-apple.html#comment-5459943631317975893
    name: Anonymous
    text: "I wish this actually worked, I have tried this bookmarklet with chrome and IE with no luck. I wish I could view only my tasks in icloud but not luck I suppose.."
  - link: https://privacylog.blogspot.com/2011/10/stop-using-google-tasks-switch-to-apple.html#comment-7834417488005982859
    name: William Entriken
    text: "This works for me on Mac 10.7/Chrome 16.0.912.63 and Win7/Chrome. First load https://www.icloud.com/#calendar then run the bookmarklet. What browser version are you using?"
  - link: https://privacylog.blogspot.com/2011/10/stop-using-google-tasks-switch-to-apple.html#comment-8968492852426646226
    name: Anonymous
    text: "The &quot;link&quot; in the bookmarklet seems to be broken for me - it ends at the end of the first getElementsByTagName function call. Does anyone have a working bookmarklet?"
  - link: https://privacylog.blogspot.com/2011/10/stop-using-google-tasks-switch-to-apple.html#comment-8258404242252704446
    name: William Entriken
    text: "I&#39;m having trouble with Blogger, here is the link  javascript:(function(){a=document.getElementsByTagName(&quot;iframe&quot;)[0].contentWindow.document;a.getElementsByClassName(&quot;month-tab&quot;)[0].style.display=&quot;none&quot;;a.getElementsByClassName(&quot;sc-split-divider-view&quot;)[0].style.display=&quot;none&quot;;a.getElementsByClassName(&quot;todo-list-container&quot;)[0].style.left=&quot;0&quot;;a.getElementsByClassName(&quot;todo-list-container&quot;)[0].style.width=&quot;100%&quot;;})();  please let me know if that works"
  - link: https://privacylog.blogspot.com/2011/10/stop-using-google-tasks-switch-to-apple.html#comment-4679774528341302598
    name: Samuel Clemens
    text: "Negative, doesn&#39;t work.  1. Saved original bookmarklet link to my bookmarks bar in Chrome 16.  2. Edited the bookmark to use the javascript in your comment above.  3. Went to iCal&#39;s calendar view, then clicked the bookmarklet.  No love, nothing happened."
  - link: https://privacylog.blogspot.com/2011/10/stop-using-google-tasks-switch-to-apple.html#comment-795219711647806507
    name: William Entriken
    text: "Mark Twain, just to be specific try this:  https://www.youtube.com/watch?v=JlY_xIAZO8M"
---

Stop using Google Tasks, switch to Apple Reminders

The result is clear: Apple releases a new product with one sexy new feature and a better interface but it's not compatible with any Google products, Google is left in the dust. Next year Google will copy all the innovation and Apple won't improve anything.

| Google Tasks | Apple Reminders |
|--------------|-----------------|
| Can input tasks, due dates, reminders | Can input tasks, due dates, reminders, and location based reminders |
| Switching task lists requires two clicks (Google Calendar & iPhone web page) | Can view all task lists at once (iCal) or swipe to switch lists (iPhone) |
| Can view tasks online at <https://mail.google.com/tasks/canvas> (looks better than Apple) | Can view tasks online at <https://www.icloud.com/#calendar> (interface sucks) |
| Viewable on iPhone through slow website | Viewable on iPhone with fast app |
| Integrates with Gmail and Google Calendar | Integrates with iCal |
| Printing looks retarded, one page per list (can print from link above) | Printing looks semi-retarded, but you can print all lists at once using iCal |
| Will copy all Apple's features and improve, someday | Won't ever improve their product and will never sync with Google |

You can view the reminders online at iCloud.com, but it bothers you will a full size calendar in the middle of the screen. To fix that, use this bookmarklet:

```javascript
javascript:(function(){a=document.getElementsByTagName("iframe")[0].contentWindow.document;a.getElementsByClassName("month-tab")[0].style.display="none";a.getElementsByClassName("sc-split-divider-view")[0].style.display="none";a.getElementsByClassName("todo-list-container")[0].style.left="0";a.getElementsByClassName("todo-list-container")[0].style.width="100%";})();
```

Basically, save that as a bookmark open iCloud to your calendar and then run that bookmark.

![Hide calendars](/assets/images/2011-12-01-stop-using-google-tasks-switch-to-apple.webp)
