#!/bin/bash

disco=$(df | grep /dev/nvme0n1p4)
usado=$(echo $disco | awk '{print $3}')
# Obtem o tempo atual, no formato RFC3339: AAAA-MM-DD HH:MM:SS 
tempo=$(date --rfc-3339=seconds)
# Separa data e hora do tempo obtido
data=$(echo $tempo | cut -d\  -f1)
hora=$(echo $tempo | cut -d\  -f2 | awk 'BEGIN{FS="-"}{print $1}')
echo "$usado $data $hora" >>logs/monitoramento-disco.txt

