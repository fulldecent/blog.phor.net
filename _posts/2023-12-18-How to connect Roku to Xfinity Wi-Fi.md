---
title: "How to connect Roku to Xfinity Wi-Fi"
tags: how-to
---

*This page includes an affiliate link. And hopefully I'll get paid if you click it. This does not increase the price you pay, you would get the same price with or without my link.*

When you login to Xfinity Wi-Fi with a computer you need to login with a browser.

![Login to Xfinity Wi-Fi with account](/assets/images/2023-12-18-How to connect Roku to Xfinity Wi-Fi.png)

But if you login from Roku there is no browser.

![Roku has no browser](/assets/images/2023-12-18-How to connect Roku to Xfinity Wi-Fi2.jpg)

So to fix this you:

1. Go to Roku > Settings > Information, then write down the MAC address

2. Buy a Mac

3. Open Terminal.app

    ```sh
    sudo bash
    ifconfig en ether
    ifconfig en ether ****TYPE IN THE WIRELESS MAC HERE****
    ```

4. Close and reopen Wi-Fi and connect to `xfinitywifi`

5. Login to Comcast

6. Open Terminal

    ```sh
    ifconfig en ether ****TYPE IN YOUR OLD ETHER HERE****
    ```

7. Use the Roku and get on `xfinitywifi`

8. TV and chill

This is confirmed for [the Roku 4K version](https://amzn.to/475rBFm).