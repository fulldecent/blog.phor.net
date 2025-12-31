---
title: DeFi primatives for RWA
tags: ["blockchain"]
comments: []
---

We have looked at the basic function of finance: asset supply, asset lending and liquidation. And we studied the minimum ways to apply this in a traditional system with legal and regulator recourse as well as a rules based blockchain system. Next we will look specifically at the finance primatives related to real world assets (RWA) onchain.

But first, what are real world assets?

## What are real world assets (RWA)?

I am not ready to take a stand on defining what are RWAs. So I will tell you what many people are using this word for, and why some of it sounds silly to me. You can make your own conclusions and I wont argue you yet.

One broad definition of RWAs is "any asset that does not exist solely on chain" or "any asset that is not solely on-chain or on IPFS". Or even "any asset that does not exist solely on-chain or a media file hosted somewhere."

These nitpicks matter to some people that spent a lot of money on non-fungible tokens (NFTs) representing images.

Another definition of RWAs is "any kind of asset that existed before the year 2000".

Another definition of RWAs is "if aliens were looking down at us from space and they saw you holding something, and they saw you using it, and they were like 'oh wow I understand that this person is using this thing', then that is a real world asset."

{: .table }

| Example        | Off-chain | Before 2000 | Alien-use |
| -------------- | ---- | ---- | ---- |
| Bitcoin (when inside Ethereum Mainnet) | YES | NO | NO |
| Gold (segregated storage) | YES | YES | YES |
| Gold (mixed storage) | YES | YES | NO |
| House          | YES | YES | YES |
| Car            | YES | YES | YES |
| Stock share    | YES | YES | NO |
| Black Lotus MtG card | YES | YES | YES |

