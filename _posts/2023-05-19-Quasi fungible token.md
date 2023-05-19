---
title: "Quasi fungible token and MiCA"
tags: blockchain
comments:
  - link: https://twitter.com/fulldecent/status/xxx
    name: '@fulldecent'
    text: The official Twitter thread
---

This week, Europe passed [legislation regulating markets for crypto tokens](https://www.europarl.europa.eu/doceo/document/TA-9-2023-0117_EN.html#title2). This is the markets in crypto-assets (MiCA) regulation. There's a few ways to read regulation:

1. **Like a parent**—trying to keep your kids safe
2. **Like a victim**—trying to make somebody else liable for your losses
3. **Like a truck driver**looking for a hole to drive your big truck through

Today we've got our truck driving glasses on.

![Man driving truck with sunglasses, courtesy World Sikh Organization of Canada @ Pexels #14797994](/assets/images/2023-05-19-Quasi fungible token.jpg)

## What's out of scope?

Here is one major finding in the regulation about non-fungible tokens:

> This Regulation should not apply to crypto-assets that are unique and not fungible with other crypto-assets, including digital art and collectibles. The value of such unique and non-fungible crypto-assets is attributable to each crypto-asset’s unique characteristics and the utility it gives to the token holder. 

And let's zoom in on that:

> The value of [non-fungible tokens] is attributable to each crypto-asset’s unique characteristics and the utility it gives to the token holder.

This is a major cop out.

## Utility, utility, utility

Remember when crypto projects were fighting every day to show utility? They had roadmaps, and promises, and some barely even had utility...

None of that is necessary anymore!

The regulation right there clearly recognizes your token's utility and its unique characteristics. So it seems like if regulators (in Europe) come to you claiming "your NFT token is clearly a security because it has no utility" then you can just say "estoppel" and wave them off.

## A demo

Here is a demonstration of a non-fungible token (check) but that also allows you to trade several of them at a time. This makes the token compatible with DeFi and other obviously financial markets (check).

And of course this may totally goes against the spirit of the regulation.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract QuasiFungibleToken is ERC721Enumerable {
    constructor() ERC721("QuasiFungibleToken", "MTK") {
        _mint(msg.sender, 0);
        _mint(msg.sender, 1);
        _mint(msg.sender, 2);
    }

    /// @notice Transfer tokens from `from` to `to`, selected using `tokenOfOwnerByIndex`. The caller is responsible to confirm that `to` is capable of receiving NFTs or else they may be permanently lost.
    /// @dev    Throws unless `msg.sender` is the current owner or an authorized operator for the NFTs. Throws if `_to` is the zero address.
    /// @param  from  The current owner of the NFT.
    /// @param  to    The new owner.
    /// @param  count The NFT to transfer.
    function transferNFrom(address from, address to, uint256 count) public {
        while (count > 0) {
            uint256 tokenId = tokenOfOwnerByIndex(from, 0);
            require(_isApprovedOrOwner(_msgSender(), tokenId), "QuasiFungibleToken: caller is not token owner or approved");
            _transfer(from, to, tokenId);
            count--;
        }
    }
}
```

But we can do better.

You can actually wrap *any* NFT this way (whether or not the underlying token is enumerable). Therefore every NFT on blockchain can be pooled and transferred as fungible tokens, seemingly sidestepping MiCA regulation.

You could create a meme coin, as NFTs (with unique, neural network generated art) and seemingly side step regulation to sell in Europe. I have decided not to launch such an example as part of this blog post.

## What's next?

This is an obvious hole in the regulation. And perhaps in the future an update will come.

But for now, let's continue to study what this means for Europe and also focus on the important parts which are built to protect consumers from poorly run exchanges or worst.