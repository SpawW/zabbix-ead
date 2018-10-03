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

> Gerar chave PSK no zabbix_server

```
mkdir /home/zabbix/
openssl rand -hex 32 | tee /home/zabbix/zabbix_agentd.psk
chown zabbix: -R /home/zabbix
```

> Copiar chave PSK para os agentes que serão monitorados

```
# dns1
# Copia PSK
scp -r -p /home/zabbix root@192.168.100.13:/home/
# Seta permissão no arquivo
ssh root@192.168.100.13 'chown -R zabbix: /home/zabbix'

# dns2
# Copia PSK
scp -r -p /home/zabbix root@192.168.100.14:/home/
# Seta permissão no arquivo
ssh root@192.168.100.14 'chown -R zabbix: /home/zabbix'

```

> Habilitar criptografia no proxy (DNS1)
```
aptitude install libssl-dev
cd /opt/zabbix-3.4.14
./configure --enable-proxy --with-sqlite3 --with-net-snmp --with-openssl
make && make install
service zabbix-proxy restart
```

> Habilitar criptografia no DNS1

```
aptitude install libssl-dev
cd /opt/zabbix-3.4.14
./configure --enable-agent --with-openssl
make && make install
```

> Criar arquivo de configuração do agente em modo criptografado e a execução de comandos remotos em DNS1 e DNS2

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
Hostname=dnsX

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
service zabbix-agent restart
zabbix_get -s127.0.0.1 -k'agent.hostname'
```

>> Verificar erros no log do agente 

```
tail /tmp/zabbix_agentd.log
```

>> Testar novamente a chave agent.hostname com os parâmetros de criptografia

```
zabbix_get -s127.0.0.1 -k'agent.hostname' --tls-connect=psk --tls-psk-identity="PSK 001" --tls-psk-file=/home/zabbix/zabbix_agentd.psk
```

>> Comando para recuperar a chave PSK gerada no zabbix_server: cat /home/zabbix/zabbix_agentd.psk

**Connections to host**: PSK
**Conections from host**: PSK
**PSK Identity**: PSK 001
**PSK**: <<Chave PSK gerada>>

  




