# Configurações adicionais no agente Zabbix

> Criar o primeiro arquivo de parâmetros de usuário dummy.conf

```
vi /etc/zabbix/zabbix_agentd.d/dummy.conf
```

UserParameter=dummy,/bin/echo "Dummy"

```
# reiniciar agente
service zabbix-agent restart
# testar nova chave
zabbix_get -s127.0.0.1 -k'dummy'
```

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

> Criar arquivo PSK

```
mkdir /home/zabbix/
openssl rand -hex 32 | tee /home/zabbix/zabbix_agentd.psk
chown zabbix: -R /home/zabbix
```
> Ajustar configuração do 
