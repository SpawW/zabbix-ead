1) Importar e inicializar as VMs **E1-SRV-DNS1 (DNS1)** e **E1-SRV-DNS2 (DNS2)**

2) Enquanto as VMs são importadas.. vamos criar dois novos hosts, usando os dados da tabela a seguir:

| Propriedade        | Host 1             | Host 2               |
| ------------------ | ------------------ | -------------------- |
| Host Name          | dns2               | frontend2            |
| Visible Name       | DNS Secundário     | Novo frontend Zabbix |
| Groups             | Linux servers      | Linux servers        |
| Groups             |                    | Zabbix server        |
| Agent Interfaces   | ip: 192.168.100.14 | ip: 192.168.100.13   |
| Templates          | 000_ICMP           | 000_ICMP             |

> Caso seja necessário o arquivo [/dia03/momento_01.xml](/dia03/momento_01.xml) poderá ser importado para ter os dois novos hosts no estado esperado para este exercício.

2.1) Atualizar template 000_ICMP adicionando trigger para avisar quando o PING falhar

| Propriedade        | Valor                             |
| ------------------ | --------------------------------- |
| Name               | Servidor não responde à ping      |
| Severity           | High                              |
| Expression         | {000_ICMP:icmpping[].last()}=0    |

2.2) Atualizar template 000_ICMP adicionando trigger para avisar quando o PING falhar por mais de 5 minutos

| Propriedade        | Valor                                                    |
| ------------------ | -------------------------------------------------------- |
| Name               | Servidor não responde à ping a mais de 300 segundos      |
| Severity           | Disaster                                                 |
| Expression         | {000_ICMP:icmpping[].sum(300)}=0                         |

2) Renomear o grupo de hosts **Linux servers** para **Servers/Linux**

3) Criar os grupos
* **Servers/Windows**
* **Network/Switchs**
* **Network/Routers**

> Caso seja necessário o arquivo [/dia03/importa_grupos.xml](/dia03/importa_grupos.xml) poderá ser importado para importar os gurpos e hosts até o momento deste exercício.

4) Clonar o host **dns2** para um novo host com os dados a seguir:

| Propriedade        | Valor                             |
| ------------------ | --------------------------------- |
| Name               | offline01                         |
| Visible Name       |                                   |
| Groups             | Servers/Windows                   |
| Agent Interfaces   | ip: 192.168.100.99                |


4.1) Clonar o host **dns2** para um novo host com os dados a seguir:

| Propriedade        | Valor                             |
| ------------------ | --------------------------------- |
| Name               | estacao_noc                       |
| Visible Name       |                                   |
| Groups             | Servers/Windows                   |
| Agent Interfaces   | ip: 192.168.100.1                 |

> Caso seja necessário o arquivo [/dia03/windows_servers.xml](/dia03/windows_servers.xml) poderá ser importado para importar os gurpos e hosts até o momento deste exercício.

5) Instalar o agente Zabbix no servidor **dns1** e **dns2**

```
wget https://repo.zabbix.com/zabbix/3.4/debian/pool/main/z/zabbix-release/zabbix-release_3.4-1+jessie_all.deb
dpkg -i zabbix-release_3.4-1+jessie_all.deb
apt update
apt install zabbix-agent
apt install zabbix-get zabbix-sender
```

5.1) Instalar o agente Zabbix no servidor **Zabbix server**
```
apt install zabbix-agent
apt install zabbix-get zabbix-sender
```

6) Configurar o agente Zabbix no dns1 e dns2 para aceitar conexões do servidor de monitoração

```
vi /etc/zabbix/zabbix_agentd.conf
```
Server=192.168.100.10
```
service zabbix-agent restart
```

6.1) Testar, a partir da linha de comando do **dns1**, a consulta ao total de memória do servidor **dns1** 

```
zabbix_get -s 127.0.0.1 -k'vm.memory.size[total]'
```
> Qual o valor retornado?

6.2) Testar, a partir da linha de comando do **ZBX Server**, a consulta ao total de memória do servidor **dns1** 

```
zabbix_get -s 127.0.0.1 -k'vm.memory.size[total]'
```
> Qual valor retornado?

6.3) Ajustar o arquivo de configuração do **dns1** e **dns2** para aceitar as requisições a partir do servidor que falhou.

** Ajuste :-D ** 

7) Atualizar template 000_ICMP para suportar customização do tempo da trigger de desastre no nível de host

| Propriedade        | Valor                                                                    |
| ------------------ | ------------------------------------------------------------------------ |
| Name               | Servidor não responde à ping a mais de {$000_ICMP_PERIODO} segundos      |
| Severity           | Disaster                                                                 |
| Expression         | {000_ICMP:icmpping[].sum({$000_ICMP_PERIODO})}=0                         |

7.1) Atualizar a trigger **Servidor não responde à ping** para depender da trigger criada no item **7**

| Propriedade        | Valor                                                                    |
| ------------------ | ------------------------------------------------------------------------ |
| Name               | Servidor não responde à ping a mais de {$000_ICMP_PERIODO} segundos      |
| Severity           | Disaster                                                                 |
| Expression         | {000_ICMP:icmpping[].sum({$000_ICMP_PERIODO})}=0                         |

> O que aconteceu com o incidente que estava ativo?
> Caso seja necessário o arquivo [/dia03/000_ICMP_momento_01.xml](/dia03/000_ICMP_momento_01.xml) poderá ser importado para ter o template **000_ICMP** no estado esperado para este exercício.



