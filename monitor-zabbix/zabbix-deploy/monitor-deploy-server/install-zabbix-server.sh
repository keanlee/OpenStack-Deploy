#!/bin/sh
#author by keanlee on 13th Oct of 2016
#wget -r -p -np -k -P ./ http://110.76.187.145/repos/
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
NTP_SERVER_IP=182.92.12.11



function debug(){
if [[ $1 -ne 0 ]]; then
    echo $RED ERROR:  $2 $NO_COLOR
    exit 1
fi
}

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
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
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

systemctl enable ntpd.service 1>/dev/null 2>&1 &&
echo $BLUE Starting the ntpd.service $NO_COLOR
systemctl start ntpd.service
    debug "$?" "start ntpd.service failed "
}

README=$(cat ./README.txt)
OS=$(cat /etc/redhat-release | awk '{print $1}')
if [ $OS = Red ];then
    OSVERSION=$(cat /etc/redhat-release | awk '{print $7}' | awk -F "." '{print $2}')
else
    OSVERSION=$(cat /etc/redhat-release | awk '{print $4}' | awk -F "." '{print $2}')
fi

function help(){
echo -e $BLUE $README $NO_COLOR
echo $CYAN =================================Usage as below:==================$NO_COLOR
echo $CYAN sh $0 begin $NO_COLOR
}




function install(){

#-----------------------------yum repos configuration ---------------------------
function yum_repos(){
if [[ ! -d /etc/yum.repos.d/bak/ ]];then
    mkdir /etc/yum.repos.d/bak/
fi
mv /etc/yum.repos.d/* /etc/yum.repos.d/bak/  1>/dev/null 2>&1
cp -f ./repos/* /etc/yum.repos.d/   &&
yum clean all 1>/dev/null 2>1&
echo $GREEN yum repos configuration done $NO_COLOR
}

#change the host name 
echo "Zabbix-Server" >/etc/hostname
hostname Zabbix-Server
#set up the ntp to sync the time 
ntp 


#yum_repos
rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
#echo $GREEN zabbix repos settting done $NO_COLOR
#------------------execute the install script --------
source ./bin/install.sh 
source ./bin/firewall.sh
echo -e "\e[1;32m ----->Please Go Ahead Zabbix frontend to finished install zabbix server \e[0m"
echo -e "\e[1;32m ----->PLEASE Login as Admin/zabbix in IP/zabbix by your Browser \e[0m"
}

function choice(){
            if [ $1 -eq 1 ];then
#--------------Downgrade the pacakge of systemc, since the higher version cause can't start zabbix-server daemon
                rpm -Uvh --force ./packages/gnutls-3.1.18-8.el7.x86_64.rpm 1>/dev/null &&
                echo $BLUE This script will be deploy zabbix-server on $GREEN $(cat /etc/redhat-release) $NO_CLOLOR
                install
            else
                echo $BLUE This script will be deploy zabbix-server on $GREEN $(cat /etc/redhat-release) $NO_CLOLOR
                install
            fi
}

#------------------------------------main------------------------
case $1 in 
begin)
    if [ $(rpm -qa | grep zabbix | wc -l) -ge 1 ];then
        source ./bin/clean.sh
        choice $OSVERSION
    else
        choice $OSVERSION
    fi
    ;;
*)
    help
    ;;
esac
