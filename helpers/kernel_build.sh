#!/bin/bash

KERNEL_VERSION=5.1.15

(cd /usr/src/linux-${KERNEL_VERSION}; make mrproper)
cp config-5.1.15 /usr/src/linux-${KERNEL_VERSION}/
cd /usr/src/linux-${KERNEL_VERSION}
make olddefconfig
make
make modules
make modules_install
cp arch/x86_64/boot/bzImage /boot/vmlinuz-${KERNEL_VERSION}
cp System.map /boot/System.map-${KERNEL_VERSION}
cp .config /boot/config-${KERNEL_VERSION}
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include
depmod -a

grub-mkconfig > /boot/grub/grub.cfg

