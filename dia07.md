# Habilitando o Zabbix para snmp por "nomes"
>> No servidor DNS1 (192.168.100.13) e no Zabbix Server (192.168.100.10)

```
aptitude install -y snmp libsnmp-dev libnet-snmp-perl snmp-mibs-downloader php5-snmp

cd /opt/zabbix-3.4.14

./configure --enable-proxy --with-sqlite3 --with-net-snmp

./configure --help | grep -i snmp

make && make install

service zabbix-proxy restart
```
>>> Passo Adicional necessário ===================================================================
>>> Editar o arquivo /etc/snmp/snmp.conf 

Alterar a linha :
mibs :
Para:
#mibs :

# Comandos de teste

```
whatis snmpwalk

whereis snmpwalk

snmpwalk -v2c -c public  192.168.100.13
```

# No servidor DNS2 (192.168.100.14)

```
aptitude update && aptitude upgrade
aptitude install snmpd libsnmp-dev

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

* A partir do servidor DNS1, verificar se o SNMPD do DNS2 está respondendo via SNMPv3

```
snmpwalk -v 3 -a md5 -A unirede! -l authNoPriv -u zabbix_snmp 192.168.100.14 sysName.0

```

# Habilitando SNMPTrap no servidor DNS1

```
aptitude install snmpd snmptrapd snmptt
```


>> vi /etc/snmp/snmptrapd.conf

authCommunity log,execute,net public

authCommunity log,execute,net TRF01

perl do "/usr/bin/zabbix_trap_receiver.pl";

```
cp /opt/zabbix-3.4.14/misc/snmptrap/* /usr/bin/
chmod +x /usr/bin/zabbix_trap_receiver.pl
```

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

>>> Passo Adicional necessário ===================================================================
>>> Criar o arquivo temporário do trapper
```
touch /tmp/zabbix_traps.tmp
chown zabbix: /tmp/zabbix_traps.tmp

```

# Teste da trap no arquivo temporário

snmptrap -v 1 -c public 127.0.0.1 '.1.3.6.1.6.3.1.1.5.3' '127.0.0.1' 6 33 '55' .1.3.6.1.6.3.1.1.5.3 s “teststring000”

# Adicionar os itens de trap

# Reiniciar o snmptrap

```
service snmptrapd restart
netstat -puan | grep snmptrapd
```
