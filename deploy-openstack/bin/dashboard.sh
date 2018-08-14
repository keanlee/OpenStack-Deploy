#!/bin/bash
##
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
#The Dashboard (horizon) is a web interface that enables cloud administrators and users to manage various OpenStack resources and services.


function dashboard(){
    #dashboard deploy function
    cat 2>&1 <<__EOF__
    $MAGENTA==========================================================================
          Begin to deploy Dashboard on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA} 
    ==========================================================================
    $NO_COLOR
__EOF__

    echo $BLUE Installing openstack-dashboard ... $NO_COLOR
    yum install openstack-dashboard -y 1>/dev/null
        debug "$?" "Install openstack-dashboard failed "
    
    #copy local_settings and edit it 
    cp -f ./etc/controller/dashboard/local_settings /etc/openstack-dashboard
    sed -i "s/127.0.0.1/$MGMT_IP/g"  /etc/openstack-dashboard/local_settings
    sed -i "s/controller/$MGMT_IP/g" /etc/openstack-dashboard/local_settings
    sed -i "s/CONTROLLER_VIP/${CONTROLLER_VIP}/g " /etc/openstack-dashboard/local_settings 
    
    echo $BLUE Restarting httpd.service and memcached.service $NO_COLOR
    systemctl restart httpd.service memcached.service  
        debug "$?" "Restart httpd.service memcached.service Failed "
    
    source  $OPENRC_DIR/admin-openrc
    if [[ $(openstack flavor list | grep True | wc -l) -ge 2 ]];then 
        debug "notice" "Base flaovor has been already created "
    else
        echo $BLUE Creating flavor for openstack user ...$NO_COLOR
        openstack flavor create --id 0 --vcpus 1 --ram 512 --disk 10  m0.nano
        openstack flavor create --id 1 --vcpus 1 --ram 1024 --disk 20  m1.nano
            debug "$?"  "opnstack flavor create failed "
    fi
    
    #Create the apache test pages:
    echo > /var/www/html/index.html
        cat > /var/www/html/index.html <<EOF
<h1>This is controller server:${MGMT_IP}</h1>
<p class="lead">This page is used to test the proper operation of the <a href="http://apache.org">Apache \
HTTP server</a> after it has been installed. If you can read this page it means that this site is working properly. \
This server is powered by <a href="http://centos.org">CentOS</a>.</p>
EOF

    if [[ ${#CONTROLLER_IP[*]} -eq 1 ]];then 
        echo "
    $GREEN=====================================================================================
       Congratulation you finished to deploy Dashboard on ${YELLOW}$(hostname)${NO_COLOR}${GREEN}
         You can log in the dasboard with below info:
              URL:http://${CONTROLLER_VIP}/dashboard
              Domain: default
              ADMIN USER: admin 
              PASSWORD: ${ADMIN_PASS}
    =====================================================================================
    $NO_COLOR "
    
    elif [[ ${#CONTROLLER_IP[*]} -eq 3 ]] && [[ ${MGMT_IP} = ${CONTROLLER_IP[2]} ]];then 
        source  $OPENRC_DIR/admin-openrc
        echo $BLUE Give the domain create  role to admin user $NO_COLOR 
        openstack role add --domain default --user admin admin
        echo "
    $GREEN=====================================================================================================================
       Congratulation you finished to deploy Dashboard on ${YELLOW}${CONTROLLER_IP[0]},   ${CONTROLLER_IP[1]},  \
     ${CONTROLLER_IP[2]}${NO_COLOR}${GREEN}
         You can log in the dasboard with below info:
              URL:http://${CONTROLLER_VIP}/dashboard
              Domain: default
              ADMIN USER: admin 
              PASSWORD: ${ADMIN_PASS}
    ======================================================================================================================$NO_COLOR" 
    fi
    
    if [[ ${#CONTROLLER_IP[*]} -eq 3 ]] && [[ ${MGMT_IP} != ${CONTROLLER_IP[2]} ]];then
        echo "
    $GREEN=====================================================================================
      Finished to deploy Dashboard on ${YELLOW}$(hostname)${NO_COLOR}${GREEN}
    ====================================================================================
    $NO_COLOR"
    fi
}

#Deploy dashboard function to deploy dashboard
dashboard 
