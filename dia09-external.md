# External Checks

> Arquitetura 64 bits

echo "ExternalScripts=/usr/lib/zabbix/externalscripts" > /etc/zabbix/zabbix_server.conf.d/external.conf

```
service zabbix-server restart
echo '#!/bin/bash' > /usr/lib/zabbix/externalscripts/64bits.sh
echo '[[ "$(grep lm /proc/cpuinfo)" ]] && echo 1 || 0' >> /usr/lib/zabbix/externalscripts/64bits.sh
chown zabbix: /usr/lib/zabbix/externalscripts/64bits.sh
chmod +x /usr/lib/zabbix/externalscripts/64bits.sh
```


# Zabbix Trapper

> Crie o template : 003 - Zabbix Trapper

>> Associe o host **df-01** e o host **dns1** ao template **003**
{003 - Zabbix Trapper:bkp.diario.status.nodata(24h)}=1
> Crie uma aplicação: **Zabbix Trapper**

> Crie um item em **003 - Zabbix Trapper** 


**Name**: Status do Backup Diario
**Item Type**: Zabbix Trapper
**Key**: bkp.diario.status
**Type of Information**: Text

> Envie uma trap
```
zabbix_sender -z 127.0.0.1 -p 10051 -s "df-01" -k "bkp.diario.status" -o "Backup diario realizado com sucesso"
```
> Criar trigger no template **003** para avisar sobre ausencia do backup a mais de 24 horas

**Expression**: {003 - Zabbix Trapper:bkp.diario.status.nodata(24h)}=1

