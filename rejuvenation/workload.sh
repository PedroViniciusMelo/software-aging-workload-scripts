#!/bin/bash
#!/bin/bash
# UFAPE
# Uname Research Group
# Felipe Oliveira 25/10/2018
# Pedro Vinícius 11/03/2022

# PARAMETERS
# $1= virtual machine name
# $2= path of the disks
# $3= quantidade de discos
#usage ./workload.sh vmDebian disks/ 50

wait_time_after_attach=10
wait_time_after_deattach=10
count_disks=1

echo "" > disks_events.txt
while true; do
  if [ "$(cat rebooting.txt)" -eq 1 ]; then
    continue
  fi
  vboxmanage storageattach "$1" --storagectl "SATA" --device 0 --port 1 --type hdd --medium "$2$count_disks.vhd"
  echo "Attaching: $2$count_disks.vhd" >> disks_events.txt
  sleep $wait_time_after_attach


  if [ "$(cat rebooting.txt)" -eq 1 ]; then
    continue
  fi
  vboxmanage storageattach "$1" --storagectl "SATA" --device 0 --port 1 --type hdd --medium none
  echo "Detaching: $2$count_disks.vhd" >> disks_events.txt
  sleep $wait_time_after_deattach


  if [ "$count_disks" -lt "$3" ]; then
    ((count_disks++))
    echo "" > disks_events.txt
  else
    count_disks=1
  fi
done
