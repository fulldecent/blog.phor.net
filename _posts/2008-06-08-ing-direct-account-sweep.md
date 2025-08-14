---
title: "ING Direct communication case study: account sweep user interface"
tags: 
  - user-interface	
  - howto
old-link: https://privacylog.blogspot.com/2008/06/ing-direct-account-sweep.html
comments:
  - link: https://privacylog.blogspot.com/2008/06/ing-direct-account-sweep.html#comments
    name: Anonymous
    text: 'Note, there is currently a workaround to get this feature: Create a payment of X cents, for each X = 2^n (n=1, ...).'
---

ING Direct does not include an account sweep function. There is an HTML hack possible to do this but I will not discuss. Following is the feature users would expect on the site:

1. A way to sweep all available money from one of your accounts to another one of your accounts. Just click the Account Balance button instead of entering an amount. This also works well with recurring payment, so that you can create a sweep account.
2. Now you have an account number you can give out to friends, PayPal, etc. You will not have to worry about them being able to withdraw money from your account, since it will remain empty. Anyone burned by PayPal will appreciate this.

Note: you cannot sweep all money from a non-ING account to an ING account, since ING cannot determine the balance of that external account.

![Account sweep setup with ING Direct](/assets/images/2008-06-08-ing-direct-account-sweep.webp)
