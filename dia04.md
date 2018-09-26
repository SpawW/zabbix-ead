
1) Reiniciar todas as vms

* Verificar se o agente zabbix subiu, não ? Qual motivo ? Como corrigir ?

> update-rc.d zabbix-agent enable

1) Importar o template 100_APACHE.xml, cadastrar a macro " {$APACHE_PROCESSO}" com o nome do processo responsável pelo apache (em modo global).


