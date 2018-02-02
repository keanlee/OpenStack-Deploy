#!/bin/bash
HA_PROXY_STATUS=$(ps -C haproxy --no-header | wc -l )

if [[  $HA_PROXY_STATUS -eq 0 ]];then 
    systemctl start haproxy
    sleep 1
    if [[ $HA_PROXY_STATUS -eq 0  ]];then 
        systemctl stop keepalived
    fi
fi 

