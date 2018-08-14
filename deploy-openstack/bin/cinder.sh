#!/bin/bash 
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License
#

#will add ceph support later 

function cinder_controller(){
    cat 2>&1 <<__EOF__
    $MAGENTA=============================================================================
       Begin to deploy Cinder on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA} 
    =============================================================================
    $NO_COLOR
__EOF__

    database_create  cinder $CINDERDB_PASS
    
    create_service_credentials $CINDER_PASS cinder 
    
    echo $BLUE Installing openstack-cinder on ${YELLOW}$(hostname)$NO_COLOR 
    yum install openstack-cinder -y  1>/dev/null 
        debug "$?" "Install openstack-cinder on ${YELLOW}$(hostname)$NO_COLOR $RED failed "
    
    #copy the cinder conf file and edit it 
    cp -f ${CONFIG_FILE_DIR}/etc/controller/cinder.conf  /etc/cinder 
    sed -i "s/controller/$MGMT_IP/g"   /etc/cinder/cinder.conf
    sed -i "s/RABBIT_PASS/$RABBIT_PASS/g"  /etc/cinder/cinder.conf
    sed -i "s/MY_IP/${MGMT_IP}/g"   /etc/cinder/cinder.conf
    sed -i "s/CINDER_DBPASS/$CINDERDB_PASS/g"  /etc/cinder/cinder.conf
    sed -i "s/CINDER_PASS/$CINDER_PASS/g"  /etc/cinder/cinder.conf
    
    if [[ ${MGMT_IP} != ${CONTROLLER_IP[0]} ]];then
        debug "notice"  "Skip to populate the block service database"
    else
        echo $BLUE Populating the Block Storage database ... $NO_COLOR 
        su -s /bin/sh -c "cinder-manage db sync" cinder  1>/dev/null 2>&1
        get_database_size cinder $CINDERDB_PASS
            debug "$?"  "Populate the Block Storage database failed "
    #  echo $GREEN populate the cinder database success ! Ignore any deprecation messages in above output $NO_COLOR 
    fi
    
    systemctl enable openstack-cinder-api.service openstack-cinder-scheduler.service  \
        openstack-cinder-backup.service 1>/dev/null 2>&1 
    echo $BLUE Starting openstack-cinder-api.service openstack-cinder-scheduler.service  \
        openstack-cinder-backup.service
    systemctl start openstack-cinder-api.service openstack-cinder-scheduler.service  \
        openstack-cinder-backup.service
        debug "$?" "start openstack-cinder-api or cinder-scheduler failed "
    
    cat 2>&1 <<__EOF__
    $GREEN=====================================================================================
     
          Congratulation you finished to deploy Cinder on ${YELLOW}$(hostname)${NO_COLOR}${GREEN}
    =====================================================================================
    $NO_COLOR
__EOF__
}


function cinder_compute(){
    cat 2>&1 <<__EOF__
    $MAGENTA=====================================================================
        Begin to deploy Cinder on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA} 
    =====================================================================
    $NO_COLOR
