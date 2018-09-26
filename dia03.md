1) Importar a VM E1-SRV-DNS1 (DNS1)

2) Enquanto é importada... criar dois novos hosts, usando os dados da tabela a seguir:

| Propriedade        | Host 1             | Host 2               |
| ------------------ |:------------------:| --------------------:|
| Host Name          | dns2               | frontend2            |
| Visible Name       | DNS Secundário     | Novo frontend Zabbix |
| Groups             | Linux servers      | Linux servers        |
| Groups             |                    | Zabbix server        |
| Agent Interfaces   | ip: 192.168.100.14 | ip: 192.168.100.13   |

> Caso seja necessário o arquivo [/dia03/momento_01.xml] poderá ser importado para ter os dois novos hosts no estado esperado para este exercício.

3) Instalar o agente Zabbix no servidor dns1 e dns2
```
wget https://repo.zabbix.com/zabbix/3.4/debian/pool/main/z/zabbix-release/zabbix-release_3.4-1+jessie_all.deb
dpkg -i zabbix-release_3.4-1+jessie_all.deb
apt update
```[I'm a relative reference to a repository file]

4) Configurar o agente Zabbix no dns1 e dns2 para aceitar conexões do servidor de monitoração

```
vi /etc/zabbix/zabbix_agentd.conf
```
Server=192.168.100.10
```
service zabbix-agent restart
```

5) Atualizar template 000_ICMP adicionando trigger para avisar quando o PING falhar

6) Importar o template 101_APACHE

