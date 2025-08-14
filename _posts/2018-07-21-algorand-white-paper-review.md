---
title: "Algorand white paper review"
tags: ["blockchain"]
old-link: https://fulldecent.blogspot.com/2018/07/algorand-white-paper-review.html
---

This article briefly reviews the Algorand [technical paper](<https://arxiv.org/pdf/1607.01341.pdf> as well as their white paper for investors. I don't know if the investor paper is public, so I wont link to it. But if you have seen you then you will know you have the right on if:

- It's in Chinese
- 1,208,476 bytes
- SHA256 d2fe315b4410dbf88e6054555d5b04c6edddef6c2ea6e1d1a12bbedf47b9eeff

## Investor analysis

- 写软件好容易。为什么找投资方？为什么不要直接写软件再找顾客？
- 复印软件好容易。他们的网络开通之后我们怎么知道别人不会复印他们？
- 区块链理论说的好清楚：一个网络不能同时安全、去中心化和有速度。他们发表了文件之后大家为什么还是相信这个理论？
- 第一句话开头是“目前没有一种加密货币。。。。。。”。已经好明显作家不懂区块链市场。为什么？应为加密货币是个应用但是以太坊是个平台。他们想开发一个系统不要开发一个应用。
- 他们的白纸没有提到spam或gas的问题。

## Technical analysis

You can see the weaknesses in these strong assumptions in the white paper.

- "[Adversaries] cannot interfere in any way with the messages exchanges among honest users.

    We assume that every propagated message reaches almost all honest users in a timely fashion."

- "each small set of players associated to a step ... most probably has empty intersection with the next set"

- "fake block might be propagated only after the legitimate one"

- "secret keys can be computed in less than one hour" is slow for creating a new account

- The forking model fails to consider that the adversary can sign multiple contradictory messages

- The networking layer is ignored
