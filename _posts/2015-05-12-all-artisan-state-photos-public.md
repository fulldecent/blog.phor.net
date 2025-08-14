---
title: "All Zno customer photos are publicly accessible"
tags: ["security", "data-leak"]
old-link: https://privacylog.blogspot.com/2015/05/all-artisan-state-user-uploaded-photos.html
---

- Update 2015-05-15: It appears this one specific issue has been fixed as of today.
- Update 2016-10-09: Renamed title to Zno (formerly Artisan State).

## Introduction

Artisan State is a photo printing service that specializes in flush mount books and other photo books. They are managed from San Francisco with fulfillment in Hong Kong and Houston and manufacturing in Shanghai. They have a pretty website and reputation seems somewhere between iPhone-level travel books and professionally-bound books you would get with an in-person event photographer. I was preparing a book for one of my clients and as I am uploading the photos, which are personal, the first thought was... "should I really be uploading these photos to this website, we just met?"

![Photos](/assets/images/2015-05-12-all-artisan-state-photos-public.webp)

## Just a hint

If you are reading this blog, then you are probably at least a little bit interested in web security. Here is the URL for this page. Now you tell me: what the first thing you would check?

> <https://www.artisanstate.com/photo-books/photobook-edit.html?projectGUID=413312>

Exactly, right? Following is the result of this URL:

> <https://www.artisanstate.com/photo-books/photobook-edit.html?projectGUID=413311>

![Other photos](/assets/images/2015-05-12-all-artisan-state-photos-public-2.webp)

Naturally, this couple probably did not expect that their wedding photos would be online like this. *(Note: that URL does not work any more)

## Reporting it

I always report these issues to the vendor. And it should go without saying. But "responsible disclosure" is a hot topic on Slashdot, so we'll be expanding on this. I provided the details and offered to help fix all their issues. Also, it was clear I intended to publish this—a date was set for 2 months, which is today. The customer support person said they would forward this to engineering and engineering would follow up with me.

Over the course of 2 months, I replied to note that this is almost fixed (not completely) and asked if there was any bounty or if they would credit me with this finding anywhere. Customer support offered me a $100 store credit (thank you) and would not credit me anywhere (boo). And their engineering not only never followed up with me to discuss further, as promised. Also, I speak Mandarin and they have engineering in China, there is no language barrier.

Since my emails are falling on deaf ears and because the (very generous) embargo period has passed, I am posting this live exploit publicly on the internet. Other people have probably already found these items and others. The goal of publishing this is to speed up the fix, provide a case study for other vendors as an example, and allow Artisan State users to know that their seemingly private photos are not secure. My understanding is that Artisan State did not notify customers of this issue.

Ethics, responsible disclosure, privacy... the books are still being written on what the right thing to do is. If you hate my guts or support open security research, please share below.

## The exploit

There are many attack vectors on this website. The URL scheme above is the most obvious, but not the best. In addition to these project files being susceptible, each image individually is also susceptible.

Here is the URL of one of my photos:

> <https://upload.artisanstate.com/upload/UploadServer/GetRenderImage?imageID=21470800>

If you are not logged in as me then you have no business accessing that photo. But alas... you can. There is nothing special about that URL, in fact you can access every photo this way. The following command confirms that you have access to a random photo without actually downloading it.

```sh
ID=$(php -r 'echo mt_rand(0,8000000);')
URL="https://upload.artisanstate.com/upload/UploadServer/GetRenderImage?imageID=$URL"
curl --head $URL --silent | grep Length
```

It is not hard to figure out how to edit this command to download *all* photos. Please don't. Based on how many photos are on Artisan State and the fact that they use Amazon S3, it will cost them about $80 each time you run the edited command. And anyway, the following section (written before this one) shows that this would not be of much interest any way.

The solution to this vector is to either add entropy to each URL or authenticate on each image load. Of course there is even a possible solution where the thumbnailing server above does not need to access the database, the files do not need to be renamed, htaccess or cookies are not needed, and security can still be reasonably assured. If you think you have it, discuss in the comments below.

## Analysis

The rest of this article was written before the above minimization technique was found. To demonstrate the problem exists, a random sample of photos was downloaded and then deleted. Because the results are so boring, I believe sharing some details will reduce others' interest in downloading these photos.

Artisan State has about 8,000,000 photos uploaded on this system. (That's how the `800000` got into the code above.)

Here are 64 random photos. To respect privacy, faces are blurred. The goal here isn't to dox anyone.

![Faces blurred](/assets/images/2015-05-12-all-artisan-state-photos-public-3.webp)

In general, a majority of photos are wedding-themed. And because this article is being posted to Reddit (where Artisan State is often discussed), I'll answer a few certain questions. No, that girl in the first row is not naked. No, that baby is not CP, nor does anything else seem illegal. Of a random sample of 200,000 photos a *reasonable* person would not find anything fappable.

In other words, you're not going to uncover any crazy scandal or get much from downloading these photos—they're just normal people's boring wedding, reunion and vacation photos.

Does hearing this story change your perspective of the vendor? And would you change your mind about placing an order with them?

Slashdotted at <https://it.slashdot.org/story/15/05/12/2115251/photo-printing-website-artisan-state-allows-access-to-all-user-uploaded-photos>
