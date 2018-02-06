#!/bin/bash
#:***********************************************
#:Program: check-process-status-openstack.sh
#:
#:Author: keanli
#:
#:History: 2017-06-20
#:
#:Version: 1.0
#:***********************************************

export OS_PROJECT_DOMAIN_NAME=default
export OS_USER_DOMAIN_NAME=default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=admin
export OS_AUTH_URL={{ OS_AUTH_URL }}
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2

case $1 in
nova)
    process_status=$($1 service-list  | awk -F '|' '{print  $3 $4 $7}' | grep down | awk '{print $2": "$1}')
       if [[ $process_status = "" ]]; then
           echo 1
       else
           echo $process_status
       fi
;;
neutron)
    process_status=$($1 agent-list | awk -F '|' '{print $4 $6 $8 }' | grep xxx | awk '{print $1 ": "$3 }')
       if [[ $process_status = "" ]]; then
               echo 1
       else
               echo $process_status
       fi
;;
cinder)
    process_status=$($1 service-list | awk -F '|' '{print $2 $3 $6}' | grep down | awk '{print $2": "$1}' )
       if [[ $process_status = "" ]]; then
               echo 1
       else
               echo $process_status
       fi
;;
esac
