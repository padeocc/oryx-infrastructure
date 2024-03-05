#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Install necessary packages for repository management
apt-get update
apt-get install -y wget gnupg2 software-properties-common

# Import the repository signing key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Add PostgreSQL's repository. Adjust the version if necessary.
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

# Update package lists
apt-get update

# Install PostgreSQL
# Replace '12' with the version you wish to install, or remove the version to install the latest
apt-get install -y postgresql-12

# Enable and start the PostgreSQL service
systemctl enable postgresql
systemctl start postgresql

# Optional: Set up a PostgreSQL role and database
# sudo -u postgres createuser myuser
# sudo -u postgres createdb mydb
# sudo -u postgres psql -c "alter user myuser with encrypted password 'mypass';"
# sudo -u postgres psql -c "grant all privileges on database mydb to myuser;"

echo "PostgreSQL installation is complete."
