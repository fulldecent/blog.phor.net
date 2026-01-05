---
title: "Nontechnical: what is ERC-721?"
tags: ["blockchain"]
old-link: https://fulldecent.blogspot.com/2018/06/nontechnical-what-is-erc-721.html
comments:
  - link: https://fulldecent.blogspot.com/2018/06/nontechnical-what-is-erc-721.html#comment-4013094080520933891
    name: M.Brito
    text: "Thanks to people like you we can get a simple understanding of the new technology, many thanks for your time."
  - link: https://fulldecent.blogspot.com/2018/06/nontechnical-what-is-erc-721.html#comment-7871212227656702104
    name: Justin Boland
    text: "This is pretty awesome. Thanks for the write up. There&#39;s a lot of great use cases coming out for this technology.  Keep up the great work!"
---

This post explains how ERC-721 works and does not require any prior knowledge of Ethereum or blockchain.

*[简体中文](https://www.sfgroup.hk/news_post/%E9%80%9A%E4%BF%97%E6%98%93%E6%87%82%E7%9A%84%E5%91%8A%E8%AF%89%E4%BD%A0%E4%BB%80%E4%B9%88%E6%98%AFerc-721/)（奇点财经翻译）

But first, let's think about something you use every day:

## How does your phone connect to a web server?

Most of your time on computers/phones/technology is spent essenntially with a web browser accessing a web page. Most of the screens you see out in the world that display information are essentially using a web page to show it, but they just hide the URL bar.

![Flight board](/assets/images/2018-06-24-nontechnical-what-is-erc-721.webp)

*The flight arrivals screen—it's just a web page.*

Think for a minute about how this ubiquitous technology works:

1. **You.** You are very busy and you are trying to access some information, maybe cat videos or sports scores or your family members' feedback on a photo you posted of your kid.
1. **Your phone**, or whatever other device is in your hand. It acts on your behalf
1. **The web server.** It decides how it wants to reply to your request.

Technology people, the ones that make your phone and the web servers, refer to you as the "user". And they call your phone the "user agent" (in other words, the thing working on behalf of you). In this situation, you see only what the server gives you—if Spotify tells you there were 2 billion streams of Taylor Swift's songs this year, then you have no basis to dispute that statement. If Spotify tells Taylor Swift that she only had 1 billion streams then neither you nor her can be sure what is correct.

Sometimes if you connect to the internet from work maybe certain web sites are blocked, or if you connect from China they might even [edit certain third-party webpages you load](https://techcrunch.com/2007/10/18/baidu-hijacking-google-traffic-in-china/) to instead be what they want you to see.

## The blockchain is a single source of truth

The blockchain is a set a computers that are connected together. And each of these computers all have identical information on them. So rather than asking Spotify how many streams there were, you ask the blockchain "right now (at time 2018-06-24 19:22:01 UTC) how many streams were there for @TaylorSwift". According to the system design, anybody who asks this question will get an identical result.

1. **You.** You want to learn a fact.
2. **Your phone.** It participates in the blockchain and has access to information that is the same as anybody else that participates.
3. **The blockchain.** It records information and is publicly accessible.

Some smart people believe that the blockchain is very tamper-resistant and censorship-resistant. That's why technology people are excited to use it. The way you will access the blockchain is still using a web browser. But there is an extension that has a special feature to connect you to the blockchain in addition to web servers.

![Browser](/assets/images/2018-06-24-nontechnical-what-is-erc-721-2.webp)

*A browser extension connects you to the blockchain.*

I hope you notice we keep calling it "the" blockchain, as in the singular one. However you connect to the blockchain, you are getting the same thing. If you are just reading information from the blockchain you should get the same information as anybody else. Also, you can put your own information onto the blockchain—here you are identified by a pseudonymous account number.

## Seven twenty-one

Ethereum is the leading technology stack for applications on the blockchain. [ERC-721](https://eips.ethereum.org/EIPS/eip-721) is the seven hundred twenty-first proposal in the Ethereum proposal process ([EIPs](https://eips.ethereum.org)) to standardize how these applications are made and how Ethereum will work. (Most proposals are not accepted.) On 2018-06-21, ERC-721 [was accepted as "final" status](https://github.com/ethereum/EIPs/pull/1170), meaning there is significant support and consensus among people that care about this stuff.

**Applications that use ERC-721 will record ownership of a bunch of things and assign them to the pseudonymous account numbers.** Maybe those things also live on the blockchain, like access to digital money or even ownership of other applications. In this case you don't need to trust the application, you could just read how it works. Remember, you can read how it works and anybody else can read the same thing—the application only does what it is supposed to do and cannot be changed.

**This gets more interesting if an entity you trust endorses that application.** If you go to an office-supply store and buy a roll of ADMIT ONE tickets and you look at ticket #755100 that is not very interesting. But if you are at a charity event and the host says "whoever has ticket #755100 wins this painting," then the ticket you got at the charity is much more interesting, at least for whoever has that ticket. For the avoidance of doubt: at the charity ball, the reason this is interesting is because you have a credible belief that the host will redeem your ticket for the painting.

![Ticket](/assets/images/2018-06-24-nontechnical-what-is-erc-721-3.webp)

*Think about when you might be excited to have this ticket.*

ERC-721 is the tickets.

## The ERC-721 applications

The tickets (we usually call them *tokens*, or *deeds*) can be used for a lot of different things. If you reach in your pocket and pull out your wallet, a lot of things in there are basically tokens. Your driver's license is an attestation by your local state/province/country that the person bearing that license, and matching the picture, is actually the identified person. Your credit card gives you access to the account identified on the card so you can buy stuff.

If you own a car, depending on which jurisdiction your car is registered under, you might have a pink slip. If you sign it over to somebody else, then the car legally passes title to a new owner.

The most successful application that has been implemented so far is a game where you trade pictures of cats. They have sold many millions of dollars worth of cats, and the ownership of the cats is recorded basically using ERC-721. With this leadership, the technology people are watching and are inspired to make the new identity and ownership applications of the future. These will be tamper-proof and easy to connect to other systems.

If you have purchased a home, maybe you went through a title-search process. ERC-721 can make that instantaneous. Maybe some time you have used a "Login With Facebook" button. ERC-721 can make that work in more places, and it can reduce dependence on Facebook. If you are interested in this future, you can find some of these good projects on Twitter and subscribe to the people working on them. For a technical deep dive on how tokens work with real world assets and DeFi, see [DeFi primitives for real world assets](2026-01-04-defi-primatives-for-rwa.md).
