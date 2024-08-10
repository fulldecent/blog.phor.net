---
title: You can break into these dApp admin accounts today
tags: ["blockchain"]
comments:
  - link: https://twitter.com/fulldecent/status/1702160272180277548
    name: '@fulldecent'
    text: The official X thread
---

{: .margin-note }
Alternate title: how to properly implement logins with a public-key system

## Web servers

When you access a website, it is a private connection between your computer and the server.

These communications are repudiable. If you download a web page, and you screenshot it and you print it out and you save all the headers when you download it... then even still it is impossible for you to prove to me that this message was actually sent by the server. Even if you use HTTPS, even if you use HTTP/2 or HTTP/3.

## dApps (which run on web servers)

Some main features of blockchains, the "d" in dApp, are that all transactions are immutable and verifiable. They are connected to public key cryptography.

Comparing this to the normal web, you can achieve extra information security by connecting to that public key cryptography.

{: .margin-note }
Lol, none of them actually work this way.

When the web server sends you information, your device can independently verify it against well-known blockchain checkpoints.

And when you provide information to it, like a login challenge-response or a transaction, you can sign it with your private key and the server can verify it.

## The right way to login

A proper login system with public key cryptography requires these parts:

1. Some login attestation must be sent to the server
2. The attestation must include some challenge from the server ("entropy")
3. The attestation must be time-limited
4. The attestation must be signed by the customer's private key

And then the customer sends the attestation and the signature to the server. (Requirement 3 can be satisfied by the customer, or if the server keeps timestamps of its challenges.)

From the server's end, they will calculate the public key from these inputs. And then the customer's identity is established as having that public key.

Please note that it is trivial to make *some* login here, but creating the login corresponding to your private key is impractical to do without knowing your private key.

## Site survey

I have reviewed several projects to see if they implement this correctly:

![dApp login implementations](/assets/images/2023-09-13-break-into-dapp-admin-accounts.png)

- azuki.com ❌ does not include nonce
- boredapeyachtclub.com ✅ includes nonce
- cryptokitties.co ❌ does not include nonce or timestamp
- foundation.app ❌ does not include nonce or timestamp
- looksrare.com ❌ does not include nonce or timestamp
- opensea.io ✅ includes nonce
- rarible.com 🤷‍♂ does not really include nonce (but maybe their millisecond timestamp is good enough)
- x2y2.io 🤷‍♀ does not include nonce (but maybe their millisecond timestamp is good enough)
- zora.co ❌ does not include nonce

## How to hack

If you want to break into somebody else's account, all you need to do is create another dApp, and get them to sign one of those messages.

Or you need to be an insider at one of those companies, or their web hosting provider, or a QUANTUMINSERT actor, or someone with writ power, or other influence.

Then with this signed message you can login as that person... today another time and permanently any time in the future.