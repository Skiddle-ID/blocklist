#!/bin/bash

FILE_NAME="$(date +"%Y-%m-%d")"

cd "$TARGET_DIR"
rm domains
if [ -e "$FILE_NAME" ]; then
    rm "$FILE_NAME"
fi

curl --insecure -x "http://180.250.200.178:3128" -o "$TARGET_DIR/domains" "$SOURCE_URL"

git add domains
git commit -m "Update"
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_EMAIL"
git rebase
git push -u origin main

cd ..
echo "Script completed successfully."
