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

echo $BLUE Reinstall the mairadb if installed $NO_COLOR
systemctl stop mariadb  1>/dev/null   
yum erase -y mariadb-* mariadb-libs 1>/dev/null   
yum erase -y python2-PyMySQL 1>/dev/null  
rm -rf /var/lib/mysql
rm -rf /usr/lib64/mysql
rm -rf /etc/my.cnf
rm -rf /etc/my.cnf.d
rm -rf /var/log/mariadb
rm -rf /usr/share/mariadb  

#set mariadb password
MARIADB_PASSWORD=admin


function debug(){
#print exit reason to help debug
if [[ $1 = "warning" ]];then 
    echo $YELLOW -----------------------------------------------------\> WARNING $NO_COLOR
    echo $YELLOW WARNING:  $2 $NO_COLOR
elif [[ $1 = 0 ]];then 
    echo $GREEN -----------------------------------------------------\>   DONE $NO_COLOR
elif [[ $1 = "notice" ]];then
    echo $CYAN INFO:  $2 $NO_COLOR
else
    echo $RED   -----------------------------------------------------\>  FAILED $NO_COLOR 
    echo $RED ERROR:  $2 $NO_COLOR
    exit 1
fi
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
yum install mariadb mariadb-server python2-PyMySQL mysql-devel -y 1>/dev/null 
    debug "$?" "$RED Install mariadb mariadb-server python2-PyMySQL failed $NO_COLOR"   
systemctl enable mariadb.service 1>/dev/null 2>&1 && 
systemctl start mariadb.service
sed -i '/Group=mysql/a\LimitNOFILE=65535' /usr/lib/systemd/system/mariadb.service
echo "collation-server = utf8mb4_general_ci" >> /etc/my.cnf
echo "character-set-server = utf8mb4" >> /etc/my.cnf
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

mysql_configuration
echo $BLUE Set the remote connect mysql ...$NO_COLOR 
mysql -uroot -padmin -e "GRANT ALL PRIVILEGES ON *.* TO root@"0.0.0.0" IDENTIFIED BY \"$MARIADB_PASSWORD\" WITH GRANT OPTION;FLUSH PRIVILEGES"
