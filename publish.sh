#!/bin/bash

echo "Running git add in current directory..."
git add .
echo "Enter commit message"
read COM
echo "Commiting..."
git commit -m "$COM"
echo "Git pulling to avoid issues..."
git pull
echo "Git pushing..."
git push
