#!bin/bash
#below is install python3 on centos steps:
yum -y install https://centos7.iuscommunity.org/ius-release.rpm -y 
yum -y install python36u 
yum -y install python36u-pip
yum -y install python36u-devel 
echo "Dowloading the get-pip python script:"
wget https://bootstrap.pypa.io/get-pip.py  


