# Preparação e verificação de agendamento de item em LLD

> Associar os hosts existentes em **DF/Servers/Linux** ao template **100 - Linux**

> Verificar qual o intervalo entre verificações de interfaces de rede e sistemas de arquivos, proceder com ajustes necessários (templates 801 e 802)

# Itens calculados

> Criar itens calculados com a **média de tempo de resposta do ICMP** no template **000 - ICMP**, em visão de 5, 10 e 20 minutos

```
avg("icmppingsec[,{$QTD_PING},200,,{$TIMEOUT_PING},avg]",300)
```


> Criar gráfico **Comparativo de resposta ICMP** comparando os tempos de respostas brutos com suas médias

> Criar itens calculados com a **média de tempo de resposta do ICMP a meia hora atrás** no template **000 - ICMP**, em visão de 5 minutos

> Ajustar gráfico adicionando a estatística com tempo deslocado

# Itens agregados

> Criar template **103 - Statistical** 

> Criar item agregado para o **máximo de tráfego de entrada** na interface **eth0** no grupo de hosts **Servers/Linux**

```
grpmax["Servers/Linux","net.if.in[eth1]",last,0]
```

> Criar item agregado para a **média de tráfego de entrada** na interface **eth0** no grupo de hosts **Servers/Linux**

> Criar gráfico **Dados agrupados de tráfego** com os dados agregados

> Associar o host **df-01** ao template **103 - Statistical**

