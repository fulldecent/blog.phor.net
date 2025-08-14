---
title: "The blockchain and know your customer (KYC) laws"
tags: ["blockchain", "business-plans"]
old-link: https://fulldecent.blogspot.com/2018/03/the-blockchain-and-know-your-customer.html
---

Right now Web 3.0, "the blockchain", the decentralized web, etc. are making a lot of people rich. People will seemingly do anything to get a few Ether so they can spend it on [pictures of kitties](https://www.cryptokitties.co). Here is the current best practice of how you can get Ether:

- Send [Western Union payment to somebody](https://localbitcoins.com) recommended by a company that is not in your legal jurisdiction to get Bitcoin, then use an exchange also not in your jurisdiction
- Create an account in the United States which requires your social security number, [your bank account website usernames/passwords](https://x.com/fulldecent/status/978370905490501632) (not a typo), and uncontrolled access to your computer's webcam

In other words, this is shady AF.

At one end of the respecting-regulation spectrum is Uber which says "we're not a taxi and we refuse to follow any taxi laws." But the Web 3.0 players are on the other end where they collect more information from you than any traditional bank.

The reason why is because banks are subject to "anti money laundering" and "know your customer" laws. Wouldn't it be great if you could go through this onerous process only ONCE and not need to do it every time you trade crypto currency for something valuable in the real world?

Enter [micro identity](https://cryptoeconomics.blog/2018/03/27/erc-721-extension-for-kyc-micro-identities/), thanks Bill Weber.

The recently posted ERC-721 was [explored in Dallas](https://explore721.com) and provides a standardized mechanism for a custodian to associate ownership of an asset to an entity on the Ethereum blockchain.

Lining up this implementation, we see that Coinbase (custodian) can hold KYC-compliant identities of real people (assets) and connection to your wallet address (entity). There is even be a way that Coinbase could charge money to other entities for this service.

Would this mechanism be sufficient for one US-based bitcoin exchange to legally do commerce with you without directly having access to your personal information?

No. There is much to read to understand the laws of AML + KYC. But I'll just refer to the [FDIC notes on the Bank Secrecy Act](https://www.fdic.gov/regulations/examinations/bsa/ffiec_cip.pdf). And it states:

> The [Customer Identification program] is intended to enable the bank to form a reasonable belief that it knows the true identity of each customer.

Plainly, it is insufficient for a bank to have reasonable belief that SOME OTHER CIP-COMPLIANT ENTITY knows the true identity of each customer.

That means Coinbase would need to send your social security number, bank passwords, and webcam access to the other entity for them to do business with you. Given how stupid people are nowadays, that might actually be a viable business plan :-).

## Bonus

But if you read a little further down the page. There is this nugget:

> [The Customer Identification Program] must also include reasonable and practical risk-based procedures for verifying the identity of each customer. Banks should conduct a risk assessment of their customer base and product offerings, and in determining the risks...

If you read that like an attacker:

> For certain "reasonable" levels of product offerings and customers, CIP requirements can be minimized.

What would a successful workaround for AML/KYC/CIP laws look like? It would look like Venmo. Here are the [account creation requirements for Venmo](https://help.venmo.com/hc/en-us/articles/209690188-Requirements):

- You must be physically located in the United States
- You must have a U.S. cell phone that can send/receive text messages from short codes (please note that this phone number can not be on file with another Venmo account)

Also, [they make very clear](https://help.venmo.com/hc/en-us/articles/217532197-Social-Security-Number) what the threshold is for further validation (collecting social security numbers):

- Send $300 or more in one week (rolling 7 day period)
- Transfer $1000 or more to your bank in one week
- Create a group account

With this quick exercise, we have identified a glorious business opportunity.

- Create and register a [Money Services Business](https://www.fincen.gov/money-services-business-definition) seek licensure in one or more US states
- Create a lifetime account limit of $300 per customer
- Use only name + phone number for account validation
- Accept payment by debit card or bank transfer
- Sell Ether
