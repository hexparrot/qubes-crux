#!/bin/bash

# mount all necessary fs from crux live iso
mount --bind /dev /mnt/dev
mount --bind /tmp /mnt/tmp
mount --bind /run /mnt/run
mount -t proc proc /mnt/proc
mount -t sysfs none /mnt/sys
mount -t devpts -o noexec,nosuid,gid=tty,mode=0620 devpts /mnt/dev/pts

if grep -qs /sys/firmware/efi/efivars /proc/mounts; then
	mount --bind /sys/firmware/efi/efivars /mnt/sys/firmware/efi/efivars
fi

# copy over the whole linux kernel and extract
mkdir -p /mnt/usr/src
cp /media/crux/kernel/linux-*.tar.xz /mnt/usr/src/
(cd /mnt/usr/src; tar -xf linux-*.tar.xz)

# enter the chroot and go!
chroot /mnt /usr/ports/qubes-crux/helpers/kernel_build.sh

