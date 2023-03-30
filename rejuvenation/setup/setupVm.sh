#!/bin/bash

VBoxManage unregistervm vmDebian --delete
./remove-disks.sh

mkdir ../disks
cp create-disks.sh ../disks
cd ../disks || exit

./create-disks.sh 51 1024

cd ..
vboxmanage import vmDebian.ova
vboxmanage list hdds
vboxmanage list vms

HOST_IP=$(hostname -I | awk '{print $1}')
VBoxManage modifyvm vmDebian --natpf1 "porta 8080,tcp,$HOST_IP,8080,,80"

vboxmanage startvm vmDebian --type headless

sleep 10

curl http://localhost:8080





