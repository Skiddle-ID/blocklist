#!/bin/bash

# Set the current timestamp
now=$(date +"%Y-%m-%d_%H-%M-%S")

# Step 1: Initialize Git LFS if not done already
echo "Setting up Git LFS..."
git lfs install

# Step 2: Download the files from URLs, with error handling
echo "Downloading files from the provided URLs..."
curl --insecure -m 300 -o "domains" "$DOMAIN_URL" && echo "Downloaded domains file successfully." || { echo "Failed to download domains file."; exit 1; }
curl --insecure -m 300 -o "ipaddress_isp" "$IP_URL" && echo "Downloaded IP address file successfully." || { echo "Failed to download IP address file."; exit 1; }
curl --insecure -m 300 -o "situs_judi.txt" "$SITUS_JUDI" && echo "Downloaded situs_judi file successfully." || { echo "Failed to download situs_judi file."; exit 1; }

# Step 3: Check if the files exceed the 100 MB limit, if so, track them with LFS
echo "Checking file sizes..."
if [[ $(stat -c%s "domains") -gt 100000000 ]]; then
    echo "File 'domains' exceeds 100 MB. Adding to Git LFS."
    git lfs track "domains"
fi

if [[ $(stat -c%s "ipaddress_isp") -gt 100000000 ]]; then
    echo "File 'ipaddress_isp' exceeds 100 MB. Adding to Git LFS."
    git lfs track "ipaddress_isp"
fi

if [[ $(stat -c%s "situs_judi.txt") -gt 100000000 ]]; then
    echo "File 'situs_judi.txt' exceeds 100 MB. Adding to Git LFS."
    git lfs track "situs_judi.txt"
fi

# Step 4: Ensure .gitattributes is committed if any files are tracked by LFS
git add .gitattributes

# Step 5: Configure git user information for automated commits
git config user.name "skiddle-bot"
git config user.email "165562787+skiddle-bot@users.noreply.github.com"

# Step 6: Pull the latest changes to avoid conflicts
echo "Pulling the latest changes from the remote repository..."
git pull origin main

# Step 7: Add and commit the downloaded files
echo "Staging and committing changes..."
git add .
git commit -m "Automated update: Updated on $now"

# Step 8: Push the changes to the main branch, including LFS-tracked files
echo "Pushing changes to the main branch..."
git push origin main

# Step 9: Clean up and finalize
echo "Script completed successfully."
