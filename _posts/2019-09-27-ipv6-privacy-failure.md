---
title: "IPv6 hurts your privacy, removes plausible deniability and is on by default"
tags: ["privacy"]
old-link: https://privacylog.blogspot.com/2019/09/ipv6-hurts-your-privacy-removes.html
---

IPv6 is a privacy joke for consumer devices.

It is enabled by default on your computer, a quick experiment shows how you are insecure, and instructions are given to turn it off.

- UPDATED 2019-10-07: Clarifying here that IPv6 is great for servers and people that WANT to publicly expose servers on the internet. The problem only affects consumers that want some amount of privacy or plausible deniability for their internet activity.

## Proof of what is broken

First connect your computer and phone to some internet connection, maybe you have already done this step. On your phone, go to internet search and search "what is my ip address" and open the first few results. Look for the longer IPv6 address.

![Your IP address](/assets/images/2019-09-27-ipv6-privacy-failure.webp)

Now do the same thing on your phone. It has a different number. This is a huge problem and it demonstrates a failure of the IPv6 protocol design and/or implementations.

It is now [public knowledge](https://en.wikipedia.org/wiki/Room_641A) that governments [record all internet activity](https://en.wikipedia.org/wiki/Edward_Snowden) of [innocent people without a warrant](https://www.youtube.com/watch?v=edP95iJWVBI)</a> for [perpetuity](https://en.wikipedia.org/wiki/Permanent_Record_(book)) and use [knowledge of private, but legal, activity](https://www.youtube.com/watch?v=edP95iJWVBI&amp;t=26m12s) to [embarrass and discredit black people and people that don't support war](https://en.wikipedia.org/wiki/COINTELPRO).

So this is what those governments, and every website you visit sees:

![What they see](/assets/images/2019-09-27-ipv6-privacy-failure-2.webp)

They see your computer connected Wikipedia learning about those classified programs above. And your neighbor's phone (on the same Wi-Fi) reading Facebook.

The different colors represent different IP addresses.

## How it used to be

IPv6 adoption rises constantly and worldwide is [at about 33% now](https://www.google.com/intl/en/ipv6/statistics.html). When you are using the IPv4 (the other option) the internet still works just as good for you, but all the devices in your house share the same publicly-visible address. (Try the same experiment above but check the IPv4 addresses!)

![What they see 2](/assets/images/2019-09-27-ipv6-privacy-failure-3.webp)

The individual connections cannot easily be corroborated. We don't know if the evil anti-war person visiting Wikipedia is the same person with Twitter account @fulldecent or if they are the person logged in as John Example on Facebook.

If you ever DIDN"T get a subpoena from the RIAA or MPAA when you downloaded an MP3, or DIDN"T have [your random sex surveilled because you support black civil rights](https://en.wikipedia.org/wiki/COINTELPRO) then it's because you avoided IPv6.

In the United States 9th district, courts have held that activities which happen on your internet connection using IPv4 cannot be directly attributed to you, absent other evidence, because those activities could have been done by your neighbor on your Wi-Fi. Cobbler Nevada, LLC v. Gonzales, 901 F. 3d 1142 - Court of Appeals, 9th Circuit 2018.

> The district court properly dismissed Cobbler Nevada's claims. The direct infringement claim fails because Gonzales's status as the registered subscriber of an infringing IP address, standing alone, does not create a reasonable inference that he is also the infringer. Because multiple devices and individuals may be able to connect via an IP address, simply identifying the IP subscriber solves only part of the puzzle. A plaintiff must allege something more to create a reasonable inference that a subscriber is also an infringer. Nor can Cobbler Nevada succeed on a contributory infringement theory because, without allegations of intentional encouragement or inducement of infringement, an individual's failure to take affirmative steps is internet connection is insufficient to state a claim.

To be clear IPv6, even with current "privacy extensions" still gives you a unique IP address, even if for a temporary time. The above legal opinion read in the converse states that a direct infringement claim would be successful against a person using IPv6 because other devices and individuals are not able to connect using the same IP address at the same time.

## How to turn it off

On macOS just do:</div>

```sh
networksetup -setv6off Ethernet &&  networksetup -setv6off Wi-Fi
```

Or do it under System Preferences

![Turn off IPv6 Mac](/assets/images/2019-09-27-ipv6-privacy-failure-4.webp)

Tweet me if you have instructions for other systems.

Your internet will not run any slower, and it may use less battery.

## Common feedback

Here are knee-jerk responses from uninformed people I have heard when presenting these topics.

- **We are running out of IPv4 addresses so we need IPv6.**

  - Ask anybody that runs a server on the internet. Their service provider sells IP addresses because some websites need a dedicated IP address. These addresses are cheap, maybe $4 per year retail. That is overpriced retail when selling to small businesses that are making money and won't shop around. The biggest consumers of IP addresses like your ISP or mobile phone carrier get cheaper rates.

  - Update: thank you&nbsp;@noIPv6, for this link:&nbsp;<https://auctions.ipv4.global/prior-sales>

- **But I saw a website that says we already ran out of IPv4 addresses.**

  - Ignore what you saw and follow the money, see above. We have not run out of addresses.

- **Carrier-grade routers can't keep up with IPv4 because it is too complicated, IPv6 fixes that.**

  - I support carrier use of IPv6 for their infrastructure! Carriers can deliver IPv4 to you on top of that. That's not a problem, that's beyond the scope of this article.

## Other notes related to IPv6, keep alive and energy usage

Update: thank you @noIPv6 for this link <https://www.circleid.com/posts/81072_megawatts_keepalive_ipv6/>

Also related: <https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/OptimizeVoIP.html>

## Path forward

There are a lot of great things with IPv6. But for consumer use, the privacy problem is unacceptable. The original version of IPv6 was designed so that every device would send its globally-unique serial number with all traffic. That makes cookies mostly obsolete because you are personally identified by default on every website you visit. It's like tattooing everybody's passport number on their face.

<mark>This demonstrates that engineers who originally drafted IPv6 do not understand the customer needs for privacy.</mark>

The solution is that every consumer access point to the internet should shuffle (and translate) IP addresses from its internal network versus the outside world. Also every consumer device should use a new randomly generated IP address for every outbound connection it makes. This is exactly how the internet works for the vast majority of people today (for simplicity I am conflating IP addresses and port numbers). This is how IPv4 works.

Until then, we should recommend to the (consumer) public to turn off IPv6.

The best work I have seen so far is [RFC 7721](https://www.ietf.org/rfc/rfc7721.txt). But still it seems nobody has considered providing this IPv4 level of privacy on top of IPv6.

I would be happy to draft this into a formal proposal and am looking into it.
