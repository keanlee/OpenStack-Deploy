#!/bin/bash 
#codeing in  2017
#author by KeanLee

cd $(cd `dirname $0`; pwd)

ZABBIXSERVER=$1                    #zabbix server ip 
HOSTNAME=$(hostname)                         #hostname will be display on zabbix server web page 
METADATA=$2                                   #For Openstack option is controller/compute/ceph/other roles,this will be used for auto Auto registration

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


debug(){
    if [[ $1 != 0 ]] ; then
        echo $RED error: $2 $NO_COLOR
        exit 1
    fi
}

function install(){
#-----------------Disable selinux-----------------
if [[ $(getenforce) = Enforcing ]];then
    echo $BLUE Disable selinux $NO_COLOR
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config 
    setenforce 0  &&
    echo $GREEN Disable the selinux by config file. The current selinux Status:$NO_COLOR $YELLOW $(getenforce) $NO_COLOR

elif [[ $(getenforce) =  Permissive ]];then 
    echo $BLUE Disable selinux $NO_COLOR
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    echo $GREEN Disable the selinux by config file. The current selinux Status:$NO_COLOR $YELLOW $(getenforce) $NO_COLOR
fi

#---------------install package of zabbix agent -----
rpm -ivh ./packages/zabbix-agent* 1>/dev/null 2>&1 &&

#--------------configuer the conf file of zabbix agent -----------
sed -i "s/Server=127.0.0.1/Server=$ZABBIXSERVER/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/ServerActive=127.0.0.1/ServerActive=$ZABBIXSERVER/g"  /etc/zabbix/zabbix_agentd.conf
sed -i "s/Hostname=Zabbix\ server/Hostname=$HOSTNAME/g"  /etc/zabbix/zabbix_agentd.conf
sed -i "167 i HostMetadata=$METADATA"  /etc/zabbix/zabbix_agentd.conf

#--------------iptables setip------
STATUS=$(systemctl status firewalld | grep Active | awk -F ":" '{print $2}' | awk '{print $1}')
if [[ $STATUS = active ]];then
    firewall-cmd --zone=public --add-port=10050/tcp --permanent 1>/dev/null 2>&1
    firewall-cmd --reload  1>/dev/null 2>&1
else
    iptables -A  INPUT -p tcp --dport 10050 -j ACCEPT
    iptables-save > /etc/sysconfig/iptables
fi

#--------------add daemon iteam script for each host------------------- 
mkdir -p /etc/zabbix/scripts
cp ./script/common/serviceexist.sh /etc/zabbix/scripts
sed -i '294 i  UserParameter=openstack.serviceexist[*],/etc/zabbix/scripts/serviceexist.sh $1 ' /etc/zabbix/zabbix_agentd.conf

#--------------For openstack controller item ---------
if [ $METADATA = controller ];then
    cp  /home/admin-openrc  /etc/zabbix/scripts
    cp ./script/controller/check-process-status-openstack.sh  /etc/zabbix/scripts
    cp ./script/controller/thread.sh  /etc/zabbix/scripts                                    
    cp ./script/controller/top.sh  /etc/zabbix/scripts                                   
    cp ./script/controller/processexist.sh  /etc/zabbix/scripts             
    cp ./script/controller/check-dbsql.sh  /etc/zabbix/scripts
    sed -i '295 i UserParameter=check-process-status-openstack[*],/etc/zabbix/scripts/check-process-status-openstack.sh $1 ' /etc/zabbix/zabbix_agentd.conf
    sed -i '296 i UserParameter=system.cpu.highload[*], /etc/zabbix/scripts/thread.sh $1 '  /etc/zabbix/zabbix_agentd.conf
    sed -i '297 i  UserParameter=system.cpu.top, /etc/zabbix/scripts/top.sh '  /etc/zabbix/zabbix_agentd.conf
    sed -i '298 i  UserParameter=system.cpu.processexist[*], /etc/zabbix/scripts/processexist.sh $1 $2 $3 ' /etc/zabbix/zabbix_agentd.conf
    sed -i '299 i  UserParameter=FromDual.MySQL.check,/usr/local/fpmmm/bin/fpmmm --config=/etc/fpmmm/fpmmm.conf ' /etc/zabbix/zabbix_agentd.conf
    sed -i '300 i  UserParameter=check-dbsql,/etc/zabbix/scripts/check-dbsql.sh '  /etc/zabbix/zabbix_agentd.conf
else 
    continue 
fi 

#--------------For openstack compute item ---------
if [ $METADATA = compute ];then
    cp ./script/compute/thread.sh  /etc/zabbix/scripts
    cp ./script/compute/top.sh  /etc/zabbix/scripts
    cp ./script/compute/processexist.sh  /etc/zabbix/scripts
    cp ./script/compute/memory.sh  /etc/zabbix/scripts
    sed -i '295 i  UserParameter=system.cpu.highload[*], /etc/zabbix/scripts/thread.sh $1 ' /etc/zabbix/zabbix_agentd.conf
    sed -i '296 i  UserParameter=system.cpu.top, /etc/zabbix/scripts/top.sh '  /etc/zabbix/zabbix_agentd.conf
    sed -i '297 i  UserParameter=system.cpu.processexist[*], /etc/zabbix/scripts/processexist.sh $1 $2 $3 ' /etc/zabbix/zabbix_agentd.conf
    sed -i '298 i  UserParameter=vm_monitor[*], /etc/zabbix/scripts/processexist.sh $1 $2 $3 ' /etc/zabbix/zabbix_agentd.conf
    sed -i '299 i  UserParameter=check-single-process-memory[*], /etc/zabbix/scripts/memory.sh $1 ' /etc/zabbix/zabbix_agentd.conf
else
    continue
fi

#--------------add ceph support -------------------------
if [ $METADATA = ceph ];then
    usermod -a -G ceph zabbix
    cp ./script/ceph/* /etc/zabbix/scripts
    sed -i '296 i UserParameter=system.process.exist[*], /etc/zabbix/scripts/processexist.sh $1 $2 $3' /etc/zabbix/zabbix_agentd.conf
    sed -i '297 i UserParameter=ceph.agent.json[*], /etc/zabbix/scripts/ceph-agent-json.py $1'  /etc/zabbix/zabbix_agentd.conf
    sed -i '298 i UserParameter=ceph.disk.scan, /etc/zabbix/scripts/ceph_disk_scan.sh '  /etc/zabbix/zabbix_agentd.conf
    sed -i "299 i UserParameter=ceph.disk.rrqm_s[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$2}' " /etc/zabbix/zabbix_agentd.conf
    sed -i "300 i UserParameter=ceph.disk.wrqm_s[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$3}' " /etc/zabbix/zabbix_agentd.conf
    sed -i "301 i UserParameter=ceph.disk.r_s[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$4}'  " /etc/zabbix/zabbix_agentd.conf
    sed -i "302 i UserParameter=ceph.disk.w_s[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$5}'  " /etc/zabbix/zabbix_agentd.conf
    sed -i "303 i UserParameter=ceph.disk.rkB_s[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$6}'  "   /etc/zabbix/zabbix_agentd.conf
    sed -i "304 i UserParameter=ceph.disk.wkB_s[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$7}'  "  /etc/zabbix/zabbix_agentd.conf
    sed -i "305 i UserParameter=ceph.disk.avgrq-sz[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$8}'  "   /etc/zabbix/zabbix_agentd.conf
    sed -i "306 i UserParameter=ceph.disk.avgqu-sz[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$9}' "  /etc/zabbix/zabbix_agentd.conf
    sed -i "307 i UserParameter=ceph.disk.await[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$10}'   "  /etc/zabbix/zabbix_agentd.conf
    sed -i "308 i UserParameter=ceph.disk.r_await[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$11}'  "/etc/zabbix/zabbix_agentd.conf
    sed -i "309 i UserParameter=ceph.disk.w_await[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$12}' " /etc/zabbix/zabbix_agentd.conf
    sed -i "310 i UserParameter=ceph.disk.svctm[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$13}' "  /etc/zabbix/zabbix_agentd.conf
    sed -i "311 i UserParameter=ceph.disk.util[*], iostat -dyx  |grep "\b$1\b"|awk '{print $$14}'  "  /etc/zabbix/zabbix_agentd.conf
    sed -i "312 i UserParameter=ceph.agent.test, /etc/zabbix/scripts/test.sh "  /etc/zabbix/zabbix_agentd.conf
fi

#--------------end install zabbix agent---------------------
chown -R zabbix:zabbix /etc/zabbix/scripts
chmod 700 /etc/zabbix/scripts/*
systemctl enable zabbix-agent 1>/dev/null 2>&1  
systemctl start zabbix-agent &&
    debug "$?" "Start zabbix-agent daemon failed "
echo -e "\e[1;32m Zabbix agent has been install on $YELLOW $(hostname) $NO_COLOR  \e[0m "
echo -e "\e[1;32m You can go to the zabbix server page to add $YELLOW $(hostname) $NO_COLOR  \e[0m "
echo -e "\e[1;32m The metadata  is $YELLOW $METADATA $NO_COLOR   \e[0m "
}

#--------------------clean agent env ----------
function clean(){
   echo -e "\e[31m Begin clean zabbix agent installed env ...\e[0m "
   yum erase zabbix-agent zabbix-sender -y  1>/dev/null 2>&1
   rm -rf /etc/zabbix
   echo -e "\e[32m Finshed clean env \e[0m"
}

if [ $(rpm -qa | grep zabbix | wc -l) -ge 1 ];then
   clean
   install
else
   install
fi
