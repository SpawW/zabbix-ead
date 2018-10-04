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
