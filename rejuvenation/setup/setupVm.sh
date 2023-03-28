#!/bin/bash

VBoxManage unregistervm vmDebian --delete
./remove-disks.sh

mkdir ../disks
cp create-disks.sh ../disks
cd ../disks || exit

./create-disks.sh 50 1024

vboxmanage import "$1".ova
vboxmanage list hdds
vboxmanage list vms

HOST_IP=$(hostname -I | awk '{print $1}')
VBoxManage modifyvm "$1" --natpf1 "porta 8080,tcp,$HOST_IP,8080,,80"

vboxmanage startvm $1 --type headless





