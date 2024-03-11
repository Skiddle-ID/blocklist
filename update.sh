#!/bin/bash

FILE_NAME="$(date +"%Y-%m-%d")"

cd "$TARGET_DIR"
rm domains
if [ -e "$FILE_NAME" ]; then
    rm "$FILE_NAME"
fi

curl --insecure --proxy "http://101.255.149.250:1234" -o "domains" "$SOURCE_URL"

git add domains
git commit -m "Update"
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git rebase
git push -u origin main

cd ..
echo "Script completed successfully."
