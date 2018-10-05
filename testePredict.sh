#/bin/bash

pausa=$1;
inicio=$2;
fim=$3;
volume=$4;
rm /tmp/arquivo*
for i in `seq $inicio $fim`;
do
  echo "Enviou - $i/$fim - Aguarda $pausa segundos.";
  dd if=/dev/zero of=/tmp/arquivo$i count=1 bs=$volume
  zabbix_sender -z 127.0.0.1 -p 10051 -s "predict" -k "paginas.pb" -o $i
  sleep $pausa;
done
