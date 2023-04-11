---
title: "OpenSea cooperated transaction with SDN sanctioned entity"
tags: nft
comments:
  - link: https://twitter.com/fulldecent/status/xxx
    name: '@fulldecent'
    text: The official Twitter thread
---

*This article is a review of facts and is not an allegation of any crime.*

Below we build on our previous article showing that OpenSea Stared Storefront [has (or had) a backdoor](/2022/11/04/Does-OpenSea-Shared-Storefront-have-a-backdoor.html) that allowed administrators to take any token. To date [about 4 millions transfers](https://etherscan.io/token/0x495f947276749ce646f68ac8c248420045cb7b5e) have happened on this system.

1. OpenSea, a US entity, had (or has) an undisclosed backdoor which allows it to freeze/take assets created on its system ("Open Store").
2. After the OFAC SDN//CYBER2 registration of Chatex, they did transfer an asset on this system which OpenSea did not block.
3. The OFAC-identified address for Chatex has much contact with related entity 0x3e4d3... which may in fact also be Chatex.
4. The other entity 0x3e4d3... may have its identity known by Binance (currently sued by CFTC).
5. The other entity 0x3e4d3... is actively dealing in USDC in amounts over USD 10,000 and transactions are not being blocked by Coinbase, a US entity.

## Sanctioned entity timeline

On-chain you can clearly study the story of one NFT purchased and moved, and one sanctioned entity and a related entity.

* 2021-11-05 0x6aCDF... [purchases](https://etherscan.io/tx/0x467857ff832a8e61c4aac9ea65a88cbdb666b1a71399763275885aebbc7e54fc) an NFT for 11 ETH on OpenSea
* 2021-11-08 The US Treasury [sanctions](https://home.treasury.gov/news/press-releases/jy0471) Chatex a/k/a 0x6aCDF...
* 2021-11-21 0x6aCDF... [gave away](https://etherscan.io/tx/0x28166d387c2d789c722d5b4e27e3a011b091a010ed70da13a8e797b09d23b53b) away this NFT to 0x3e4d3...
* 2021-12-29 0x3e4d3... [received](https://etherscan.io/tx/0x9f63a1415539c85e63617de30ed27bab83166b3d81852b3d99a161f259247942) inbound payment from Binance

## What is the Specially Designated Nationals (SDN) list?

The United States Department of the Treasury, Office of Foreign Assets Control (OFAC) maintains a list of individuals and entities called the Specially Designated Nationals (SDN) list, as well as some other lists, wrapped up in the Consolidated Sanctions List (Non-SDN Lists).

Entities can be added or removed from these lists by the Treasury, and from direction of the President of the United States.

These lists are important for banks, marketplaces and other financial institutions operating in the United States because they process transactions for lots of people. And generally US persons are prohibited from doing business with SDNs and entities on other sanctions lists.

I personally know that NFT marketplaces operating in the United States smaller than OpenSea have been contacted by the FBI and OFAC to establish communication channels and to report suspicious activity, mostly related to money laundering. Back then, OpenSea represented over 90% of the market share (i.e. they were ten times bigger than everyone else combined). So I have to assume that OpenSea has open communication with the FBI and OFAC as well.

## What are my and OpenSea's obligations in dealing with OFAC?

I'm not sure, talk to your lawyer.

On 2021-10-15 (before all events in the timeline above), OFAC published [*Sanctions Compliance Guidance for the Virtual Currency Industry*](https://ofac.treasury.gov/media/913571/download?inline). This document states:

> In general, unless exempt or authorized by OFAC, U.S. persons ... must block any property in their possession or control in which an SDN or a blocked person has an interest.

## What was OpenSea's role in this transaction?

More than you might think.

Often I hear the argument "We built a 'decentralized' finance application, everybody deals directly with the blockchain, we are not responsible for what they do, we don't have possession."

That's a common view for people building "DeFi"<sup>[citation needed]</sup>. But is a token minted on OpenSea Open Store really hands-off, fully on the blockchain and not under the control of OpenSea?

No!

OpenSea has (or had) undocumented backdoor access which allows them to block or take any asset. This is signing authority and is documented in our [other article](/2022/11/04/Does-OpenSea-Shared-Storefront-have-a-backdoor.html).

Since OpenSea has signing authority over this asset, they can have block, deny access to, or seize it at any time.

It is not clear whether OpenSea was obligated to seize, prevent transferring the asset or report the transaction to OFAC. But it is clear that OpenSea had the ability to do so.

## Finding the transaction

Thank you to Google for providing access to BigQuery public datasets and processing in support of this article.

There may be other transactions with SDN and non-SDN entities, but I stopped looking. Queries across the entire Ethereum blockchain can be costly and I exhausted my allowance for several months working on this article. You can find other articles on this site (and associated older blogs I am converting over) that used thousands of USD of gas fees and other resources to bring you first-class reporting. But for this one I relied on the free allowance from Google.

Here is the query:

```sql
SELECT DISTINCT topics[OFFSET(2)] recipient
  FROM `bigquery-public-data.crypto_ethereum.logs`
 WHERE address = "0x495f947276749ce646f68ac8c248420045cb7b5e" -- OpenSea Shared Storefront
   AND topics[OFFSET(0)] = "0xc3d58168c5ae7397731d063d5bbf3d657854427343f4c083240f7aacaa2d0f62" -- ERC1155 transfer single    
   AND DATE(block_timestamp) = "2021-11-05" -- horizontal filters manage your query cost
--     vertical filters find sanctioned entities
-- AND topics[OFFSET(2)] IN (
--     "0x00000000000000000000000001e2919679362dfbc9ee1644ba9c6da6d6245bb1",
--     "0x00000000000000000000000003893a7c7463ae47d46bc7f091665f1893656003",
--     ...
--     )
```

## What could OpenSea have done to block this transaction?

Since OpenSea had signing authority over this asset, they could have blocked the sanctioned entity from accessing it.

[Here is a demonstration](https://github.com/fulldecent/opensea-shared-storefront-backdoor/commit/58443a7d469cff120f82f7b1af58d6d3bc13d4be) of a specific transaction OpenSea could have executed on November 2021 to block the sanctioned entity from accessing their asset.

Even though you don't know OpenSea's private key for their wallet, you can perfectly simulate what would have happened if you did. This is one of the debugging tools available when working with Ethereum.

Nerd details follow showing what would have happened if this transaction was executed.

```
Storefront (ERC-1155): 0x495f947276749ce646f68ac8c248420045cb7b5e
Contract backdoor:     0x5b3256965e7C3cF26E11FCAf296DfC8807C01073
Token ID:              103964089402971035322194754460519211901162239038652937872902470904772294606849
Token owner:           0x6acdfba02d390b97ac2b2d42a63e85293bcc160e
Proxy registry stub:   0x37197C9B145CCB73bEa78Ac92a31A49369F8Ed84
Sender balance:        1
Recipient balance:     0
Transaction hash:      0xcdf29153f1a77f24488e46da812dbdfa44ac50d3025632ffac9900ba94486e3d
Transaction logs:      [
  {
    transactionIndex: 0,
    blockNumber: 13558937,
    transactionHash: '0xcdf29153f1a77f24488e46da812dbdfa44ac50d3025632ffac9900ba94486e3d',
    address: '0x495f947276749Ce646f68AC8c248420045cb7b5e',
    topics: [
      '0xc3d58168c5ae7397731d063d5bbf3d657854427343f4c083240f7aacaa2d0f62',
      '0x0000000000000000000000005b3256965e7c3cf26e11fcaf296dfc8807c01073',
      '0x0000000000000000000000006acdfba02d390b97ac2b2d42a63e85293bcc160e',
      '0x000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    ],
    data: '0xe5d996dea423cd8af960ea39aed17c23f1bc3f530000000000000500000000010000000000000000000000000000000000000000000000000000000000000001',
    logIndex: 0,
    blockHash: '0xf0f3f782a75a3c04a2e14d64d730e2c2789f283112c67f85521c2a000ba899a0'
  }
]
Sender balance:        0
Recipient balance:     1
```

However, this transaction was never actually executed and the sanctioned entity did transfer the asset to another address. However, the backdoor can be used at any time to block/take any asset minted on OpenSea (i.e. Open Store).

## Reading circle questions

1. If somebody is able to transfer an asset, is that considered possession or signing authority over the asset?
2. What if this transaction requires multiple steps and using a backdoor that you put there?
3. Which regulatory definitions does this "possession" or "signing authority" meet?
4. All events regarding this token and the sanctioned entity took course within one month, is it reasonable for OpenSea to notice and act that fast?
6. Does the sanctioned entity also a/k/a 0x3e4d3cC9aA605b37692a79c5ccF8D41E0E5F4229?
6. The address 0x3e4d3cC9aA605b37692a79c5ccF8D41E0E5F4229 received assets from Binance, does Binance know their identity, account balance and other information?
7. Binance is currently being sued by the CFTC, is this an opportunity to subpoena Binance?