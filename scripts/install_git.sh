#!/bin/bash

# Update the package list to ensure access to the latest versions
sudo apt update

# Install Git
sudo apt install git -y

# Verify the installation by checking the installed version
git --version

# Optional: Configure Git with your user name and email
# Uncomment and replace "Your Name" and "youremail@example.com" with your information
# git config --global user.name "Your Name"
# git config --global user.email "youremail@example.com"

echo "Git installation and basic configuration complete."
