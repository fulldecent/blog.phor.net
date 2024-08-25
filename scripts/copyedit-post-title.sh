#!/bin/sh
#
# Usage: copyedit-post.sh <post>
#
# Checks for:
#  - Great title and file name (URL slug)
#
# Outputs:
#  - yq command to update title using post name (if necessary)
#  - mv A B command to rename post (if necessary)
#
# Prerequisites:
#  - pip install --upgrade openai

set -e

# Check for correct number of arguments
if [ "$#" -ne 1 ]; then
  echo "Usage: copyedit-post-title.sh <post>"
  exit 1
fi

this_program_text=$(cat "$0")
post_text=$(cat "$1")
style_guide_text=$(cat README.md)
prompt='Read this post and the style guide. Try to improve the title (wittier/grabbier, always use sentence case). And try to improve the URL slug (best practice for slugs). Output exactly one line of TSV (with no Markdown formatting): old name <tab> new name <tab> new title.'

# Run the OpenAI command
openai api chat.completions.create --model gpt-4o \
  -g 'system' "$prompt" \
  -g 'user' "$1" \
  -g 'user' "$post_text" \
  -g 'user' "$style_guide_text" \
  --stream
#echo "$prompt"