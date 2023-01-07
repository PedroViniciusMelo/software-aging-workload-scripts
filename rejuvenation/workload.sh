#!/bin/bash
#!/bin/bash
# Universidade Federal Rural de Pernambuco - Unidade Acadêmica de Garanhuns 
# Uname Research Group
# Felipe Oliveira 25/10/2018

# PARAMETERS
# $1= virtual machine name
# $2= path of the disks
# $3= base name of the disks
# $4= extension of the disks
# $5= number of disks

wait_time_after_attach=30
wait_time_after_deattach=10
wait_time_after_curl=15
count_disks=1
while true
do
    echo "Anexando disco... $3$count_disks"."$4"
    vboxmanage storageattach $1 --storagectl "SATA" --device 0 --port 1 --type hdd --medium $2$3$count_disks"."$4
    sleep $wait_time_after_attach
    echo "Dexanexando disco $3$count_disks"."$4"
    vboxmanage storageattach $1 --storagectl "SATA" --device 0 --port 1 --type hdd --medium none
    sleep $wait_time_after_deattach
    echo "Fazendo requisição no nginx..."
    curl localhost:8080  > /dev/null 2>&1
    sleep $wait_time_after_curl

    if [ $count_disks -lt $5 ]
    then
        count_disks=$(($count_disks + 1))
    else
        count_disks=1
    fi
done


