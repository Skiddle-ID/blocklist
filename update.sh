#!/bin/bash

now=$(date +"%Y-%m-%d_%H-%M-%S")

curl --insecure -o "domains" "$DOMAIN_URL"
curl --insecure -o "ipaddress_isp" "$IP_URL"


git config user.name "Skiddle-Git"
git config user.email "160487326+Skiddle-Git@users.noreply.github.com"
git add .
git commit -m "Updated on $now"
git rebase
git push -u origin main

cd ..
echo "Script completed successfully."
