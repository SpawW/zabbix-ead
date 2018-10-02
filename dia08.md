
# Criptografia

> Habilitar suporte à criptografia no dns1

```
aptitude install libssl-dev

cd /opt/zabbix-3.4.14

./configure --enable-agent --with-openssl

make && make install

./configure --enable-proxy --with-sqlite3 --with-net-snmp --with-openssl

make && make install

```

> Configurar zabbix-agent para comunicação criptografada

```
```
