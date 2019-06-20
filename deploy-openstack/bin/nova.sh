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

#openStack Compute can scale horizontally on standard hardware, and download images to launch instances
#---------------compute.sh just support controller and compute parameter---------

function nova_controller(){
    #nova for controllrer node 
    cat 2>&1 <<__EOF__
    $MAGENTA=================================================================
          Begin to deploy nova on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA} 
    =================================================================
    $NO_COLOR
__EOF__
    
    database_create nova $NOVA_DBPASS
    database_create nova_api $NOVA_DBPASS
    
    create_service_credentials $NOVA_PASS nova
    
    echo $BLUE Installing openstack-nova-api openstack-nova-conductor $NO_COLOR
    echo $BLUE openstack-nova-console openstack-nova-novncproxy openstack-nova-scheduler ... $NO_COLOR 
    yum install openstack-nova-api openstack-nova-conductor \
        openstack-nova-console openstack-nova-novncproxy \
            openstack-nova-scheduler  -y 1>/dev/null 
        debug_info "Install openstack-nova-api openstack-nova-conductor openstack-nova-console\
            openstack-nova-novncproxy openstack-nova-scheduler "
    
    # Copy nova.conf and edit it ... 
    cp -f ${CONFIG_FILE_DIR}/etc/controller/nova.conf  /etc/nova/ 
    sed -i "s/MY_IP/$MY_IP_CONTROLLER/g" /etc/nova/nova.conf 
    sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" /etc/nova/nova.conf
    sed -i "s/controller/$MGMT_IP/g" /etc/nova/nova.conf
    sed -i "s/NOVA_DBPASS/$NOVA_DBPASS/g" /etc/nova/nova.conf
    sed -i "s/NOVA_PASS/$NOVA_PASS/g" /etc/nova/nova.conf
    
    sed -i "s/NEUTRON_PASS/$NEUTRON_PASS/g"  /etc/nova/nova.conf
    sed -i "s/METADATA_SECRET/$METADATA_SECRET/g" /etc/nova/nova.conf
    
    if [[ ${MGMT_IP} != ${CONTROLLER_IP[0]} ]];then
        debug "notice" "Skip to populate the nova and nova api service database"
    else
        
        echo $BLUE Populating the nova_api databases $NO_COLOR
        su -s /bin/sh -c "nova-manage api_db sync" nova  1>/dev/null 2>&1
            debug "$?" "nova-manage api_db sync failed "
        get_database_size nova_api $NOVA_DBPASS

        echo $BLUE Populating the Nova databases $NO_COLOR
        su -s /bin/sh -c "nova-manage db sync" nova  1>/dev/null 2>&1
            debug_info "nova-manage db sync "
        get_database_size nova $NOVA_DBPASS
        #echo $GREEN Populate nova database success , ignore any deprecation messages in  above output $NO_COLOR
    fi
    
    systemctl enable openstack-nova-api.service \
        openstack-nova-consoleauth.service openstack-nova-scheduler.service openstack-nova-conductor.service \
            openstack-nova-novncproxy.service 1>/dev/null 2>&1 
        debug_info "systemctl enable nova service "
    
    echo $BLUE Starting the openstack nova service on $(hostname) node  $NO_COLOR 
    systemctl start openstack-nova-api.service \
        openstack-nova-consoleauth.service openstack-nova-scheduler.service \
            openstack-nova-conductor.service openstack-nova-novncproxy.service
        debug_info "Start the nova service on $(hostname)"
    
    cat 2>&1 <<__EOF__
    $GREEN=====================================================================
           
      Congratulation you finished to deploy nova on ${YELLOW}$(hostname)${NO_COLOR}${GREEN}
     
    =====================================================================
    $NO_COLOR
__EOF__
}

function nova_compute(){
    #This section describes how to install and configure the Compute service on a compute node
    cat 2>&1 <<__EOF__
    $MAGENTA=======================================================================
       Begin to deploy nova on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA} 
    =======================================================================
    $NO_COLOR
