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
#write by keanlee in June of 2017
#https://docs.openstack.org/ha-guide/intro-ha.html#stateless-versus-stateful-services

#refer docs: https://mariadb.com/kb/en/mariadb/yum/#installing-mariadb-galera-cluster-with-yum
#http://www.linuxidc.com/Linux/2015-07/119512.htm

#steps 
#memcache no ha 
#http://freeloda.blog.51cto.com/2033581/1280962  for keepalived 

#for selinux open
#semanage port -a -t mysqld_port_t -p tcp 3306

#semanage permissive -a mysqld_t

#Set the Env...
cd $(cd $(dirname $0); pwd)
source ./common.sh ha
yum_repos ha
initialize_env
source ./firewall.sh

#add hostname with ip addr to hosts file 
if [[ $(cat /etc/hosts | grep ${CONTROLLER_IP[0]} | wc -l) -ge 1 ]];then 
    debug "notice" "Skip to add hostname with ip:${CONTROLLER_IP[0]}  to hosts file"
else 
    echo  "${CONTROLLER_IP[0]}   ${CONTROLLER_HOSTNAME[0]}" >>/etc/hosts
fi 

if [[ $(cat /etc/hosts | grep ${CONTROLLER_IP[1]} | wc -l) -ge 1 ]];then
    debug "notice" "Skip to add hostname with ip:${CONTROLLER_IP[1]}  to hosts file"
else
    echo  "${CONTROLLER_IP[1]}   ${CONTROLLER_HOSTNAME[1]}" >>/etc/hosts
fi

if [[ $(cat /etc/hosts | grep ${CONTROLLER_IP[2]} | wc -l) -ge 1 ]];then
    debug "notice" "Skip to add hostname with ip:${CONTROLLER_IP[2]}  to hosts file"
else
    echo  "${CONTROLLER_IP[2]}   ${CONTROLLER_HOSTNAME[2]}" >>/etc/hosts
fi


