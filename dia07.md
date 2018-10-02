>> No servidor DNS1 (192.168.100.13)

aptitude install -y snmp libsnmp-dev libnet-snmp-perl snmp-mibs-downloader php5-snmp

export MIBS=/usr/share/mibs

cd /opt/zabbix-3.4.14

./configure --enable-proxy --with-sqlite3 --with-net-snmp

./configure --help | grep -i snmp

make && make install

service zabbix-proxy restart

# Comandos de teste

whatis snmpwalk

whereis snmpwalk

snmpwalk -v2c -c public  192.168.100.13

>> No servidor DNS2 (192.168.100.14)

```
aptitude update && aptitude upgrade && aptitude install snmpd

```

> Editar o arquivo /etc/snmp/snmpd.conf

```
# Listen for connections from the local system only
#agentAddress udp:127.0.0.1:161
# Listen for connections on all interfaces (both IPv4 *and* IPv6)
agentAddress udp:161,udp6:[::1]:161
rocommunity public 192.168.100.0/24
#rocommunity public localhost
```

> Salvar e reiniciar o deamon do SNMP
#/etc/init.d/snmpd restart
