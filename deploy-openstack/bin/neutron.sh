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
#Write by keanlee on May 19th

#OpenStack Networking (neutron) allows you to create and attach interface devices managed by other OpenStack services to 
#networks. Plug-ins can be implemented to accommodate different networking equipment and software, providing flexibility to 
#OpenStack architecture and deployment.

#It includes the following components:
#neutron-server
#OpenStack Networking plug-ins and agents
#Messaging queue

#Refer https://docs.openstack.org/newton/install-guide-rdo/common/get-started-networking.html to get more info 
#refer https://wenku.baidu.com/view/46ced95180eb6294dc886c5b.html?pn=88 for openvswitch guide 

#network monitor tools
#http://os.51cto.com/art/201404/435279.htm

#Some debug command:
#ip netns exec qrouter-bdb56fe4-eff2-4150-ad84-24427a617faf  iptables -t nat -S

#network virtaul device introduction:
#http://blog.csdn.net/tantexian/article/details/45395075
#通过使用 DVR，三层的转发（L3 Forwarding）和 NAT 功能都会被分布到计算节点上，这意味着计算节点也有了网络节点的功能。
#但是，DVR 依然不能消除集中式的 Virtual Router，这是为了节省宝贵的 IPV4 公网地址，所有依然将 SNAT 放在网络节点上提供。
#IF_ENABLE_NEUTRON_HA_DVR=yes  will be install neutron with DVR,ALL compute node as a network node 



#----------------------------------------------------neutron for controller node ----------------------
function neutron_controller(){
    cat 2>&1 <<__EOF__
    $MAGENTA=================================================================
          Begin to deploy Neutron on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA}
    =================================================================
    $NO_COLOR
__EOF__
    
    database_create neutron  $NEUTRON_DBPASS
    create_service_credentials $NEUTRON_PASS neutron
    
    #Option 1 deploys the simplest possible architecture that only supports attaching instances to provider (external) networks. 
    #No self-service (private) networks, routers, or floating IP addresses. Only the admin or other privileged user can manage provider networks.
    
    #Option 2 augments option 1 with layer-3 services that support attaching instances to self-service networks.
    #The demo or other unprivileged user can manage self-service networks including routers that provide connectivity between self-service and provider networks. Additionally, 
    #floating IP addresses provide connectivity to instances using self-service networks from external networks such as the Internet.
    
    #Option 2 also supports attaching instances to provider networks
    # Using the option 2 of neutron to deploy 
    echo $BLUE Installing openstack-neutron openstack-neutron-ml2 ... $NO_COLOR 
    yum install openstack-neutron openstack-neutron-ml2 -y 1>/dev/null
        debug "$?" "Install openstack-neutron openstack-neutron-ml2  failed "
    
    # Copy and edit neutron.conf 
    cp -f ${CONFIG_FILE_DIR}/etc/controller/neutron/neutron.conf  /etc/neutron
    sed -i "s/controller/$MGMT_IP/g"  /etc/neutron/neutron.conf 
    sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" /etc/neutron/neutron.conf 
    sed -i "s/NEUTRON_DBPASS/$NEUTRON_DBPASS/g" /etc/neutron/neutron.conf
    sed -i "s/NEUTRON_PASS/$NEUTRON_PASS/g" /etc/neutron/neutron.conf
    sed -i "s/NOVA_PASS/$NOVA_PASS/g"  /etc/neutron/neutron.conf
    sed -i "s/dhcp_agent_number/$DHCP_AGENT_NUMBER/g" /etc/neutron/neutron.conf
    # Copy plugin.ini file 
    cp -f ${CONFIG_FILE_DIR}/etc/controller/neutron/ml2_conf.ini  /etc/neutron/plugins/ml2/ml2_conf.ini
    
    #The Networking service initialization scripts expect a symbolic link /etc/neutron/plugin.ini 
    #pointing to the ML2 plug-in configuration file, /etc/neutron/plugins/ml2/ml2_conf.ini
    ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
        debug "$?" "ln -s failed for /etc/neutron/plugin.ini "
    
    if [[ ${MGMT_IP} != ${CONTROLLER_IP[0]} ]];then
        debug "notice" "Skip to populate the network service database "
    else
        echo $BLUE Populating the database ...  $NO_COLOR
        su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
    --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron  1>/dev/null 2>&1
            debug_info "Populating the neutron database "
        get_database_size neutron $NEUTRON_DBPASS
    #        debug "$?" "Populate the database of neutron failed "
    fi
    
    echo $BLUE Restarting nova-api.service nova-scheduler.service nova-conductor.service $NO_COLOR
    systemctl restart openstack-nova-api.service openstack-nova-scheduler.service \
            openstack-nova-conductor.service 
        debug_info  "Restarting openstack-nova-api openstack-nova-scheduler.service \
            openstack-nova-conductor.service"
    
    echo $BLUE Starting neutron-server.service $NO_COLOR
    systemctl enable neutron-server.service 1>/dev/null 2>&1 
    systemctl start  neutron-server.service
        debug_info "Start neutron-server"
    
    cat 1>&2 <<__EOF__
    $GREEN=====================================================================================
           
       Congratulation you finished to deploy Neutron server on ${YELLOW}$(hostname)${NO_COLOR}${GREEN}
                   Want to list loaded extensions to verify it ?
                    run <neutron ext-list> command 
     
    =====================================================================================
    $NO_COLOR
