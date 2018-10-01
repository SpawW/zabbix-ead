

1) Instalar o proxy a partir dos fontes

```
wget https://sourceforge.net/projects/zabbix/files/ZABBIX%20Latest%20Stable/3.4.14/zabbix-3.4.14.tar.gz/download -O /tmp/zabbix.tar.gz

tar zxvf /tmp/zabbix.tar.gz -C /opt/

mkdir /var/lib/sqlite3/

sqlite3 /var/lib/sqlite3/zabbix.db < /opt/zabbix-3.4.8/database/sqlite3/schema.sql

useradd -m -s /bin/bash zabbix

chown -R zabbix:zabbix /var/lib/sqlite3/

/opt/zabbix-3.4.14/configure --enable-proxy --with-sqlite3

make && make install

cp /opt/zabbix-3.4.8/misc/init.d/debian/zabbix-agent /usr/local/sbin/zabbix_proxy

vi /etc/init.d/zabbix-proxy

```

NAME=zabbix_proxy

DAEMON=/usr/local/sbin/${NAME}

DESC="Zabbix Proxy daemon"

PID=/tmp/$NAME.pid

```

update-rc.d zabbix-proxy defaults

vi /usr/local/etc/zabbix_proxy.conf

```

Server=192.168.100.10 # O IP de seu Zabbix Server

Hostname=proxy-dns1

LogFile=/tmp/zabbix_proxy.log

DebugLevel=3

DBName=/var/lib/sqlite3/zabbix.db

Timeout=3

```
service zabbix-proxy start

netstat -ntpl | grep zabbix

tail -f /tmp/zabbix_proxy.log

```
