#!/bin/bash

disco=$(df | grep /dev/nvme0n1p4)
usado=$(echo $disco | awk '{print $3}')

echo "$usado;$date_time" >>logs/monitoramento-disco.csv

