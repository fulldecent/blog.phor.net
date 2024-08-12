#!/bin/sh -e
#
# Usage: validate-posts.sh
#
# Validate all posts in _posts against the JSON schema
#
# Requirements:
#
# brew install parallel

find _posts _drafts -type f -name "*.md" | sort | parallel --max-args=1 ./scripts/validate-post.sh