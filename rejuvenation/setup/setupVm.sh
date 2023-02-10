#!/bin/bash

vboxmanage import $1
vboxmanage startvm $1 --type headless

HOST_IP=$(hostname -I | awk '{print $1}')
VBoxManage modifyvm $1 --natpf1 "porta 8080,tcp,$HOST_IP,8080,,80"

