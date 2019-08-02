#!/bin/bash

#IPADDR=10.137.0.2
#GW=10.137.0.18
#DEV=eth0
#
#ifconfig $DEV up
#ip route add $GW dev $DEV
#ip route add default via $GW
#
#ip addr add $IPADDR/32 dev $DEV
#ip link set $DEV up

echo 'nameserver 10.139.1.1' >> /etc/resolv.conf
