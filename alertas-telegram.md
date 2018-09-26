O Bot Já foi criado pelo instrutor e possui o hash a seguir: 
> 660982645:AAGpv4jFqZyFwX7-zMLlGLIx5gqExXmE8Ac

1) Adquirir os scripts de teste e integração com o Telegram
  cd /usr/lib/zabbix/alertscripts/
  wget https://goo.gl/JB2PSy -O telegram-notify.sh
  wget https://goo.gl/tAhWvL -O telegram-getUpdates.sh
  chmod +x telegram-*.sh
  chown zabbix: telegram-*.sh
