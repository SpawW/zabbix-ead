
1) Instalação do agente no windows

https://www.zabbix.com/downloads/3.4.6/zabbix_agents_3.4.6.win.zip

> c:\zabbix\bin\win32\zabbix_agentd.exe -i -c c:\zabbix\conf\zabbix_agentd.conf

```
ListenPort=10050
StartAgents=3
Timeout=3 
Hostname=Maquina Windows
HostMetadata=windows

Server=192.168.100.10
ServerActive=192.168.100.10

LogFile=c:\zabbix\zabbix-agentd.log
```

1.1) Testar se o agente está funcional
```
zabbix_get -s192.168.100.<YYY> -k'agent.version'
```
> Verificar o IP da sua estação de trabalho na rede de hostonly (ontem tentei contra o IP de gateway... por isso não estava funcionado... #falhaMinha)

_____________________
2) Criação de Mapas

2.1) Criar um novo mapa

**Name** - Mapa DNS

**Minimum trigger severity** - Warning

--- Sharing ---

**User Groups** - DF

2.2) Editar conteúdo do mapa adicionando os hosts DNS1 e DNS2

2.3) Testar visualização com o usuário **joao**

2.4) Editar novamente o mapa com o seu usuário **Super Admin**, adicionando o host **Maquina Windows**

2.3) Testar visualização com o usuário **victor**

> Qual a diferença da visualização entre **victor** e **joao** ?

2.2) Importar mapa contendo imagens que serão utilizadas no exercício

> https://raw.githubusercontent.com/zabbix-brasil/livrozabbix2014/master/Capitulo_6/fase_1_mapa_com_imagens.xml

_____________________
3) Criação de telas

_____________________
4) Desativar alertas anteriores e criar novos separando por sistema operacional:

4.1) Para servidores Windows, aplicando o "Template OS Windows"

**Conditions**

**Received value** like **windows**

**Operations**

**Send message to user groups:** Zabbix administrators via all media

**Add to host groups:** DF/Servers/Windows

**Remove from host groups:** Discovered hosts

**Link to templates:** Template OS Windows

4.2) Para servidores Linux, aplicando o "100 - Linux"

**Conditions**

**Received value** like **linux**

**Operations**

**Send message to user groups:** Zabbix administrators via all media

**Add to host groups:** DF/Servers/Linux

**Remove from host groups:** Discovered hosts

**Link to templates:** Template OS Windows

_____________________
5) Alterar descoberta de rede **Agente Zabbix Apto a ser monitorado** 

**Checks**

* Zabbix agent "system.hostname"	

* Zabbix agent "system.uname"

**Device uniqueness criteria**

* Zabbix agent "system.hostname"

_____________________
7) Reconhecimento de eventos

7.1) Escalonamento de notificações sem reconhecimento de eventos

_____________________
8) Monitoração ativa vs passiva

8.1) Criar template 101 em modo passivo

8.2) Aplicar a um host

8.3) Parar o processo do Zabbix Server por 5 minutos, retornar e ver os dados retroativos

_____________________
8) Criação de Slideshow

_____________________
============  Em Paralelo  =============

1) Conferir efeitos dos períodos de manutenção criados na aula 04

1.1) Para hosts Linux (09:21)

1.2) Para hosts Windows (09:16)

_____________________
2) Criar tipo de midia de "integração" (script) e configurar usuários para receber notificações desta forma

```
apt install curl
wget https://raw.githubusercontent.com/SpawW/zabbix-ead/master/dia05/telegram-notify.sh -O /usr/lib/zabbix/alertscripts/telegram-notify.sh
chown zabbix: telegram-notify.sh
chmod +x telegram-notify.sh
```
> URL para recuperar o ID dos usuários: https://api.telegram.org/bot<<ID>>/getupdates





