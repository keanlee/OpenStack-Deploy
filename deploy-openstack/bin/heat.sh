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
#The Orchestration service provides a template-based orchestration for describing a cloud application by running OpenStack API calls to generate running cloud applications.
#
#


function heat_deploy(){
    #heat deploy function
    cat 2>&1 <<__EOF__
    $MAGENTA==========================================================================
          Begin to deploy HEAT on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA} 
    ==========================================================================
    $NO_COLOR
__EOF__

    database_create heat ${HEAT_DBPASS}
    
    create_service_credentials ${HEAT_PASS} heat
    #this need to comfirm by common.sh 
    
    
    echo $BLUE Installing  openstack-heat-api openstack-heat-api-cfn \
        openstack-heat-engine ... $NO_COLOR
    yum  install openstack-heat-api openstack-heat-api-cfn openstack-heat-engine -y 1>/dev/null
        debug "$?" "Install openstack-heat-api openstack-heat-api-cfn openstack-heat-engine failed "
    
    #copy local conf  and edit it 
    cp -f ${CONFIG_FILE_DIR}/etc/controller/heat.conf /etc/heat/
    sed -i "s/controller/$MGMT_IP/g" /etc/heat/heat.conf
    sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" /etc/heat/heat.conf
    sed -i "s/HEAT_DOMAIN_PASS/$HEAT_DOMAIN_PASS/g" /etc/heat/heat.conf
    sed -i "s/HEAT_DBPASS/$HEAT_DBPASS/g" /etc/heat/heat.conf
    sed -i "s/HEAT_PASS/$HEAT_PASS/g"  /etc/heat/heat.conf
    sed -i "s/HEAT_PASS/$HEAT_PASS/g"  /etc/heat/heat.conf
    
    echo $BLUE Change glance conf to work with heat $NO_COLOR
    sed -i "/^enable_v1_api = False/d"  /etc/glance/glance-api.conf
    sed -i "/^enable_v2_api=True/d" /etc/glance/glance-api.conf 
    
    sed -i "/\[DEFAULT\]/aenable_v1_api = true" /etc/glance/glance-api.conf
    sed -i "/\[DEFAULT\]/aenable_v2_api = true " /etc/glance/glance-api.conf
    sed -i "/\[DEFAULT\]/aenable_v1_registry = true " /etc/glance/glance-api.conf
    sed -i "/\[DEFAULT\]/aenable_v2_registry = true " /etc/glance/glance-api.conf
    
    
    sed -i "/\[DEFAULT\]/aenable_v1_api = true" /etc/glance/glance-registry.conf
    sed -i "/\[DEFAULT\]/aenable_v2_api = true " /etc/glance/glance-registry.conf
    sed -i "/\[DEFAULT\]/aenable_v1_registry = true " /etc/glance/glance-registry.conf
    sed -i "/\[DEFAULT\]/aenable_v2_registry = true " /etc/glance/glance-registry.conf
    systemctl restart openstack-glance-api  openstack-glance-registry  
    
    if [[ ${MGMT_IP} != ${CONTROLLER_IP[0]} ]];then
        debug "notice" "Skip to populate the HEAT service database"
    else
        echo $BLUE Populating the nova_api databases $NO_COLOR
        su -s /bin/sh -c "heat-manage db_sync" heat 1>/dev/null 2>&1 
           # debug "$?" "heat sync failed "
        get_database_size heat $HEAT_DBPASS
    fi 
    
    systemctl enable openstack-heat-api.service \
    openstack-heat-api-cfn.service openstack-heat-engine.service  1>/dev/null 2>&1 
        debug "$?" "systemctl enable openstack-heat's service failed " 
    
    echo $BLUE Starting the openstack heat service on $(hostname) node  $NO_COLOR 
    systemctl start openstack-heat-api.service \
    openstack-heat-api-cfn.service openstack-heat-engine.service
        debug "$?" "Start openstack-heat's service failed " 
    
    cat 2>&1 <<__EOF__
    $GREEN=====================================================================
           
      Congratulation you finished to deploy heat on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA}
     
    =====================================================================
    $NO_COLOR
__EOF__
}

case $1 in
controller)
    heat_deploy    
    ;;
*)
    debug "1" "heat.sh just support controller parameter, your $1 is not support "
    ;;
esac 
