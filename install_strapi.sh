#!/bin/bash

# Create a directory for your Strapi project
mkdir strapi-docker && cd strapi-docker

# Create a Docker Compose file
cat > docker-compose.yml <<EOF
version: '3'
services:
  strapi:
    image: ghcr.io/padeocc/strapi:latest
    environment:
      DATABASE_CLIENT: postgres
      DATABASE_NAME: strapi
      DATABASE_HOST: postgres
      DATABASE_PORT: 5432
      DATABASE_USERNAME: strapi
      DATABASE_PASSWORD: strapi
    volumes:
      - ./strapi-app:/srv/apps/strapi-app
    ports:
      - "1337:1337"
    
EOF

# Run Docker Compose up to start your containers
docker-compose up -d

echo "Strapi and PostgreSQL containers are up and running."
