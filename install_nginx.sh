#!/bin/bash

# Update your local package index first
sudo apt update

# Install Nginx
sudo apt install nginx -y

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Start Nginx service
sudo systemctl start nginx

# Optional: Check the status of the Nginx service
sudo systemctl status nginx
