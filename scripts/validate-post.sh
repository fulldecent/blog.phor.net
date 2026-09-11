#!/bin/sh -e
#
# Usage: validate-posts.sh
#
# Validate a post in source/_posts against the JSON schema
#
# Requirements:
#
# brew install python
# pip install check-jsonschema

SCHEMA="scripts/posts-schema.json"

post="$1"
echo "Validating $post"

# Create a temporary file safely
tmp_file=$(mktemp) || { echo "💣 Failed to create temporary file"; exit 1; }

# Extract and validate the front matter
if ! yq eval --front-matter=extract '.' "$post" | tail -n +2 > "$tmp_file"; then
  echo "❌ Failed to extract front matter from $post"
  rm -f "$tmp_file"
  exit 1
fi

if ! check-jsonschema --default-filetype=yaml --schemafile "$SCHEMA" "$tmp_file"; then
  echo "❌ Frontmatter error in $post"
  rm -f "$tmp_file"
  exit 1
fi

rm -f "$tmp_file"  # Clean up the temporary file