#!/bin/bash

grub-install /dev/xvda
grub-mkconfig > /boot/grub/grub.cfg

groupadd --force --system --gid 98 qubes
useradd -m -U --shell /bin/bash user
usermod -a --groups qubes user
usermod -p '' root
usermod -L user
usermod -a -G wheel user

mkdir -p /etc/qubes/protected-files.d
mkdir -p /etc/skel

dbus-uuidgen --ensure=/etc/machine-id

sed -i '$iexport DISPLAY=:0' /etc/profile
sed 's# net # #' /etc/rc.conf

mv /etc/rc.local /etc/rc.local.bak
cp rc.local /etc/rc.local
