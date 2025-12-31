# Copilot instructions for blog.phor.net

## Rendering Mermaid diagrams as article images

When a post does not have an associated hero image but contains a Mermaid diagram, you can render the diagram as an SVG to use as the article's hero/social sharing image.

Hero images are matched by filename convention: a static file in `/assets/images/` with the same basename as the post (without extension) will be used as the hero image. For example, a post at `_posts/2025-12-20-one-core-finance-function.md` will use an image at `assets/images/2025-12-20-one-core-finance-function.svg`.

### Process

1. Extract the first (or most representative) Mermaid diagram from the post
2. Save it to a temporary file:
   ```bash
   cat > /tmp/diagram.mmd << 'EOF'
   # paste mermaid code here
   EOF
   ```
3. Render to SVG using Mermaid CLI, naming it to match the post basename:
   ```bash
   mmdc -i /tmp/diagram.mmd -o /path/to/blog/assets/images/YYYY-MM-DD-post-slug.svg -b transparent
   ```

### Finding posts that need images

Use this shell script to find posts that have embedded images or Mermaid diagrams but no hero image:

```bash
cd /path/to/blog

# First, build a list of posts that already have hero images
(ls assets/images/*.webp 2>/dev/null; ls assets/images/*.svg 2>/dev/null) | \
  xargs -I {} basename {} | sed 's/\.[^.]*$//' | sort -u > /tmp/hero_basenames.txt

# Then find posts with content but no hero
for f in _posts/*.md; do
  bn=$(basename "$f" .md)
  if ! grep -q "^${bn}$" /tmp/hero_basenames.txt; then
    img=$(grep -c '\!\[' "$f" 2>/dev/null || echo 0)
    mmd=$(grep -c 'mermaid' "$f" 2>/dev/null || echo 0)
    if [ "$img" -gt 0 ] || [ "$mmd" -gt 0 ]; then
      echo "$bn | img:$img | mmd:$mmd"
    fi
  fi
done
```

### Priority for hero images

1. **Existing embedded image** - If the post already has an image referenced inside, prefer copying/converting that image to be the hero (rename to match post basename)
2. **Mermaid diagram** - If no embedded images exist but there's a Mermaid diagram, render it as SVG

### Prerequisites

Install Mermaid CLI if not already available:
```bash
npm install -g @mermaid-js/mermaid-cli
```

### Notes

- Use `-b transparent` for a transparent background
- The image filename must match the post's date-slug exactly (e.g., `2025-12-20-one-core-finance-function.svg`)
- Images go in `assets/images/`, not `assets/`
- No frontmatter `image:` is needed - the match is automatic by filename

## Auditing post-to-image naming consistency

When posts are renamed, their associated images may not be updated, breaking the hero image matching. Use this script to audit all posts and their referenced images:

```bash
cd /path/to/blog
for f in _posts/*.md; do
  bn=$(basename "$f" .md)
  imgs=$(grep -oE '/assets/images/[^)]+' "$f" 2>/dev/null)
  if [ -n "$imgs" ]; then
    echo "$imgs" | while read img; do
      echo "$bn | $img"
    done
  fi
done
```

### How to analyze the output

Each line shows `POST_BASENAME | IMAGE_PATH`. Look for these issues:

1. **Slug mismatch**: The image basename should start with the post basename. For example:
   - ✅ `2009-01-12-how-to-implement-paperless | /assets/images/2009-01-12-how-to-implement-paperless.webp`
   - ❌ `2009-01-12-how-to-implement-paperless | /assets/images/2009-01-12-how-to-successfully-implement-paperless.webp`
   
   The second case indicates the post was renamed from "how-to-successfully-implement-paperless" to "how-to-implement-paperless" but the images weren't updated.

2. **Multiple images with suffixes**: Posts with multiple images should use `-2`, `-3`, etc. suffixes:
   - ✅ `2008-01-27-im-no-poet | /assets/images/2008-01-27-im-no-poet-2.webp`
   - ✅ `2008-01-27-im-no-poet | /assets/images/2008-01-27-im-no-poet-3.webp`

3. **Descriptive suffixes**: Some posts have images with meaningful suffixes (like dates or descriptions). These are acceptable if the base matches:
   - ✅ `2006-11-28-just-like-baby-seal | /assets/images/2006-11-28-just-like-baby-seal-before.webp`

### Fixing mismatches

When you find a mismatch, you need to:
1. Rename the image file(s) to match the current post basename
2. Update the image references in the post markdown file

For example, if `2013-08-05-hotpot-only.md` references `/assets/images/2013-08-05-stay-focused.webp`:
1. `mv assets/images/2013-08-05-stay-focused.webp assets/images/2013-08-05-hotpot-only.webp`
2. Update the post: `sed -i '' 's/2013-08-05-stay-focused/2013-08-05-hotpot-only/g' _posts/2013-08-05-hotpot-only.md`
