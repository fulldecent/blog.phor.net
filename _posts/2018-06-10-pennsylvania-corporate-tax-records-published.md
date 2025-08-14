---
title: "Pennsylvania corporate tax records were available to public"
tags: ["investigations", "civics"]
old-link: https://privacylog.blogspot.com/2018/06/pennsylvania-corporate-tax-records-were.html
---

I work for a company where we recently applied for a grant through the Pennsylvania Department of Community and Economic Development. At some point in the application process you need to upload tax records and other documents. However, I learned that anybody could download all the records. DCED administers [over 100 different funding programs](<https://dced.pa.gov/program/> and so many tax records for businesses (mostly small businesses) in Pennsylvania were affected.

**Here are the main topics of this story: how do you responsibly disclose a vulnerability to government if you, or somebody you know, may have broken federal laws to find it? How do you ensure that it gets fixed? And how do you get credit?**

## The exploit

First, let's show off the actual exploit. DCED includes a centralized application process for programs and grants that all applicants must follow. Here is the vulnerable step in the application process:

![Registration](/assets/images/2018-06-10-pennsylvania-corporate-tax-records-published.webp)

So here is the key part zoomed in:

![Registration zoomed](/assets/images/2018-06-10-pennsylvania-corporate-tax-records-published-2.webp

And if you click it you can verify the file you uploaded. Here's the URL for the tax records I just uploaded:

> <https://www.esa.dced.state.pa.us/AddendaStream.aspx?SurveyUploadUid=104097>

So I read out the URL to my coworker sitting next to me, or maybe I typed it in on another computer, honestly I forget. **And don't you know, somebody else's application or tax records or something came up.** What?

Well it turns out the typed in URL had an 8 at the end. I immediately recognized what happened, closed the browser, did not save the file, and understood the implications:

- The files are numerically sequenced
- The files are accessible by anybody
- You do not have to be logged in to access the files

And the consequences of these three tenets are:

- Anybody could download all the tax records from the system by loading starting at `SurveyUploadUid=1` and keep going up until they got 'em all.

*My goal here isn't to get all the tax records. But my job is to break things, so I recognize the exploit and the logical consequences when I see something. I don't need to download all the tax records to understand that all the tax records are downloadable. Also I have no interest in enumerating how many there are.*

Anyway, now I understand that my duty is to inform the responsible party and see to it that they accept responsibility for fixing the issue.

## Breaking the law

Here are some laws that I, or my coworker, may have broken in the above story:

- [18 U.S.C. § 1030](https://uscode.house.gov/view.xhtml?req=granuleid:USC-prelim-title18-section1030&amp;num=0&amp;edition=prelim), commonly known as the "[Computer Fraud and Abuse Act](<https://www.congress.gov/bill/99th-congress/house-bill/4718?q=%7B%22search%22%3A%5B%22%5C%22Computer+Fraud+and+Abuse+Act%5C%22%22%5D%7D&amp;r=3>", this includes a very broad definition:

    > Whoever ... intentionally accesses a computer without authorization or exceeds authorized access, and thereby obtains ... information from any protected computer (which is used in or affecting interstate or foreign commerce or communication...) ... shall be punished as provided in subsection (c) of this section.

- I'm sure Pennsylvania has a similar law but I can't find a good way to search their law. (Let me know if you have a good citation for here.)

I'm not concerned about this. Because the people that interpret the laws, a jury of my peers, will find no fault in what I did with this information, that's the next section.... And also, literally, I did not intentionally access.

## Disclosing the exploit

Here is how I got the information to the responsible party:

- 2017-09-14: Emailed <ra-dcedcs@pa.gov> with "Hello, I have found a serious security issue with your website <https://www.esa.dced.state.pa.us> that is making information public that should not be. Could you please advise me who I may properly disclose my finding to?"
- 2017-09-14: Received an immediate reply from Sarah, Customer Service Representative, PA Department of Community &amp; Economic Development. We engaged and she directed me to the next contact.
- *There were some phone calls in between here, sorry I don't have access to my phone records right now.*
- 2017-10-12: Sent complete details of vulnerability to Brian, Application Developer Administrator, PA Office of Administration
- 2017-10-12: Brian replies "Thank you for the information."

## Getting them to fix it

Now is the delicate part of the process in security disclosure. You want them to accept responsibility for fixing the problem—and it will be nice if they will pay you or provide credit. On the other hand, they might want to avoid public disclosure and might even want to avoid having to fix the problem.

I've made mistakes before, [don't sign an NDA when you send a zero-day to a bank](https://privacylog.blogspot.com/2017/04/what-happens-when-you-send-zero-day-to.html).

Also, don't demand money in exchange for not disclosing what you found. I don't know what the law says about this but I don't need to know because I don't do that.

What's a good policy? Normally I just say: "Here's the information. I will publish it in X days, you should fix it before then. Pay me or credit me if you like."

But government moves slower, I understand. Also, I am not exactly sure if certain laws will apply to such a disclosure. Anyway, I played extra careful here, considering the sensitive data at risk. Side story: I also have an exploit against an agency under the US Department of Defense... disclosed it only to cognizant authorities and patiently waiting for them to fix it... following up over two years. This is a painful slowness. But it involves classified information so I'm not taking any risk.

People stop answering the phone when they owe you something:

- 2017-11-??: Called Brian, no reply
- 2017-12-15: Emailed Brian, I see the issue is resolved, I'm preparing to publish, would you help?
- 2017-12-21: Emailed Brian, hello, are you still around?
- 2018-01-04: Emailed Brian, are my contributions welcome?
- 2018-03-19: Emailed Brian and his boss, provided a summary of the events, requesting public credit
- 2018-03-26: Emailed Brian and his boss, please provide receipt of letter
- 2018-04-02: Emailed Brian, boss, boss's boss, boss's boss's boss, recounted story, implore them to handle this situation ethically (and more notes below)

You can see that I found the issue was resolved by December. Maybe I could have published then. You need to understand that just because I think it is fixed does not mean it is fixed. Maybe upon receipt they have realized that another system was affected—it might be reckless for me to publish if a hacker could find that information and learn how to exploit the other system that I did not know about. So it really helps me to know this item is fixed FROM THEM. This is another delicate item that rests on your judgement.

A polite way to entice cooperation is to remind them that you may have more things to disclose. The first time you disclose to them maybe you are nuisance. But if you remind them there could be more then hopefully they will realize the risks of not cooperating with you and the value of your contribution.

Anyway, after months of unreturned emails, I filed a PA Right To Know request. This gave me access to Brian's email inbox and let me see who my email was forwarded to, and who was aware of what when. Actually, there were multiple RTKs and some back-and-forth there too. Thank you to the RTK administrators, always super helpful.

![RTKL 1](/assets/images/2018-06-10-pennsylvania-corporate-tax-records-published-3.webp)

![RTKL 2](/assets/images/2018-06-10-pennsylvania-corporate-tax-records-published-4.webp)

I made reference to these Right To Know requests in the final email above. Then I got a phone call from John MacMillan, Deputy Secretary, PA Office of Administration.

## A resolution

John called me on April 3, 2018 plus or minus a day. He volunteered lots of good information I was waiting to hear:

- He had received, and thanked me for, the assistance
- DCED had worked quickly and resolved the issue (not sure of the exact date)
- The Office of Administration had reviewed and found only one instance of an unauthorized access of information (me and/or my coworker)
- The unauthorized access happened to be a public record anyway

I asked if PA would consider to publish details of this incident so that affected parties could be notified and so that the public could be informed of how the Commonwealth handled the response. John explained that The Office of Administration reviewed regulation on public disclosure and found that disclosure was not necessary because no specific instances of data loss had been identified.

John understands that I publish stories like this and hope to inform the public on my blog. And he was kind enough to offer a letter which I recently received.

![John letter](/assets/images/2018-06-10-pennsylvania-corporate-tax-records-published-5.webp)

## Conclusion<

Thank you to the Commonwealth staff for taking care of this issue and resolving it quickly.

The Commonwealth might consider to have a standard response in future situations like the above. Publishing the policy might incentivize more welcome contributions. Somebody reading my story now and wanting to submit and see a problem fixed might not feel encouraged.

To policymakers and leaders of public administrations, please consider... it is impossible to confirm you were *not* compromised. Adopt a policy of publicly disclosing any hack, potential hack, threat of a hack, thought of a hack. This reduces the risk that you will be responsible for failing to disclose something that later becomes material.

You, dear reader, might be in situation where you find something like this too. It always starts with a simple aha! moment like you saw here. The discovery only takes one second, and here the disclosure was fast too. But the process to ensure it was resolved took considerable time and determination. Think through who you are working with and and how you can work together for the goal.
