# Verificações SSH

> Criar usuário para executar comandos ssh no servidor de destino

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

