# blog.phor.net

How to add posts and maintain this site.

## How to build this website locally

### Setup local environment

_In production (GitHub Actions), environment is setup by workflows in [.github/workflows/](.github/workflows/)._

Use VS Code and the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers), install a Docker host (on Mac, use [OrbStack](https://orbstack.dev/)) then run VS Code command "Reopen in Container".

Or if you do not want VS Code or the Docker setup, install your environment manually:

1. Install Ruby and gems to match GitHub Pages versions:

   ```sh
   brew install rv # uses .ruby-version
   rv ruby install
   rv run bundle install
   ```

2. Install Node.js, yarn and packages for utilities:

   ```sh
   fnm install # uses .node-version
   fnm use
   corepack enable
   yarn install
   ```

### Build the site

Build the HTML website.

```sh
yarn build
```

### Serve/run the site

```sh
yarn dev
```

Access your site at <http://127.0.0.1:4000> (or see other "server address" in console output).

### Linting

Perform code linting (this does not require building the site):

```sh
yarn lint
```

And automatically fix with:

```sh
yarn format
```

You can also run these commands on specific files:

```sh
yarn lint source/index.html README.md
yarn format source/index.html README.md
```

**Notes:**
- Prettier caching is enabled using the `cache/` folder to speed up formatting checks. The cache is only written during `--write` operations (not `--check`), so CI environments should not expect cache benefits on lint-only operations.
- Markdown files (`.md`) are formatted by markdownlint, not Prettier (see `.prettierignore`).
- When you pass specific files, only `.md` files are processed by markdownlint; other file types are silently skipped.

### Testing

Perform website testing (you must have already [built the site](#build-the-site)):

```sh
yarn test
```

This tests structured data (JSON+LD), hyperlinks and other best practices on each page. This done using [HTML-validate](https://html-validate.org/) and [Nice Checkers](https://github.com/fulldecent/html-validate-nice-checkers).

## Notes for VS Code

Open this folder in VS Code, allow the "Reopen in Container" and install recommended extensions.

This will give you formatting, linting, and other tools to help you develop.

## Maintenance: updating dependencies

Do this every month or so and please send a PR here if you see updates available:

1. Update Node.js parts

   ```sh
   curl -s https://nodejs.org/dist/index.json | jq -r '[.[] | select(.lts != false)][0].version' > .node-version
   yarn set version latest && yarn
   yarn upgrade-interactive
   ```

2. Get updated Ruby + gems GitHub Pages uses, no PR for this, the lock file is git-ignored

   ```sh
   curl -s https://pages.github.com/versions.json | jq -r .ruby > .ruby-version
   rv ruby install
   rv run bundle install
   ```

3. Update versions in .github/workflows scripts to latest GitHub supported Action versions.

4. Update .devcontainer/devcontainer.json to use the latest Microsoft supported runners and matching versions per above.

## Add a post

1. Copy from `source/_drafts/YYYY-MM-DD-TITLE.md` to `source/_posts`
2. Add the publish date
3. Add the URL slug, following [instructions for URL slugs](#url-slugs)

This adds the required and optional front matter, with notes on how to use them.

## URL slugs

*We need URLs that will be permanent, even with anticipated changes to the article.*

Name every post like: `source/_posts/2006-05-24-accepted-into-google-soc.md`.

This will publish to: <https://blog.phor.net/accepted-into-google-soc.md> and the RSS feed will sort it, and permalink it, based on that date.

How to choose good URLs that will be permanent?

- If a title is like "Best TVs of 2023" then be careful to choose a URL like `/best-tvs` because the list could be updated later and we want to keep the same URL.

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

1. Make a featured image with the same post slug as the post filename (without the `YYYY-MM-DD-` prefix) and put it in `source/assets/images`. Include it like:

   ```markdown
   ![Fair random immediate decentralized](/assets/images/randomization-strategies-for-nft-drops.webp)
   ```

2. For other images, name sequentiall, with suffixes or a folder:

   ```markdown
   ![Fair random immediate decentralized](/assets/images/randomization-strategies-for-nft-drops-2.svg)
   ![Fair random immediate decentralized](/assets/images/randomization-strategies-for-nft-drops-some-feature.svg)
   ![Fair random immediate decentralized](/assets/images/randomization-strategies-for-nft-drops/some-feature.svg)
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

- Use uppercase letters just at the start of sentences, and for proper nouns and initialisms.

Formatting a chat conversation (Full Decent is always the red one):

- Preserve typos

- Format color like this

  ```md
  > <span style="color:blue">Steven Shim:</span> ok the riddle ... it's not possible, because 8x + 6y = 5 does not have a solution where you can use integers, so there is no way to get 3 or 1 gallons from the mix.... otherwise you'd be able to get 5 gallons. is this right?<br />
  > <span style="color:red">Full Decent:</span> xml asap!!!<br />
  > <span style="color:blue">Steven Shim:</span> because the lowest common denominator is 1
  ```

Prose:

- Do not use Oxford comma.
- Citing US court cases: Bluebook style, e.g. United States v. Google, No. 20-cv-3010 (APM) (D.D.C. Aug. 5, 2024).

## Discussion of best practices

- Jekyll [does not have a good, built-in way of directly associating images to posts](https://github.com/jekyll/jekyll/issues/7681) (i.e. putting them in the `_posts` folder). Other people have thoughtful discussions and prescriptions about this problem:

  - <https://www.miguoliang.com/effective-jekyll-content-management-image-assets-in-posts.html>

  - <https://billraymond.github.io/jekyll-featured-images/>

- The Verge has a thoughtful approach to URL/slug choice. Examples: [1](https://www.theverge.com/22727963/roku-streaming-stick-4k-review), [2](https://www.theverge.com/21375098/best-streaming-device), [3](https://www.theverge.com/2023/1/4/23537503/roku-select-plus-tvs-features-price), [4](https://www.theverge.com/2023/11/15/23961754/sharp-aquos-oled-roku-tv-size-price).

## Tools

See scripts/ folder for some cool tools. Requerements for the tools are documented in those files.

- ```sh
  scripts/rename-post.sh YYYY-MM-DD-old-title.md YYYY-MM-DD-new-title.md
  ```

- Use `yq` to change title.

## Tags

Tags should use slug formatting, don't mash words.

Here is how to batch edit a tag:

```sh
find source/_posts -type f -name "*.md" -exec yq e -i -I 2 --front-matter=process '.tags |= map(select(. == "mylife") = "my-life")' {} \;
```

## How to promote a post

After publishing a post, you can promote it by:

- Tweet it
- Post it to Hacker News (<https://news.ycombinator.com/>)
- Post it to Reddit (<https://www.reddit.com/r/programming/>)
- Post it to Lobsters (<https://lobste.rs/>)
- My press contacts

## References

1. This website is built based on [best practices documented in github-pages-template](https://github.com/fulldecent/github-pages-template).
2. Setting up Docker
   1. We would prefer an open-source-licensed Docker implementation that runs at native speed on Mac, Linux and Windows. For Mac, you may prefer to [install Colima](https://github.com/abiosoft/colima?tab=readme-ov-file#installation) which is open source but about 5x slower than the OrbStack recommended above.
3. We use the github-pages gem instead of Jekyll because GitHub Pages [uses those specific versions](https://pages.github.com/versions/) instead of what is in your Gemfile.lock. This is also why we add Gemfile.lock to .gitignore.
