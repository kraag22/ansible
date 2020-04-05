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

