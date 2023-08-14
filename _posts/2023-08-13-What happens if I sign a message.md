---
title: What is the worst thing that could happen if I sign a bad message?
tags: blockchain security
comments:
  - link: https://twitter.com/fulldecent/status/1690924467403337728
    name: '@fulldecent'
    text: The official Twitter thread
---

Did you ever quickly sign a message and not know what it was?

For example, here is a message for logging into Rarible.

![Message signature request for logging into Rarible](/assets/images/2023-08-13-What happens if I sign a message.png)

This article explains the worst thing that could happen if you sign a message you didn't understand. And it explains an ongoing issue with major Ethereum wallet applications that implement message signing.

## What is a message?

In the context of Ethereum applications, a <dfn>message</dfn> is some data that is endorsed by some human. That message can be validated off-chain and it can also be validated on-chain by a smart contract.

Formalizing this a little bit: 

* By *data*, we typically refer to a sequence of text or raw bytes. Although a standard exists for higher-level data structures.
* By *some human*, we refer to an externally owned account (EOA). This is controlled by a person, not a smart contract.
* *Validation* is done with a well-known cryptographic process.

## Where are messages used?

Ethereum messages are used primarily for two purposes:

1. **To authenticate a human to a website or application.** By validating a message, the website or application can verify that the human controls a particular Ethereum account. This includes:
  * Logging into a website
  * Sending a verifiable email to somebody else
2. **To authorize a smart contract to perform some action.** Typically, a smart contract uses signed messages when a transaction involves multiple parties:
  * Selling an NFT, where another human party wants to buy it
  * Preparing some arbitrary transaction, where another human party wants to pay to broadcast it

Most nything that can be done using a message could also be done using a transaction. But transactions have a cost (to record on a blockchain) and messages are free. Therefore, messages can be a first choice when possible.

There are best practices for each of these kinds of messages, which I will elaborate on in a future article.

## How are messages more powerful than transactions?

As per above, most anything that can be done using a message could also be done (more expensively) using a transaction. In addition, messages can do three extras things that transactions cannot.

