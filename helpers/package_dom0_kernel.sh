#!/bin/bash

KERN_VERSION=$(uname -r)

mkdir /tmp/$KERN_VERSION
pushd /tmp/$KERN_VERSION

#: | gzip > initramfs
cp /boot/initramfs-$KERN_VERSION.img initramfs
cp /boot/vmlinuz-$KERN_VERSION vmlinuz
cp /boot/config-$KERN_VERSION .

echo 'root=/dev/xvda3 ro nomodeset console=hvc0 xen_scrub_pages=0' > default-kernelopts-common.txt
popd

tar -C /tmp -czf kernel.tar.gz $KERN_VERSION
rm -rf /tmp/$KERN_VERSION
