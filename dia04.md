
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

7) Criar ação cadastrar automaticamente servidores a partir do autorregistro dos agentes

8) Instalação do agente no windows

https://www.zabbix.com/downloads/3.4.6/zabbix_agents_3.4.6.win.zip
```
Server=192.168.100.10
ListenPort=10050
StartAgents=3
ServerActive=192.168.100.10
Hostname=Maquina Windows
Timeout=3 
HostMetadata=windows
```

9) Criar ação para notificar sobre incidentes com severidade igual ou superior a **average**

9.1) Separar notificações para usuários do grupo windows e do grupo linux

10) Criar períodos de manutenção

10.1) Para hosts Linux entre 13:00 e 13:10

10.2) Para hosts Windows entre 13:15 e 13:30

11) Criar tipo de midia de "integração" (script)

12) Reconhecimento de eventos

12.1) Escalonamento de notificações sem reconhecimento de eventos




