#!/bin/bash
REGION=fra1
SIZE=s-1vcpu-2gb
NAME=ocean-test
IMAGE=docker-20-04
TAG=test-droplet
TOKEN=( $(cat /Users/kraag22/.digitalocean.token) )

curl -X POST -H 'Content-Type: application/json' \
     -H 'Authorization: Bearer '$TOKEN'' -d \
     '{"name":"'$NAME'","region":"'$REGION'","size":"'$SIZE'","image":"'$IMAGE'","tags":["'$TAG'"],"ssh_keys":["95695"]}' \
     "https://api.digitalocean.com/v2/droplets"
