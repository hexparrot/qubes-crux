#!/bin/sh


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

# copy over the whole qubes-crux tree
mkdir -p /mnt/usr/ports
cp -R ../../qubes-crux /mnt/usr/ports/

# enter the chroot and go!
chroot /mnt /usr/ports/qubes-crux/helpers/in_chroot.sh