In all cases, a real world asset implies some kind of custodial. And therefore you must remember [Entriken's Law](https://x.com/fulldecent/status/978777547772170242):

> Your ownership of assets on a ledger is only as valid as your trust in the custodian who has physical control of the assets.

This applies because the assets are recorded on a blockchain, which is a ledger. But the assets themselves are not on the blockchain, they are held somewhere by some custodian.

## What primatives apply to any RWA?

Let's think about some of the exceptional situations that could apply to a real world asset.

1. It could be irreparably damaged.
2. It could be stolen.
3. The custodian could fail to honor committments they have made about the asset.
4. The custodian could be unable to honor some specific committments due to legal or regulatory restrictions.
5. The custodian could becaume incapacitated or unreachable.
6. The custodian may have never made committments about the asset that you thought they made.
7. The asset may not be what you thought it was.
8. The asset may cease to provide the benefits you expected.

You also need to clearly understand if the blockchain token is a **companion token** or a **custodian token**.

Anyway, studying these exceptional situations do not necessarily tell you what DeFi primatives you need. But as a concept you need to be prepared for these circumstances.

## DeFi primatives for profit generating enterprises

If a profit generating enterprise will want to share its benefits with on-chain participants, there are several approachs.

1. Perform snapshot of on-chain token holders, and distribute benefits off-chain to them.
1. Perform snapshot of on-chain token holders, and distribute benefits on-chain to them. (Similar to how OpenSea broadcasts royalties for NFTs).
1. Execute a multi-award reverse auction to buy tokens and then burn them.
1. Execute a market purchase order against an on-chain DEX to buy tokens and then burn them.

Any decentralized way to implement a multi-award reverse auction will need fees and other countermeasures to prevent spam and DoS attacks. These are worth exploring further. But for simplicity, I will recommend using the market purchase order.

The market purchase contract can work just like UniSwap. But it needs a small lockup period to prevent front running specifically related to the lumpy purchase:

```solidity
public const uint256 minimumLockupAnnouncementPeriod = 3 days;
public const uint256 maximumLockupPeriod = 3 hours;
public const uint256 minimumNonlockupPeriod = 30 days;

function lockupPeriodStartTime() external view returns (uint256 startTime);
function lockupPeriodEndTime() external view returns (uint256 endTime);
function designatedBuyer() external view returns (address buyer);

event LockupPeriodCreated(
    uint256 startTime,
    uint256 endTime
);

/// @notice Creates a lockup period during which only the designated buyer can purchase/withdraw tokens.
/// @description Swaps to buy tokens and liquidation from the pool are disabled during the lockup time for all except
/// the designated buyer. This is to prevent front running of large market purchase orders.
///
/// Fails if lockup period is currently active or the minimums/maximums are not satisfied.
///
/// @param startTime The timestamp when the lockup period starts.
/// @param endTime The timestamp when the lockup period ends.
/// @param buyer The address of the designated buyer who can purchase tokens during the lockup period.
function createLockupPeriod(
    uint256 startTime,
    uint256 endTime,
    address buyer
) external onlyRole(ADMIN_ROLE);

// ... remaining functions are a normal DEX interface ...
```

## Multiparty crowdsale primatives for secondary sales

Another unique situation for onboarding RWAs is the crowdsale from an in-group to an out-group.

In this scenario, a group of people are holding tokens and trading amonng themselves. This is enforced by an allow list. However, after a successful crowdsale event, the transfers allow list is removed and the tokens can be traded freely on-chain.

This aligns with business reality where managing a closely held group of token holders is simpler than managing a large open group. And satisfying a threshold value can make this worthwhile.

```solidity
public const uint256 minimumCrowdsalePeriod = 7 days;
public const uint256 maximumCrowdsalePeriod = 90 days;
public const uint256 finalizationPeriod = 7 days;

function wasCrowdsaleSuccessful(uint256 crowdsaleId) external view returns (bool successful);

event CrowdsaleScheduled(
    uint256 indexed crowdsaleId,
    uint256 startTime,
    uint256 endTime,
    ERC20 tokenForSale,
    ERC20 paymentToken,
    uint256 pricePerSaleTokenEE18
);

event CrowdsaleParticipation(
    uint256 indexed crowdsaleId,
    address indexed participant,
    uint256 amountOfSaleTokensPurchased,
    uint256 amountOfPaymentTokensSpent
);

event CrowdsaleFinalized(
    uint256 indexed crowdsaleId,
    bool successful
);

/// @notice Starts a crowdsale period during which transfers are only allowed to/from the allow list.
/// @param startTime The timestamp when the crowdsale starts.
/// @param endTime The timestamp when the crowdsale ends.
/// @param tokenForSale The ERC20 token being sold in the crowdsale.
/// @param paymentToken The ERC20 token used for payment in the crowdsale.
/// @param pricePerSaleTokenEE18 The price per sale token, expressed in payment tokens with 18 decimals.
/// @dev Fails if the crowdsale period is currently active or the minimums/maximums are not satisfied.
function scheduleCrowdsale(
    uint256 startTime,
    uint256 endTime,
    ERC20 tokenForSale,
    ERC20 paymentToken,
    uint256 pricePerSaleTokenEE18
) external onlyRole(ADMIN_ROLE);

/// @notice Participates in an active crowdsale by purchasing sale tokens with payment tokens.
/// @param crowdsaleId The identifier of the crowdsale to participate in.
/// @param amountOfSaleTokensToPurchase The amount of sale tokens the participant wishes to purchase.
/// @dev Fails if the crowdsale is not active, if there are insufficient payment tokens,
/// or if the purchase exceeds the available sale tokens. Marks as finalized if full allocation reached.
function participateInCrowdsale(
    uint256 crowdsaleId,
    uint256 amountOfSaleTokensToPurchase
) external; // Be sure to calculate dust payments correctly at the end!

/// @notice Withdraws purchased sale tokens after the crowdsale has finalized or original tokens if unsuccessful.
function withdraw(uint256 crowdsaleId, address participant) external;
```

And then the actual token contract needs to allow one-time unlock if crowdsale is successful

```solidity
address public crowdsaleContract;
uint256 public crowsaleId;
bool public transfersLockedForCrowdsale = true;

/// @notice Overrides the standard transfer function to enforce crowdsale transfer restrictions.
/// @param to The address to transfer tokens to.
/// @param amount The amount of tokens to transfer.
/// @dev If transfers are locked for crowdsale, only allow transfers to/from addresses on the allow list.
function transfer(address to, uint256 amount) public override returns (bool) {
    if (transfersLockedForCrowdsale) {
        require(
            isAddressOnAllowList(msg.sender) || isAddressOnAllowList(to),
            "Transfers are locked for crowdsale; only allowed to/from allow list addresses."
        );
    }
    return super.transfer(to, amount);
}

/// @notice Sets the crowdsale contract address and ID for transfer unlocking.
/// @param _crowdsaleContract The address of the crowdsale contract.
/// @param _crowdsaleId The identifier of the crowdsale.
/// @dev Can only be called once by an admin role.
function setCrowdsaleContract(address _crowdsaleContract, uint256 _crowdsaleId) external onlyRole(ADMIN_ROLE) {
    if (crowdsaleContract != address(0)) {
        revert("Crowdsale contract already set");
    }
    crowdsaleContract = _crowdsaleContract;
    crowsaleId = _crowdsaleId;
}

/// @notice Unlocks transfers after a successful crowdsale.
/// @dev Anybody can call this function, but it will only succeed if the crowdsale was successful.
function unlockTransfersAfterCrowdsale() external {
    require(crowdsaleContract != address(0), "Crowdsale contract not set");
    ICrowdsale crowdsale = ICrowdsale(crowdsaleContract);
    require(crowdsale.wasCrowdsaleSuccessful(crowsaleId), "Crowdsale was not successful");
    transfersLockedForCrowdsale = false;
}
```
