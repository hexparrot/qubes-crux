#!/bin/bash

echo -n 'eth0 operational state: '
if cat /sys/class/net/eth0/operstate | grep up; then
  echo 'eth0 appears configured, skipping configure steps'
else
  IP=${IP:?"Provide env variable: IP=10.137.0.x"}
  GW=${GW:?"Provide env variable: GW=10.137.0.y"}
  DEV=eth0
  
  ifconfig $DEV up
  ip route add $GW dev $DEV
  ip route add default via $GW
  
  ip addr add $IP/32 dev $DEV
  ip link set $DEV up
fi

echo 'nameserver 10.139.1.1' >> /etc/resolv.conf

