#!/bin/sh
#
# Usage: validate-posts.sh
#
# Validate all posts in _posts against the JSON schema
#
# Requirements:
#
# brew install python
# pip install check-jsonschema

set -e

SCHEMA="scripts/posts-schema.json"

# Function to validate the front matter of a file
validate_front_matter() {
  local post=$1
  tmp_file=$(mktemp)
  yq eval --front-matter=extract '.' "$post" | tail -n +2 > "$tmp_file"

  # Validate the extracted front matter
  check-jsonschema --default-filetype=yaml --schemafile "$SCHEMA" "$tmp_file" ||
  { 
    echo " ❌ Frontmatter error in $post"
    cat "$tmp_file"
    exit 1
  }

  # If the file date is before 2022-01-01, ensure that old-link is set
  # date is in the file name like YYYY-MM-DD-title.md
  date=$(echo "$post" | sed -E 's/.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/')
  if [ "$date" \< "2022-01-01" ]; then
    if ! yq eval --exit-status --front-matter=extract 'has("old-link")' "$post" >/dev/null 2>&1; then
      echo " ❌ Frontmatter error, old-link should be set for posts before 2022-01-01"
      exit 1
    fi
  fi

  rm -f "$temp_file"  # Clean up the temporary file after successful validation
}

# Find and validate Markdown files in _posts
#for post in $(find _posts _drafts -type f -name "*.md" | sort); do
for post in $(find _posts -type f -name "*.md" | sort); do
  echo "Validating $post"
  validate_front_matter "$post"
done

echo " ✅ All posts validated successfully"