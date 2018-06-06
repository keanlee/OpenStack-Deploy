#!/bin/bash
#Author by  Hao Li 
#E-mail hao.li@hermes-sys.com 
#Date: 2018-5-22 Tuesday 

#This script force on auto delete the network and router which is unused 


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
1.#release Flating ip first 
2.release the router port   neutron router-interface-delete 64c40591-0f7b-4a89-b7ed-b1673682a430  203b92e5-51ba-42ea-96e5-e430d0e2
3.delete router port 




source /root/admin-openrc
function delete_net(){
neutron net-list 
neutron net-delete
neutron router-list

neutron floatingip-list


}


function delete_router(){


}

