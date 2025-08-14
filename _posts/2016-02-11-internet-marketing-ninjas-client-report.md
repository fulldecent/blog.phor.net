---
title: "Internet Marketing Ninjas client report vulnerability"
tags: 
  - privacy
  - security	
old-link: https://privacylog.blogspot.com/2016/02/internet-marketing-ninjas-client-report.html
---

- EMBARGO: THIS ARTICLE IS HELD FOR RELEASE ON 2016-02-11

William Entriken and Internet Marketing Ninjas worked together the week of December 7th, 2015 to find and correct a data enumeration vulnerability on IMN's client reporting system.

Following is the dashboard which IMN clients can use to see information related to their account.

![Dashboard](/assets/images/2016-02-11-internet-marketing-ninjas-client-report.webp)

Additionally there is a view where clients may see the results of linkbuilding efforts by the company.

![Dashboard](/assets/images/2016-02-11-internet-marketing-ninjas-client-report-2.webp)

This website uses AJAX heavily to refresh and deliver reporting content to the user. It is possible to recreate these requests using a command line interface. (Although this may be a violation of IMN terms of service, so don't do it without their permission!)

## Synopsis

The following command can be used to download a list of a client's reports. The number ### is the client's ID number. It requires client access to the website, which is given through the Authorization Basic HTTP header. However, the number can be changed to any number to download that user’s account information.

```sh
curl -H "Authorization: Basic XXXXXXXX==" --data "func=reports_list&amp;client_id=###” https://reports.internetmarketingninjas.com/index.php
```

Likewise, the following command can be used to download links for that client's site. However, the number ### can be changed to any number to download links for a given account.

```sh
curl -H "Authorization: Basic XXXXXXXX==" --data "func=links_report_url_all_download&amp;client_site_id=###" https://reports.internetmarketingninjas.com/index.php
```

## Risk

The risk is that this command can be surreptitiously issued for each number. This would produce IMN's entire client list and all reports created for any client. This vulnerability applies to any client or other user with access to the IMN system. I have not reviewed any other potential vulnerability and there may be other risks.

Another part of the client reporting system, accessible at the /report-files/ URL is secure from this vulnerability. It is recommended that the same security in use there be applied to the two cases above.

## Recommendation

Perform connect authentication checks on this page and ensure proper authentication for all resources.

## Resolution

Full details of this vulnerability were reported to the vendor on Friday December 11, 2015 at 12:45 and the issue was resolved within two hours and fifteen minutes. We consider Internet Marketing Ninjas' response time to be exemplary. At this time, no evidence has been found to suggest that unauthorized access to client data has occurred. There are no remaining known vulnerabilities for client data at this time.