#------------------------------Galera ----------------------------------------------------------------
function Galera(){

    #SSH-KEYs for controller nodedddd:
    if [[ -e ~/.ssh/id_rsa.pub ]];then
        echo $BLUE the id_rsa.pub file has already exist $NO_COLOR
    else
        echo $BLUE Generating public/private rsa key pair $NO_COLOR
        ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa  1>/dev/null
        #-N "" tells it to use an empty passphrase (the same as two of the enters in an interactive script)
        #-f my.key tells it to store the key into my.key (change as you see fit).
    fi
    
    which sshpass 1>/dev/null 2>&1 || rpm -ivh ${CONFIG_FILE_DIR_HA}/lib/sshpass* 1>/dev/null 2>&1
    echo $BLUE Copying public key to controller hosts:  $NO_COLOR
    if [[ -e  ~/.ssh/known_hosts ]];then
        debug "$?" "The know_hosts file exists"
    else
        touch ~/.ssh/known_hosts
        chmod 644 ~/.ssh/known_hosts
    fi
    
    for ips in ${CONTROLLER_IP[*]};do
        ssh-keyscan $ips >> ~/.ssh/known_hosts;
    done
    
    for hostname in ${CONTROLLER_HOSTNAME[*]};do
        ssh-keyscan $hostname  >> ~/.ssh/known_hosts;
    done
    
    for ips in ${CONTROLLER_IP[*]};do 
        sshpass -p ${PASSWORD_EACH_NODE} ssh-copy-id -i ~/.ssh/id_rsa.pub  $ips;
    done
    
    echo $BLUE Installing  mariadb mariadb-galera-server mariadb-galera-common galera rsync ...$NO_COLOR
    yum install -y  mariadb mariadb-galera-server mariadb-galera-common galera rsync  1>/dev/null
        debug "$?" "install galera  fialed on $(hostname)"
    
    if [[ $(hostname) = ${CONTROLLER_HOSTNAME[0]} ]];then 
        sed -i '/Group=mysql/a\LimitNOFILE=65535' /usr/lib/systemd/system/mariadb.service
        systemctl daemon-reload
        systemctl enable mariadb  1>/dev/null 2>&1
        #chown mysql:mysql /var/lib/mysql/grastate.dat
        #chown mysql:mysql  /var/lib/mysql/galera.cache
        systemctl start mariadb
            debug "$?" "Start mairadb failed on $(hostname)"
        echo $BLUE Set admin password for galera mariadb... $NO_COLOR
    
        mysql_secure_installation 1>/dev/null 2>&1 <<EOF

y
$GALERA_PASSWORD
$GALERA_PASSWORD
y
y
y
y
EOF
            debug "$?" "GALERA admin password configuration failed"
        systemctl stop mariadb
    
        cp -f ${CONFIG_FILE_DIR_HA}/etc/HA/galera.cnf /etc/my.cnf.d/
        sed -i "s/this-host-name/$(hostname)/g" /etc/my.cnf.d/galera.cnf
        sed -i "s/this-host-ip/$MGMT_IP/g"  /etc/my.cnf.d/galera.cnf
        sed -i "s/cluster-nodes/${CONTROLLER_HOSTNAME[0]},${CONTROLLER_HOSTNAME[1]},\
            ${CONTROLLER_HOSTNAME[2]}/g" /etc/my.cnf.d/galera.cnf
    
    #service mysql start --wsrep-new-cluster
    #systemctl start mariadb --wsrep-new-cluster
        echo $BLUE Starting Galera Cluster ...$NO_COLOR
        #systemctl start mariadb --wsrep-new-cluster --user=mysql 1>/dev/null
        /usr/libexec/mysqld --wsrep-new-cluster --user=mysql &  1>/dev/null 2>&1  
            debug "$?" "Start galera cluster on $(hostname) failed "
        sleep 2
        echo $GREEN Finshed Galera Install On ${YELLOW}$(hostname) $NO_COLOR
    else 
        cp -f ${CONFIG_FILE_DIR_HA}/etc/HA/galera.cnf /etc/my.cnf.d/
        sed -i "s/this-host-name/$(hostname)/g" /etc/my.cnf.d/galera.cnf
        sed -i "s/this-host-ip/$MGMT_IP/g"  /etc/my.cnf.d/galera.cnf
        sed -i "s/cluster-nodes/${CONTROLLER_HOSTNAME[0]},${CONTROLLER_HOSTNAME[1]},${CONTROLLER_HOSTNAME[2]}/g"  \
            /etc/my.cnf.d/galera.cnf
        #for each node 
        systemctl enable mariadb  1>/dev/null 2>&1
        sed -i '/Group=mysql/a\LimitNOFILE=65535' /usr/lib/systemd/system/mariadb.service
        systemctl daemon-reload
       
        echo $BLUE Starting mariadb service ...$NO_COLOR
        systemctl start mariadb 
            debug "$?"  "Start mariadb failed on $(hostname)"
        echo $GREEN Finshed Galera Install On ${YELLOW}$(hostname) $NO_COLOR
    fi  
    
    #Debug for galera:
    #check status after install and configure it 
    #mysql -uroot -p${GALERA_PASSWORD} -e "SHOW STATUS LIKE 'wsrep_%';"
    #mysql -uroot -p${GALERA_PASSWORD} -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
    #Individual cluster nodes can stop and be restarted without issue. When a database 
    
    #loses its connection or restarts, the Galera Cluster brings it back into sync once it reestablishes 
    #connection with the Primary Component. In the event that you need to restart the entire cluster, 
    #identify the most advanced cluster node and initialize the Primary Component on that node.
}


