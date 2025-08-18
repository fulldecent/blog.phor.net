---
title: "Google Apps publishes administrator contact information"
tags:
  - privacy
  - security
  - zero-day
old-link: https://privacylog.blogspot.com/2020/08/google-apps-publishes-administrator.html
comments:
  - link: https://privacylog.blogspot.com/2020/08/google-apps-publishes-administrator.html#comment-8432039822837375362
    name: Chad Elliott
    text: "Excellent info in the fight to keep customer&#39;s safe from hackers. Have you reached out to any of the above companies to share your findings and how it could negatively affect them?"
---

## Summary

You can look up the public contact information for any G Suite  account. This includes companies that host their email with Google.

## Introduction

This information is at, for example: <https://www.google.com/a/arstechnica.com/DomainContact>

I have looked at the [Moz Top 500](https://moz.com/top500) list and found which websites publish their administrator information.

Here's how to do that:

```sh
head ../domains.csv | sed -e 's/www\.//' | while read DOMAIN;
do curl "https://www.google.com/a/$DOMAIN/DomainContact" > $DOMAIN.txt
done
```

And here's a quick way to filter out accounts that aren't using G Suite and businesses that have not published information:

```sh
grep -A20 '"card' * | egrep -v '<'
```

## Result

Here is the full text list of helpdesk employees and password reset  instruction for internal employees at the top 500 websites.  Surprisingly, Google does not publish its own helpdesk information for  Googlers!

- about.com — <techteam@dotdash.com>
- arstechnica.com — Email <civis@arstechnica.com>
- avast.com — Contact it crowd at <itcrowd@avast.com>.
- bbc.co.uk — If you have further questions about this setting please click this link&nbsp;below:
- bbc.co.uk — <https://drive.google.com/drive/folders/0AKDMkhQ3AbyZUk9PVA>
- bbc.com — If you have further questions about this setting please click this link&nbsp;below:
- bbc.com — <https://drive.google.com/drive/folders/0AKDMkhQ3AbyZUk9PVA>
- bloglovin.com — <support@bloglovin.com>
- bloomberg.com — For questions about this service contact Raj Naghee Reddy or Enda McGee:
- booking.com — You cannot login with your existing booking.com account.
- booking.com — Please contact the Helpdesk on +44 2086128899 if external.  If on Cisco phone then 8899.
- change.org — <it.support@change.org>
- columbia.edu — LionMail is the main email system of Columbia University. For information write <askcuit@columbia.edu>.
- cornell.edu — If you don&#39;t remember your password you may reset it via <https://netid.cornell.edu>
- cornell.edu — For other issues send email to <helpdesk@cornell.edu>.
- deezer.com — <sos-it@deezer.com>
- digg.com — If you are having a Google App issue, please contact <it@digg.com>
- ea.com — For EA G-Suite support, please contact the IT Help Desk through...
- ea.com — &gt; Slack: #it_google_drive_help
- ea.com — &gt; Web: <https://helpdesk.ea.com>
- ea.com — &gt; Phone: x55555 or 1-877-232-4295
- fb.com — <help@fb.com>
- github.com — Please email  <it@github.com>  for technical support, or find us on Chat in the +IT Crowd room. Thanks, Hubot.
- gofundme.com — Please reach out to <itrequests@gofundme.com> for Support
- greenpeace.org — Hello Rainbow Warrior!
- greenpeace.org — This is your personal user hub. If you have any issues or questions please contact <global-it@greenpeace.org>
- gutenberg.org — Please ask questions here:
- gutenberg.org — <https://answers.ibiblio.org>
- harvard.edu — Please navigate to the following URL for information regarding obtaining support and changing your password:
- harvard.edu — <https://sites.google.com/a/g.harvard.edu/password-change/>
- hm.com — If you need help with your password or other support please contact your SEC responsible.
- hollywoodreporter.com — Do you need help signing in to your account?
- hollywoodreporter.com — Email us at:
- hollywoodreporter.com — <helpdesk@mrcentertainment.com>
- hollywoodreporter.com — or
- hollywoodreporter.com — Call us at:
- hollywoodreporter.com — 212-493-4123
- hp.com — ***
- instagram.com — <help@fb.com>
- intel.com — Contact <gapps_support@intel.com> for Google Support and Escalation  Process. For access requests, apply for - oogle Apps entitlement in AGS.
- linkedin.com — Contact LinkedIn&#39;s Help Desk +1.650.605.1700
- marriott.com — Please contact your Google Apps project team.
- mediafire.com — If you forget your password, please make a request to the NOC at extension 500.
- mit.edu — To request an account in the MIT Google Apps domain or to reset your  password please contact  google-help@mit.- du  or find more information on the web at  <https://mit.edu/google/>
- netflix.com — If you need assistance, please contact the Netflix Help Desk at 1-408-540-3614 (x73614).
- news.com.au — If you have lost your password or account details, please contact the IT Service Desk.
- news.com.au — If you need admin privileges on this account, please contact the Analytics Team.
- newyorker.com — For any G Suite support related queries please contact <support@condenastint.com>
- noaa.gov — If you are having a problem logging in, please clear your browser  cache and restart your browser.  If you problem persists try resetting  your password using accounts.noaa.gov.  If you are still having issues  or trouble with - esetting your password please contact your local  support.
- npr.org — Please e-mail <onlinetech@npr.org> for assistance.
- nps.gov — Please contact your DOI, Bureau or Office, support desk or your local office Information Technology team for - ssistance.
- nvidia.com — Please file a help request - <https://ithelp/>
- oreilly.com — If you need help with your company-assigned account, please contact <solutions@oreilly.com>.
- oup.com — Please contact the ITSD Service Desk for help.
- pixabay.com — <https://support.canva.com/>
- princeton.edu — This is the Princeton University Google Apps domain managed by the  Office of Information Technology.  Please visit  <https://www.princeton.edu/oit> for more information, or contact the OIT  Help Desk at <helpdesk@Princeton.edu> or - 8-4357 if you have any questions or problems.  
- rottentomatoes.com — rtfm
- salon.com — Call support
- scribd.com — For help please contact <helpdesk@scribd.com>
- shopify.com — Contact IT for help.
- shopify.com — <it@shopify.com>
- shopify.com — <https://shopify.slack.com/messages/it>
- shopify.com — <https://github.com/Shopify/it>
- shutterstock.com — If you require assistance with Google Apps, please contact <it@shutterstock.com>
- soundcloud.com — Please contact <techsupport@soundcloud.com>
- spotify.com — <it-support@spotify.com>
- stanford.edu — For support with the stanford.edu domain of Google Apps please submit a ServiceNow request:  
- stanford.edu — <https://stanford.service-now.com/it_services?id=sc_cat_item&amp;sys_id=6970905a13bce2008a9175c36144b08c>
- ted.com — Having trouble?  Please drop us a line at <it@ted.com> and we&#39;ll back to you as soon as we can!
- theatlantic.com — Contact <support@atlanticmedia.com>
- themeforest.net — Contact Service Desk and provide an alternative email address and the means for independent verification - f this email address through either another staff member or another means of communication.
- thesun.co.uk — Please contact the Service Desk on extension 26969.
- thetimes.co.uk — Please contact the Service Desk on extension 26969.
- time.com — For help, email <tech@time.com> or find help in the #google_help Slack channel.
- usgs.gov — Please contact your DOI, Bureau or Office, support desk or your local office Information Technology team for - ssistance.
- usnews.com — Please contact the Help Desk at <Helpdesk@usnews.com> or (202) 955-2555
- utexas.edu — To reset your password, please go to  <https://get.utmail.utexas.edu/manage>. For other issues,  please visit the ITS Help Desk at  <https://www.utexas.edu/its/helpdesk/forms/emailform.php>.
- weebly.com — Hope for the best..
- whatsapp.com — <help@fb.com>
- wikihow.com — Email us at <wiki@wikihow.com> with any questions.
- wikimedia.org — Wikimedia Staff:
- wikimedia.org — If you experience problems using Google Apps please e-mail <techsupport@wikimedia.org>
- wired.com — For any G Suite support related queries please contact <support@condenastint.com>
- yelp.com — Hi Yelper!
- yelp.com — Please contact <helpdesk@yelp.com> or call 415-230-6521 for assistance with your Yelp account.
- yelp.com — Love,
- yelp.com — Yelp IT
- zendesk.com — Please send an email to <it@zendesk.com> if you require any assistance with your account.

## Conclusion

This information could be useful to social engineers. You should  not publish this online in this way. Also when you train your staff, you should tell them your helpdesk contact information, rather then having  them rely on third-party websites to tell them who to call.

▧
