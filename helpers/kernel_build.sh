#!/bin/bash

# extract kernel version from dirnames, get most recent, semantic-versioned
name=$(ls -Av1 /usr/src | tail -1)
nums=${name#*-}
VERS=${nums%?}

cd /usr/src/linux-${VERS}
make mrproper
cp /usr/ports/qubes-crux/helpers/kernel.config .config

make olddefconfig
make
make modules
make modules_install
cp arch/x86_64/boot/bzImage /boot/vmlinuz-${VERS}
cp System.map /boot/System.map-${VERS}
cp .config /boot/config-${VERS}
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include
depmod -a

grub-mkconfig > /boot/grub/grub.cfg
