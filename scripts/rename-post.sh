#!/bin/sh -e

# Usage: rename-post.sh <old-base-name> <new-base-name>
#
# Rename a post in _posts and associated images/references.
#
# 1. Rename post in _posts
# 2. Rename images (if any) in assets/images
# 3. Fix references in post to those images (if any)
# 4. (TODO) find and fix references to the post in other posts and in the redirects collection

# Check if the number of arguments is correct
if [ "$#" -ne 2 ]; then
  echo "Usage: rename-post.sh <old-base-name> <new-base-name>"
  exit 1
fi

# Get names
old_base_name="$1"
new_base_name="$2"
old_post="_posts/${old_base_name}.md"
new_post="_posts/${new_base_name}.md"

# Check if the old post exists
if [ ! -f "$old_post" ]; then
  echo "Post ${old_post} does not exist"
  exit 1
fi

# Check if the new post already exists
if [ -f "$new_post" ]; then
  echo "Post ${new_post} already exists"
  exit 1
fi

# Rename the post
mv "$old_post" "$new_post"

# Rename images
for old_image in assets/images/"${old_base_name}"*; do
  new_image=$(echo "$old_image" | sed "s/${old_base_name}/${new_base_name}/")
  mv "$old_image" "$new_image"
done

# Replace references in the post
sed -i '' "s/${old_base_name}/${new_base_name}/g" "$new_post"