__EOF__
    echo $BLUE Installing openstack-nova-compute ... $NO_COLOR 
    yum install openstack-nova-compute -y 1>/dev/null 
        debug_info "Install openstack-nova-compute "
    # Copy nova.conf and edit it ...  
    cp -f ${CONFIG_FILE_DIR}/etc/compute/nova.conf  /etc/nova
    sed -i "s/COMPUTE_MANAGEMENT_INTERFACE_IP_ADDRESS/$COMPUTE_MANAGEMENT_INTERFACE_IP_ADDRESS/g" /etc/nova/nova.conf
    sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" /etc/nova/nova.conf
    sed -i "s/controller/$CONTROLLER_VIP/g" /etc/nova/nova.conf
    sed -i "s/NOVA_PASS/$NOVA_PASS/g" /etc/nova/nova.conf
    
    #for ha mode
    if [[ ${#CONTROLLER_IP[*]} -eq 3 ]];then 
        # Config the compute service to use the rabbitmq cluster and memcached 
    #RabbitMQ
        sed -i '/^transport_url.*/d' /etc/nova/nova.conf
        sed -i "/rabbitmq-config/a\transport_url = rabbit://openstack:RABBIT_PASS@rabbit1:5672,\
            openstack:RABBIT_PASS@rabbit2:5672,openstack:RABBIT_PASS@rabbit3:5672" /etc/nova/nova.conf
        sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" /etc/nova/nova.conf 
        sed -i "s/rabbit1/${CONTROLLER_IP[0]}/g" /etc/nova/nova.conf
        sed -i "s/rabbit2/${CONTROLLER_IP[1]}/g" /etc/nova/nova.conf
        sed -i "s/rabbit3/${CONTROLLER_IP[2]}/g" /etc/nova/nova.conf
    #Memcache
        sed -i '/^memcached_servers*/d' /etc/nova/nova.conf
        sed -i "/Memcache/a\Memcached_servers = controller1:11211,controller2:11211,controller3:11211"   /etc/nova/nova.conf 
        sed -i "s/controller1/${CONTROLLER_IP[0]}/g" /etc/nova/nova.conf
        sed -i "s/controller2/${CONTROLLER_IP[1]}/g" /etc/nova/nova.conf
        sed -i "s/controller3/${CONTROLLER_IP[2]}/g" /etc/nova/nova.conf
    fi 
    
    if [[ $(egrep -c '(vmx|svm)' /proc/cpuinfo) = 0 ]];then 
        debug "warning" "Your compute node does not support hardware acceleration and configure libvirt to use QEMU instead of KVM "
        sed -i "/\[libvirt\]/a\virt_type\ =\ qemu" /etc/nova/nova.conf
    fi 
    
    echo $BLUE Starting libvirtd.service openstack-nova-compute.service ...$NO_COLOR
    systemctl enable libvirtd.service openstack-nova-compute.service  1>/dev/null 2>&1
    systemctl start libvirtd.service openstack-nova-compute.service  
        debug_info "Start libvirtd or openstack-nova-compute "
    
    
    if [[ ${NOVA_STOREAGE_HA} = "ceph" ]];then 
        debug "notice" "Since use ceph as share storage ,so no need to configure nova ssh-key" 
    else 
        #SSH-KEYs for compute node:
        if [[ -e ~/.ssh/id_rsa.pub ]];then
            debug "notice" "The id_rsa.pub file has already exists"
        else
            echo $BLUE Generating public/private rsa key pair $NO_COLOR
            ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa  1>/dev/null
            #-N "" tells it to use an empty passphrase (the same as two of the enters in an interactive script)
            #-f my.key tells it to store the key into my.key (change as you see fit).
        fi

        which sshpass 1>/dev/null 2>&1 || rpm -ivh ${CONFIG_FILE_DIR}/lib/sshpass* 1>/dev/null 2>&1
        echo $BLUE Copying public key to compute hosts:  $NO_COLOR
        if [[ -e  ~/.ssh/known_hosts ]];then
            debug "notice" "The know_hosts file exists "
        else
            touch ~/.ssh/known_hosts
            chmod 644 ~/.ssh/known_hosts
        fi
        
        for ips in ${COMPUTE_NODE_IP[*]};do
            ssh-keyscan $ips >> ~/.ssh/known_hosts;
        done
        
        for ips in ${COMPUTE_NODE_IP[*]};
           do sshpass -p ${PASSWORD_EACH_NODE} ssh-copy-id -i ~/.ssh/id_rsa.pub  $ips;
        done
           debug "$?"  "Configure root ssh-key for each compute node failed "
        
        if [[ -d /var/lib/nova/ ]];then 
            chown -R nova:nova /var/lib/nova/ 
        fi
        
        #ssh-key for nova
        usermod -s /bin/bash nova
        su nova  <<EOF
mkdir -p -m 700 /var/lib/nova/.ssh;
cd /var/lib/nova/.ssh;
echo 'Host *' >> /var/lib/nova/.ssh/config;
echo 'StrictHostKeyChecking no' >> /var/lib/nova/.ssh/config;
echo 'UserKnownHostsFile=/dev/null' >> /var/lib/nova/.ssh/config;
ssh-keygen -f id_rsa -b 1024 -P ""  1>/dev/null;
exit
EOF
        if [[ ${MGMT_IP} = ${COMPUTE_NODE_IP[${#COMPUTE_NODE_IP[*]}-1]} ]];then 
            echo $BLUE Configure VM migrate nova SSH ... $NO_COLOR
            for ips in ${COMPUTE_NODE_IP[*]};do 
                scp /var/lib/nova/.ssh/id_rsa.pub root@${ips}:/var/lib/nova/.ssh/authorized_keys;
                scp /var/lib/nova/.ssh/* root@${ips}:/var/lib/nova/.ssh/;
            done
            chown -R nova:nova /var/lib/nova/;
            chmod 700 /var/lib/nova/.ssh;chmod 600 /var/lib/nova/.ssh/authorized_keys
            for ips in ${COMPUTE_NODE_IP[*]};do   
            ssh -n root@${ips} "for ips in ${COMPUTE_NODE_IP[*]};do scp /var/lib/nova/.ssh/id_rsa.pub root@${ips}:/var/lib/nova/.ssh/\
                authorized_keys;scp /var/lib/nova/.ssh/* root@${ips}:/var/lib/nova/.ssh/;done;chown -R nova:nova /var/lib/nova/;chmod \
                    700 /var/lib/nova/.ssh;chmod 600 /var/lib/nova/.ssh/authorized_keys"
            done
                debug "$?" "Configure VM migrate nova SSH Failed "
        fi
    
    fi	
    
    #add ceph support here 
    if [[ ${NOVA_STOREAGE_HA} = "ceph" ]];then 
        echo $BLUE Nova will use ceph as the backend storage $NO_COLOR 
        echo $BLUE Installing the ceph ...$NO_COLOR 
        yum install ceph -y 1>/dev/null
            debug "$?" "install ceph failed !!! Did you have add the ceph repo ?"
        echo $BLUE Copy the ceph config file $NO_COLOR 
        cp -f ${CONFIG_FILE_DIR}/etc/ceph/* /etc/ceph/
        chown -R ceph.ceph /etc/ceph
        chmod -R 755 /etc/ceph
        virsh secret-define --file /etc/ceph/secret.xml
        virsh secret-set-value --secret $(awk 'BEGIN{ RS=">|</"}NR%2' /etc/ceph/secret.xml | sed -n '2p') --base64 \
            $(cat /etc/ceph/ceph.client.admin.keyring | grep key | awk '{print $3}')
        
        echo $BLUE Change the nova conf to work with ceph backend $NO_COLOR 
        sed -i "/\[libvirt\]/arbd_secret_uuid = $(awk 'BEGIN{ RS=">|</"}NR%2' /etc/ceph/secret.xml | sed -n '2p')"  /etc/nova/nova.conf
        sed -i "/\[libvirt\]/arbd_user = ${RDB_STORE_NOVA_USER}"   /etc/nova/nova.conf
        sed -i "/\[libvirt\]/aimages_rbd_ceph_conf=/etc/ceph/ceph.conf"  /etc/nova/nova.conf
        sed -i "/\[libvirt\]/aimages_rbd_pool=${RDB_STORE_NOVA_POOL}"  /etc/nova/nova.conf
        sed -i "/\[libvirt\]/aimages_type=rbd"  /etc/nova/nova.conf
       
        systemctl restart libvirtd.service openstack-nova-compute.service
            debug "$?" "Restart libvirtd or openstack-nova-compute failed after add ceph as backend storage"
    fi


    cat 2>&1 <<__EOF__
    $GREEN=========================================================================================
       
        Congratulation you finished to deploy nova on ${YELLOW}$(hostname)${NO_COLOR}${GREEN}
 
    You can go to controller node to verify it by <openstack compute service list> command
    =========================================================================================
    $NO_COLOR
__EOF__
}



case $1 in
controller)
    nova_controller
    ;;
compute)
    nova_compute
    ;;
*)
    debug "1" "compute.sh just support controller and compute parameter, your $1 is not support "
    ;;
esac 
