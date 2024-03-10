#!/bin/bash

TARGET_DIR=~/Documents/blocklist
FILE_NAME="$(date +"%Y-%m-%d")"

cd "$TARGET_DIR"
rm domains
if [ -e "$FILE_NAME" ]; then
    rm "$FILE_NAME"
fi

curl --insecure --proxy "http://103.80.237.211:3888" -o "$TARGET_DIR/domains" "$SOURCE_URL"

git add domains
git commit -m "Update"
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git rebase
git push -u origin main

cd ..
echo "Script completed successfully."
