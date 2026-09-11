---
title: "Firefox security case study: Mozilla's CSS :visited solution is still vulnerable"
tags:
  - security
old-link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html
comments:
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-5877805008057028986
    name: Alberto Armandi
    text: "is there any way to exploit this directly ? i tried to post your blog link on Hacker News ( read <https://news.ycombinator.com> ) but seems people mostly ignored it. Mr Baron and Mozilla&#39;s Team should be informed."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-1024628167405991906
    name: Anonymous
    text: "This is totally crazy."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-8290526344360943382
    name: Alberto Armandi
    text: "Honestly, after 1 day of coding, hacking and researching i haven&#39;t found a viable way to exploit the vulnerability you mention here."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-5116718469940124286
    name: William Entriken
    text: "Hello Alberto, thanks for the info and links. I have updated this blog page which contains two active exploits. The second one shows how to apply this to sensitive financial transactions. I will not provide the code, but the javascript alert could be replaced with code that causes the user to send information to a server, or does something nasty based on the fact that it is known the user has logged in to a given website and has the session cookies necessary to make transactions. DISCLAIMER: NOTHING IN THIS POST OR COMMENT DEMONSTRATES A VULNERABILITY, WORKAROUND, OR PLANNED FEATURE UPGRADE OF ZECCO.COM. INSTEAD THIS SHOWS A PROBLEM WITH THE CURRENT W3C WEB STANDARDS AND MOZILLA&quot;S PROPOSED IMPLEMENTATION."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-8130330158262939060
    name: Alberto Armandi
    text: "I have just purchased the domain getComputedStyle.com and i intend to publicly release a javascript exploit that is based on the technique you show here to motivate Mr. Baron and the others to switch the API back to the normal behavior. Most of my web apps are breaking because they are based on getComputedStyle, but not for malicious purposes. None of the techniques i have tried until now have worked .What i tried to far is : 1)getting element offsetHeight after it changed color. Not exploitable, returns always the same value for both kind of links. 2)Changing your crafted CSS adding special positioning rules and trying to get the position of the box on the screen by getting its coordinates does not work either. 3) The old-fashioned approach, setting a background url(&#39;bg.jpg&#39;) works erratically and only if the file pointed is an image and not a php or the likes. 4) I am now trying to hook up to event DOMAttrModified to see if can detected the color change, but i doubt it is going to work because normally it is a script that fires a change in color. In this case it is directly the css trick. I would love to know your thoughts about the matter. Best Regards"
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-7500410896137239161
    name: William Entriken
    text: "Hello Alberto, are you referring to the enso-now site? How are you using the getComputedStyle? All of the tricks you describe are implementation dependent and should not work. If they do work, that is a bug in Mozilla from following their own specification and it will be fixed. The web-designer will be prevented from making good use of getComputedStyle. Their motivation was to make the web safer. What I am demonstrating is that regardless of Mozilla&#39;s changes, which only affect legitimate designers like yourself, there will always be a way to use :visited for nefarious purposes."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-8094838356910861421
    name: Anonymous
    text: "This doesn&#39;t work for me as the &quot;here&quot; on the page is duplicated. You should fix this. I&#39;m on firefox by the way"
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-5759491426239301858
    name: William Entriken
    text: "Yes, there&#39;s two Here&#39;s. But one has no instruction in front of i, so Boone will click on it."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-6354369005921155923
    name: Resuna
    text: "OK, it&#39;s a social engineering attack based on getting people to follow a link based on hiding visited links selectively using color. The exposure here is a tiny tiny fraction of the exposure using getComputedStyle. You can&#39;t check 20,000 links in a page this way. This is like trying to break people&#39;s passwords by trying to log on to the site, instead of downloading the hashed password file and feeding it to rainbow tables. It&#39;s just not a practical attack vector for most of the problem space."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-8456678263053282415
    name: William Entriken
    text: "@Resuna good analysis, I&#39;m changing my stance on this"
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-7529047859843402773
    name: Anonymous
    text: "I am really not sure whats supposed to happen here. I click the first link, nothing happens (why does even nothing happen?) i press the second one, and i get the alert. But i actually never visited once of the pages before."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-5936258119751214069
    name: William Entriken
    text: "Sorry, this is not clearer. Please only click the link next to &quot;Click here for free wallpapers&quot; and ignore the other link. I have fixed the javascript on the first link. Thanks."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-7661721874834402281
    name: ovi
    text: "thank you! this helped me lots."
  - link: https://privacylog.blogspot.com/2010/08/mozillas-css-visited-solution-is-still.html#comment-7816650059593349552
    name: ovi
    text: "Thank you, this helped me lots!"
---

Javascript running on browsers that implement W3C standards today can allow the present page to find pages the user has previously visited. This would be very useful as part of a XSS attack where you needed to know if the user has already authenticated against a login system.<br>

{: .margin-note}
Such as a XSS attack where you can [trade stocks on other people's investment accounts](https://privacylog.blogspot.com/2008/10/pre-announcement.html).

Since this information is very useful to an attacker, Mozilla is preparing to break compliance with APIs to stop this vector:

- `getComputedStyle()` et al. will not leak information about page visited status
- Differences in styling for visited links versus styling for unvisited links will be restricted against changes in opacity, visibility, and many other ways
- These rules propagate and are immune to CSS tricks like [combinators](https://www.w3.org/TR/css3-selectors/#combinators) and nesting

These are detailed at [Mozilla's privacy CSS blog post](https://hacks.mozilla.org/2010/03/privacy-related-changes-coming-to-css-vistited/)

But this issue is too big to settle for a "solution" that breaks the API, does so ungracefully, and still does not solve the problem. Here is a demonstration that will still work if Mozilla goes through with this cowboy (read: Microsoft) attitude to web standards. The first one tells you if you visited purple.com before and the second one tells you if you have logged in to Zecco.com:

<div style="border: 1em solid #ccc; margin: 0 2em; padding: 1em;">
<a href="https://purple.com/" id="shownotvisit" style="text-decoration: none;">Click for free wallpapers </a>&nbsp;<a href="javascript:alert('you did not visit purple.com before')">here</a> (you didn't visit purple.com before)<br>
<a href="https://purple.com/" id="showvisit" style="text-decoration: none;">Click for free wallpapers </a>&nbsp;<a href="javascript:alert('you visited purple.com before')">here</a> (you visited purple.com before)</div>

<div style="border: 1em solid #ccc; margin: 0 2em; padding: 1em;">
<a href="https://trading.zecco.com/zecco/genericRequest.nexa?stylesheet=zcoSiteTemplate" id="shownotvisit" style="text-decoration: none;">Click for free wallpapers </a>&nbsp;<a href="javascript:alert('you did not visit zecco.com before')">here</a> (you didn't visit zecco.com before)<br>
<a href="https://trading.zecco.com/zecco/genericRequest.nexa?stylesheet=zcoSiteTemplate" id="showvisit" style="text-decoration: none;">Click for free wallpapers </a>&nbsp;<a href="javascript:alert('you visited zecco.com before')">here</a> (you visited zecco.com before)</div>

You could probably do a better job than me of styling these elements, but either way, the attack vector still exists.
