#!/bin/bash
numCpuThread=(`grep 'processor' /proc/cpuinfo | sort -u | wc -l`)
printf "{\n"
printf  '\t'"\"data\":["
for ((i=0;i<$numCpuThread;i++))
do
         printf '\n\t\t{'
         printf "\"{#CPUTHREAD}\":\"$i\"}"
         if [ $i -lt $[$numCpuThread-1] ];then
                 printf ','
         fi
done
printf  "\n\t]\n"
printf "}\n"

