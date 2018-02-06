#!/bin/sh
#:***********************************************
#:Program: check processexist
#:
#:Author: keanli
#:
#:History: 2017-06-20
#:
#:Version: 1.0
#:***********************************************

let processNumber=0

if [ $# = 0 -o $# -gt 3 ]; then
    echo "wrong parameters number, it should be [1~3], \$1 should be service name "
    exit 0
fi

if [ 1 = $# ]; then
    processNumber=`ps -ef | grep $1 |wc -l`
    processNumber=`expr $processNumber - 3`
elif [ 2 = $# ]; then
    processNumber=`ps -ef | grep $1 | grep $2 |wc -l`
    processNumber=`expr $processNumber - 2`
else
    processNumber=`ps -ef | grep $1 | grep $2 | grep $3 |wc -l`
    processNumber=`expr $processNumber - 2`
fi

if [ $processNumber -gt 0 ]; then
    processNumber=1
fi

echo $processNumber
