
1) Reiniciar todas as vms

* Verificar se o agente zabbix subiu, não ? Qual motivo ? Como corrigir ?

> update-rc.d zabbix-agent enable # Habilita a carga automática do agente zabbix

1) Importar os templates a seguir (a ordem deles está errada, tente importa-los nesta ordem e descubra a ordem correta):

* [dia04/101_Apache.xml](dia04/101_Apache.xml)
* [dia04/000_ICMP_Estatisticas.xml](dia04/000_ICMP_Estatisticas.xml)
* [dia04/000_ICMP.xml](dia04/000_ICMP.xml)
* [dia04/102_Linux_Security.xml](dia04/102_Linux_Security.xml)
* [dia04/100_Linux.xml](dia04/100_Linux.xml)
* [dia04/800_LLD.xml](dia04/800_LLD.xml)

2) Regras de descoberta de rede:

2.1) Ativos na rede **192.168.100.0/24**

2.2) Ativos na rede do Laboratório físico

2.3) Servidores web (porta 80) na rede **192.168.100.0/24**

2.4) Agente Zabbix pronto para monitoração (rede física e rede virtual)

3) Criar ação para cadastramento automático de hosts na monitoração com o template de monitoramento em Linux

4) Criar ação para adicionar template 101_APACHE nos hosts descobertos através da regra de HTTP.

5) Criar ação para adicionar template 100_Linux nos hosts descobertos através da regra de AGENTE.

6) Alterar ação para adicionar template 000_ICMP nos hosts descobertos através da regra de ICMP.



