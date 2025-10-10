#!/bin/bash

# this script is part of AAlx repo
# you need to install dpkg-dev from my repo. also add Bingner repo and run apt-get update && apt-get upgrade please

echo "Clearing previous files..."
rm *Packages* *Release*
echo "Making Packages file..."
dpkg-scanpackages -m ./debs > Packages
echo "Zipping Packages file..."
bzip2 -k Packages
echo "Making Release file..."
apt-ftparchive -c apt-release.conf release . > Release
echo "Signing Release..."
gpg --clearsign -o InRelease Release
gpg -abs -o Release.gpg Release
