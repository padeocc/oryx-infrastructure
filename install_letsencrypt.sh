#!/bin/bash

# Define your domain name
DOMAIN="cms.padeo.fr"
EMAIL="contact@padeo.fr" # Email used for registration and recovery contact.

# Update the package list
sudo apt update

# Install software-properties-common if not already installed
sudo apt install software-properties-common -y

# Add the Certbot repository
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot -y

# Update the package list again after adding new repositories
sudo apt update

# Install Certbot's Nginx package
sudo apt install certbot python3-certbot-nginx -y

# Obtain the SSL Certificate and Configure Nginx Automatically
sudo certbot --nginx -d $DOMAIN -d www.$DOMAIN --non-interactive --agree-tos --email $EMAIL --redirect

# Set up automatic renewal
echo "Setting up automatic renewal..."
sudo systemctl enable certbot-renew.timer
sudo systemctl start certbot-renew.timer

echo "SSL Certificate installation and setup complete."
