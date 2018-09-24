Configuração do virtualbox
1.a Interface - NAT 
2.a Interface - Bridge - Anotar o IP que for adquirido (comando ip addr) e toda vez que o instrutor mostrar 192.168.100.10 substituir pelo ip 

URL de informações de instação
https://www.zabbix.com/documentation/3.4/manual/installation/install_from_packages/debian_ubuntu


ntpdate <ip_ntp> 172.16.300.1

wget https://repo.zabbix.com/zabbix/3.4/debian/pool/main/z/zabbix-release/zabbix-release_3.4-1+jessie_all.deb
dpkg -i zabbix-release_3.4-1+jessie_all.deb
apt update


