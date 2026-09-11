---
keywords: information service, trustless, online betting, blockchain, ethereum, smart contracts, web3, game theory, oracles, digital rights management, web5, web2+3, web2.5
---

:running: TODO:

- [ ] Find target publications :bomb: :arrow_left: :warning: :unicorn:rn
- [ ] USEFUL DATA or EXTRINSICLY USEFUL DATA? TRUSTED DATA
- [ ] Add in talk of Augur
- [ ] Find great coauthors
  - [ ] ? coauthor with kremalicious? data paper <https://oceanprotocol.com>

# A game-theoretic approach to publish and sell trust-value data

*ABSTRACT: A definition is put forth for "trust-value" in data, as distinct from other kinds of valuable data. For trust-value data, the risks of unauthorized copying are explored as well as current best practice countermeasures. A novel approach for publishing and selling this data, including on blockchain, is presented and an equillibrium is reviewed for market participants. In brief, only a small subset of data for sale has trust-value; the seller is protected when they introduce known errors into the data and sell insurance against those errors.*

## What is trust-value in data?

Data includes facts, observations, and information. This paper is primarily concerned with data that has trust-value. And typically this kind of value is related to actions that can be taken with the data.

First, let's review some data which has trust-value.

**Examples of data with trust-value:**

- A list of live current market prices for equities listed on the New York Stock Exchange
  Anybody could copy and repost this data. However, a person that trades stock who relies on inaccurate or stale information to place market, could be harmed by suboptimal trade execution. Live, real-time quotations are not publicly available.

- A list of statistics and outcomes for horseracing events, published in an almanac

  Anybody could attend horseracing games and compile the outcomes and statistics. However, anybody could just not and say they did. Trust-value is present whereas somebody relying on the information is unable to independently verify the it (if they were not there).

- A list of the top 100 colleges as reviewed by U.S. News and World Report

  Anybody could produce a list of colleges and claim it was published by U.S. News and World Report. A person that relies on an inaccurate, forged list could be harmed by overvaluing a school that was falsely added. A school that is on the legitimate list but omitted in the forgery could suffer reputational risk—however in this case they are not the one using the data, so this effect is derivative.

- A list of unused exfiltrated usernames, passwords and credit card numbers from WalMart

  A person using exfiltrated (e.g. "stolen") data can independently verify it, by attempting to login with the username and password, or attempting to use the credit card. However there is a risk of detection each time they use it. We can assume WalMart will investigate and take countermeasures when reports of this misappropriation come in. Therefore a person relying on a claim of unused data, trusts the seller has not already sold it to other parties.

Data only has trust-value if if there is an element of trust in the provider of the data. This includes trusting their methods for calculating, tabulating or collecting the data. In a derivative sense, this can also include trust that other people will rely on the provider of the data.

**Examples of data without trust-value:**

- A collection of clinical outcomes for a patient drug study

  This is extremely valuable to a researcher because they can cite this information in a paper and claim "used with permission" without fear of lawsuit. This is intellectual-property-value, not use-value. If the clinical outcomes are open access, great, the researcher can use them without consideration of cost. But if the clinical outcomes are only available at a cost, and the researcher does not appreciate this intellectual-property value, they are just as well served by using an unauthorized copy of the data from a third-party source.

- The bits representing Michael Jackson's *Thriller* album, encoded in 128-bit AAC format

  A reason people pay for *Thriller* rather than pirating or ripping it is because it is easier. That's convenience-value. Or because they want to support the estate of Michael Jackson and other rightsholders. That's intellectual-property-value. Or they want want to avoid going to jail. That can also be called convenience-value. A person that does not appreciate either of the above values will be just as well served by acquiring this data from an unauthorized source.

- Search results on DuckDuckGo for tapas restaurants in Center City Philadelphia

  A person that wants to eat tapas will be happy to have a list of nearby tapas restaurants, regardless of the source. This is convenience-value or entertainment-value. However, if a person relies on this list to exclude closed restaurants then this is a trust-value on DuckDuckGo's maintenance of this list—the hungry person reduces their risk of harm from visitng a closed restaurant.

If the well-known source for some data publishes it on their well-known official website, it loses all economic value. The same is true if this source digitally signs some data and pastes only that signature onto their well-known Twitter account.

💬 Discussion question: why does signed, useful data become economically worthless?

## to charge money for access to data

Now that we have identified useful data and understand the risks of piracy, surely other people have dealt with this problem, right? There are some well-known approaches used to frustrate would-be pirates of data. The straightforward way to sell data is to publish it in a book, or an e-book or ZIP file and then sell that file.

### Licensing agreements

When you buy data, typically the seller will require you to agree not to share that data. These are licensing agreements supported by government legal systems in various jurisdictions.

### Intentional wrong values ("sentinal values")

With sentinal values, the seller inserts known incorrect information into the data set. This makes it easy to detect and prove so when their data is copied. The amount of incorrect information is typically designed to minimize harm to data end-users.

- Logarithm tables where some of the least-siginificant digits are rounded arbitrarily. (Successfully used ...)
- Maps where non-existant streets are added (used to sue...)
- Dictionaries with fake words added (...)
- Search engine results with fake data (...) Google/Bing example
- Address lists with a sentinel address to detect if more mail is being sent than agreed upon.
- Google lyrics copied from Genius (...)

