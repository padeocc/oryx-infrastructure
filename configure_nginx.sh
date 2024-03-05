#!/bin/bash

# Define variables
DOMAIN="cms.padeo.fr"
NGINX_SITES_AVAILABLE="/etc/nginx/sites-available"
NGINX_SITES_ENABLED="/etc/nginx/sites-enabled"
WEB_ROOT="/var/www/$DOMAIN/html"
SSL_CERT="/etc/ssl/certs/$DOMAIN.pem" # Adjust for your SSL certificate path
SSL_CERT_KEY="/etc/ssl/private/$DOMAIN.key" # Adjust for your SSL key path
PROXY_PASS="http://127.0.0.1:1337" # Adjust the port as needed

# Ensure the NGINX_SITES_AVAILABLE directory exists
if [ ! -d "$NGINX_SITES_AVAILABLE" ]; then
    echo "The directory $NGINX_SITES_AVAILABLE does not exist. Creating it now."
    mkdir -p $NGINX_SITES_AVAILABLE
fi

# Create or overwrite the Nginx server block file
cat > $NGINX_SITES_AVAILABLE/$DOMAIN <<EOF
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    location / {
        proxy_pass $PROXY_PASS;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }

    root $WEB_ROOT;
    index index.html index.htm;

}

server {
    listen 443 ssl;
    server_name $DOMAIN www.$DOMAIN;

    ssl_certificate $SSL_CERT;
    ssl_certificate_key $SSL_CERT_KEY;

    location / {
        proxy_pass $PROXY_PASS;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }

    root $WEB_ROOT;
    index index.html index.htm;
}
EOF

# Enable the site by creating a symbolic link
ln -sf $NGINX_SITES_AVAILABLE/$DOMAIN $NGINX_SITES_ENABLED/

# Remove default site, if you don't need it
rm -f $NGINX_SITES_ENABLED/default

# Test Nginx configuration
nginx -t

# Reload Nginx to apply changes
systemctl reload nginx

echo "Nginx has been configured to listen on ports 80 and 443 for $DOMAIN and traffic proxy to $PROXY_PASS."
