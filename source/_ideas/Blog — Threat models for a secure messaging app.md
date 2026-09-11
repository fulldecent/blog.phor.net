TITLE?: Manifesto for a Secure Chat Client

# What is the goal here

Assume that Signal App is an honest attempt to create a secure messaging system. Then describe several attack scenarios that Signal is not designed for and show recommendations on how to improve the design to address them.

---

# TODO

- [ ] Add sources for all claims

-

Threat vector

---

# How to design a secure messaging app/system

I have seen many "secure messaging" apps in the 2010s and they all seem to be making progress towards protecting your communications in some way, while simultaneously promoting their own interests.

Here is a user-centric review of how secure messaging should look and some basic designs that can be incorporated.

## What is security?

> Security is the design of a product or situation such that stakeholders are protected from certain threat vectors.

Back in college I could have logged into anybody's Facebook account in my dorm by opening Firesheep and hijacking their session cookies. The solution is that Facebook and others simply enforce HTTPS on websites. Back then you could have said the system was still insecure because the NSA/CIA could get your data, consumer goods companies would would use your private messages to influence what products you buy, and others would build up psychological models on you to influence your voting.

In 2005 if you tried to convince somebody these threats were likely to affect you, friends would put you on "batshit crazy" somewhere between Illumunati and Flat Earthers. That's the same year the NSA recruited me to work on what may or may not have been that exact project. Today, your friends are asking you questions like "I sent this photo of my feet in Facebook messenger and didn't type this ANYWHERE but all I'm getting now is ads for anti-fungal foot cream, isn't that supposed to be encrypted?"

So again, "security" is just a relative word like "won". You don't say you "win" at tennis—Serena Williams didn't beat tennis, in fact competitions are still ongoing. Instead, you are "secure" against certain threat vectors. And Serena Williams is the champion of specific competitons, some notable ones mentioned on her Wikipedia page, and also taking down wedding photography drones.

This post motivates the design of a secure messing app by considering certain threat vectors and providing a design to defeat them.

## Threat vector: Dragnet

This is where an investigative entity who is researching a crime and has no reason to suspect you, finds you based on proximity to the crime.

(It is also known that police will investigate crimes that they themselves are responsible for, in an effort to set up individuals—that is outside the scope of this article.)

So defined, how does dragnet actually work? The New York Time has an excellent article on Sensorvault, the Google product that captures the location of everyones'* phones. In this story, a man was found and jailed because investigators ask Google who was in the vicinity of a crime, this individual was found. After a week in jail and facing, potentially, an entirely ruined life, this invididual was released.

Maybe one day you are in Palm Beach, Florida, and sent a message to your mom (who knows you would never hurt anybody) that you wish Donald Trump was dead. And tomorrow he dies, no clues, no suspects, not a Odor-Eater, nothing. Right about then you are calling your mom and asking her to erase and reset her phone, "no reason, just because."

- TENET: Your messages should be saved on the least number of devices and jurisdictions possible.

Design:

- Use end-to-end encryption for your communicatons

## Threat vector: "bad actors" and Facebook

Facebook claims that it can find bad actors using its services by analyzing messages where it can't see the contents of those messages. <https://www.wired.com/story/facebook-messenger-safety-alerts-encryption/>

Just like the Dragnet threat model, your interest in using these systems is that your messages will not be flagged by Facebook.

Design:

- Messages sent on the behalf of users should be combined with fake messages to effectuate differential privacy.

## Threat vector: border agent search

Border agents in various jurisdictions will collect and search mobile devices. If you are an American and return from travel abroad, border agents can seize and search your cell phone without a warrant.

Anything found during this search may be used as evidence against you. And the understanding is that this evidence represents with perfect fidelity of things that you said.

Even with the most honest person, six lines written by them will be enough to hang them. In using these systems, it is in your interest that your mobile device will not provide reliable testimony against you.

- TENET: If your device is searched there should be plausible deniability on any information recorded therein.

Design:

- Every conversation you make should have an "edit" button where you can change the words, timestamps, and participants. You can edit *any* history. The product is designed so a conversation which was edited cannot be shown to be edited and a conversation that is original cannot be shown to be original.
- A feature should exist (on by default) which tampers messages in your history automatically. These tamperings should be plausible and should include messages that would be of interest to outside parties searching your device.

