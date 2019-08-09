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

# copy over the kernel present in original copy of this repo
echo "copying generic stripped kernel to chroot (/usr/ports/qubes-crux/helpers)..."
cp kernel.config /mnt/usr/ports/qubes-crux/helpers/kernel.config

name=$(ls -dAv1 /mnt/usr/src/*/)
nums=${name#*-}
VERS=${nums%?}

# enter the chroot and go!
chroot /mnt /bin/bash -x <<EOF

if [ ! -f "/usr/src/linux-$VERS/.config" ]; then
	echo "cleaning linux source tree and copying back config..."

	cd /usr/src/linux-"$VERS"
	make mrproper
	cp -v /usr/ports/qubes-crux/helpers/kernel.config \
	      /usr/src/linux-$VERS/.config
fi

cd /usr/ports/qubes-crux/helpers
/bin/bash /usr/ports/qubes-crux/helpers/kernel_build.sh

EOF
