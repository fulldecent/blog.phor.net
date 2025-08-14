---
title: "ProDPI ordering system leaking private customer information"
tags: ["security"]
old-link: https://privacylog.blogspot.com/2015/07/prodpi-ordering-system-leaking-private_4.html
---

UPDATES

- First draft 2015-07-01: Reviewed with ProDPI COO&nbsp;Jeffrey Lazo.
- Update 2015-07-04: ProDPI has made a blog post at <https://www.prodpi.com/security-warning/> which reasonably notifies customers of the vulnerability. Updated text to reflect this.
- Update 2016-07-08: The website is now vulnerable again in nearly the same exact way.

## Background

ProDPI is a photo lab which is marketed to professional photographers, specifically wedding photographers. I have used their services in the past.

## Technical overview

ProDPI uses several systems for sales, client interaction, and order processing:

- <https://www.prodpi.com/> main sales website
- <https://www.prodpiconnect.com/> order tracking and account management
- ProDPI ROES downloadable Java "Remote Order Entry System" system for uploading
- <https://www.roeslaunch.com> backend server for ROES
- <https://www.prodpiroes.com> backend server for ROES
- <https://199.127.202.18:81> backend server for ROES

![Systems](/assets/images/2015-07-04-prodpi-customer-information-leak.webp)

## The vulnerability

When accessing the <https://www.prodpiconnect.com/> website to review an order, you must be logged in to access any data. However, once logged in, you are able to access billing data from another user's account. A URL for accessing my invoice it at:

- <https://www.prodpiconnect.com/invoice_prodpi.asp?InvoiceID=1126629>

![Access](/assets/images/2015-07-04-prodpi-customer-information-leak.webp)

However, you are able to modify the number in the URL to access the invoice from a user account which is not yours.

The vulnerability is a user information enumeration attack. It would allow a person to download the contact information (name, business name, address) of all clients as well as any confidential pricing information. If you have done business with ProDPI, you must assume that this information of yours has been leaked.

## Communication

I wrote in with the following letter to announce this vulnerability to the vendor around midnight Eastern Time late Tuesday 23, 2015. It was emailed to the support email address and the company CEO (found via LinkedIn).

> Hello,
>
> I am writing in to note that your entire list of customers is publicly available online. This includes the studio name and their address.
>
> These can be found by logging in then accessing the URL below and then changing the number at the end to all possible order numbers (which are sequential).
>
> <https://www.prodpiconnect.com/workorder_prodpi.asp?ACTION=WorkOrder&amp;Workorder=1031060>
>
> This may sound like a tedious task, however, someone with the right expertise would be able to download all such orders with no more than 5 minutes of effort. (I have not done so. Although others may have already done this.)
>
> I intend to publish this finding on a blog where I discuss security problems with websites. I have set a publication date of July 7, which I believe gives you a reasonable amount of time to fix the problem.
>
> I hope that you are happy to hear this from me, because this will allow you to correct a problem that currently exposes your entire customer list to competitors. After the problem is fixed, I would appreciate if you would give credit to me for finding this by mentioning my name on your blog with a description of what was fixed, and then linking to [my blog](https://blog.phor.net). Also, if you offer a bounty, store credit or anything else for referring this to you, I would appreciate it.
>
> Regards
> Will
>
> P.S. If your technical team is not sure how to correct this problem, I am available to discuss this with them. It is a simple fix, I would not charge a fee for this.
>
> William Entriken
> WE Design &amp; Consulting
> phor.net

I don't know if my letters are appropriate in asking for a bounty. But I provide these letters in the interest of promoting discussion among security professionals on the topic. Either way, it is definitely appropriate to ask that the vendor fix the problem and inform its users that they were vulnerable. In Europe, of course, data protection laws require it.

# The resolution

The support email / Zen Desk autoresponder replied immediately to note a response time of one business day.

From email quotes, I can see Caitlin Lazo, the CEO, forwarded the message to Jeffrey Lazo, COO and husband, within seven minutes.

Jeffrey replied 39 minutes after my original message to note that the issue has been fixed by temporarily disabling access to invoices. He said it would be secured and brought back online soon. I can confirm this has been done.

ProDPI has made <a href="https://www.prodpi.com/security-warning/">a blog post on its website</a> regarding the potential breach to inform customers that some data may have been compromised.

## The privacy policy

The ProDPI website privacy policy notes that:

> Your personal information is contained behind secured networks and is only accessible by a limited number of persons who have special access rights to such systems, and are required to keep the information confidential. In addition, all sensitive/credit information you supply is encrypted via Secure Socket Layer (SSL) technology.

Previously, "personal information" was defined as:

> When ordering or registering on our site, as appropriate, you may be asked to enter your <b>name, email address, mailing address, phone number, credit card information or other details</b> to help you with your experience.

As such by bring this breach to their attention, ProDPI has obliged itself to disclose this to its customers.

Lastly, ProDPI mentions the [California Online Privacy Protection Act](https://oag.ca.gov/ecrime/databreach/list). The Act requires disclosure that data breaches such as this should result in notification to customers and posting on the COPPA website. COPPA defines personal information in CAL. CIV. CODE § 1798.80(e) as:

> "Personal information" means any information that identifies, relates to, describes, or is capable of being associated with, a particular individual, including, but not limited to, his or her name, signature, social security number, physical characteristics or description, address, telephone number, passport number, driver's license or state identification card number, insurance policy number, education, employment, employment history, bank account number, credit card number, debit card number, or any other financial information, medical information, or health insurance information. "Personal information" does not include publicly available information that is lawfully made available to the general public from federal, state, or local government records.

COPPA may also oblige them to post this incident to their website. However, the disclosure they made on their blog was definitely reasonable in this situation.

## Conclusion

ProDPI's technical and business response to this issue was exemplary. They did the right thing (which is difficult!) and properly disclosed the potential problem to their customers, and gave credit. Everyone wins.
