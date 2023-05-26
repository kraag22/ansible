# Init

install galaxy roles with 

```
    ansible-galaxy install -r requirements.yml
```


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
