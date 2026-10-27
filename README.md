# Init

Create the local Ansible environment and install the required collections:

```sh
uv venv --python 3.12 .venv
uv pip install --python .venv/bin/python 'ansible-core>=2.19,<2.20'
.venv/bin/ansible-galaxy collection install -r requirements.yml
```

`run.sh` uses `.venv/bin/ansible-playbook` directly, so activation is unnecessary.
Ansible Core 2.19 supports the Python 3.8 system interpreter on `ocean`.

## Node.js

The local `nodejs` role installs the latest Node.js 26.x and bundled npm from
the signed NodeSource APT repository, then verifies Node.js is at least 26.12.1.
It requires Ansible Core 2.15+ and a supported amd64/arm64 Debian or Ubuntu host.

```sh
./run.sh --tags node --limit hetzner
```

After a runtime upgrade, rebuild native application dependencies if needed and
restart the affected services to use the new Node.js version.


## Manual steps

### Add/remove ansible host
Look to file ```~/.ansible/hosts```

### Generate Berlingame DB backup

```
#in old mysql container generate db backup
mysqldump -p --databases d4355_berlin > bg.sql
docker cp docker_db_1:/bg.sql .
zip -r bg.sql.zip bg.sql
```

### Berlingame Docker Compose prerequisite

Berlingame uses the Docker Compose plugin (`docker compose`), not the retired
Python `docker-compose` client. Verify `sudo docker compose version` on the server
before deployment. With Docker's APT repository configured, install it using
`sudo apt-get update && sudo apt-get install docker-compose-plugin`.
See https://docs.docker.com/compose/install/linux/ for installation instructions.

The role checks this prerequisite before updating the application. The legacy
client can fail with `KeyError: 'ContainerConfig'` while recreating a container.
This is a Compose client migration; MySQL 5.7 and `/srv/berlingame/mysql` stay
unchanged. Do not run the SQL import to fix this error.

### Run berlingame SQL import

```
run_import=true ./run.sh --tags berlingame_import_sql
```

## Debugging

### Disable UFW
Disable default firewall with
```
ufw disable
```

### Verify that caddy works
Firstly delete automatic tls downloading and add port `:80` to all websites
configurations. It will allow to get http traffic.

### Test with curl
Use resolve param to set domain to desired IP address
```
curl -vv --resolve berlingame.cz:80:IP_ADDRESS http://berlingame.cz
```
This works from the server or from network
