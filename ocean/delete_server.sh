#!/bin/bash
TAG=test-droplet
TOKEN=( $(cat /Users/kraag22/.digitalocean.token) )

curl -X DELETE -H "Content-Type: application/json" \
     -H "Authorization: Bearer $TOKEN" \
     "https://api.digitalocean.com/v2/droplets?tag_name=$TAG"
