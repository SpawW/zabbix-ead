>> No servidor DNS1 (192.168.100.13)

```
aptitude install -y snmp libsnmp-dev libnet-snmp-perl snmp-mibs-downloader php5-snmp

export MIBS=/usr/share/mibs

cd /opt/zabbix-3.4.14

./configure --enable-proxy --with-sqlite3 --with-net-snmp

./configure --help | grep -i snmp

make && make install

service zabbix-proxy restart
```

# Comandos de teste

```
whatis snmpwalk

whereis snmpwalk

snmpwalk -v2c -c public  192.168.100.13
```


>> No servidor DNS2 (192.168.100.14)

```
aptitude update && aptitude upgrade && aptitude install snmpd libsnmp-dev

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

> Salvar e reiniciar e testar o deamon do SNMP

```
/etc/init.d/snmpd restart

snmpwalk -v 2c -c public 192.168.100.14

```

>> Habilitando SNMPv3 em DNS

* Parando o serviço snmpd

```
/etc/init.d/snmpd stop
```

* Criar o usuário para uso do snmp v3

#apt-get install libsnmp-dev

```
net-snmp-config --create-snmpv3-user -a unirede! zabbix_snmp
```

* Inicie novamente o serviço snmpd

```
/etc/init.d/snmpd start


```


* Em DNS1


```
snmpwalk -v 3 -a md5 -A unirede! -l authNoPriv -u zabbix_snmp 192.168.100.14

```

aptitude install snmpd snmptrapd snmptt


>> vi /etc/snmp/snmptrapd.conf

authCommunity log,execute,net public

perl do "/usr/bin/zabbix_trap_receiver.pl";

cp /opt/zabbix-3.4.14/misc/snmptrap /usr/bin/

>> vi /etc/snmp/snmptt.conf

EVENT general .* "General event" Normal

FORMAT ZBXTRAP $aA $ar


>> vi /etc/default/snmptrapd

Alterar a linha :
TRAPDRUN=no
Para:
TRAPDRUN=yes



# Editar o Proxy
vi /usr/local/etc/zabbix_proxy.conf

StartSNMPTrapper=1

SNMPTrapperFile=/tmp/zabbix_traps.tmp


service zabbix-proxy restart

ps -ef | grep snmptr