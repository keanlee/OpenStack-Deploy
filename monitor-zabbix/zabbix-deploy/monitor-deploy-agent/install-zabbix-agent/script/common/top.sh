#!/bin/sh
#:***********************************************
#:Program: top.sh
#:
#:Author: keanli
#:
#:History: 2017-06-20
#:
#:Version: 1.0
#:***********************************************

cat /etc/zabbix/scripts/.Top.tmp
top -b -n 1 |sed -n '8,9p' | grep -v top | head -n 1 | awk '{if($9>99)print $1; else print 0;}' > /etc/zabbix/scripts/.Top.tmp &
