# blog.phor.net

How to maintain this site and add posts.

## Add a post

Copy from `_drafts/YYYY-MM-DD-TITLE.md` to `_posts` and add the publish date and title slug, see URL SLUG heading below for notes.

This adds the required and optional front matter, with notes on how to use them.

## URL/slug, filename choice

*We need URLs that will be permanent, even with anticipated changes to the article.*

Name every post like: `_posts/2006-05-24-accepted-into-google-soc.md`.

This will publish to: https://blog.phor.net/accepted-into-google-soc.md and the RSS feed will sort it, and permalink it, based on that date.

How to choose good URLs that will be permanent?

* If a title is like "Best TVs of 2023" then be careful to choose a URL like `/best-tvs` because the list could be updated later and we want to keep the same URL.

(Maybe?) If you want to bump a page to the top of the RSS feed for a major change (like switching the title from "best TVs of 2023" to "best TVs of 2024") then change the date in the filename (not the slug). And then you would have to rename all image files related to this post (maybe?)

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

* Jekyll [does not have a good, built-in way of directly associating images to posts](https://github.com/jekyll/jekyll/issues/7681) (i.e. putting them in the `_posts` folder). Other people have thoughtful discussions and prescriptions about this problem:

  - https://www.miguoliang.com/effective-jekyll-content-management-image-assets-in-posts.html

  - https://billraymond.github.io/jekyll-featured-images/


* The Verge has a thoughtful approach to URL/slug choice. Examples: [1](https://www.theverge.com/22727963/roku-streaming-stick-4k-review), [2](https://www.theverge.com/21375098/best-streaming-device), [3](https://www.theverge.com/2023/1/4/23537503/roku-select-plus-tvs-features-price), [4](https://www.theverge.com/2023/11/15/23961754/sharp-aquos-oled-roku-tv-size-price).

## Tools

See scripts/ folder for some cool tools. Requerements for the tools are documented in those files.

* ```sh
  scripts/rename-post.sh YYYY-MM-DD-old-title.md YYYY-MM-DD-new-title.md
  ```

* Use `yq` to change title.

## How to promote a post

After publishing a post, you can promote it by:

- Tweet it
- Post it to Hacker News (https://news.ycombinator.com/)
- Post it to Reddit (https://www.reddit.com/r/programming/)
- Post it to Lobsters (https://lobste.rs/)
- My press contacts 