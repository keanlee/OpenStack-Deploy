#!/bin/bash
#:***********************************************
#:Program: memory.sh
#:
#:Author: keanli
#:
#:History: 2017-06-20
#:
#:Version: 1.0
#:***********************************************

PID=`ps -ef|grep $1|grep -v grep|grep -v $0|awk '{print $2}'`
MEMORY=`top -b -n 1|grep $PID|awk '{print $6}'`

echo $MEMORY'000'