__EOF__
}


#--------------------------------------------------neutron for compute node -----------------------------
function neutron_compute(){
    cat 2>&1 <<__EOF__
    $MAGENTA====================================================================
      Begin to deploy Neutron on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA} 
    ====================================================================
    $NO_COLOR
__EOF__

    #The compute node handles connectivity and security groups for instances
    
    # To configure prerequisites:configure certain kernel networking parameters $NO_COLOR
    if [[ $(cat /etc/sysctl.conf | grep net.ipv4.ip_forward | wc -l) -eq 0 ]];then 
        echo "net.ipv4.ip_forward = 1" >>/etc/sysctl.conf
    fi 
    
    if [[ $(cat /etc/sysctl.conf | grep net.ipv4.conf.all.rp_filter | wc -l) -eq 0  ]];then
        echo "net.ipv4.conf.all.rp_filter = 0" >>/etc/sysctl.conf
    fi
    
    if [[ $(cat /etc/sysctl.conf | grep net.ipv4.conf.default.rp_filter | wc -l) -eq 0  ]];then
        echo "net.ipv4.conf.default.rp_filter = 0" >>/etc/sysctl.conf
    fi
    
    sysctl -p 1>/dev/null
    
    echo $BLUE Installing openstack-neutron-ml2 openstack-neutron-openvswitch... $NO_COLOR 
    yum install openstack-neutron-ml2 openstack-neutron-openvswitch -y 1>/dev/null 
    #install openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch
        debug "$?" "Install openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch failed"
    
    systemctl enable openvswitch.service  1>/dev/null 2>&1
    echo $BLUE Starting openvswitch.service $NO_COLOR
    systemctl start openvswitch.service
         debug_info "Start openvswitch "
    
    #Copy conf file and edit it 
    cp -f ${CONFIG_FILE_DIR}/etc/compute/neutron/neutron.conf  /etc/neutron
    sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" /etc/neutron/neutron.conf 
    sed -i "s/controller/$CONTROLLER_VIP/g"  /etc/neutron/neutron.conf
    sed -i "s/NEUTRON_PASS/$NEUTRON_PASS/g" /etc/neutron/neutron.conf
    sed -i "s/dhcp_agent_number/$DHCP_AGENT_NUMBER/g" /etc/neutron/neutron.conf
    #for ha mode
    if [[ ${#CONTROLLER_IP[*]} -eq 3 ]];then
        #Config the neutron agent service to use the rabbitmq cluster and memcached 
    #RabbitMQ 
        sed -i '/^transport_url.*/d' /etc/neutron/neutron.conf
        sed -i "/rabbitmq-config/a\transport_url = rabbit://openstack:RABBIT_PASS@rabbit1:5672,openstack:\
            RABBIT_PASS@rabbit2:5672,openstack:RABBIT_PASS@rabbit3:5672" /etc/neutron/neutron.conf
        sed -i "s/RABBIT_PASS/$RABBIT_PASS/g"  /etc/neutron/neutron.conf
        sed -i "s/rabbit1/${CONTROLLER_IP[0]}/g"  /etc/neutron/neutron.conf
        sed -i "s/rabbit2/${CONTROLLER_IP[1]}/g"  /etc/neutron/neutron.conf
        sed -i "s/rabbit3/${CONTROLLER_IP[2]}/g"  /etc/neutron/neutron.conf
    #Memcache
        sed -i '/^memcached_servers*/d'  /etc/neutron/neutron.conf
        sed -i "/Memcache/a\Memcached_servers = controller1:11211,\
            controller2:11211,controller3:11211"  /etc/neutron/neutron.conf
        sed -i "s/controller1/${CONTROLLER_IP[0]}/g"   /etc/neutron/neutron.conf
        sed -i "s/controller2/${CONTROLLER_IP[1]}/g"   /etc/neutron/neutron.conf
        sed -i "s/controller3/${CONTROLLER_IP[2]}/g"   /etc/neutron/neutron.conf
    fi
    
    cp -f ${CONFIG_FILE_DIR}/etc/compute/neutron/openvswitch_agent.ini  /etc/neutron/plugins/ml2
    sed -i "s/LOCAL_IP/${PRIVATE_IP}/g" /etc/neutron/plugins/ml2/openvswitch_agent.ini
    sed -i "s/br-provider/${br_provider}/g"  /etc/neutron/plugins/ml2/openvswitch_agent.ini
    
    sed -i "s/NEUTRON_PASS/$NEUTRON_PASS/g"  /etc/nova/nova.conf
    
    chown -R root:neutron /etc/neutron/
    
    echo $BLUE Rstarting openstack-nova-compute.service $NO_COLOR
    systemctl restart openstack-nova-compute.service
        debug_info "restart openstack-nova-compute after install neutron on compute node "
    
    echo $BLUE Starting neutron-openvswitch-agent.service $NO_COLOR
    systemctl enable neutron-openvswitch-agent.service  neutron-ovs-cleanup.service 1>/dev/null 2>&1
    systemctl start neutron-openvswitch-agent.service  
        debug_info "Start neutron-openvswitch-agent.service"
    
    cat 2>&1 <<__EOF__
    $GREEN=====================================================================================
           
     Congratulation you finished to deploy Neutron on ${YELLOW}$(hostname)${NO_COLOR}${GREEN}
     Verify it by below command on Controller node: 
       execute: <neutron ext-list> 
              : <neutron agent-list>
    =====================================================================================
    $NO_COLOR
__EOF__

}

function ovs_bridge_create(){
    echo $BLUE Create the OVS provider bridge ${YELLOW}${br_provider}${NO_COLOR} 
    #disable the ip addr of provider internet network device
    PROVIDER_INTER_ADRR=$(ip addr show ${PROVIDER_INTERFACE} | \
        grep 'inet[^6]' | sed -n '1p' | awk '{print $2}')
    if [[ $PROVIDER_INTER_ADRR != "" ]];then
         #echo $BLUE Please ignore the above error output $NO_COLOR
         echo $BLUE Disable ${YELLOW}${PROVIDER_INTERFACE}${BLUE} ip address $NO_COLOR 
         ip addr del dev ${PROVIDER_INTERFACE} ${PROVIDER_INTER_ADRR}
    fi 
    
    if  [[ -e /etc/sysconfig/network-scripts/ifcfg-${PROVIDER_INTERFACE} ]];then
        #if [[ $(cat /etc/sysconfig/network-scripts/ifcfg-${PROVIDER_INTERFACE} | grep -i dhcp | wc -l) -eq 1 ]];then 
        sed -i "/^BOOTPROTO.*/d" /etc/sysconfig/network-scripts/ifcfg-${PROVIDER_INTERFACE}
        echo "BOOTPROTO=none" >> /etc/sysconfig/network-scripts/ifcfg-${PROVIDER_INTERFACE}
        #sed -i "s/dhcp/static/g" /etc/sysconfig/network-scripts/ifcfg-${PROVIDER_INTERFACE}
        sed -i "/^ONBOOT.*/d"  /etc/sysconfig/network-scripts/ifcfg-${PROVIDER_INTERFACE}
        echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-${PROVIDER_INTERFACE}
        #fi
    fi
    
    ovs-vsctl add-br ${br_provider}
        debug_info "ovs-vsctl add-br ${br_provider}"
    
    echo $BLUE Added the provider network interface:$YELLOW$PROVIDER_INTERFACE$BLUE as a port \
    on the OVS provider bridge ${YELLOW}${br_provider}${NO_COLOR}
    #Replace PROVIDER_INTERFACE with the name of the underlying interface that handles provider networks. For example, eth1
    ovs-vsctl add-port ${br_provider} $PROVIDER_INTERFACE
        debug_info "ovs-vsctl add-port ${br_provider} $PROVIDER_INTERFACE"
    echo $BLUE Added port $YELLOW$PROVIDER_INTERFACE$BLUE to $br_provider $NO_COLOR 
    
    #Depending on your network interface driver, you may need to disable generic receive offload (GRO) to achieve 
    #suitable throughput between yourinstances and the external network
    ethtool -K $PROVIDER_INTERFACE gro off
        debug_info "ethtool -K $PROVIDER_INTERFACE gro off"
}

#------------------------------------------neutron for network node -----------------------
function neutron_network_node(){
    #A switchport that is configured to pass frames from all VLANs and tag them with the VLAN IDs is called a trunk port.
    cat 2>&1 <<__EOF__
    $MAGENTA=====================================================================================
           
        Begin to deploy Neutron as network node on ${YELLOW}$(hostname)${NO_COLOR}${MAGENTA}
     
    =====================================================================================
    $NO_COLOR
__EOF__

    #The network node primarily handles internal and external routing and DHCP services for vir-tual networks
    #floating ip mapping 
    
    #Private IP Address
    # A private IP address is assigned to an instance's network-interface by the DHCP server.
    # The address is visible from within the instance by using a command like “ip a”. The address is 
    # typically part of a private network and is used for communication between instances in the same
    # broadcast domain via virtual switch (L2 agent on each compute node). It can also be accessible 
    # from instances in other private networks via virtual router (L3 agent).
    
    #Floating IP Address
    # A floating IP address is a service provided by Neutron. It's not using any DHCP service or being set statically within the guest. 
    # As a matter of fact the guest's operating system has no idea that it was assigned a floating IP address. The delivery of packets to 
    # the interface with the assigned floating address is the responsibility of Neutron's L3 agent. Instances with an assigned floating IP 
    # address can be accessed from the public network by the floating IP.
    
    #http://www.cnblogs.com/CloudMan6/p/6005081.html
    # To configure prerequisites:configure certain kernel networking parameters $NO_COLOR
    if [[ $(cat /etc/sysctl.conf | grep net.ipv4.ip_forward | wc -l) -eq 0  ]];then 
        echo "net.ipv4.ip_forward = 1" >>/etc/sysctl.conf
    fi 
    
    if [[ $(cat /etc/sysctl.conf | grep net.ipv4.conf.all.rp_filter | wc -l) -eq 0  ]];then
        echo "net.ipv4.conf.all.rp_filter = 0" >>/etc/sysctl.conf
    fi
    
    if [[ $(cat /etc/sysctl.conf | grep net.ipv4.conf.default.rp_filter | wc -l) -eq 0  ]];then
        echo "net.ipv4.conf.default.rp_filter = 0" >>/etc/sysctl.conf
    fi
    sysctl -p 1>/dev/null
    
    
    echo $BLUE Installing openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch ... $NO_COLOR
    yum install openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch -y 1>/dev/null
        debug_info "Install openstack-neutron openstack-neutron-ml2 openstack-neutron-openvswitch "
    
    #add network node on controller or compute node  
    if [[ $1 = "controller" || $1 = "compute" ]];then 
        debug "notice" "Adding network role to $1 node "
    else 
        # Copy and edit configuration file of network node 
        cp -f ${CONFIG_FILE_DIR}/etc/network/neutron.conf  /etc/neutron
        sed -i "s/RABBIT_PASS/$RABBIT_PASS/g" /etc/neutron/neutron.conf 
        sed -i "s/controller/$CONTROLLER_VIP/g"  /etc/neutron/neutron.conf
        sed -i "s/NEUTRON_PASS/$NEUTRON_PASS/g" /etc/neutron/neutron.conf
        sed -i "s/dhcp_agent_number/$DHCP_AGENT_NUMBER/g" /etc/neutron/neutron.conf
    fi
    
    cp -f  ${CONFIG_FILE_DIR}/etc/network/dhcp_agent.ini  /etc/neutron
    cp -f ${CONFIG_FILE_DIR}/etc/network/dnsmasq-neutron.conf /etc/neutron
    #echo $BLUE Kill any existing dnsmasq processes before start neutron-dhcp-agent $NO_COLOR
    pkill dnsmasq 
 
    #The Layer-3 (L3) agent provides routing services for virtual networks
    cp -f ${CONFIG_FILE_DIR}/etc/network/l3_agent.ini    /etc/neutron
    sed -i "s/br-provider/$br_provider/g"  /etc/neutron/l3_agent.ini
    
    cp -f ${CONFIG_FILE_DIR}/etc/network/metadata_agent.ini  /etc/neutron 
    sed -i "s/controller/$CONTROLLER_VIP/g"  /etc/neutron/metadata_agent.ini
    sed -i "s/METADATA_SECRET/$METADATA_SECRET/g" /etc/neutron/metadata_agent.ini
    
    local CPUs=$(lscpu | grep ^CPU\(s\) | awk -F ":" '{print $2}')
    local HALFcpus=$(expr $CPUs / 2)
    sed -i "s/valuesnumber/${HALFcpus}/g" /etc/neutron/metadata_agent.ini
    #echo $BLUE Set the metadata_workers value as ${YELLOW}$HALFcpus $NO_COLOR
    
    #The ML2 plug-in uses the Open vSwitch (OVS) mechanism (agent) to build the virtual net-working framework for instances
    cp -f ${CONFIG_FILE_DIR}/etc/network/openvswitch_agent.ini  /etc/neutron/plugins/ml2/
    sed -i "s/LOCAL_IP/${PRIVATE_IP}/g"  /etc/neutron/plugins/ml2/openvswitch_agent.ini
    sed -i "s/br-provider/$br_provider/g" /etc/neutron/plugins/ml2/openvswitch_agent.ini
    chown -R root:neutron /etc/neutron/
    
    systemctl enable neutron-openvswitch-agent.service neutron-dhcp-agent.service \
    neutron-metadata-agent.service  openvswitch.service 1>/dev/null 2>&1 
    if [[ $1 = "compute" ]];then 
        systemctl restart openvswitch.service
    else 
        echo $BLUE Starting the openvswitch.service $NO_COLOR
        systemctl start openvswitch.service
            debug_info "start openvswitch.service"
    fi
    
    ovs_bridge_create
    
    echo $BLUE Starting neutron-dhcp-agent.service $NO_COLOR
    systemctl start  neutron-dhcp-agent.service 
        debug_info "Start neutron-dhcp-agent "
    
    echo $BLUE Starting neutron-metadata-agent.service $NO_COLOR
    systemctl start  neutron-metadata-agent.service
        debug_info "Start neutron-metadata-agent "
    
    echo $BLUE Starting neutron-openvswitch-agent.service $NO_COLOR
    systemctl start  neutron-openvswitch-agent.service
        debug_info "Start neutron-openvswitch-agent "
    
    #for option 2
    echo $BLUE Starting neutron-l3-agent $NO_COLOR
    systemctl enable neutron-l3-agent.service 1>/dev/null 2>&1
    systemctl start neutron-l3-agent.service
       debug_info "Start neutron-l3-agent "
    
    cat 2>&1 <<__EOF__
    $GREEN=====================================================================================
           
     Congratulation you finished to deploy Neutron as network node on ${YELLOW}$(hostname)${NO_COLOR}${GREEN}
                  Verify it by below command on Controller node: 
                         execute: <neutron ext-list> 
                         <neutron agent-list>
    =====================================================================================
    $NO_COLOR
__EOF__
}


function enable_dvr(){
    #refer https://docs.openstack.org/liberty/networking-guide/scenario-dvr-ovs.html#example-configuration
    #this function can enable the DVR with openstack 
    #this function default as think all network componement as installed 
    if [[ $1 = controller ]];then 
        #for controller as network  node 
        echo $BLUE Change the config to match the DVR mode on controller node $NO_COLOR 
        sed -i "/\[DEFAULT\]/arouter_distributed = True" /etc/neutron/neutron.conf
        sed -i "s/dhcp_agent_number/$DHCP_AGENT_NUMBER/g" /etc/neutron/neutron.conf 
    
        sed -i "/\[ml2_type_vlan\]/anetwork_vlan_ranges = default:1:4091,external" \
            /etc/neutron/plugins/ml2/ml2_conf.ini
        
        sed -i "/^l2_population*/d" /etc/neutron/plugins/ml2/openvswitch_agent.ini
        sed -i "/\[agent\]/al2_population = True"  /etc/neutron/plugins/ml2/openvswitch_agent.ini
    
        sed -i "/\[DEFAULT\]/ause_namespaces = True" /etc/neutron/l3_agent.ini
        sed -i "s/legacy/dvr_snat/g" /etc/neutron/l3_agent.ini 
    
        echo "l3_ha = false "  >> /etc/neutron/neutron.conf 
    #    echo "router_distributed = True" >> /etc/neutron/neutron.conf
    #    echo "l3_ha = True "  >> /etc/neutron/neutron.conf
    #    echo "l3_ha_net_cidr = 169.254.192.0/18"  >>/etc/neutron/neutron.conf
    #    #Set automatic L3 agent failover for routers
    #    echo "allow_automatic_l3agent_failover= True" >>/etc/neutron/neutron.conf 
    #
    #    echo "max_l3_agents_per_router = 3" >>/etc/neutron/neutron.conf 
    #     
    #    #Minimum number of network nodes to use for the HA router. A new router can be created only if this number of network nodes are available.
    #    echo "min_l3_agents_per_router = 2" >>/etc/neutron/neutron.conf 
    #
    #    #since controler node as network node when dvr mode 
    #    echo "[ovs]" >> /etc/neutron/plugins/ml2/ml2_conf.ini
    #    echo "local_ip = TUNNEL_INTERFACE_IP_ADDRESS" >> /etc/neutron/plugins/ml2/ml2_conf.ini
    #    echo "bridge_mappings = external:br-ex" >> /etc/neutron/plugins/ml2/ml2_conf.ini
    #
    #    echo "[agent] " >> /etc/neutron/plugins/ml2/ml2_conf.ini
    #    echo "enable_distributed_routing = True" >> /etc/neutron/plugins/ml2/ml2_conf.ini
         echo "tunnel_types = vxlan" >> /etc/neutron/plugins/ml2/ml2_conf.ini
    #    echo "l2_population = True" >> /etc/neutron/plugins/ml2/ml2_conf.ini
    
    
        #for network node 
        
        
        #if [[ ${MGMT_IP} = ${CONTROLLER_IP[2]} ]];then
        #    source ${OPENRC_DIR}/admin-openrc
        #    echo $BLUE Enable the router ha $NO_COLOR 
        #    neutron router-create HA-of-Router --distributed=True --ha=True
        #fi
        #The external_network_bridge option intentionally contains no value.
        #sed -i "s/br-ex/ /g" /etc/neutron/l3_agent.ini 
        #confirm later 
        echo $BLUE Restart service with neutron $NO_COLOR 
        systemctl restart neutron-server neutron-openvswitch-agent.service neutron-dhcp-agent.service \
            neutron-metadata-agent.service  openvswitch.service  neutron-l3-agent.service
    
    elif [[ $1 = compute ]];then 
        echo $BLUE Change the config to match the DVR mode on compute node $NO_COLOR 
        #for compute node 
        sed -i "s/legacy/dvr/g" /etc/neutron/l3_agent.ini
        sed -i "/\[DEFAULT\]/ause_namespaces = True" /etc/neutron/l3_agent.ini 
    
        sed -i "/^l2_population*/d" /etc/neutron/plugins/ml2/openvswitch_agent.ini
        sed -i "/\[agent\]/al2_population = True"  /etc/neutron/plugins/ml2/openvswitch_agent.ini
        sed -i "/\[agent\]/aenable_distributed_routing = True"  /etc/neutron/plugins/ml2/openvswitch_agent.ini     
     
        echo $BLUE Restart service with neutron $NO_COLOR 
        systemctl restart neutron-openvswitch-agent.service neutron-dhcp-agent.service \
            neutron-metadata-agent.service  openvswitch.service  neutron-l3-agent.service
    else 
        debug "1" "unsupport parameter for you typed "
    fi 
    
    #ior dhcp agent 
    #echo "dhcp_agents_per_network = dhcp_agent_number"  >>/etc/neutron/neutron.conf  #more than one to match our deployment 
    
    #dhcp_agent_numbers=${#COMPUTE_NODE_IP[*]}
    #sed -i "s/dhcp_agent_number/${dhcp_agent_numbers}/g" /etc/neutron/neutron.conf
    #because duplicate 
}

function tenant_network_types(){
    if [[ ${TENANT_NETWORK_TYPES} = "flat" ]];then
        echo $BLUE Use ${YELLOW}${TENANT_NETWORK_TYPES}${NO_COLOR}${BLUE} network as the tenant network $NO_COLOR
        
        if [[ $1 = "network" ]] || [[ $1 = "compute" ]];then 
            echo $BLUE Change the openvswitch agent conf file ${YELLOW}$(hostname)$NO_COLOR
            sed -i "/^tunnel_types*/d" /etc/neutron/plugins/ml2/openvswitch_agent.ini
            sed -i "/^integration_bridge*/d" /etc/neutron/plugins/ml2/openvswitch_agent.ini
            sed -i "/^tunnel_bridge*/d" /etc/neutron/plugins/ml2/openvswitch_agent.ini
            sed -i "/^local_ip*/d" /etc/neutron/plugins/ml2/openvswitch_agent.ini
            sed -i "/^bridge_mappings*/d" /etc/neutron/plugins/ml2/openvswitch_agent.ini
            sed -i "/bridge mappings/abridge_mappings = default:br-ex" /etc/neutron/plugins/ml2/openvswitch_agent.ini
        fi
    
        if [[ $1 = "controller" ]];then 
            echo $BLUE Change the ml2 conf file on ${YELLOW}$(hostname)$NO_COLOR 
            sed -i "/^tenant_network_types*/d" /etc/neutron/plugins/ml2/ml2_conf.ini
            sed -i "/tenant network types/atenant_network_types = flat" /etc/neutron/plugins/ml2/ml2_conf.ini
           
            sed -i "/^flat_networks*/d" /etc/neutron/plugins/ml2/ml2_conf.ini
            sed -i "/flat network here/aflat_networks = default" /etc/neutron/plugins/ml2/ml2_conf.ini
        elif [[ $1 = "compute" ]];then
            ovs_bridge_create  
        elif [[ $1 = "network" ]];then 
            sleep 1     
        else 
            debug "warning" "$1 is unsuport parameter for taneant_network_types function"
        fi
    
        if [[ $1 = "network" ]] || [[ $1 = "compute" ]];then
            echo $BLUE Restarting the neutron-openvswitch-agent.service  openvswitch $NO_COLOR 
            systemctl restart  neutron-openvswitch-agent.service  openvswitch
                debug_info "Restart the neutron-openvswitch-agent.service  openvswitch "
        fi
    
    elif [[ ${TENANT_NETWORK_TYPES} = "vlan" ]];then
        echo $BLUE Use ${YELLOW}${TENANT_NETWORK_TYPES}$NO_COLOR network as the tenant network $NO_COLOR
    
    else 
       echo $BLUE Use ${YELLOW}VXLAN${NO_COLOR} network as the tenant network $NO_COLOR
    
    fi
}

#--------------------------------------------Main--------------------------------------------
case $1 in
controller)
    neutron_controller
    tenant_network_types controller
    ;;
compute)
    neutron_compute
    tenant_network_types compute
    ;;
network)
    neutron_network_node
    tenant_network_types network
    ;;
controller-as-network-node)
    echo $YELLOW You will deploy network node on controller ... $NO_COLOR
    neutron_controller
    neutron_network_node controller 
    tenant_network_types controller 
    tenant_network_types network
    if [[ $IF_ENABLE_NEUTRON_HA_DVR = yes ]];then 
        enable_dvr controller 
    fi 
    ;;
compute-as-network-node)
    echo $YELLOW You will deploy network node on compute ... $NO_COLOR
    neutron_compute
    neutron_network_node compute
    tenant_network_types network
    tenant_network_types compute
    if [[ $IF_ENABLE_NEUTRON_HA_DVR = yes ]];then 
        enable_dvr compute  
    fi 
    ;;
*)
    debug "1" "neutron.sh just support controller ,network , compute and controller-as-network-node neutron_network_node compute parameter, your $1 is not support "
    ;;
esac
