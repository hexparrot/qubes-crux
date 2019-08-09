#!/bin/bash

# mount all necessary fs from crux live iso
mount --bind /dev /mnt/dev
mount --bind /tmp /mnt/tmp
mount --bind /run /mnt/run
mount -t proc proc /mnt/proc 2&>/dev/null
mount -t sysfs none /mnt/sys 2&>/dev/null
mount -t devpts -o noexec,nosuid,gid=tty,mode=0620 devpts /mnt/dev/pts

if grep -qs /sys/firmware/efi/efivars /proc/mounts; then
	mount --bind /sys/firmware/efi/efivars /mnt/sys/firmware/efi/efivars
fi

name=$(ls -dAv1 /mnt/usr/src/*/)
nums=${name#*-}
VERS=${nums%?}

if [ ! -f "/mnt/usr/src/linux-$VERS/.config" ]; then
	cp -v /mnt/usr/ports/qubes-crux/helpers/kernel.config \
	      /mnt/usr/src/linux-$VERS/.config
fi

echo "cd /usr/src/linux-$VERS"
echo "make menuconfig"
echo "cd /usr/ports/qubes-crux/helpers"
echo "./kernel_build.sh #includes modules,headers,bzimage"
chroot /mnt /usr/bin/env PS1="(chroot) # ${PS1}" /bin/bash

