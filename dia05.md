
1) Instalação do agente no windows

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

1.1) Testar se o agente está funcional
```
zabbix_get -s192.168.100.<YYY> -k'agent.version'
```
> Verificar o IP da sua estação de trabalho na rede de hostonly (ontem tentei contra o IP de gateway... por isso não estava funcionado... #falhaMinha)

2) Criação de Mapas

2.1) Criar um novo mapa

**Name** - Mapa DNS
**Minimum trigger severity** - Warning

--- Sharing ---
**User Groups** - DF

2.2) Editar conteúdo do mapa adicionando os hosts DNS1 e DNS2


2.2) Importar mapa contendo imagens que serão utilizadas no exercício
> https://raw.githubusercontent.com/zabbix-brasil/livrozabbix2014/master/Capitulo_6/fase_1_mapa_com_imagens.xml


3) Criação de telas

4) Desativar regras anteriores e criar regra de descoberta de rede separando por sistema operacional:

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

5) Conferir efeitos dos períodos de manutenção criados na aula 04

5.1) Para hosts Linux (09:21)

5.2) Para hosts Windows (09:16)

6) Criar tipo de midia de "integração" (script)

7) Reconhecimento de eventos

5.1) Escalonamento de notificações sem reconhecimento de eventos

8) Criação de Slideshow