__EOF__

    echo $BLUE Installing lvm2  $NO_COLOR
    yum install lvm2 -y 1>/dev/null
    #echo $BLUE Your partitions is below:   $NO_COLOR 
    #echo $BLUE Partitioned disk: $NO_COLOR 
    #cat /proc/partitions | awk '{print $4}' | sed -n '3,$p' | grep "[a-z]$"
    systemctl enable lvm2-lvmetad.service   1>/dev/null 2>&1
    systemctl start lvm2-lvmetad.service
        debug "$?" "start lvm2-lvmetad failed "
    #PARTITION=sde
    for disk in ${PARTITION[*]};do
       echo $BLUE Creating the LVM physical volume /dev/$disk: $NO_COLOR 
       pvcreate /dev/$disk   1>/dev/null
            debug "$?" "pvcreate /dev/$disk failed "
    
       echo $BLUE Creating the LVM volume group cinder-volumes: $NO_COLOR
       vgcreate cinder-volumes /dev/$disk  1>/dev/null
           debug "$?"  "vgcreate cinder-volumes /dev/$disk failed"
    
    #Each item in the filter array begins with a for accept or r for reject and includes a regular expression for the device name. 
    #The array must end with r/.*/ to reject any remaining devices. You can use the vgs -vvvv command to test filters
    #refer https://docs.openstack.org/newton/install-guide-rdo/cinder-storage-install.html
       sed -i "/\# Configuration option devices\/dir./a\        filter = [ \"a/${disk}/\", \"r/.*/\"]"  /etc/lvm/lvm.conf
    done 
    
    echo $BLUE Installing openstack-cinder targetcli python-keystone ... $NO_COLOR
    yum install openstack-cinder targetcli python-keystone -y 1>/dev/null
        debug "$?" "Install openstack-cinder targetcli python-keystone failed "
    
    #echo $BLUE Copy cinder.conf and edit it $NO_COLOR 
    cp -f ${CONFIG_FILE_DIR}/etc/compute/cinder.conf  /etc/cinder
    sed -i "s/controller/$CONTROLLER_VIP/g"   /etc/cinder/cinder.conf
    sed -i "s/RABBIT_PASS/$RABBIT_PASS/g"  /etc/cinder/cinder.conf
    sed -i "s/LOCAL_MGMT_IP/${BLOCK_IP}/g"  /etc/cinder/cinder.conf
    sed -i "s/CINDER_DBPASS/$CINDERDB_PASS/g"  /etc/cinder/cinder.conf
    sed -i "s/CINDER_PASS/$CINDER_PASS/g"   /etc/cinder/cinder.conf
    
    #for ha mode
    if [[ ${#CONTROLLER_IP[*]} -eq 3 ]];then
        #Config the cinder volume service to use the rabbitmq cluster and memcached 
    #RabbitMQ
        sed -i '/^transport_url.*/d' /etc/cinder/cinder.conf
        sed -i "/rabbitmq-config/a\transport_url = rabbit://openstack:RABBIT_PASS@rabbit1:5672,openstack:RABBIT_PASS\
            @rabbit2:5672,openstack:RABBIT_PASS@rabbit3:5672" /etc/cinder/cinder.conf
        sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" /etc/cinder/cinder.conf
        sed -i "s/rabbit1/${CONTROLLER_IP[0]}/g" /etc/cinder/cinder.conf
        sed -i "s/rabbit2/${CONTROLLER_IP[1]}/g" /etc/cinder/cinder.conf
        sed -i "s/rabbit3/${CONTROLLER_IP[2]}/g" /etc/cinder/cinder.conf
    #Memcache
        sed -i '/^memcached_servers*/d' /etc/cinder/cinder.conf
        sed -i "/Memcache/a\Memcached_servers = controller1:11211,controller2:11211,controller3:11211"  /etc/cinder/cinder.conf
        sed -i "s/controller1/${CONTROLLER_IP[0]}/g"  /etc/cinder/cinder.conf
        sed -i "s/controller2/${CONTROLLER_IP[1]}/g"  /etc/cinder/cinder.conf
        sed -i "s/controller3/${CONTROLLER_IP[2]}/g"  /etc/cinder/cinder.conf
    fi
    
    systemctl enable openstack-cinder-volume.service target.service  1>/dev/null 2>&1
    systemctl start openstack-cinder-volume.service target.service
        debug "$?"  "start openstack-cinder-volume.service target.service failed "
    
    cat 2>&1 <<__EOF__
    $GREEN=====================================================================================
           
    Congratulation you finished to deploy Cinder on ${YELLOW}$(hostname)${NO_COLOR}${GREEN}
      You can go to controller node to Verify by <openstack volume service list> 
    
    =====================================================================================
    $NO_COLOR
__EOF__
}

case $1 in
controller)
    cinder_controller
    ;;
compute)
    cinder_compute
    ;;
*)
    debug "1" "cinder.sh just support controller and compute parameter, your $1 is not support "
    ;;
esac
