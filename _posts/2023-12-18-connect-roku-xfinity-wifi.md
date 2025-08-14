---
title: "How to connect Roku to Xfinity Wi-Fi"
tags: ["how-to"]
old-link: https://fulldecent.blogspot.com/2013/12/how-to-connect-your-roku-to-xfinitywifi.html
affiliate-link: true
---

Connecting your Roku device to Xfinity Wi-Fi can be tricky, especially since Roku devices do not come with any built-in browser. This limitation makes the standard login process through a web page impossible. However, there's an effective workaround using a computer to spoof your Roku's MAC address, allowing you to authenticate on the Xfinity Wi-Fi network. Here's a step-by-step guide on how to do it, specifically tested and confirmed for the Roku 4K version.

## You will need

- A Roku device
- A computer, preferably a Mac for this guide
- Access to the Xfinity Wi-Fi network

## Step-by-step guide

**1. Gather your Roku's MAC address**

First, navigate to `Settings > Network > About` on your Roku device to find its MAC address. The MAC address is a unique identifier for your device on the network. Write this down, as you'll need it for later steps.

**2. Spoof your MAC address**

On your Mac, open the Terminal application. You'll need administrative access, so start by typing `sudo bash` and enter your password when prompted. To change your MAC address, use the following commands:

```sh
sudo bash
ifconfig en0 ether
ifconfig en0 ether [Your Roku's MAC Address]
```

Replace `[Your Roku's MAC Address]` with the actual MAC address you wrote down earlier. If your Wi-Fi interface is not `en0`, replace `en0` with the correct interface identifier (you can find this by running `ifconfig`).

**3. Connect to Xfinity Wi-Fi**

After changing your MAC address, reconnect your computer to the `xfinitywifi` network. A login page should appear. Use your Xfinity account credentials to log in.

**4. Restore Your MAC Address**

Once you've successfully logged in, it's important to change your MAC address back to its original value. Restart your computer or manually reset it in the Terminal using the same steps as before, but with your original MAC address.

**5. Connect your Roku**

With the authentication process completed using your computer, your Roku device should now be able to connect to `xfinitywifi` without any login prompts. Navigate to the network settings on your Roku, select `xfinitywifi`, and connect.

## Conclusion

Now you can TV and chill.

These instructions are confirmed for [the Roku 4K version](https://amzn.to/475rBFm).
