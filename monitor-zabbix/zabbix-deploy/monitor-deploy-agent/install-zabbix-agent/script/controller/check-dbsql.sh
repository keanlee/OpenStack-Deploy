#!/bin/bash
#:***********************************************
#:Program: check-dbsql.sh
#:
#:Author: lee
#:
#:History: 2017-06-20
#:
#:Version: 1.0
#:***********************************************

serviceExist=`ps -ef|grep mysqld|grep /tmp/mysql.sock  |grep -vE 'grep|mysqld_safe'|awk '{print $2}'`

if [ -z $serviceExist ];then
    echo 0
    exit 0
else
    echo 1
    exit 0
fi
