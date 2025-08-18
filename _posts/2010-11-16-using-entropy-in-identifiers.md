---
title: "Giving away all your customer details because of a checksum"
tags:
  - privacy
old-link: https://privacylog.blogspot.com/2010/11/using-entropy-in-identifiers.html
comments:
  - link: https://privacylog.blogspot.com/2010/11/using-entropy-in-identifiers.html#comment-4425274784706274842
    name: William Entriken
    text: "Here is a famous parking ticket... you can use it to look up Justice Scalia's license plate!<br><br>https://articles.philly.com/2012-10-17/news/34527154_1_interpretation-of-legal-texts-justice-scalia-ppa-officer/2"
---

The **Philadelphia Parking Authority** is often criticized for being one of the most taxing entities on everyday people in Philadelphia. In 2007, they reported a revenue of [**$192 million**](https://www.dailypennsylvanian.com/article/amanda-please-no-need-parking-wars). Additionally, their expansion results in [**$11 million in annual red-light camera revenue**](https://www.philapark.org/redlight/fyr2010.pdf). This indicates that they collect on average $212 per local driver per year. To understand this better, consider the [number of licensed drivers](https://www.statemaster.com/graph/trn_lic_dri_tot_num-transportation-licensed-drivers-total-number) and the [population of Philadelphia](https://www.wolframalpha.com/input/?i=population+of+philadelphia+/+population+of+pennsylvania).

### Ticket processing

They manage this through a convenient online ticket payment website at [philapark.org](https://philapark.org/). By entering just a ticket number, you can obtain the offender’s license plate number, the date and location of the infraction, and a description of the offense. Due to the predictable sequence of the tickets and their immediate upload to the website, it becomes possible to enumerate all tickets and compile a list of license plates with parking violations, their physical locations, and a record of infractions. This system could potentially be misused to track vehicles.

#### Example of ticket enumeration

Here is an example of valid ticket numbers:

- 550491336
- 550491344
- 550491351
- 550491369
- 550491377
- 550491385
- 550491393
- 550491401
- 550491419
- 550491427
- 550491435
- 550491443
- 550491450
- 550491468
- 550491476
- 550491484
- 550491492
- 550491500
- 550491518
- 550491526
- 550491534
- 550491542
- 550491559
- 550491567

The last digit of these tickets is a checksum based on digit weights of 1, 2, 1, 2, 1, 2, 1, 2, 1, with an offset of 5 on the last digit. As a recent ticket number is 554682872, enumeration could start from there.

### The solution

To address this issue, the following measures could be implemented:

- Restrict the amount of information available on the public web interface.
- Require users to input their license plate number to access ticket details, thereby preventing any unauthorized enumeration.
