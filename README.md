# blog.phor.net

How to add posts and maintain this site.

## Add a post

1. Copy from `_drafts/YYYY-MM-DD-TITLE.md` to `_posts`
2. Add the publish date
3. Add the URL slug, following [instructions for URL slugs](#url-slugs)

This adds the required and optional front matter, with notes on how to use them.

## URL slugs

*We need URLs that will be permanent, even with anticipated changes to the article.*

Name every post like: `_posts/2006-05-24-accepted-into-google-soc.md`.

This will publish to: <https://blog.phor.net/accepted-into-google-soc.md> and the RSS feed will sort it, and permalink it, based on that date.

How to choose good URLs that will be permanent?

* If a title is like "Best TVs of 2023" then be careful to choose a URL like `/best-tvs` because the list could be updated later and we want to keep the same URL.

(Maybe?) If you want to bump a page to the top of the RSS feed for a major change (like switching the title from "best TVs of 2023" to "best TVs of 2024") then change the date in the filename (not the slug). And then you would have to rename all image files related to this post (maybe rename not needed? See below)

## Asides

Article text usually displays in the left two-thirds of the page.

Use the right third for some side notes like this:

```markdown
{: .margin-note}
Some margin note paragraph text
```

This syntax is explained at <https://kramdown.gettalong.org/quickref.html>

## Article images

For raster images hard limit is 1600 px max size for high detail. For editorial, use max 800 px.

1. Make a featured image with the same basename as the post and put it in `/assets/images`. Include it like:

   ```markdown
   ![Fair random immediate decentralized](/assets/images/2022-02-04-randomization-strategies-for-nft-drops.svg)
   ```

2. For other images, name sequentiall, with suffixes or a folder:

   ```markdown
   ![Fair random immediate decentralized](/assets/images/2022-02-04-randomization-strategies-for-nft-drops-2.svg)
   ![Fair random immediate decentralized](/assets/images/2022-02-04-randomization-strategies-for-nft-drops-some-feature.svg)
   ![Fair random immediate decentralized](/assets/images/2022-02-04-randomization-strategies-for-nft-drops/some-feature.svg)
   ```

Here is how to convert one image to webp format, with a maximum width of 800 pixels:

```sh
convert_to_webp() {
    local input_file="$1"
    local max_width=1600
    local output_file="${input_file%.*}.webp"

    if ! [ -f "$input_file" ]; then
        echo "Error: File '$input_file' not found."
        return 1
    fi

    local width
    width=$(identify -format "%w" "$input_file") || {
        echo "Error: Failed to get image width for '$input_file'"
        return 1
    }

    if [ "$width" -gt "$max_width" ]; then
        cwebp -q 80 -m 6 -mt -v -resize "$max_width" 0 -o "$output_file" "$input_file"
    else
        cwebp -q 80 -m 6 -mt -v -o "$output_file" "$input_file"
    fi

    echo "✅ Converted: $input_file → $output_file"
}

# Example usage
convert_to_webp "input.png"
  ```

## Style guide

Word case:

* Post titles use sentence case. Headings use sentence case. Prose uses sentence case. DO NOT USE TITLE CASE.

Formatting a chat conversation (Full Decent is always the red one):

* Preserve typos

* Format color like this

  ```md
  > <span style="color:blue">Steven Shim:</span> ok the riddle ... it's not possible, because 8x + 6y = 5 does not have a solution where you can use integers, so there is no way to get 3 or 1 gallons from the mix.... otherwise you'd be able to get 5 gallons. is this right?<br />
  > <span style="color:red">Full Decent:</span> xml asap!!!<br />
  > <span style="color:blue">Steven Shim:</span> because the lowest common denominator is 1
  ```

Prose:

* Do not use Oxford comma.
* Citing US court cases: Bluebook style, e.g. United States v. Google, No. 20-cv-3010 (APM) (D.D.C. Aug. 5, 2024).

## Discussion of best practices

* Jekyll [does not have a good, built-in way of directly associating images to posts](https://github.com/jekyll/jekyll/issues/7681) (i.e. putting them in the `_posts` folder). Other people have thoughtful discussions and prescriptions about this problem:

  * <https://www.miguoliang.com/effective-jekyll-content-management-image-assets-in-posts.html>

  * <https://billraymond.github.io/jekyll-featured-images/>

* The Verge has a thoughtful approach to URL/slug choice. Examples: [1](https://www.theverge.com/22727963/roku-streaming-stick-4k-review), [2](https://www.theverge.com/21375098/best-streaming-device), [3](https://www.theverge.com/2023/1/4/23537503/roku-select-plus-tvs-features-price), [4](https://www.theverge.com/2023/11/15/23961754/sharp-aquos-oled-roku-tv-size-price).

## Tools

See scripts/ folder for some cool tools. Requerements for the tools are documented in those files.

* ```sh
  scripts/rename-post.sh YYYY-MM-DD-old-title.md YYYY-MM-DD-new-title.md
  ```

* Use `yq` to change title.

## How to promote a post

After publishing a post, you can promote it by:

* Tweet it
* Post it to Hacker News (<https://news.ycombinator.com/>)
* Post it to Reddit (<https://www.reddit.com/r/programming/>)
* Post it to Lobsters (<https://lobste.rs/>)
* My press contacts
