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
#This script will prepare the env for install openstack 
#Include function ntp mysql rabbitmq memcache  

function variable_set(){
    ########################################################################################################################################### 
    ########################################################################################################################################### 
    ########################################################################################################### 
    # 
    # 
    #---------------The below config info is option for change-----------------------------  
    # 
    # 
    ########################################################################################################### 
    # ansi colors for formatting heredoc
    ESC=$(printf "\e")
    GREEN="$ESC[0;32m"
    NO_COLOR="$ESC[0;0m"
    RED="$ESC[0;31m"
    MAGENTA="$ESC[0;35m"
    YELLOW="$ESC[0;33m"
    BLUE="$ESC[0;34m"
    WHITE="$ESC[0;37m"
    #PURPLE="$ESC[0;35m"
    CYAN="$ESC[0;36m"
    
    
    #The VARIABLE file DIR 
    THE_VARIABLE_DIR=$(find / -name 'VARIABLE_DIR')
    CONFIG_FILE_DIR_HA=..
    CONFIG_FILE_DIR=.
    source $(find / -name 'VARIABLE')
    
    
    
    #set the rabbitmq host IP and password as below  
    RABBIT_HOSTS=$(ip addr show $MGMT_IP_DEVICE | grep 'inet[^6]' | sed -n '1p' | awk '{print $2}' | awk -F "/" '{print $1}') 
    RABBIT_PASS=rabbitmqpass
     
    #----------------------------------KEEPALIVED----------------------------
    #router id for the keepavlied  
    #The range is: 1-255 
    ROUTER_ID=123 
    PRIORITY_NUMS=(100 67 45)
    
    #--------------------Keystone ------------------
    #set keystone database password 
    KEYSTONE_DBPASS=keystone_dbpassword
    
    if [[ ${CONTROLLER_VIP} = "" ]];then 
        CONTROLLER_VIP=${CONTROLLER_IP[0]}
    fi
    
    #set mariadb password
    MARIADB_PASSWORD=galera_admin
    
    #--------------------the admin password 
    DEMO_PASS=demo
    
    #for ntp server USE only
    #for future use ...
    ALLOW_IP_RANGES=
    ALLOW_IP_NETMASK=
    
    #-----------------Glance------------- 
    #glance database password 
    GLANCE_DBPASS=glancedb 
     
    #glance password use for keystone 
    GLANCE_PASS=glance 
    
    
    #Which dir you want to it's as the share foloder    for the glusterfs setup use                ------------------------
    GLUSTERFS_SHARE_DIR=/var/lib/glance/images/
    #------------------------------------------------------------------------------------------
    
     
    #-----------------Nova for controller node -------- 
    #both nova and nova_api database use this 
    NOVA_DBPASS=novadb 
     
    #nova pass for keystone  
    NOVA_PASS=novapass 
    
    #The block block interface,Default:MGMT_IP_DEVICE
    BLOCK_IP_DEVICE=${MGMT_IP_DEVICE}
    
    #nova.conf need my_ip  
    #In the [DEFAULT] section, configure the my_ip option to use the management interface IP address of the controller node 
    #my_ip here: 
    MY_IP_CONTROLLER=$(ip addr show $MGMT_IP_DEVICE | grep 'inet[^6]' | sed -n '1p' | awk '{print $2}' | awk -F "/" '{print $1}') 
     
    #--------------------Neutron --------------------------- ----------- 
    NEUTRON_DBPASS=neutrondb 
    NEUTRON_PASS=neutron 
    
    #option OVS or linux-bridge
    #so far not support linux-bridge
    NEUTRON_L2_AGENT=OVS
    
     
    #Edit the /etc/neutron/metadata_agent.ini  
    METADATA_SECRET=02fwtwkpweglbw 
     
     
    #--------------------Cinder for controller  
    CINDERDB_PASS=cinderdb 
    CINDER_PASS=cinderpass 
     
    #---------------Controller HA proxy ----------- 
    
    #This section will be update later 
    
    #galera config here
    GALERA_PASSWORD=${MARIADB_PASSWORD}
    
    #------------------------------optional for edit -----------------------
    #openvswitch 
    #which bridge name you want to create 
    #For example: br-tun - tunnel bridge (vxlan or gre)
    #             br-int - integration bridge 
    #             br-ex  - external bridge
    
    #no need to change this 
    br_provider=br-ex
    
    #MGMT_IP is both controller and all slave node management ip 
    MGMT_IP=$(ip addr show $MGMT_IP_DEVICE | grep 'inet[^6]' | sed -n '1p' | awk '{print $2}' | awk -F "/" '{print $1}')
    
    PRIVATE_IP=$(ip addr show ${PRIVATE_IP_DEVICE} | grep 'inet[^6]' | sed -n '1p' | awk '{print $2}' | awk -F "/" '{print $1}')
    
    BLOCK_IP=$(ip addr show ${BLOCK_IP_DEVICE} | grep 'inet[^6]' | sed -n '1p' | awk '{print $2}' | awk -F "/" '{print $1}')
    #-----------------------------------notice------------------------------------
    #Recommend you generate them using <openssl rand -hex 10>  command 
    
    #-------------------------------------nova compute node ------------------------------------------------------
    COMPUTE_MANAGEMENT_INTERFACE_IP_ADDRESS=$(ip addr show $MGMT_IP_DEVICE | grep 'inet[^6]' | sed -n '1p' | awk '{print $2}' | awk -F "/" '{print $1}')
    
    
    #-----------------Heat -------------------------------------
    HEAT_DBPASS=heatdbpass
    HEAT_PASS=heatpas
    HEAT_DOMAIN_PASS=heatdomainpas
}

