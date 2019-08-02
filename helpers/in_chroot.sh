#!/bin/bash

# install grub2
grub-install /dev/xvda
grub-mkconfig > /boot/grub/grub.cfg

# because PAM will want the passwd changed first
sed -i '1s#0#1#' /etc/shadow

# create users, configure
groupadd --force --system --gid 98 qubes
useradd -m -U --shell /bin/bash user
usermod -a --groups qubes user
usermod -L user
usermod -p '' root
usermod -a -G wheel user

# revert shadow change so error shows up forcing chg
sed -i '1s#1#0#' /etc/shadow

# some qubes directories
mkdir -p /etc/qubes/protected-files.d
mkdir -p /etc/skel

dbus-uuidgen --ensure=/etc/machine-id

# to ensure user/root all attach to :0
sed -i '$iexport DISPLAY=:0' /etc/profile

# disable crux' net config in favor of qubes'
sed 's# net # #' /etc/rc.conf

