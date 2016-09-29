Repo Info
=========
This repo contains PowerDNS Recursor for the following
versions..  
`3.7.3` - latest  
`4.x` - development

Each of these are available separately using [Docker] hub as:
`mrlesmithjr/powerdns-recursor`
`mrlesmithjr/powerdns-recursor:3.7.3`
`mrlesmithjr/powerdns-recursor:4.x`

Spin up PDNS Recursor:
```
docker run -d --name pdns-recursor \
  -e PDNS_RECURSOR_LOCAL_ADDRESS="0.0.0.0" \
  -e PDNS_RECURSOR_LISTEN_PORT="5300" \
  mrlesmithjr/powerdns-recursor:3.7.3
```

Consuming using `docker-compose`
--------------------------------
* Spin up containers
```
docker-compose up -d
```

The DB port `33306` is exposed so that you COULD spin up
[phpIPAM] and manage your DNS using
phpIPAM if you configure the integration within [phpIPAM] PowerDNS settings.

* Validate
`dig @127.0.0.1 google.com`
Now configure some of your devices to use the `DockerHostIP` for DNS.

* Python fun
Within the `python-powerdns-management` folder you will find a Python script
I had created a while back to manage PDNS.
http://everythingshouldbevirtual.com/python-manage-powerdns-zonesrecords

Backing up DB data
------------------
If you find yourself in need of backing up your DB data in order to migrate to
another host or just to backup the data in general. You can do that as simple as
below:
* Requirements
  * Destination mountpoint to backup to `/backups`

We will use the method of backing up using the `--volumes-from` [Docker] volume
option. This process will spin up a temporary container, mount the
`/var/lib/mysql` folder, and then back it all up to a `tar.gz` file in our
`/backups` folder.
```
docker run --rm --volumes-from dockeransiblepowerdns_db_1 \
-v /backups:/backup ubuntu tar cvzf /backup/dockeransiblepowerdns_db_1.backup.tar.gz \
/var/lib/mysql
```
And to validate that the backup exists:
```
ll /backups
total 550
drwxrwxrwx  2 root root      3 Aug 11 01:01 ./
drwxr-xr-x 24 root root   4096 Aug 11 00:47 ../
-rw-r--r--  1 root root 811475 Aug 11 01:01 dockeransiblepowerdns_db_1.backup.tar.gz
```
Now you can copy/move that anywhere and extract it with all of your data intact.

License
-------

BSD

Author Information
------------------

Larry Smith Jr.
- [@mrlesmithjr]
- [everythingshouldbevirtual.com]
- [mrlesmithjr@gmail.com]


[Ansible]: <https://www.ansible.com/>
[Docker]: <https://www.docker.com>
[phpIPAM]: <https://github.com/mrlesmithjr/docker-phpipam>
[@mrlesmithjr]: <https://twitter.com/mrlesmithjr>
[everythingshouldbevirtual.com]: <http://everythingshouldbevirtual.com>
[mrlesmithjr@gmail.com]: <mailto:mrlesmithjr@gmail.com>
