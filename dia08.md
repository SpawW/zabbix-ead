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

> Criar arquivo de configuração do agente em modo criptografado e a execução de comandos remotos

>> vi /etc/zabbix/zabbix_agentd.d/security.conf

```
# Arquivo de log do zabbix agent
LogFile=/tmp/zabbix_agentd.log 
# Uso de comandos remotos habilitado
EnableRemoteCommands=1 
# Log de comandos remotos habilitado
LogRemoteCommands=1 

# Aceitar conexões passivas do zabbix_server e de localhost
Server=192.168.100.10,192.168.100.13,127.0.0.1 
# Endereço do Zabbix Server
ServerActive=192.168.100.10,192.168.100.13 
# Hostname do frontend
Hostname=dns1

# ------ Criptografia ------------
# Como o zabbix agent deve se conectar ao zabbix server (ou proxy)
TLSConnect=psk
# Tipo de conexões TLS aceitas vindas do zabbix server (ou proxy)
TLSAccept=psk 
# Nome único que identificará a Pre-Shared Key - PSK
TLSPSKIdentity=PSK 001 
# Caminho completo do arquivo que contém a PSK
TLSPSKFile=/home/zabbix/zabbix_agentd.psk
```
>> Reiniciar o agente e testar a chave agent.hostname

```
zabbix_get -s127.0.0.1 -k'agent.hostname'
```


