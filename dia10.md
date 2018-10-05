# Java Gateway - Parte 1

> Instalando java da Oracle **no dns1 e no dns2**
```
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

apt -y update && apt -y install oracle-java8-installer
```

# Prediction Functions

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

# Java Gateway - Parte 2

> Verificando versao do java (dns1)
```
#Verificar versao do java
java -version
#java version "1.8.0_181"
#Java(TM) SE Runtime Environment (build 1.8.0_181-b13)
#Java HotSpot(TM) Client VM (build 25.181-b13, mixed mode)

```

> Atualizando o proxy para suportar java (dns1)
```
cd /opt/zabbix-3.4.14
./configure --enable-proxy --with-sqlite3 --with-net-snmp --with-openssl --enable-java
make && make install

echo "StartJavaPollers=2" > /usr/local/etc/zabbix_proxy.conf.d/java_gateway.conf
echo "JavaGatewayPort=10052" > /usr/local/etc/zabbix_proxy.conf.d/java_gateway.conf
echo "JavaGateway=192.168.100.13" > /usr/local/etc/zabbix_proxy.conf.d/java_gateway.conf

echo "Include=/usr/local/etc/zabbix_proxy.conf.d/*.conf" >> /usr/local/etc/zabbix_proxy.conf
 
service zabbix-proxy restart 
```

> Configurando o zabbix-java gateway (dns1)

```

sed -i 's/^# LISTEN_IP/LISTEN_IP/g' /usr/local/sbin/zabbix_java/settings.sh
sed -i 's/^# LISTEN_PORT/LISTEN_PORT/g' /usr/local/sbin/zabbix_java/settings.sh
sed -i 's/^# START_POLLERS/START_POLLERS/g' /usr/local/sbin/zabbix_java/settings.sh

/usr/local/sbin/zabbix_java/startup.sh
ps aux | grep java 

```

> Configurando tomcat (dns2)

```
apt install -y curl
curl http://mirror.nbtelecom.com.br/apache/tomcat/tomcat-8/v8.5.34/bin/apache-tomcat-8.5.34.tar.gz -o /tmp/tomcat.tgz
cd /usr/local
tar -xvzf /tmp/tomcat.tgz
cd /usr/local/apache-tomcat-*/bin/
vi catalina.sh
´´´

>>Antes (aproximadamente linha 102)

´´´
CATALINA_OPTS="$JPDA_OPTS $CATALINA_OPTS"
´´´

>>Depois

´´´
#CATALINA_OPTS="$JPDA_OPTS $CATALINA_OPTS“
export CATALINA_OPTS="-
Dcom.sun.management.jmxremote.port=8090 -
Dcom.sun.management.jmxremote.authenticate=false -
Dcom.sun.management.jmxremote.ssl=false -
Djava.rmi.server.hostname=192.168.100.14"
´´´

> Inicializar tomcat e tentar o acesso na porta 8090
./startup.sh && netstat -ntpl | grep 8080










