#bin/bash

# ansi colors for formatting heredoc

HOST_LIST=(
39.107.71.13
)

TOP_DIR=$(cd $(dirname $0); pwd)
cd ${TOP_DIR}
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


function ssh_key(){
    #make sure that all node can reachable from deploy host
    if [[ ${#HOST_LIST[*]} -ne 0 ]];then 
        echo $BLUE Checking the host\'s IPs $NO_COLOR
        for ips in ${HOST_LIST[*]};do
            echo " ${ips}"
            ping -c 1 ${ips} 1>/dev/null 2>&1
                debug "$?" "The ${YELLOW}$ips${RED} is unreachable from Deploy Host"       
        done 
    else 
        continue 
    fi
    
    #do ssh-key to nodes
    if [[ -e ~/.ssh/id_rsa.pub ]];then 
        rm -rf ~/.ssh/id_rsa*
        #continue
    fi
    echo $BLUE Generating public/private rsa key pair $NO_COLOR
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa 1>/dev/null
    #-N "" tells it to use an empty passphrase (the same as two of the enters in an interactive script)
    #-f my.key tells it to store the key into my.key (change as you see fit).
    which sshpass 1>/dev/null 2>&1 || rpm -ivh ./sshpass* 1>/dev/null 2>&1   
        debug "$?" "Install sshpass failed,Please Check $TOP_DIR If Has The Package !!!"    
    
    echo -n $BLUE Please type the correct password for ${YELLOW}${ips}${BLUE}:  $NO_COLOR
    read Password
    
    if [[ -e  ~/.ssh/known_hosts ]];then
        continue
    else
        touch ~/.ssh/known_hosts
    fi
    
    if [[ ${#HOST_LIST[*]} -ge 1 ]];then
        echo $BLUE Copying public key to target hosts: $NO_COLOR
        for ips in ${HOST_LIST[*]};do
            if [[ $(cat ~/.ssh/known_hosts | grep $ips | wc -l) -ge 2 ]];then        
                sed -i "/${ips}/d" ~/.ssh/known_hosts
                ssh-keyscan $ips >> ~/.ssh/known_hosts 
            else
                ssh-keyscan $ips >> ~/.ssh/known_hosts
            fi
        done
        for ips in ${HOST_LIST[*]};do 
            sshpass -p $Password ssh-copy-id -i ~/.ssh/id_rsa.pub root@$ips;
                debug "$?" "execute the sshpass to ${ips} failed "
        done
    fi
}

ssh_key