function load_balancing(){
    # load-balancing client
    #Generally, we use round-robin to distribute load amongst instances of active/active services. 
    #Alternatively, Galera uses stick-table options to ensure that incoming connection to virtual IP (VIP) are 
    #directed to only one of the available back ends. This helps avoid lock contention and prevent deadlocks, although 
    #Galera can run active/active. Used in combination with 
    #the httpchk option, this ensure only nodes that are in sync with their peers are allowed to handle requests.
    
    yum install xinetd  -y 1>/dev/null 
    
    #Ensure your HAProxy installation is not a single point of failure, 
    #it is advisable to have multiple HAProxy instances running.
    #You can also ensure the availability by other means, using Keepalived or Pacemaker.
    echo $BLUE Installing haproxy keepalived ...$NO_COLOR
    yum install haproxy keepalived  -y 1>/dev/null
    #echo $BLUE Config the haproxy for controller node $NO_COLOR
    cp -f ${CONFIG_FILE_DIR_HA}/etc/HA/haproxy.cfg  /etc/haproxy/
    sed -i "s/<Virtual IP>/${CONTROLLER_VIP}/g"  /etc/haproxy/haproxy.cfg
    
    sed -i "s/controller1-hostname/${CONTROLLER_HOSTNAME[0]}/g"  /etc/haproxy/haproxy.cfg
    sed -i "s/controller2-hostname/${CONTROLLER_HOSTNAME[1]}/g"  /etc/haproxy/haproxy.cfg
    sed -i "s/controller3-hostname/${CONTROLLER_HOSTNAME[2]}/g"  /etc/haproxy/haproxy.cfg
    
    sed -i "s/CONTROLLER1_IP/${CONTROLLER_IP[0]}/g" /etc/haproxy/haproxy.cfg
    sed -i "s/CONTROLLER2_IP/${CONTROLLER_IP[1]}/g" /etc/haproxy/haproxy.cfg
    sed -i "s/CONTROLLER3_IP/${CONTROLLER_IP[2]}/g" /etc/haproxy/haproxy.cfg
    
    
    #Configure the kernel parameter to allow non-local IP binding. 
    #This allows running HAProxy instances to bind to a VIP for failover. 
    #echo $BLUE Config the keepalived for controller $NO_COLOR
    if [[ $(cat /etc/sysctl.conf | grep net.ipv4.ip_nonlocal_bind | wc -l) -eq 0 ]];then
        echo "net.ipv4.ip_nonlocal_bind = 1" >> /etc/sysctl.conf
    fi
    sysctl -p  1>/dev/null
    cp -f ${CONFIG_FILE_DIR_HA}/etc/HA/keepalived.conf /etc/keepalived/
    cp -f ${CONFIG_FILE_DIR_HA}/etc/HA/haproxy-health-check.sh   /etc/keepalived/
    chmod 777 /etc/keepalived/haproxy-health-check.sh

    if [[ $MGMT_IP = ${CONTROLLER_IP[0]} ]];then 
        sed -i "s/ROLEs/MASTER/g"   /etc/keepalived/keepalived.conf
        sed -i "s/priority_nums/${PRIORITY_NUMS[0]}/g" /etc/keepalived/keepalived.conf 
        sed -i "s/controller_peer1/${CONTROLLER_IP[1]}/g" /etc/keepalived/keepalived.conf
        sed -i "s/controller_peer2/${CONTROLLER_IP[2]}/g" /etc/keepalived/keepalived.conf
    elif [[ $MGMT_IP = ${CONTROLLER_IP[1]} ]];then
        sed -i "s/ROLEs/BACKUP/g"   /etc/keepalived/keepalived.conf
        sed -i "s/priority_nums/${PRIORITY_NUMS[1]}/g" /etc/keepalived/keepalived.conf
        sed -i "s/controller_peer1/${CONTROLLER_IP[0]}/g" /etc/keepalived/keepalived.conf
        sed -i "s/controller_peer2/${CONTROLLER_IP[2]}/g" /etc/keepalived/keepalived.conf
    elif [[ $MGMT_IP = ${CONTROLLER_IP[2]} ]];then 
        sed -i "s/ROLEs/BACKUP/g"   /etc/keepalived/keepalived.conf
        sed -i "s/priority_nums/${PRIORITY_NUMS[2]}/g" /etc/keepalived/keepalived.conf
        sed -i "s/controller_peer1/${CONTROLLER_IP[0]}/g" /etc/keepalived/keepalived.conf
        sed -i "s/controller_peer2/${CONTROLLER_IP[1]}/g" /etc/keepalived/keepalived.conf
    fi
    
    sed -i "s/VIP_NETWORK_DEVICE/${MGMT_IP_DEVICE}/g"  /etc/keepalived/keepalived.conf
    sed -i "s/ROUTER_ID/${ROUTER_ID}/g"  /etc/keepalived/keepalived.conf 
    sed -i "s/CONTROLLER_VIP/${CONTROLLER_VIP}/g"  /etc/keepalived/keepalived.conf 
    sed -i "s/LOCAL_IP/${MGMT_IP}/g" /etc/keepalived/keepalived.conf 
    sed -i "s/CIDR_POSTFIX/${CIDR_POSTFIX}/g" /etc/keepalived/keepalived.conf
    #vrrp_script chk_http_port  ADD this next time 
    echo $BLUE Starting the keepalived.service ...  $NO_COLOR
    systemctl enable haproxy  1>/dev/null 2>&1
    systemctl enable keepalived.service 1>/dev/null 2>&1 &&
    systemctl start keepalived.service  &&
        debug "$?" "Start keepalived.service failed "
    sleep 3
    
    HAPROXY_STATUS=$(systemctl status haproxy | grep Active | awk -F ":" '{print $2}' | awk '{print $1}')
    if [[ $HAPROXY_STATUS = "inactive" ]];then 
        debug "warning" "The HA-Proxy has start failed"
    elif [[ $HAPROXY_STATUS = "active" ]];then
        echo $BLUE The HA-Proxy Status: ${GREEN}active $NO_COLOR
    else
        echo $BLUE The HA-Proxy Status: ${YELLOW}${HAPROXY_STATUS} $NO_COLOR
    fi
    
    if [[ $(systemctl status keepalived | grep Active | awk '{print $2}') != "active" ]];then 
        systemctl restart keepalived.service
        sleep 2
    fi
    
    if [[ ${MGMT_IP} == ${CONTROLLER_IP[0]} ]];then
        echo $BLUE Checking the VIP if working: $NO_COLOR
        ping -c 1 ${CONTROLLER_VIP} 1>/dev/null 2>&1
        if [[ $? -ne 0 ]];then 
            debug "notice" "The controller VIP is not working on ${CONTROLLER_IP[0]} !!!"
        else 
            debug "0"
        fi 
    fi
    
    #For Xinetd
    #If you use HAProxy as a load-balancing client to provide access to the Galera Cluster, 
    #as described in the HAProxy, you can use the clustercheck utility to improve health checks.
    #
    mysql -uroot -p$GALERA_PASSWORD -e "GRANT PROCESS ON *.* TO 'clustercheck_user'@'localhost' \
        IDENTIFIED BY 'clustercheck';FLUSH PRIVILEGES;"
    echo > /etc/sysconfig/clustercheck
        cat > /etc/sysconfig/clustercheck <<EOF
MYSQL_USERNAME="clustercheck_user"
MYSQL_PASSWORD="clustercheck"
MYSQL_HOST="localhost"
MYSQL_PORT="3306"
EOF

    #echo $BLUE Create a configuration file for the HAProxy monitor service $NO_COLOR
    echo > /etc/xinetd.d/galera-monitor
    cat > /etc/xinetd.d/galera-monitor <<EOF
service galera-monitor
{
   port = 9200
   disable = no
   socket_type = stream
   protocol = tcp
   wait = no
   user = root
   group = root
   groups = yes
   server = /usr/bin/clustercheck
   type = UNLISTED
   per_source = UNLIMITED
   log_on_success =
   log_on_failure = HOST
   flags = REUSE
}
EOF
    systemctl daemon-reload
    systemctl enable xinetd 1>/dev/null 2>&1
    echo $BLUE Starting the Xinetd service ...$NO_COLOR
    systemctl start xinetd
    if [[ $? -ne 0 ]];then 
        debug "warning"  "The xinetd service has start failed  "
    else 
        debug "0"
    fi
}


