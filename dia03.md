1) Importar e inicializar as VMs **E1-SRV-DNS1 (DNS1)** e **E1-SRV-DNS2 (DNS2)**

2) Enquanto as VMs são importadas.. vamos criar dois novos hosts, usando os dados da tabela a seguir:

| Propriedade        | Host 1             | Host 2               |
| ------------------ |:------------------:| --------------------:|
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

5) Instalar o agente Zabbix no servidor dns1 e dns2
```
wget https://repo.zabbix.com/zabbix/3.4/debian/pool/main/z/zabbix-release/zabbix-release_3.4-1+jessie_all.deb
dpkg -i zabbix-release_3.4-1+jessie_all.deb
apt update
apt install zabbix-agent
```

6) Configurar o agente Zabbix no dns1 e dns2 para aceitar conexões do servidor de monitoração

```
vi /etc/zabbix/zabbix_agentd.conf
```
Server=192.168.100.10
```
service zabbix-agent restart
```

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



