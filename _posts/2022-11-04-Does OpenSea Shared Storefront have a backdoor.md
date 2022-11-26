---
title: "Does OpenSea Shared Storefront have a backdoor?"
tags: nft
comments:
  - link: https://twitter.com/fulldecent/status/1589652866041401344
    name: '@fulldecent'
    text: The official Twitter thread
  - link: https://twitter.com/fulldecent/status/1577066829440503808
    name: '@fulldecent'
    text: Why didn't OpenSea publish this smart contract?
  - link: https://twitter.com/fulldecent/status/1582140475208699904
    name: '@fulldecent'
    text: Reverse engineering bytecode, Ben Affleck style, no paycheck
---

This project demonstrates how OpenSea administrators can take any tokens minted on the OpenSea Shared Storefront. This is a previously-undocumented backdoor.

Is this what artists expected when they decided to mint with OpenSea?

## Background

OpenSea Shared Storefront is the ERC-1155 contract deployed on Ethereum Mainnet. If you try to create an NFT using the OpenSea website and follow all the default options without creating your own smart contract, this is where your NFT will go.

{: .margin-note}

At time of writing, this contract holds NFTs "owned" by 600k+ accounts.

There [are about 1 million transactions](https://etherscan.io/txs?a=0x495f947276749ce646f68ac8c248420045cb7b5e) against this contract.

OpenSea administrators maintain control over this contract such that they can take, or freeze, anybody's NFT at any time. The contract's source code is not published and this control ability is not disclosed anywhere in OpenSea's terms of service or documentation.

OpenSea's level of control should be considered "signature authority" over the assets, for US FinCen purposes and this makes OpenSea administrators capable of executing civil asset seizures/forfeitures requested by governments.

## Demonstration

I [published a project](https://github.com/fulldecent/opensea-shared-storefront-backdoor) showing you exactly how to perform these asset seizures.

This project allows you to make a live copy of Ethereum Mainnet, execute some transactions as if you were OpenSea (even though you don't know their private key) and examine the outcomes.

You should see some information printed and proof that the token was transferred even though the "owner" did not wittingly authorize it.

If OpenSea administrators run this same transaction with their real private key this token would be transferred for real. (What you are seeing is a local copy of this transaction which ignores the fact that it is invalid for want of the correct private key.)

The above paragraph is a brief simplification. OpenSea Shared Storefront has recently changed from a single owner, to a Gnosis safe. No difference, to execute this transaction OpenSea administrators need to use only a slightly different process.

## Is OpenSea violating US Treasury OFAC/SDN sanction requirements?

Is OpenSea subverting sanctions by allowing sanctioned entities to hold digital assets that OpenSea has the ability to seize?

In their [privacy policy](https://opensea.io/privacy), they already state that customer's personal data can be used to comply with investigations by law enforcement and for other reasons.

But are they using this ability to seize tokens? And since OpenSea is obligated to stop transactions with sanctioned entities from the OFAR/SDN lists, are they using this ability to comply with this requirement?

To answer this question, I reviewed the historical list of OpenSea Shared Storefront token holders and then current OFAC/SDN sanctions lists to find if OpenSea has effectively stopped sanctioned entities from putting through transactions. Too much for this post, so stay tuned for a follow up post here.

## How do decompile and study smart contracts

Because OpenSea did not publish the source code for this contract, it was necessary for me to decompile it to study it. If you would ever like to try the same approach with other popular but unverified smart contracts, below are some basic notes on the approach.

Here are some notes about how to effectively decompile and study smart contracts, read the Matrix. I recommend doing this on paper with color pencils/highlighters. You might have to take a lot of notes and this helps.

1. Use [Online Solidity Decompiler](https://ethervm.io/decompile).
1. Remove top-level `contract`, reduce indent, paste into MS Word or similar

Since OpenSea general produces intentional code, I was only looking for backdoors, code paths that results in a `SSTORE`.

1. Replace `revert.*;` to `REVERT`
1. Replace `  var.*\W+REVERT.*` and `  memory.*\W+REVERT` to `REVERT`, go back and forth a few times
1. In `main` function
  1. Find dispatches that result in `return`, replace with `return; // does not change state`
  1. On dispatch, mark in red any called function/goto
  1. On red things, mark in red any called function/goto, repeat
  1. Delete everything not red

You have completed the easy steps. Go to bed and do the rest steps with full brain power.


## Acknowledgements

- Contract decompilation (easier than reading straight bytecode) provided by [https://ethervm.io/decompile](https://ethervm.io/decompile)
- Tracing each `SLOAD` and `STATICCALL` while playing with contracts provided by [@sohamzemse](https://twitter.com/sohamzemse) in [hardhat-tracer](https://github.com/zemse/hardhat-tracer), running on [@HardhatHQ](https://twitter.com/HardhatHQ) [Hardhat](https://hardhat.org/).


## Reading circle questions

- For artists, does this shared ownership with OpenSea affect your interest in publishing with them?
- Does OpenSea's ability to take tokens count as "ownership" in the same way that the token's buyer is considered an "owner"?
- Is OpenSea's implementation compliant with [ERC-1155](https://eips.ethereum.org/EIPS/eip-1155#approval)'s transfer and approval specifications?
- Is it necessary for a large company to publish their smart contract's source code even when many people won't read it?

{%- comment -%}
- [x] Publish GitHub repo // visibility public
- [x] Tweet
- [x] Update 2 BLOG POSTS to link to that tweet
- [x] Update Tweets to reference this new tweet
  - [x] https://twitter.com/fulldecent/status/1581004011763007488
  - [x] https://twitter.com/fulldecent/status/1577066829440503808
  - [x] https://twitter.com/fulldecent/status/1582140475208699904
- [x] Post to https://news.ycombinator.com/item?id=33507819
- [x] Post to https://www.reddit.com/r/opensea/comments/yorv3l/why_does_the_main_opensea_smart_contract_no/
- [x] Post audit to https://etherscan.io/token/0x495f947276749ce646f68ac8c248420045cb7b5e#comments
{%- endcomment -%}
