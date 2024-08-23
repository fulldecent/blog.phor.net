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

this_program_text=$(cat "$0")
post_text=$(cat "$1")
style_guide_text=$(cat README.md)
prompt='Your inputs from the user will be 1) the post file name 2) the post text 3) the style guide text. Your outputs will be the yq command to fix title (if necessary) and mv command to rename post (if necessary). Changes are necessary if you are correcting an error or if you have a much wittier/grabbing title.'

# Run the OpenAI command
openai api chat.completions.create --model gpt-4 \
  -g 'system' "$prompt" \
  -g 'user' "$1" \
  -g 'user' "$post_text" \
  -g 'user' "$style_guide_text" \
  --stream
#echo "$prompt"