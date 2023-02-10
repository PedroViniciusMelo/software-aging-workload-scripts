#!/bin/bash
# Universidade Federal Rural de Pernambuco - Unidade Acadêmica de Garanhuns 
# Uname Research Group
# Felipe Oliveira 09/11/2018

# Parameters 
# $1 = number of disks
# $2 = size (MB)

count=0

while [ $count -lt $1 ]
do
    vboxmanage createhd --filename disk$count.vhd --size $2
    count=`expr $count + 1`
done