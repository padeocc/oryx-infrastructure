#!/bin/bash

if [ -z "$TOKEN" ]; then
  echo "Please set the TOKEN environment variable"
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: $0 <GITHUB_USERNAME>"
  exit 1
fi

echo $TOKEN | docker login ghcr.io -u $USERNAME --password-stdin
