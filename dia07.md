aptitude install -y snmp libsnmp-dev libnet-snmp-perl snmp-mibs-downloader php5-snmp

export MIBS=/usr/share/mibs

cd /opt/zabbix-3.4.14

./configure --enable-proxy --with-sqlite3 --with-net-snmp