#------------------------------------------Gluster FS------------------------------------------------------------------------
function Gluster_FS(){
    #Install glusterfs cluster ...
    echo $BLUE Installing glusterfs-server $NO_COLOR
    yum install glusterfs-server -y 1>/dev/null
        debug "$?" "Install glusterfs-server failed"
    
    systemctl enable glusterd  1>/dev/null 2>&1
    echo $BLUE Starting glusterd  $NO_COLOR
    systemctl start glusterd.service
        debug "$?" "Start glusterd.service failed"
    
    echo $BLUE Creating ${GLUSTERFS_USE_DISK} PV: $NO_COLOR
    pvcreate /dev/${GLUSTERFS_USE_DISK}  1>/dev/null
        debug "$?" "Create ${GLUSTERFS_USE_DISK} PV failed"
    
    echo $BLUE Creating ${GLUSTERFS_USE_DISK} VG: $NO_COLOR
    vgcreate vg_gluster /dev/${GLUSTERFS_USE_DISK} 1>/dev/null 
        debug "$?" "Create ${GLUSTERFS_USE_DISK} VG failed "
    
    echo $BLUE Creating LV: $NO_COLOR
    lvcreate -l 100%FREE -n brick-img vg_gluster  1>/dev/null 
        debug "$?"  "Create LV ${GLUSTERFS_USE_DISK} failed"
       
    echo $BLUE Formatting the /dev/vg_gluster/brick-img: $NO_COLOR
    mkfs.xfs /dev/vg_gluster/brick-img   1>/dev/null 
        debug "$?"  "Format the /dev/vg_gluster/brick-img failed "
    
    echo $BLUE Verifying glusterfs: $NO_COLOR
    if [[ $(lsblk | grep vg_gluster-brick--img | wc -l) -eq 1 ]];then 
        debug "0"
    else 
        debug "warning"  "Verfiy glusterfs failed by command lsblk"
    fi 
    
    echo $BLUE Creating /var/brick-img directoy: $NO_COLOR
    if [[ ! -d  /var/brick-img/ ]];then 
        mkdir -p /var/brick-img
    fi
    
    mount /dev/vg_gluster/brick-img/  /var/brick-img
    if [[ $? -ne 0 ]];then
        debug "warning" "Mount /dev/vg_gluster/brick-img  /var/lib/glance/ failed"
    else
        debug "0"
    fi
    
    echo  /dev/vg_gluster/brick-img /var/brick-img        xfs   defaults  0  0  >> /etc/fstab &&
    #keep 4 weeks backlog only
    sed -i "s/52/4/g"  /etc/logrotate.d/glusterfs
    
    #Create glance use dir
    if [[ ! -d ${GLUSTERFS_SHARE_DIR} ]];then
        mkdir -p  ${GLUSTERFS_SHARE_DIR}
        #chown glance:glance /var/lib/glance/images/
        chmod 777 ${GLUSTERFS_SHARE_DIR}
    else
        #chown glance:glance /var/lib/glance/images/
        chmod 777 ${GLUSTERFS_SHARE_DIR}
    fi
    
    if [[ $(hostname) = ${CONTROLLER_HOSTNAME[2]} ]];then 
        echo $BLUE Configuring the glusterfs trusted pool $NO_COLOR
        gluster peer probe ${CONTROLLER_HOSTNAME[0]}   1>/dev/null
        gluster peer probe ${CONTROLLER_HOSTNAME[1]}   1>/dev/null
        
        echo $BLUE Checking the glusterfs peer status: $NO_COLOR
        if [[ $(gluster peer status | sed -n '1p' | awk '{print $4}') -eq 2 ]];then 
            echo $GREEN Finish glusterfs config on $(hostname) $NO_COLOR
            debug "0"
        else 
            gluster peer status
            debug "warning" "Check the glusterfs peer failed, check above info to debug "
        fi 
    
        echo $BLUE Creating GlusterFS volume on ${CONTROLLER_IP[0]}: $NO_COLOR
        ssh -n root@${CONTROLLER_IP[0]} "gluster volume create vol-1 replica 3 ${CONTROLLER_HOSTNAME[0]}:/var/brick-img/running \
        ${CONTROLLER_HOSTNAME[1]}:/var/brick-img/running ${CONTROLLER_HOSTNAME[2]}:/var/brick-img/running"
        if [[ $? -ne 0 ]];then 
            debug "warning"  "Execute command: gluster volume create vol-1 replica 3  xxx on ${CONTROLLER_IP[0]} failed  "
        else 
            debug "0"
        fi
     
        ssh -n root@${CONTROLLER_IP[0]}  "gluster volume start vol-1"
        if [[ $? -ne 0 ]];then 
            debug "warning"  "gluster volume start vol-1 failed on ${CONTROLLER_IP[0]}"
        else 
            debug "0"
        fi
    
        echo $BLUE Verifying the Gluster volume if running: $NO_COLOR
        if [[ $(gluster volume info all | sed -n '10,12p' | grep ${CONTROLLER_HOSTNAME[0]} | wc -l) -eq 1 ]] && \
            [[ $(gluster volume info all | sed -n '10,12p' | grep ${CONTROLLER_HOSTNAME[1]} | wc -l) -eq 1 ]] && \
                [[ $(gluster volume info all | sed -n '10,12p' | grep ${CONTROLLER_HOSTNAME[2]} | wc -l) -eq 1 ]];then 
            debug "0"
        else 
            debug "warning" "Gluster volume is not running"
        fi 
        
        echo $BLUE Creating share directory on each node:  $NO_COLOR
        ssh -n root@${CONTROLLER_IP[0]} "mount -t glusterfs $(hostname):/vol-1 ${GLUSTERFS_SHARE_DIR}"
        ssh -n root@${CONTROLLER_IP[0]} "echo \"127.0.0.1:vol-1  ${GLUSTERFS_SHARE_DIR} glusterfs \
            defaults,_netdev,noauto,x-systemd.automount 0 0\" >> /etc/fstab"
        
        ssh -n root@${CONTROLLER_IP[1]} "mount -t glusterfs $(hostname):/vol-1 ${GLUSTERFS_SHARE_DIR}"
        ssh -n root@${CONTROLLER_IP[1]} "echo \"127.0.0.1:vol-1  ${GLUSTERFS_SHARE_DIR} glusterfs \
            defaults,_netdev,noauto,x-systemd.automount 0 0\" >> /etc/fstab"
        
        mount -t glusterfs $(hostname):/vol-1 ${GLUSTERFS_SHARE_DIR}
        echo "127.0.0.1:vol-1  ${GLUSTERFS_SHARE_DIR} glusterfs defaults,_netdev,noauto,x-systemd.automount 0 0" >> /etc/fstab
    fi
}


case $1 in 
    galera)
       Galera
       ;;
    load_balancing)
       load_balancing
       ;;
    Gluster_FS)
       Gluster_FS
       ;;
    HA_ALL)
       Galera
       load_balancing
       if [[ $GLANCE_STORAGE_HA = "glusterfs" ]];then 
           Gluster_FS
       fi
       ;;
    *)
       debug "1" " ${YELLOW}$1${RED} is unsupport parameter !!!"
esac 
