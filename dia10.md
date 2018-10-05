# Trigger Prediction

> Importar template **901 - Prediction**

> Importar host **predict**

> Criar script "testePredict.sh"

Testar com os comandos a seguir, acompanhando pelo dashboard e pela screen do host:

```
 curl https://raw.githubusercontent.com/SpawW/zabbix-ead/master/testePredict.sh -o /tmp/testePredict.sh
 ./testePredict.sh 10  1 10 100M
 ./testePredict.sh 10  1 10 6M
 ./testePredict.sh 10  1 10 2M
 ./testePredict.sh 10  1 10 1M

```

# Java Gateway (fazendo)

```
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

apt -y update && apt -y install oracle-java8-installer

java -version

cd /opt/zabbix-3.4.14
./configure --enable-proxy --with-sqlite3 --with-net-snmp --with-openssl --enable-java
make && make install

echo "StartJavaPollers=2" > /usr/local/etc/zabbix_proxy.conf.d/java_gateway.conf
echo "JavaGatewayPort=10052" > /usr/local/etc/zabbix_proxy.conf.d/java_gateway.conf
echo "JavaGateway=192.168.100.13" > /usr/local/etc/zabbix_proxy.conf.d/java_gateway.conf

echo "Include=/usr/local/etc/zabbix_proxy.conf.d/*.conf" >> /usr/local/etc/zabbix_proxy.conf
 
service zabbix-proxy restart && tail –f /tmp/zabbix_proxy.log


```
