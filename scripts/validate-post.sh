#!/bin/sh -e
#
# Usage: validate-posts.sh
#
# Validate all posts in _posts against the JSON schema
#
# Requirements:
#
# brew install python
# pip install check-jsonschema

SCHEMA="scripts/posts-schema.json"

post="$1"
echo "Validating $post"

# Create a temporary file safely
tmp_file=$(mktemp) || { echo " ❌ Failed to create temporary file"; exit 1; }

# Extract and validate the front matter
if ! yq eval --front-matter=extract '.' "$post" | tail -n +2 > "$tmp_file"; then
  echo " ❌ Failed to extract front matter from $post"
  rm -f "$tmp_file"
  exit 1
fi

if ! check-jsonschema --default-filetype=yaml --schemafile "$SCHEMA" "$tmp_file"; then
  echo " ❌ Frontmatter error in $post"
  rm -f "$tmp_file"
  exit 1
fi

# Extract date from the filename and validate old-link for posts before 2022-01-01
post_date=$(echo "$post" | sed -E 's/.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')
if [[ "$post_date" < "2022-01-01" ]]; then
  if ! yq eval --exit-status --front-matter=extract 'has("old-link")' "$post" >/dev/null 2>&1; then
    echo " ❌ Frontmatter error, old-link should be set for posts before 2022-01-01"
    rm -f "$tmp_file"
    exit 1
  fi
fi

rm -f "$tmp_file"  # Clean up the temporary file