#!/bin/bash
#:***********************************************
#:Program: get cpu thread.
#:
#:Author: keanli
#:
#:History: 2017-06-20
#:
#:Version: 1.0
#:***********************************************

if [ 'CpuTotal' = $1 ]
then
    cat /etc/zabbix/scripts/.Total.tmp
    mpstat -P ALL 1 1|grep '^[0-9]'|egrep -v '(CPU)|(all)'|awk 'BEGIN {count=0;}{if(99<$3)count++}END{print count}'>/etc/zabbix/scripts/.Total.tmp &
elif [ 'CpuNumber' = $1 ]
then
    cat /etc/zabbix/scripts/.Number.tmp
    mpstat -P ALL 1 1|grep '^[0-9]'|egrep -v '(CPU)|(all)'|awk 'BEGIN {out=-1;F=1;}{if(99<$3&&F){F=0;out=$2;}}END{print out}'>/etc/zabbix/scripts/.Number.tmp &
else
    echo "Only CpuNumber or CpuTotal is acceptable!"
fi
