#!/bin/bash
TOKEN=( $(cat /Users/kraag22/.digitalocean.token) )

curl -X GET -H 'Content-Type: application/json' -H \
    'Authorization: Bearer '$TOKEN "https://api.digitalocean.com/v2/account/keys"