#-----------------------------------------------------------------------------------
#
#-------------------------function is all below ------------------------------------
#
#-----------------------------------------------------------------------------------

#-----------------------------yum repos configuration ---------------------------
function yum_repos(){
    if [[ ${OS_REPO_USE_DEFAULT} = "true" ]];then
        if [[ ! -d /etc/yum.repos.d/bak/ ]];then
            mkdir /etc/yum.repos.d/bak/
        fi
        mv /etc/yum.repos.d/* /etc/yum.repos.d/bak/  1>/dev/null 2>&1
    fi
    cp -f ${THE_VARIABLE_DIR}/repos/* /etc/yum.repos.d/ 1>/dev/null 
    yum clean all 1>/dev/null 2>1&
    echo $BLUE Configuration YUM Repo $NO_COLOR
}

function debug_info() {
    if [[ $? -ne 0 ]]; then
        echo ${RED}ERROR -\> $1 ${NO_COLOR}
        echo $RED   -----------------------------------------------------\>  FAILED $NO_COLOR
        #wechat_alert "" "$1 failed"
        exit 1
    else
        echo ${GREEN}INFO -\> $1 ${NO_COLOR}
        echo $GREEN -----------------------------------------------------\>  SUCCEEDED $NO_COLOR
    fi
}


function debug(){
    #print exit reason to help debug
    if [[ $1 = "warning" ]];then
        echo $YELLOW -----------------------------------------------------\> WARNING $NO_COLOR
        echo $YELLOW WARNING:  $2 $NO_COLOR
    elif [[ $1 = 0 ]];then
        echo $GREEN -----------------------------------------------------\>  SUCCEEDED $NO_COLOR
    elif [[ $1 = "info" ]] || [[ $1 = "notice" ]];then
        echo $CYAN INFO:  $2 $NO_COLOR
    else
        echo $RED   -----------------------------------------------------\>  FAILED $NO_COLOR
        echo $RED ERROR:  $2 $NO_COLOR
        #wechat_alert "" "$2" "$3"
        exit 1
    fi
}


#---------------------------initialize env ------------------------------------
function initialize_env(){
    #----------------disable selinux-------------------------
    cat 2>&1 <<__EOF__
    $MAGENTA==========================================================
                Begin to initialize env ...
    ==========================================================
    $NO_COLOR
__EOF__
    
    if [[ $(cat /etc/selinux/config | sed -n '7p' | awk -F "=" '{print $2}') = "enforcing" ]];then 
         echo $BLUE Disable selinux $NO_COLOR
         sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
         echo $GREEN Disable the selinux by config file $NO_COLOR
    else
         debug "notice" "The Selinux has been change to disable on the config file on $(hostname)"
    fi    
    
    if [[ $(getenforce) = "Enforcing" ]];then
        setenforce 0 
        echo $GREEN The current selinux Status:$NO_COLOR $YELLOW $(getenforce) $NO_COLOR 
    fi
    
    #which gzexe 1>/dev/null 2>&1 && yum erase gzexe -y 1>/dev/null  2>&1
    systemctl status NetworkManager 1>/dev/null 2>&1
    if [[ $? = 0 ]];then
        echo $BLUE Uninstall NetworkManager ... $NO_COLOR
        systemctl stop NetworkManager 1>/dev/null 2>&1
        yum erase NetworkManager  -y 1>/dev/null 2>&1
    else 
        debug "notice" "No NetworkManager Installed on $(hostname)"
    fi
    
    which firewall-cmd  1>/dev/null 2>&1 &&
    echo $BLUE Uninstall firewalld ...$NO_COLOR
    yum erase firewalld* -y 1>/dev/null 2>&1
}


function common_packages(){
    echo $BLUE Installing openstack-selinux and  python-openstackclient ...$NO_COLOR
    #RHEL and CentOS enable SELinux by default. Install the openstack-selinux package to automatically manage security policies for OpenStack services
    yum install openstack-selinux python-openstackclient -y 1>/dev/null
        debug "$?" "$RED Install openstack-selinux python-openstackclient failed $NO_COLOR"
    
}


#--------------------------------------ntp server --------------------------------
function ntp(){
    cat 2>&1 <<__EOF__
    $MAGENTA==========================================================
                Begin to delpoy ntp
    ==========================================================
    $NO_COLOR
__EOF__
    echo $BLUE Installing ntp ... $NO_COLOR
    yum install ntp -y  1>/dev/null
        debug "$?" "Install ntp failed, please check your yum repos"
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 1>/dev/null 2>&1
    hwclock --systohc
    if [[ $1 = "server" ]];then 
        cp -f  ${THE_VARIABLE_DIR}/etc/ntp.conf  /etc
        sed -i "s/NTP-SERVER-IP/$NTP_SERVER_IP/g" /etc/ntp.conf
        sed -i "s/IP-ADDR/$ALLOW_IP_RANGES/g" /etc/ntp.conf
        sed -i "s/NETMASK-ADDR/$ALLOW_IP_NETMASK/g" /etc/ntp.conf
        ntpdate ntp1.aliyun.com 1>/dev/null
    else 
        sed -i "/server 0.centos.pool.ntp.org iburst/d" /etc/ntp.conf
        sed -i "/server 1.centos.pool.ntp.org iburst/d" /etc/ntp.conf
        sed -i "/server 2.centos.pool.ntp.org iburst/d" /etc/ntp.conf
        sed -i "/server 3.centos.pool.ntp.org iburst/d" /etc/ntp.conf
        sed -i "21 i server $NTP_SERVER_IP iburst " /etc/ntp.conf
        if [[ $(ps -ef | grep ntpd | grep -v grep | wc -l) -ge 1 ]];then
            systemctl stop ntpd.service
            ntpdate $NTP_SERVER_IP 1>/dev/null
            if [[ $? -ne 0 ]];then 
                debug "warning" "The ntp sync time from ntp server failed"
            fi
        else
            ntpdate $NTP_SERVER_IP 1>/dev/null
            if [[ $? -ne 0 ]];then
                debug "warning" "The ntp sync time from ntp server failed"
            fi
        fi
    fi
    
    systemctl enable ntpd.service 1>/dev/null 2>&1  
    
    echo $BLUE Starting the ntpd.service $NO_COLOR
    systemctl start ntpd.service
        debug "$?" "start ntpd.service failed "
}

#-----------------------------DNS server ----------------------------------
function dns_server(){
    echo > ./resolv.conf
        cat > ./resolv.conf <<EOF
#Auto create this file by keanlee's script
nameserver      $DNS_SERVER 
EOF
    mv -f ./resolv.conf /etc
}

#----------------------------------------mariadb install ------------------------------------------------
function mysql_configuration(){
    #change password if forgot mysql password
    cat 2>&1 <<__EOF__
    $MAGENTA==========================================================
                Begin to delpoy Mariadb
    ==========================================================
    $NO_COLOR
__EOF__
    
    echo $BLUE Beginning configuration mysql for controller node on $YELLOW $(hostname) $NO_COLOR
    # set the bind-address key to the management IP address of the controller node to enable access by other nodes via the management network
    # refer https://docs.openstack.org/newton/install-guide-rdo/environment-sql-database.html
    echo $BLUE Installing mariadb mariadb-server python2-PyMySQL $NO_COLOR
    yum install mariadb mariadb-server python2-PyMySQL  mysql-devel -y 1>/dev/null 
        debug "$?" "$RED Install mariadb mariadb-server python2-PyMySQL failed $NO_COLOR"   
echo > /etc/my.cnf.d/openstack.cnf
    cat > /etc/my.cnf.d/openstack.cnf <<EOF
[mysqld]
bind-address = $MGMT_IP
default-storage-engine = innodb
innodb_file_per_table
max_connections=4096
collation-server = utf8_general_ci
character-set-server = utf8
init-connect = 'SET NAMES utf8'
EOF
    systemctl enable mariadb.service 1>/dev/null 2>&1 && 
    systemctl start mariadb.service
    sed -i '/Group=mysql/a\LimitNOFILE=65535' /usr/lib/systemd/system/mariadb.service
    systemctl daemon-reload
    systemctl restart mariadb.service
    
    echo $BLUE Set admin password for mariadb... $NO_COLOR
    mysql_secure_installation 1>/dev/null 2>&1 <<EOF

y
$MARIADB_PASSWORD
$MARIADB_PASSWORD
y
y
y
y
EOF
        debug "$?" "Mysql configuration failed"
    echo $GREEN Finished the Mariadb install and configuration on $YELLOW $(hostname) $NO_COLOR 
}


#------------------------------------------Database size -----------------------------
function get_database_size(){
    #$1 as the database name 
    #$2 as the database password 
    #For example get_database_size nova novadb
    if [[ $# != 2 ]];then
        echo $RED This function need to two parameter $NO_COLOR
    exit 1
    fi
    
    if [[ $1 = nova_api ]];then
        DB_SIZE=$(mysql -unova -p$2 -e "show databases;use information_schema;\
    select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data from TABLES where table_schema='nova_api';" )
    else
        DB_SIZE=$(mysql -u$1 -p$2 -e "show databases;use information_schema;\
    select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data from TABLES where table_schema='$1';" )
    fi
    
    if [[ $1 = nova || $1 = nova_api  ]];then
        local NUMS=6
    else
        local NUMS=5
    fi
    
    echo -n $BLUE The database $YELLOW${1}${BLUE} size is: $NO_COLOR 
    echo $DB_SIZE  | awk  '{print $'$NUMS'}' 
}



#-------------------------------------database create function --------------------------
function database_create(){
    #create database and user in mariadb for openstack component
    #How to invoke this function? 
    #$1 is the database name (comonent name and usename) 
    #$2 is password of database
    DATABASE_NAME=$(mysql -uroot -p$MARIADB_PASSWORD -e "show databases" | grep $1 | wc -l)
    if [[ ${DATABASE_NAME} -ge 1 ]];then 
        debug "notice" "The database $1 exists, so skip create database"
    else
        echo $BLUE Create $YELLOW$1$BLUE database in mariadb  $NO_COLOR
        local USER=$1
            if [[ $1 = nova_api ]];then
                USER=nova
    fi 
    
    mysql -uroot -p$MARIADB_PASSWORD -e "CREATE DATABASE $1;GRANT ALL PRIVILEGES ON $1.* TO '$USER'@'localhost' \
        IDENTIFIED BY '$2';GRANT ALL PRIVILEGES ON $1.* TO '$USER'@'%'  IDENTIFIED BY '$2';flush privileges;"  
            debug "$?" "Create database $1 Failed "
    fi
}


#-------------------------------rabbitmq install ----------------------------------------------
function rabbitmq_configuration(){
    cat 2>&1 <<__EOF__
    $MAGENTA==========================================================
                Begin to delpoy RabbitMQ 
    ==========================================================
    $NO_COLOR
__EOF__
    
    #RABBIT_P 
    #Except Horizone and keystone ,each component need connect to Rabbitmq 
    echo $BLUE Installing rabbitmq-server ... $NO_COLOR
    yum install rabbitmq-server  -y 1>/dev/null
        debug "$?" "$RED Install rabbitmq-server failed $NO_COLOR"
    systemctl enable rabbitmq-server.service 1>/dev/null 2>&1 && 
    
    if [[ $(cat /etc/hosts | grep $(hostname) | wc -l) -ge 1 ]];then 
        debug "notice"  "Skip to add host name with ip addr to hosts file"
    else
        echo "${MGMT_IP} $(hostname)" >>/etc/hosts
    fi 
    echo $BLUE Starting rabbitmq-server.service $NO_COLOR
    systemctl start rabbitmq-server.service
        debug "$?" "Start rabbitmq-server.service Faild, Did you edit the /etc/hosts correct ? "
    
    if [[ ${#CONTROLLER_IP[*]} -eq 3 ]] && [[ ${MGMT_IP} != ${CONTROLLER_IP[0]} ]];then
        echo $BLUE Rabbitmq cluster deploying ... $NO_COLOR
        scp root@${CONTROLLER_IP[0]}:/var/lib/rabbitmq/.erlang.cookie  /var/lib/rabbitmq/   1>/dev/null  &&
        chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
        chmod 400 /var/lib/rabbitmq/.erlang.cookie   &&
        systemctl restart rabbitmq-server.service
        rabbitmqctl stop_app   1>/dev/null  &&
        rabbitmqctl reset   1>/dev/null  &&
        rabbitmqctl join_cluster rabbit@${CONTROLLER_HOSTNAME[0]}  1>/dev/null  &&
        rabbitmqctl start_app  1>/dev/null
        if [[ ${MGMT_IP} = ${CONTROLLER_IP[2]} ]];then 
            echo $BLUE Set the ha-mode policy key: $NO_COLOR
            rabbitmqctl set_policy ha-all '^(?!amq\.).*' '{"ha-mode": "all"}'  1>/dev/null 
            echo $BLUE Checking the rabbitmq cluster status: $NO_COLOR
            for rabbit_user in ${CONTROLLER_HOSTNAME[*]};do
                echo $BLUE Checking the ${rabbit_user} if in the rabbitmq cluster: $NO_COLOR
                if [[ $(rabbitmqctl cluster_status | grep ${rabbit_user} | wc -l) -ge 3 ]];then   
                    debug "0"
                else
                    debug "warning" "The ${rabbit_user} not in the rabbitmq cluster"
                fi
            done
    
        fi
    else
        rabbitmqctl add_user openstack $RABBIT_PASS  1>/dev/null
        echo $BLUE Permit configuration, write, and read access for the openstack user ...$NO_COLOR
        rabbitmqctl set_permissions openstack ".*" ".*" ".*"  1>/dev/null
    fi

    sed -i '/Group=rabbitmq/a\LimitNOFILE=10240' /usr/lib/systemd/system/rabbitmq-server.service
    systemctl daemon-reload
    #rabbitmq-plugins list
    #enable rabbitmq_management boot after the os boot 
    #Use rabbitmq-web 
    rabbitmq-plugins enable rabbitmq_management 1>/dev/null 2>&1
    systemctl restart rabbitmq-server.service &&
        debug "$?" "Restart rabbitmq-server.service fail after enable rabbitmq_management "
    echo $GREEN You can browse rabbitmq web via 15672 port $NO_COLOR
}



#-------------------------------memcache install ----------------------------------------------
function memcache(){
    #install and configuration memecache 
    #Need variable MGMT_IP
    #The Identity service authentication mechanism for services uses Memcached to cache tokens. 
    #The memcached service typically runs on the controller node. 
    #For production deployments, we recommend enabling a combination of firewalling, authentication, and encryption to secure it.
    
    #For HA
    #Most OpenStack services can use Memcached to store ephemeral data such as tokens. Although Memcached does 
    #not support typical forms of redundancy such as clustering, OpenStack services can use almost any number of 
    #instances by configuring multiple hostnames or IP addresses.
    echo $BLUE Installing memcached python-memcached ... $NO_COLOR 
    yum install memcached python-memcached -y 1>/dev/null
    sed -i "s/127.0.0.1/$MGMT_IP/g" /etc/sysconfig/memcached
    systemctl enable memcached.service   1>/dev/null 2>&1 &&
    systemctl start memcached.service
        debug "$?"  "Start memcached.service failed "
}



#----------------------------create_service_credentials----------------------
function create_service_credentials(){
    #This function need two parameter :
    #$1 is the service password 
    #$2 is the service name ,example nova glance neutron cinder. 
    
    #The judgment is very simple now, will be change by the future  
    if [[ ${#CONTROLLER_IP[*]} -eq 3 ]] && [[ ${MGMT_IP} != ${CONTROLLER_IP[0]} ]];then 
        debug "notice" "Skip to create the $2 service credentials"
    else 
        cat 2>&1 <<__EOF__
        $MAGENTA==========================================================
                  Create $2 service credentials 
        ==========================================================
        $NO_COLOR
__EOF__
        #echo $BLUE To create the service credentials, complete these steps: $NO_COLOR 
        source $OPENRC_DIR/admin-openrc
        echo $BLUE Creating the service credentials: $NO_COLOR
        echo $BLUE Creating the $2  user  $NO_COLOR
        openstack user create --domain default --password $1  $2  &&
    
        echo $BLUE Adding the admin role to the $2 user and service project $NO_COLOR
        openstack role add --project service --user $2 admin
    
        echo $BLUE Creating the $2 service entity $NO_COLOR
        case $2 in
        glance)
            local SERVICE=Image
            local SERVICE1=image
            local PORTS=9292
            ;;
        nova)
            local SERVICE=Compute
            local SERVICE1=compute
            local PORTS=8774
            ;;
        neutron)
            local SERVICE=Networking
            local SERVICE1=network 
    
            local PORTS=9696
            ;;
        cinder)
            local SERVICE=Block Storage
            local PORTS=8776
            local SERVICE1=volume
            ;;
        heat)
   #new add heat 
            local SERVICE=Orchestration
            local SERVICE1=orchestration
            local PORTS=8004
            local PORTS1=8000
            ;;
        *)
            debug "1" "The second parameter is the service name:nova glance neutron cinder etc,your $2 is unkown "
            ;;
        esac 
        sleep 2
       
        echo $BLUE Creating the $2 service entities: $NO_COLOR 
        openstack service create --name $2 --description "OpenStack ${SERVICE}" ${SERVICE1}
            debug "$?" "openstack service $2 create failed "
        
        if [[ $2 = heat ]];then 
            echo $BLUE Creating the heat-cfn service entities: $NO_COLOR 
            openstack service create --name heat-cfn  --description "Orchestration"  cloudformation 
        fi
    
        if [[ $2 = cinder ]];then 
            openstack service create --name cinderv2 --description "OpenStack ${SERVICE}" volumev2
                debug "$?" "openstack service volumev2 create failed " 
        fi
    
        echo $BLUE Creating the ${YELLOW}$SERVICE${NO_COLOR}${BLUE} service API endpoints $NO_COLOR
    
        if [[ $2 = nova ]];then 
            openstack endpoint create --region RegionOne ${SERVICE1} public http://${CONTROLLER_VIP}:${PORTS}/v2.1/%\(tenant_id\)s
            openstack endpoint create --region RegionOne ${SERVICE1} internal http://${CONTROLLER_VIP}:${PORTS}/v2.1/%\(tenant_id\)s
            openstack endpoint create --region RegionOne ${SERVICE1} admin http://${CONTROLLER_VIP}:${PORTS}/v2.1/%\(tenant_id\)s
                debug "$?" "openstack endpoint create $2 failed "
    
        elif [[ $2 = cinder ]];then
            openstack endpoint create --region RegionOne ${SERVICE1} public http://${CONTROLLER_VIP}:${PORTS}/v1/%\(tenant_id\)s
            openstack endpoint create --region RegionOne ${SERVICE1} internal http://${CONTROLLER_VIP}:${PORTS}/v1/%\(tenant_id\)s
            openstack endpoint create --region RegionOne ${SERVICE1} admin http://${CONTROLLER_VIP}:${PORTS}/v1/%\(tenant_id\)s
                debug "$?" "openstack endpoint create $2 failed "
    
            openstack endpoint create --region RegionOne volumev2 public http://${CONTROLLER_VIP}:${PORTS}/v2/%\(tenant_id\)s
            openstack endpoint create --region RegionOne volumev2 internal http://{$CONTROLLER_VIP}:${PORTS}/v2/%\(tenant_id\)s
            openstack endpoint create --region RegionOne volumev2 admin http://${CONTROLLER_VIP}:${PORTS}/v2/%\(tenant_id\)s
                debug "$?" "openstack endpoint create $2 failed "
        elif [[ $2 = heat ]];then 
            echo $BLUE Creating the Orchestration service API endpoints: $NO_COLOR 
            openstack endpoint create --region RegionOne orchestration public http://${CONTROLLER_VIP}:${PORTS}/v1/%\(tenant_id\)s
            openstack endpoint create --region RegionOne orchestration internal http://${CONTROLLER_VIP}:${PORTS}/v1/%\(tenant_id\)s
            openstack endpoint create --region RegionOne orchestration admin http://${CONTROLLER_VIP}:${PORTS}/v1/%\(tenant_id\)s
            
            openstack endpoint create --region RegionOne cloudformation public http://${CONTROLLER_VIP}:${PORTS1}/v1
            openstack endpoint create --region RegionOne cloudformation internal http://${CONTROLLER_VIP}:${PORTS1}/v1
            openstack endpoint create --region RegionOne cloudformation admin http://${CONTROLLER_VIP}:${PORTS1}/v1
    
            #Orchestration requires additional information in the Identity service to manage stacks. To add this information, complete these steps:
            echo $BLUE Creating the heat domain that contains projects and users for stacks: $NO_COLOR 
            openstack domain create --description "Stack projects and users" heat
            
            echo $BLUE Creating the heat_domain_admin user to manage projects and users in the heat domain: $NO_COLOR 
            openstack user create --domain heat  --password  $HEAT_DOMAIN_PASS  heat_domain_admin  
            
            echo $BLUE Add the admin role to the heat_domain_admin user in the heat domain to enable administrative \
                stack management privileges by the heat_domain_admin user: $NO_COLOR 
            openstack role add --domain heat --user-domain heat --user heat_domain_admin admin
           
            echo $BLUE Creating the heat_stack_owner role: $NO_COLOR 
            openstack role create heat_stack_owner
        
            echo $BLUE add the heat_stack_owner role to the demo project and user to enable stack management by the demo user: $NO_COLOR 
            openstack role add --project demo --user demo heat_stack_owner

            echo $BLUE Creating the heat_stack_user role: $NO_COLOR 
            openstack role create heat_stack_user

            echo $GREEN Completed added additional information in keystone for Orchestration $NO_COLOR 

            #Note:
            #The Orchestration service automatically assigns the heat_stack_user role to users that it creates during stack 
            #deployment. By default, this role restricts API <Application Programming Interface (API)> operations. 
            #To avoid conflicts, do not add this role to users with the heat_stack_owner role.
        else 
            openstack endpoint create --region RegionOne ${SERVICE1} public http://${CONTROLLER_VIP}:${PORTS}
            openstack endpoint create --region RegionOne ${SERVICE1} internal http://${CONTROLLER_VIP}:${PORTS}
            openstack endpoint create --region RegionOne ${SERVICE1} admin http://${CONTROLLER_VIP}:${PORTS}
                debug "$?" "openstack endpoint create $2 failed "
        fi 
        echo $GREEN openstack ${YELLOW}$2${GREEN} endpoint create success $NO_COLOR 
    fi
}

#source the variable 
variable_set
