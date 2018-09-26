1) Importar a VM E1-SRV-DNS1 (DNS1)
2) Enquanto é importada... criar dois novos hosts, usando os dados da tabela a seguir:
| Propriedade        | Host 1          | Host 2  |
| ------------- |:-------------:| -----:|
| Host Name     | dns2 | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

wget https://repo.zabbix.com/zabbix/3.4/debian/pool/main/z/zabbix-release/zabbix-release_3.4-1+jessie_all.deb
dpkg -i zabbix-release_3.4-1+jessie_all.deb
apt update

