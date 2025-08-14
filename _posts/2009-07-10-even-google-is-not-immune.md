---
title: "Security case study: Google Voice"
tags: 
  - security	
old-link: https://privacylog.blogspot.com/2009/07/even-google-is-not-immune.html
comments:
  - link: https://privacylog.blogspot.com/2009/07/even-google-is-not-immune.html#comment-9167516521980163702
    name: William Entriken
    text: "Here is an example of how to do this in an enterprise system like Google: Find the line that connects your firewall to your server farm, then split the wire so that all requests also go to another server farm. The second wire is on a READ ONLY network interface, and can't disturb the normal network. The second farm drops 99% of packets randomly. The remaining are analyzed for non-application-specific attacks. Output from this system goes to the firewall. This method would have prevented my attack."
---

Posted at [best number on Google Voice](best-number-on-google-voice) we see a enumeration script run against Google Voice. This method uses multiple requests to acquire all phone numbers available on the Google Voice service. Probably not an intended use of the system.

New product offerings are a black hole for exploits, everyone wants to be the first one in before the hole gets so big it closes on itself. When making fixes to a large system like this, the rules are:

* Don't mess anything up or slow down the server
* Don't mess anything up or slow down the server
* Add features

The problem is, there is not adequate logging or analytics being performed on incoming requests to google.com. This isn't rocket science, we're talking about "someone just sent 10+ million web requests in a row... let's block them" types of no-brainers.

Maybe logging is expensive or maybe concurrency is an issue. Facebook's databases (last I checked) have a ratio of 10 reads to 1 write -- writes are concurrent, reads work off of cached copies. If that's the case one solution is to vertically partition the system. Physically split the wire coming into the farm, use two web gateways. One gateway fans out to applications servers. One gateway fans out to analytics. Those functions are different, have different access needs, and databases can be set up to take advantage of that.
