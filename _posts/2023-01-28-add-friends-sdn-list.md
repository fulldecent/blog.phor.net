---
title: "Add your friends to the SDN list with this one weird trick"
tags: ["nft", "zero-day"]
comments:
  - link: https://x.com/fulldecent/status/1619215274263322624
    name: '@fulldecent'
    text: The official X thread
  - link: https://github.com/MetaMask/metamask-extension/issues/11147
    name: '@fulldecent'
    text: Bug report
  - link: https://hackerone.com/reports/1664280
    name: '@fulldecent'
    text: HackerOne report
---

*There is humor in this article title, you do not want to add your friends to the Specially Designated Nationals (SDN) list. This list is published by the US Department of the Treasury's Office of Foreign Assets Control (OFAC) and is used to enforce economic sanctions and other financial restrictions imposed by the United States government.*

## Summary

A dapp that uses a contract interaction can add a value amount of 1000000000 Wei to the transaction and MetaMask will show that the amount is zero ("0").

## Steps to reproduce

1. Transfer 1000000000 Wei, or in Ethers, use any contract interaction with:

   ```javascript
   contractWithSigner.someFunction({ value: "1000000000" });
   ```

2. The MetaMask interface will show the user that zero Ether is being spent ("0") when in fact Ether is being sent.

3. 100% reproducible on every transaction to individuals. And 100% reproducible on any call to a smart contract function if that contract does not revert when value is attached.

4. None of the applicable MetaMask documentation that a user sees before performing this operation specifies that any rounding will applied to figures in the user interface.

1. In addition to the very large zero ("0") amount shown, the "total" value at the bottom also does not show this amount.

## Supporting material/references

![Transaction confirmation box](/assets/images/2023-01-28-add-friends-sdn-list.webp)

## Impact

This results in an unexpected loss of funds from the actor in the transaction.

Additionally, because in certain legal jurisdictions sending money to an address maybe be treated differently than interacting with a smart contract, this bug may cause your account to be flagged.

For example calling a "check" function on a mixer may be legal. But if the dapp inadvertently adds Ether value to that call, and MetaMask shows it as zero, then your account could be flagged as sending money to a flagged entity in the United States. This could result in your funds of any amount being frozen.

## Timeline

* 2022-08-09 Reported to vendor using their preferred vulnerability reporting process
* 2022-08-09 Vendor closed issue, "We consider this to be an UI issue and not a security vulnerability." (within hours of report, great timing!)
