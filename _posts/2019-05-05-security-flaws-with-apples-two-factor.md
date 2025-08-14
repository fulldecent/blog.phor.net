---
title: "Security flaws with Apple's two-factor authentication"
tags: ["security"]
old-link: https://privacylog.blogspot.com/2019/05/security-flaws-with-apples-two-factor.html
comments:
  - link: https://privacylog.blogspot.com/2019/05/security-flaws-with-apples-two-factor.html#comment-9071165585209717893
    name: Roger
    text: "&gt; however this documentation wholly excludes any mention of the steps where you are required to enter your iPhone password or Mac administration password  It&#39;s now documented in a separate article: https://support.apple.com/en-us/HT202303  &gt; which is ostensibly sent to Apple  Agreed that the UX is confusing. However, the above doc clearly suggests that the Mac/iPhone password is used in key derivation and not directly sent anywhere: &quot;a key derived from information unique to your device, combined with your device passcode&quot;. (I&#39;m guessing &quot;information unique to your device&quot; is just salting with a unique identifier.)  &gt; If Apple wishes, or its agents, or anybody in any jurisdiction that has the authority of search warrants, the password could be misused.  You&#39;re basically saying that Apple stores plaintext passwords that are meant specifically to be used for end-to-end encryption (or at least receives them temporarily), or perhaps that Filevault and iCloud end-to-end encryption use identical deterministic key derivation functions?  Based on what&#39;s been stated publicly, I&#39;d guess that iCloud prompts for your Mac or iPhone password exclusively to perform key derivation on the device where you entered it, in order to derive the iCloud end-to-end encryption key. Assuming a baseline level of competence, the iCloud service itself doesn&#39;t store all of the factors required to derive this key (specifically, the password), but it apparently does store other information (device names and the unique identifiers that feed into the KDF).  Maybe you didn&#39;t get a response for your security report because this system was working as designed, more or less?"
---

## Background

Apple has made recent updates to its two-factor authentication system. Important parts of this system are undocumented, and this systems make make your local system administrator password available to people at Apple and anybody with subpoena power or coercion over Apple. This also reduces the security of Apple’s File Vault 2 (full disk encryption).

All enrollees to the Apple developer program are required to use two-factor authentication for their Apple account.

## Steps to reproduce

As part of the process to enable two-factor authentication for iCloud, the Apple account holder is asked to enter their device password (iPhone Passcode or Mac Administrator Password). And the Mac Administrator password is the same password which is used to encrypt a Mac hard drive.

When this happens, the account holder is shown a prompt and it is explained that this password must be entered into another device to login to iCloud.

![Two factor](/assets/images/2019-05-05-security-flaws-with-apples-two-factor.webp)

![Two factor 2](/assets/images/2019-05-05-security-flaws-with-apples-two-factor-2.webp)

## Analysis

Here are the steps involved in registering multiple accounts with Apple.

```mermaid
sequenceDiagram
title Apple Account Registration

participant iPhone as Your iPhone
participant Apple as Apple
participant Mac as Your Mac

iPhone->>iPhone: Enter iPhone password
iPhone->>Apple: Something is sent
Mac->>Mac: Enter iPhone password
Mac->>Apple: Request to use Apple ID
Apple->>Mac: Access granted
```

Apple published [detailed documentation](https://support.apple.com/en-us/HT204915) for two-factor authentication, however this documentation wholly excludes any mention of the steps where you are required to enter your iPhone password or Mac administration password, which is ostensibly sent to Apple. Following is a screenshot of the current version of this webpage for posterity.

![Register](/assets/images/2019-05-05-security-flaws-with-apples-two-factor-4.webp)

Zero explanation of this security feature is available so I cannot evaluate if the system is designed properly. I can imagine several possible poor implementations of the systems meeting all the advertised system features while also making my local hard drive encryption (File Vault 2) password at risk for Apple or an agent of Apple to brute force it.

By failing to describe the feature at the time that Apple software collects the account holder password and also failing to document it on the website, Apple fails to establish proper custody of this authentication token. If Apple wishes, or its agents, or anybody in any jurisdiction that has the authority of search warrants, the password could be misused. This would compromise the security of File Vault 2, a hitherto offline-only secure system.

## Summary

Anybody using File Vault 2 full disk encryption on an Apple computer where that computer's administrator uses two-factor authentication should consider their disk encryption broken. Their computer is no longer secure against physical interception and description.

## Disclosure timeline

- 2019-04-02: I made discovery, reported to Apple product security team, set 30-day disclosure timeline
- 2019-04-02: Apple sent automated email receipt
- 2019-04-04: Apple confirms investigation, requests additional details and extension to 30-day disclosure timeline
- 2019-04-04: I confirm no additional details are relevant, offer to extend disclosure timeline if defect is confirmed
- 2019-04-16: Apple confirms investigation, requests to see this full blog post
- 2019-04-17: I decline to send blog post, since the "substantive" part  was already sent and the blog post had not been written yet
- 2019-04-29: I sent a reminder that publication is forthcoming and will be delayed if the defect is confirmed
- 2019-05-05: Published to Privacy Log
