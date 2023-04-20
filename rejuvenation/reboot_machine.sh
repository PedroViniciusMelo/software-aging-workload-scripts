#!/bin/bash

force=$1
soft=$2
ssh=$3
vm_name=$4

vboxmanage storageattach vmDebian --storagectl "SATA" --device 0 --port 1 --type hdd --medium none
if [ "$soft" -eq 1 ]; then
  echo "Machine will reboot now | Graceful reboot"
  vboxmanage controlvm "$vm_name" acpipowerbutton
  sleep 5
  vboxmanage startvm "$vm_name" --type headless
  exit 0
fi

if [ "$ssh" -eq 1 ]; then
  echo "Machine will reboot now | SSH reboot"
  ssh -p 2222 root@localhost "/sbin/shutdown -r now"
  sleep 5
  exit 0
fi

if [ "$force" -eq 1 ]; then
  echo "Machine will reboot now | Forced reboot"
  vboxmanage controlvm "$vm_name" reset
  sleep 5
  exit 0
fi
