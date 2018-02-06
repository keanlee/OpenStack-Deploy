#!/bin/bash
diskarray=(`iostat -dyx |awk '{print $1}'|sort|uniq   2>/dev/null`)
length=${#diskarray[@]}-2
printf "{\n"
printf  '\t'"\"data\":["
for ((i=0;i<$length;i++))
do
         printf '\n\t\t{'
         printf "\"{#DISKNAME}\":\"${diskarray[$i+2]}\"}"
         if [ $i -lt $[$length-1] ];then
                 printf ','
         fi
done
printf  "\n\t]\n"
printf "}\n"

