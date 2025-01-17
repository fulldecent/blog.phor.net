---
title: "Inefficiencies in the football betting market"
tags:
  - finance
  - technical
  - youhearditherefirst
old-link: "https://fulldecent.blogspot.com/2010/09/inefficiencies-in-football-betting.html"
comments:
  - link: "https://fulldecent.blogspot.com/2010/09/inefficiencies-in-football-betting.html#comment-5771333833318783272"
    name: William Entriken
    text: Data shows that the underdog inefficiency, while pronounced in the past, is currently no more.
---

**Is there an opportunity to systematically win in the NFL betting market?**

If there is, possible sources of this opportunity, "market inefficiency", or "pricing error" may include:

- Aggregate bettor bias
- Observable effects of the game being fixed
- Over compensation of the above by professional bettors

Of course, this analysis isn't going to do itself, so I needed to step up to the plate. I found some research on the topic, mostly focusing on simple betting strategies and all of them severely limited in timeframe (citations at link below). My analysis includes all regular season game data from 1978 to 2009. So let's get to the fun part!

> **Bet on the visitor**
>
> - Wins: 3603
> - Ties: 203
> - Losses: 3600

And then the obvious:

> **Bet on the underdog**
>
> - Wins: 3735
> - Ties: 203
> - Losses: 3468

Ok... what about betting on a team when that team just lost to the opponent it is about to play within the past 21 days?

> **Payback in 21 days (after losing previous game)**
>
> - Wins: 30
> - Ties: 1
> - Losses: 30

> **Payback in 21 days (after losing the previous line)**
>
> - Wins: 27
> - Ties: 1
> - Losses: 29

And to be more devious, will there be a bias on A beating B if recently A beat C and C beat B (I call this a "transitive" bet)?

> **Bet on transitives based on 14-day history**
>
> - Wins: 12
> - Ties: 1
> - Losses: 13

> **Bet on 14-day transitives based on the line**
>
> - Wins: 8
> - Ties: 1
> - Losses: 15

Now we're getting interesting results! Using some more data points: after A beat C by Y more points than B beat C, what is your expected payout Y betting on A beating B (within 14 days of those two games)?

> **IMAGE:**  
> [Transitives.png](https://1.bp.blogspot.com/_rG3Oup-CHJE/TKD-B6i8PfI/AAAAAAAAA-I/5V5_DQZttc8/s1600/Transitives.png)

If you want to make money on the "A beat C by more points than B beat C" strategy, you're going to have to perform a regression on the graph above. Any guess on the R-square for that?

You are welcome to take part in the research. All data files, code and results are available online. Some additional things I started but didn't find promising results for were: transitives and paybacks when the big game happens on a Monday or involves the largest teams (more temptation to fix these types of games).

Another thing you could try would be to estimate bettor volume per game (based on Nielsen ratings or data from Vegas) and dot product bettor sentiment (I won’t say how to get this) and then see if there is a positive value for bookies -- this may indicate a fixed game, but would be hard to exploit for profit since both of those will be harder to predict (and they may not be independent!).

[Data files, source code and results are here.](https://code.google.com/p/footballbetting/)