## Threat vector: network analysis

When you install Signal, the first question it asks you is "what is your phone number." Then it associated your phone number to your Signal account. In the United States, your phone number is probably associated wih your social security number. Your Signal account also associates your account with an Apple Push Notification System identifier (or copycat competing service) which is associated with your device serial number. Then every message you send is timestamped and sent through your device to the recipient device quickly (i.e. an associated time).

Network analysis is performed by passive observers on the network such as internet service providers and government agencies. It is well known that internet service providers sell any information they have for profit and that government agencies will do anything, deny it, and then use parallel construction to prosecute targets. Additionally, any attack that can be performed by a network participant can be performed through writ (i.e. court order, kidnapping somebody's child) or hack against them. For example, Google is probably not your ISP, but their router in your home can access all traffic and knows all your device MAC addresses. Signal sounds like they care about your privacy, but your device identifiers are on a database, and those database administrators have kids and they click on "free wallpaper" apps on their parent's computers. Anybody that has administrator of an ISP is a potential target for government: <https://theintercept.com/2014/03/20/inside-nsa-secret-efforts-hunt-hack-system-administrators/>

At a minimum:

- DESIGN: Do not require service users to provide a phone number or other identifying information (what were you thinking Signal?)

And if governments, ISPs and service providers using network analysis are a threat vector you want to protect against:

- DESIGN: Do not send push notifications instantaneously, instead buffer them by a certain amount of time that makes it infeasible to correlate senders with receivers. Also do not send 100% of push notifications as requested. And, sometimes, send a push notification that is not requested which is indistinguishable from a legitimate message.
- DESIGN: Disable IPV6. This is terribly broken and gives each device on Earth a unique identifier that traces when it moves around.
- DESIGN: Allow sharing of private keys. Friends should be able to share cryptographic keys so that the service provider does not know which sent a given message. And the risk of sharing private keys should also be explained.

Documentation:

- This document <https://signal.org/blog/private-contact-discovery/> states that Signal does not have access to your contacts [find quote]. But actually when you send a message then Signal does know you have that contact. This should be caveated on that page under Oblivious limitations.
- This document <https://signal.org/bigbrother/eastern-virginia-grand-jury/> states that only certain information is HELD by Signal. But it should be clear that other information is seen (and not recorded) by Signal. Surely, that information is also held by NSA and is recorded.

## Threat vector: contact analysis

Signal employs a fancy method so that everybody can find their friends using the service. This method is broken and every possible method to securely find friends is broken.

The reason Signal makes you input your phone number is because you are helping them build their network effect. It is the Signal growth department taking over the Signal security department.

- TENET: It is not possible to publish the fact that you are using a secure messaging service while making it impossible for others to find out you are using that secure messaging service.
- TENET: It is not possible to send your list of contacts to Signal without them getting your list of contacts.

And of course, having some "bad actor" in your contact list is enough to make you the subject of an investigation.

And the solution:

- DESIGN: Actually explain risks to system users before asking them to provide their phone number.
- DESIGN: Do not require system users to provide their phone number.
- DESIGN: Explain the risks of contact discovery to system users.

** Add the note here about how to actually hack contact discovery.

- I use hyperbole in my writing to make writing more vivid and to igone irrelevant details. For example I might say "everbody has five fingers on their hands" when in fact some people have six fingers or less than five. I strive to use "every", "all" and "none" to refer to similaritiy of 99% or more of a population.

Show what it should look like

## Design requirements

- If someone takes your phone, cuts off your thumb and beats you with a $5 hammer, they will not gain assurances of anything communicatedChannels

- Secure DM
- You get emial addresses / each is a public key
- <aut34u4chu29uch392@channels.io>

Channels.

---

News

- How Apple is insecure

## Ping interested people

- <https://latacora.micro.blog/2020/02/19/stop-using-encrypted.html>

---

---

sucker disclosure

<Security@Signal.org> // <https://www.tenable.com/security/research/tra-2020-33>

win disclosure

contact this company <https://www.tenable.com/products> and ask if they buy vulnerabilities for the publicity of being able to publish first about it
