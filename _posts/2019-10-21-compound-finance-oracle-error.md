---
title: "Compound Finance zero-day: prices can move faster than advertised"
tags: ["blockchain", "security", "zero-day"]
old-link: https://privacylog.blogspot.com/2019/10/compound-finance-zero-day-prices-can.html
---

SUBJECT: BUG: Automated price oracle can violate guaranteed max swing without human intervention

## Summary

The price oracle documentation specifies how price anchors are set. However the implementation does not follow that specification. This makes possible a violation of guarantees made by the system.

## Specification

Source: <https://github.com/compound-finance/compound-oracle/blob/master/docs/Oracle-Specification.pdf>

> At the beginning of every hour, the price is stored as a new anchor price, and every price for the rest of the hour must be within 10% of that price.

## Implementation

Source: <https://github.com/compound-finance/compound-oracle/blob/master/contracts/PriceOracle.sol#L301>

```solidity
localVars.currentPeriod = (block.number / numBlocksPerPeriod) + 1;
uint public constant numBlocksPerPeriod = 240; // approximately 1 hour: 60 seconds/minute * 60 minutes/hour * 1 block/15 seconds
```

The period is set based on block number.

# Details

The implementation assumes 240 blocks per hour. This is incorrect, as admitted in the code. Actual block times are variable and skew is possible. See [actual times reported by Etherscan](https://etherscan.io/chart/blocktime).

## Impact

It is possible that price swings as large as 22.2% (1.1/0.9) will occur within a single hour without alarming or requiring human interaction. This exceeds the advertised limit of 10% price swings within one hour requiring human intervention.

SEVERITY: Medium

LIKELIHOOD: HIGH

Likelihood is high because token price movements are volatile and it is likely that a swing greater than ±10% will happen in one hour at some point.

# Recommendations

### Set reasonable expectations

The advertised specification is not possible. I recommend the following new specification:

> Our automated tools (price oracles) gather information from exchanges and set the market value of asset prices within the Compound system. As a quality control mechanism, we require any large price changes to have a human review. It works as follows:
>
> - A price anchor is set, originally by a human on our team.
> - Our automated tool updates this price periodically reflecting exchange prices, but is limited to a range ±10% of the anchor.
> - After some period of time, no less than approximately 60 minutes, a new anchor will be set based on the then-current price (also limited to ±10% of the previous anchor).
> - Our humans are able to manually override a price anchor if necessary to correct for a market price that is actually changing more than ±10% per hour.

### Update the implementation

Remove `uint period` from <https://github.com/compound-finance/compound-oracle/blob/master/contracts/PriceOracle.sol#L301>.

Add `uint block` to record the anchor block.

Rename `numBlocksPerPeriod` to `minimumPriceAnchorEffectiveTime`, `SetPriceLocalVars` and other calculation to implement new specification.

### Be transparent

Since we are making guarantees to the participants about pricing, we should provide them with the explicit data they need to understand the system.

Create a new event:

```solidity
event PriceAnchored(address asset, uint priceMantissa);
```

### Make it simpler

Many variables are named matching `New[Pending]Anchor[Admin]` this reduces readability.

The entire concept of a pending anchor is unnecessary. Just use:

```solidi
event PriceAnchoredByAdmin(address asset, uint priceMantissa);
```

and have it take immediate effect. This will save gas and increases code auditability.

## Timeline

- 2018-11-11 Discovered vulnerability
- 2018-11-11 Notified vendor
- 2018-11-11 Posted timestamped, hashed message in Compound issues tracker (bbf58c5b1fe7f6482063d3d27c3cc875aa529c3fc36f0ecba3c0ed38031abadd) which mostly matches this announcement
- Issue was not fixed
- Published on Privacy Log

Compound has announced version two of the protocol, but the affected version is still live.

- 2020-06-02 Confirmed also affects version 2.0.
- 2020-06-01 Assigned CVE-2019-20809
