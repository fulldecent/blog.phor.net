#!/bin/sh -e
#
# Usage: validate-posts.sh
#
# Validate all posts in source/_posts against the JSON schema
#
# Requirements:
#
# brew install parallel

find source/_posts source/_drafts -type f -name "*.md" | sort | parallel --max-args=1 ./scripts/validate-post.sh