These techniques are useful to a seller when somebody wants to resell their data without authorization. If the reseller is collecting money it is easy to trace back to the seller's entity, then the seller just needs to prove the data is unauthorized duplication and seek legal relief.

### Unique watermarking

A seller can give every customer a different copy of the data set. If a copy is ever published this helps identify which person exposed it. Watermarking can be introducing using certain sentinal values or by introducing other artifacts which do not affect the actual data.

- Music sold on iTunes includes your Apple ID email address hidden inside every song.
- Source code downloaded by Google employees for their normal work includes arbitrary invisible spaces at the end of certain lines.
- Edward Snowden briefly discussed a similar system at the U.S. National Security Agency to detect whistleblowers.

Watermarking is effectively when the risk is that one person with authorized access to data will publish it anonymously. This approach increases the accountability for that person. And if the process of gaining access includes identifing the data user, then this deanonymizes the publisher.

💬 Discussion question: what is a countermeasure to unique watermarking? (buy multiple copies and compare/mix them, quantize/reformat the data)

### Price the data assuming it will leak

Since it is easy to copy data, a data product can be priced for just one seller.

- Companies which manufacture or sell in China can price their technology transfer in expectation of a data leak. I visited Knorr Bremf for a class trip and we asked how they deal with China copying their product designs. They say it's simple, they figure out how long it will take China to copy the current model. When they go to China, then they plan so that all project investments are paid off with profit before that amount of time. [[source: my visit in 2008]]
- Software exploits are priced for the world-wide impact upfront.
  Intelligence agencies are always looking for new nobody but us ("NOBUS") capabilities. And intelligence agencies maintain operation controls to reduce leaks. But the seller/broker has an incentive to leak or resell since they can multiply their profits. Exploits can be sold at a high price representing the total worldwide NOBUS value with clawback contract terms used to disincentivise resale by the seller/broker.

## Why these classical approaches fail for anonymous sale of data

In 2018, with the advent of blockchain applications, several projects were funded & started which involve selling access to data, anonymously, using a decentralized platform. This essay reviews the problem space, compares previous solutions using older technology, and proposes an equilibrium solution for market participants.

If a person with authorized access is effectively anonymous then they can take their data and publish it without fear of reprocussions. Unique watermarking is not useful if the customer can achieve anonymity. If you try to pirate Final Cut Pro or other Mac software you will see that those apps are usually registered to somebody in Russia. It is likely that if Apple wanted to find the person associated with those email addresses they would be unsuccessful, or they would fail to make recourse against them.

> :star: Unique watermarking cannot help a seller if they fail to positively identify their customers

Sentinal values continue to be useful, but only against somebody that wishes to resell the data. This provides no defense against somebody that wants to only use the data. This is because a vast majority of the data is correct.

Selling through blockchain to anonymous buyers faces these problems.

## Ambivilant oracle, a new approach to selling trust-value data

A subscription-based model is presented which allows a seller to sell *useful* data to a buyer. We review a simple game to show that this approach is efficient and in equilibrium. This uses a single published dataset .... called the Ambivilant Oracle.

The ambivalent oracle publishes and digitally signs data with trust-value. However, this data includes known errors and those errors are designed to include a measurable and high cost to the user of the data.

An example of an ambivalent oracle includes a public, live-market price-reporting service for sales on the New York Stock Exchange where some values are intentionally wrong and where the publisher picks the wrong values such that somebody relying on those values will lose, an average, a significant amount of money in suboptimal trade execution.

Another workable example would include a blockchain,

This sale of data can include a time limit for claims of incorrect data.

---

----

- Discuss parasitic market risk of Augur

## Why sell data? Why new approaches?

There are plenty of kinds of data for sale. Looser definitions of data include all digital products for sale, information and certain one-off publications. These data can be sold through online commerce between parties that have not met face-to-face and have not established trust. This presents challenges for untrusted (e.g. blockchain) applications because the seller may trivially forge the product and the buyer may trivially publish or resell without authorization. So far these business models, the problems, and some countermeasures are understood—at least intuititively—by market participants.

[[]] NEED CITATIONS, of people understanding this already // cite web5?

Some broad trends have an effect on this market. Because data and digital products can be easy to transport they are often available across national borders.

1. The international regulatory framework and treaties for trade have a large effect on this sale of data—including Brexit, United States negotiation with China regarding intellectual property protection, Iran and United Arab Emirates barricade of civilian access to the Internet, European and California legislation on data privacy and retention—and this framework is getting more complex.
2. The retail value of services and digital goods is outpacing the value of physical goods. [[cite]]
3. New kinds of systems, like public access, pseudonymous networks ("trustless," "Web3," "blockchain," "darknet" systems) are rising in commercial value. These systems might be considered as outside any jurisdiction. And also, the introduction of pseudonymous actors can be unintuititive for people that understand the social contract and the more commercial markets of yesteryear for digital items.

These trends point towards a future that will require new models and intuition for understanding the sale of data.
