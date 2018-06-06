#!/bin/bashi
#author by keanlee on May 15th of 2017 
#wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

#useful
#echo -ne '[#####                     ](33%)\r'
#yum install tmux -y 1>/dev/null
#echo -ne '[#############             ](66%)\r'
#sleep 3
#echo -ne '[##########################](100%)\r'
#echo -ne '\n'
TOP_DIR=$(cd $(dirname $0); pwd)
cd $TOP_DIR
source ${TOP_DIR}/bin/common.sh

#echo $GREEN This script will be deploy OpenStack on ${NO_COLOR}${YELLOW}$(cat /etc/redhat-release) $NO_COLOR
function help(){
cat 1>&2 <<__EOF__
$MAGENTA================================================================
            --------Usage as below ---------
             sh $0 controller
             sh $0 compute
             sh $0 network
             sh $0 check
             sh $0 all-in-one
             sh $0 controller-as-network-node
             sh $0 compute-as-network-node 
             sh $0 deploy-block-node
================================================================
$NO_COLOR
__EOF__
}

if [[ $# = 0 || $# -gt 1 ]]; then 
    which pv 1>/dev/null 2>&1 || rpm -ivh ${TOP_DIR}/lib/pv* 1>/dev/null 2>&1
        debug "$?" "install pv failed "
    echo -e $CYAN $(cat ./README.txt) $NO_COLOR | pv -qL 30
    help
    exit 1
fi



#---------------compnment choose -----------
function support_service_common(){
yum_repos
initialize_env
ntp
dns_server
source ${TOP_DIR}/bin/firewall.sh
}

function support_service_controller(){
rabbitmq_configuration
memcache
if [[ $(rpm -qa | grep galera | wc -l) -ge 1 ]];then 
    debug "notice" "Since galera cluster has been already installed,so skip to deploy mariadb-server on $(hostname)"
else
    mysql_configuration
fi
common_packages
}


case $1 in
controller)
    echo $BLUE Beginning Deploy Controller On ${YELLOW}$(hostname)$NO_COLOR 
    support_service_common
    support_service_controller
    source ${TOP_DIR}/bin/keystone.sh
    source ${TOP_DIR}/bin/glance.sh
    source ${TOP_DIR}/bin/nova.sh controller  
    source ${TOP_DIR}/bin/neutron.sh controller
    if [[ $if_enable_cinder = yes ]];then  
        source ${TOP_DIR}/bin/cinder.sh controller
    fi
    if [[ $if_enable_heat = yes ]];then 
        source ${TOP_DIR}/bin/heat.sh controller
    fi  
    source ${TOP_DIR}/bin/dashboard.sh
    source ${TOP_DIR}/bin/initial_network.sh
    ;;
compute)
    echo $BLUE Beginning Deploy Compute on ${YELLOW}$(hostname)$NO_COLOR
    support_service_common
    source ${TOP_DIR}/bin/nova.sh compute
    source ${TOP_DIR}/bin/neutron.sh compute
    #source ${TOP_DIR}/bin/cinder.sh  compute 
    ;;
network) 
    echo $BLUE Beginning Deploy Network on ${YELLOW}$(hostname)$NO_COLOR
    support_service_common
    source ${TOP_DIR}/bin/neutron.sh network
    ;;
controller-as-network-node)
    echo $BLUE Beginning Deploy controller as network node on ${YELLOW}$(hostname)$NO_COLOR
    support_service_common
    support_service_controller
    source ${TOP_DIR}/bin/keystone.sh
    source ${TOP_DIR}/bin/glance.sh
    source ${TOP_DIR}/bin/nova.sh controller  
    source ${TOP_DIR}/bin/neutron.sh controller-as-network-node
    if [[ $if_enable_cinder = yes ]];then
        source ${TOP_DIR}/bin/cinder.sh controller
    fi
    if [[ $if_enable_heat = yes ]];then
        source ${TOP_DIR}/bin/heat.sh controller
    fi
    source ${TOP_DIR}/bin/dashboard.sh 
    source ${TOP_DIR}/bin/initial_network.sh
    ;;
compute-as-network-node)
    echo $BLUE Beginning Deploy compute as network node on ${YELLOW}$(hostname)$NO_COLOR
    support_service_common
    source ${TOP_DIR}/bin/nova.sh compute
    source ${TOP_DIR}/bin/neutron.sh compute
    source ${TOP_DIR}/bin/neutron.sh compute-as-network-node
    ;;
deploy-all-in-one)
    echo $BLUE Beginning Deploy ALL-In-One on ${YELLOW}$(hostname)$NO_COLOR
    support_service_common
    support_service_controller
    source ${TOP_DIR}/bin/keystone.sh
    source ${TOP_DIR}/bin/glance.sh
    source ${TOP_DIR}/bin/nova.sh controller  
    ;;
deploy-block-node)
    echo $BLUE Beginning Deploy block node on ${YELLOW}$(hostname)$NO_COLOR
    support_service_common
    source ${TOP_DIR}/bin/cinder.sh  compute
    ;;
check)
    source ${TOP_DIR}/bin/system_info.sh
    ;;
*)
    help
    ;;
esac
