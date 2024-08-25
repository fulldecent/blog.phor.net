#!/bin/sh -e
#
# Usage: copyedit-post.sh <post>
#
# Checks for:
#  - Spelling and grammar
#  - Adherence to all notes in README.md
#
# Outputs:
#  - Notes and suggestions (very brief, only where necessary)
#  - Non-interactive yq command to update title using post name (if necessary)
#  - Non-interactive patch commands to update post (if necessary)
#
# Prerequisites:
#  - pip install --upgrade openai

if [ $# -ne 1 ]; then
  echo "Usage: $0 <post>"
  exit 1
fi

this_program_text=$(cat "$0")
post_text=$(cat "$1")
style_guide_text=$(cat README.md)

prompt=$(cat <<EOF
Here is the program:
~~~
$this_program_text
~~~

Here is the post:
~~~
$post_text
~~~

Here is the style guide:
~~~
$style_guide_text
~~~

Produce the program outputs as described above.
EOF
)

# Run the OpenAI command
openai api chat.completions.create --model gpt-4o -g "user" "$prompt" --stream
#echo "$prompt"