{: .margin-note}
A replay attack is mentioned in the [rationale for EIP-712](https://eips.ethereum.org/EIPS/eip-712).

1. **Messages can be used multiple times**. Whereas a transaction includes a nonce, preventing duplicate execution, messages do not necessarily have this restriction.
2. **Messages can be used out of order**. Because of the nonce, transactions are only valid when the previous nonce has been broadcast. Messages do not necessarily have this restriction.
3. **Messages can be used across multiple networks.** Transactions include a specifier that limits them to a specific network, so for example a transaction on Polygon cannot be replayed on Ethereum Mainnet. Messages do not necessarily have this restriction.

Although they are more powerful, most Ethereum wallets, including MetaMask and Taho lack an important control for them. When you broadcast a transaction, it is shown in the wallet's transaction history. **But when you sign a message, this disappears without any record as soon as you click sign.**

Wallets should include a "signed message" pane detailing all signed messages. And I don't know any that currently do this.

## Bad things can happen when you sign a message

The most dangerous part about messages is that they can be used against you at any time in the future and you cannot necessarily cancel them.

**Even if you have no tokens and not much value in your account, a message you sign today can be parked and then executed later when you are rich.**

It is possible to make a message that drains all your blue chip NFTs and wrapped ETH. Even if you don't have any today, if you unwittingly signed that message, somebody else much later can claim it and take everything you have.

*It is likely that the old signed, executable messages OpenSea has in its database are worth more than the entire rest of the company. Therefore, an arbitrage opportunity exists: buy the OpenSea company (or exert influence over any of its administrators), sandwich/frontrun all the stale transactions, retire. While there, you can also execute any [other backdoors](/2022/11/04/Does-OpenSea-Shared-Storefront-have-a-backdoor.html) that are known.*

For websites which do not properly implement website logins, like Foundation, signing a login message can allow other people to login to your account forever anytime into the future.

## How to protect yourself

You should know that messages are more dangerous than transactions and you should be careful when signing them.

If you ever signed an errant message in the future, the most secure thing you can do is transfer all tokens/reputation to a new account. Consider the old account dead. Less extreme options may be reasonable, talk to an expert.

Also, demand that your wallet software will include a "signed message" pane detailing all signed messages.

## Appendix

Here is the code using [EIP-712](https://eips.ethereum.org/EIPS/eip-712) with Ethers.js to sign a simple Seaport order.

<details>
<summary>Click to expand code</summary>

```javascript
import { ethers } from "https://cdnjs.cloudflare.com/ajax/libs/ethers/6.7.0/ethers.min.js";
await ethereum.request({ method: "eth_requestAccounts" });
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();
const message = "Hello, MetaMask!";

// Constants https://github.com/ProjectOpenSea/seaport-js/blob/v2.0.6/src/constants.ts
const itemType = {
  NATIVE: 0,
  ERC20: 1,
  ERC721: 2,
  ERC1155: 3,
  ERC721_WITH_CRITERIA: 4,
  ERC1155_WITH_CRITERIA: 5,
};
const orderType = {
  FULL_OPEN: 0,
  PARTIAL_OPEN: 1,
  FULL_RESTRICTED: 2,
  PARTIAL_RESTRICTED: 3,
};
const EIP_712_ORDER_TYPE = {
  OrderComponents: [
    { name: "offerer", type: "address" },
    { name: "zone", type: "address" },
    { name: "offer", type: "OfferItem[]" },
    { name: "consideration", type: "ConsiderationItem[]" },
    { name: "orderType", type: "uint8" },
    { name: "startTime", type: "uint256" },
    { name: "endTime", type: "uint256" },
    { name: "zoneHash", type: "bytes32" },
    { name: "salt", type: "uint256" },
    { name: "conduitKey", type: "bytes32" },
    { name: "counter", type: "uint256" },
  ],
  OfferItem: [
    { name: "itemType", type: "uint8" },
    { name: "token", type: "address" },
    { name: "identifierOrCriteria", type: "uint256" },
    { name: "startAmount", type: "uint256" },
    { name: "endAmount", type: "uint256" },
  ],
  ConsiderationItem: [
    { name: "itemType", type: "uint8" },
    { name: "token", type: "address" },
    { name: "identifierOrCriteria", type: "uint256" },
    { name: "startAmount", type: "uint256" },
    { name: "endAmount", type: "uint256" },
    { name: "recipient", type: "address" },
  ],
};

// Parameters
const wrappedTokenEthereumMainnet = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";
const nftAddress = "0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D";
const nftTokenId = 1234;
const quantity = 1;
const price = ethers.parseUnits("0.1", "ether");
const participant = await signer.getAddress();
const network = await provider.getNetwork();
const chainId = network.chainId;
const dataDomain = {
  name: "Seaport",
  version: "1.5",
  chainId: chainId,
  verifyingContract: nftAddress,
}

// This follows the requirements of the "basic" function, fulfillBasicOrder
const orderComponents = {
  offerer: participant,
  zone: ethers.ZeroAddress,
  offer: [
    {
      itemType: itemType.ERC20,
      token: wrappedTokenEthereumMainnet,
      identifierOrCriteria: 0,
      startAmount: price,
      endAmount: price,
    },
  ],
  consideration: [
    {
      itemType: itemType.ERC721,
      token: ethers.ZeroAddress,
      identifierOrCriteria: nftTokenId,
      startAmount: price,
      endAmount: price,
      recipient: participant,
    },
  ],
  orderType: orderType.FULL_OPEN,
  startTime: 0,
  endTime: 0,
  zone: ethers.ZeroAddress,
  zoneHash: ethers.ZeroHash,
  salt: 0,
  conduitKey: ethers.ZeroHash,
  counter: 0,
};

// Sign the data using EIP-712
const signature = await signer.signTypedData(
  dataDomain,
  EIP_712_ORDER_TYPE,
  orderComponents
);
```

</details>