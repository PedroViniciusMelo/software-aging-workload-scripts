#!/bin/bash
#!/bin/bash
# Universidade Federal Rural de Pernambuco - Unidade Acadêmica de Garanhuns 
# Uname Research Group
# Felipe Oliveira 25/10/2018

# PARAMETERS
# $1= virtual machine name
# $2= path of the disks
# $3= quantidade de discos

wait_time_after_attach=30
wait_time_after_deattach=10
count_disks=1

while true
do
    vboxmanage storageattach "$1" --storagectl "SATA" --device 0 --port 1 --type hdd --medium "$2"$count_disks".vdh"
    sleep $wait_time_after_attach
    
    vboxmanage storageattach "$1" --storagectl "SATA" --device 0 --port 1 --type hdd --medium none
    sleep $wait_time_after_deattach

    if [ "$count_disks" -lt $3 ]
    then
        ((count_disks++))
    else
        count_disks=1
    fi
done


