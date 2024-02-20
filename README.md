# blog.phor.net

How to maintain this site and add posts.

## URL/slug choice

We take inspiration from The Verge for this policy. Examples: [1](https://www.theverge.com/22727963/roku-streaming-stick-4k-review), [2](https://www.theverge.com/21375098/best-streaming-device), [3](https://www.theverge.com/2023/1/4/23537503/roku-select-plus-tvs-features-price), [4](https://www.theverge.com/2023/11/15/23961754/sharp-aquos-oled-roku-tv-size-price). We need URLs that will be permanent, even with anticipated changes to the article.

* Reporting an external event, and nobody should be interested in it after next week: `/2023/10/16/IRS-proposed-regulation-for-crypto` because this is about a specific regulation announcement. A further announcement will be a new article.
* If there is some chance people will be interested in this later. And we may update the title/content to reflect that. Use a `page`. URL is like: `/how-to-connect-roku-to-xfinity-wifi`.

If a title is like "Best TVs of 2023", the be careful to choose a URL like `/best-tvs` because the list could be updated later and we want to keep the same URL.

For pages, update the `date` when major changes are made to bump it to top of homepage and RSS feed.

Keep everything in `_posts` and set a permalink to make a page, if needed.

## Comments

Every blog post can link to an official X thread (or a comment thread hosted anywhere) as well as notable comments and media coverage across the web.

When publishing a post, add comments in the front matter like this:

```yaml
comments:
  - link: https://twitter.com/fulldecent/status/1486181100904980482
    name: '@fulldecent'
    text: The official X thread
  - link: https://fulldecent.blogspot.com/2004/06/are-you-badass-with-c-then-fix-this.html?showComment=1087170900000#c108717092705622985
    name: Tyler
    date: 
    text: "You were very close to getting the solution"
```

Ideally, you want to link an X post and other good media coverage to each blog post.

## Asides

Article text usually displays in the left two-thirds of the page.

Use the right third for some side notes like this:

```markdown
{: .margin-note}
Some margin note paragraph text
```

This syntax is explained at https://kramdown.gettalong.org/quickref.html

## Article images

If a raster image is used just for editorial (detail not needed), scale down to 800 px.

1. Make a featured image with the same basename as the post and put it in `/assets/images`. Include it like:

   ```markdown
   ![Fair random immediate decentralized](/assets/images/2022-02-04-Randomization strategies for NFT drops.svg)
   ```

2. For other images, put in folder like `/assets/images/2021-12-03-a-post/xxxyyy.png` and link like this:

   ```markdown
   ![Fair random immediate decentralized](/assets/images/2022-02-04-Randomization strategies for NFT drops/Fair random immediate decentralized.svg)
   ```

## Style guide

* The blog's name is in title case. Everything else, including post titles, is sentence case.

## Discussion of best practices

Jekyll [does not have a good, built-in way of directly associating images to posts](https://github.com/jekyll/jekyll/issues/7681) (i.e. putting them in the `_posts` folder). Other people have thoughtful discussions and prescriptions about this problem:

- https://www.miguoliang.com/effective-jekyll-content-management-image-assets-in-posts.html
- https://billraymond.github.io/jekyll-featured-images/

## Tool

```
@@@ GOOD FORMAT EXAMPLE @@@

> <span style="color:blue">Steven Shim:</span> ok the riddle ... it's not possible, because 8x + 6y = 5 does not have a solution where you can use integers, so there is no way to get 3 or 1 gallons from the mix.... otherwise you'd be able to get 5 gallons. is this right?<br />
> <span style="color:red">Full Decent: xml asap!!!</span><br />
> <span style="color:blue">Steven Shim:</span> because the lowest common denominator is 1

@@@ TEXT TO REFORMAT @@@

@@@ REFORMATTED TEXT @@@
```