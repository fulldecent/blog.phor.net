---
title: "Oil prices and election years regression analysis"
tags: 
  - finance	
old-link: https://fulldecent.blogspot.com/2008/10/oil-prices-and-election-years.html
---

I have heard that oil prices are affected by an election year. After some analysis, this is clearly not the case. Here's the data, relative oil prices on election years and non-election years:

![Oil prices and election years](assets/images/2008-10-01-oil-prices-and-election-years.png)

Methodology:

- Collect oil spot prices from [https://tonto.eia.doe.gov/dnav/pet/hist/rwtcd.htm](https://tonto.eia.doe.gov/dnav/pet/hist/rwtcd.htm)
- Divide each day's price by the previous day
- Take the geometric average across combinations of months and election/non-election years
- Visually see that the results are not statistically significant

P.S.

- The blue line is the election years and the red line is non-election years.
- The vertical axis represents average daily price change during the month (1.00 = 0% change)
- This is based on Cushing, OK WTI Spot Price FOB, from 1985 to today.