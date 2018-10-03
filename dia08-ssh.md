# Verificações SSH com usuário e senha

> Criar usuário para executar comandos ssh no(s) servidor(es) de destino (localhost, dns1, dns2)

```
useradd -m -s /bin/bash zabbix.ssh
passwd zabbix.ssh
```

>> Sugestão para laboratório: zabbix123

> Criar host para testes de coleta ssh

**Name**: host-ssh

> Criar item ssh para coleta de CPU Load

**Name**: CPU Load

**Type**: SSH Agent

**Key**: ssh.run[cpu_load]

**User name**: zabbix.ssh

**Password**: zabbix123

**Executed Script**: cat /proc/loadavg | cut -d " " -f 1

**Type of information**: Numeric(Float)

**New application**: SSH Checks


> Criar item ssh para coleta de CPU Load de 5 e de 15 minutos

5 - ...

**Key**: ssh.run[cpu_load_5]

**Executed Script**: cat /proc/loadavg | cut -d " " -f 2

**Application**: SSH Checks

15 - ...

**Key**: ssh.run[cpu_load_15]

**Executed Script**: cat /proc/loadavg | cut -d " " -f 3

**Application**: SSH Checks


# Verificações SSH com par de chaves

É necessário ajustar a configuração do Zabbix Server para informar o caminho para os arquivos de chaves.
De forma similar à configuração do agente, também é possível configurar o Zabbix Server através de arquivos de configuração adicionais.

* Adicione a linha a seguir em /etc/zabbix/zabbix_server.conf

```
Include=/etc/zabbix/zabbix_server.conf.d/*.conf
```

* Criar o arquivo /usr/local/etc/zabbix_server.conf.d/ssh_config.conf

```
mkdir /etc/zabbix/zabbix_server.conf.d/
echo "SSHKeyLocation=/home/zabbix/.ssh/" > /etc/zabbix/zabbix_server.conf.d/ssh_config.conf
```

* Crie a pasta /home/zabbix/.ssh/ com o usuário zabbix como proprietário e reinicie o servidor zabbix

```
mkdir /home/zabbix/.ssh/
chown zabbix: /home/zabbix/.ssh/

service zabbix-server restart 
```

* Gerar chaves SSH para o usuário zabbix

```
ssh-keygen -t rsa -b 4096 -C "zabbix@company" -f /home/zabbix/.ssh/id_rsa
```


* Copiar chaves pública para o servidor de destino

```
ssh-copy-id -i /home/zabbix/.ssh/id_rsa.pub zabbix.ssh@127.0.0.1

# Verificar se a chave foi adicionada
cat /home/zabbix.ssh/.ssh/authorized_keys 

```


