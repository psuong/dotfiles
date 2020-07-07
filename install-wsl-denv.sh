#!/bin/bash

IP_ADDRESS=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
echo $IP_ADDRESS
export DISPLAY="$IP_ADDRESS:0"
