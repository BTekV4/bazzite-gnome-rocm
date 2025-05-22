#!/bin/bash
set -euo pipefail

# Add Brave repository
echo "Adding Brave repository..."
curl -fsSLo /etc/yum.repos.d/brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# Import GPG key 
echo "Importing Brave GPG key..."
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Force metadata refresh
echo "Updating repository metadata..."
rm -rf /var/cache/libdnf5/solv/* || true
echo "Brave repository has been successfully added." 