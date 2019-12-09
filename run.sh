#/bin/bash

ansible-playbook --vault-password-file /Users/kraag22/.ansible/ocean \
  -e @vault.yml \
  site.yml "$@"

