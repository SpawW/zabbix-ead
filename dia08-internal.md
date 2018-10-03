# Zabbix Internal Checks

> Tempo em carga do Zabbix

**Name**: Zabbix Boot Time

**Type**: Zabbix Internal

**Key**: zabbix[boottime]

**Type of information**: Numeric (unsigned)

**Units**: unixtime

**Update Interval**: 60s

**New application**: Internal Checks

> Quantidade de valores numéricos no history

>> Itens com o tipo de dado = Numeric (unsigned)

**Name**: Numeric Values on History Table

**Type**: Zabbix Internal

**Key**: zabbix[history]

**Type of information**: Numeric (unsigned)

**Update Interval**: 60s

**Application**: Internal Checks

> Quantidade de valores no history de textos (1)

>> Itens com o tipo de dado = Character

**Name**: String Values on History Table

**Type**: Zabbix Internal

**Key**: zabbix[history_str]

**Type of information**: Numeric (unsigned)

**Update Interval**: 60s

**Application**: Internal Checks

> Quantidade de valores no history de textos (2)

>> Itens com o tipo de dado = Text

**Name**: Text Values on History Table

**Type**: Zabbix Internal

**Key**: zabbix[history_text]

**Type of information**: Numeric (unsigned)

**Update Interval**: 60s

**Application**: Internal Checks

> Quantidade de valores no history de logs

>> Itens com o tipo de dado = Log

**Name**: Log Values on History Table

**Type**: Zabbix Internal

**Key**: zabbix[history_log]

**Type of information**: Numeric (unsigned)

**Update Interval**: 60s

**Application**: Internal Checks

> Cadastrar um novo tipo de mapeamento de valores para o status de manutenção do host

>> Administration | General | Value Mapping | Create value map

**Name**: Maintenance status

0 -------

**Value**: 0

**Mapped to**: Normal state

1 -------

**Value**: 1

**Mapped to**: Maintenance with data collection

2 -------

**Value**: 2

**Mapped to**: Maintenance without data collection


> Status do host em função de manutenções

**Name**: Maintenance Status

**Type**: Zabbix Internal

**Key**: zabbix[host,,maintenance]

**Type of information**: Numeric (unsigned)

**Update Interval**: 60s

**Show value**: Maintenance status

**Application**: Internal Checks

> Tipos de monitoramento disponíveis no host

>> Valores possíveis para o parâmetro >Type<: agent, snmp, ipmi, jmx

**Name**: Monitoring by $2

**Type**: Zabbix Internal

**Key**: zabbix[host,>Type<,available]

**Type of information**: Numeric (unsigned)

**Update Interval**: 60s

**Application**: Internal Checks

