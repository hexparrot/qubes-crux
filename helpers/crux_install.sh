#!/bin/bash


err=''
trap "err+=1" ERR

for ATTEMPTS in 1 2 3; do
  err=''
  umount --force /mnt/sys/firmware/efi/efivars 2>/dev/null
  umount --force /mnt/sys 2>/dev/null
  umount --force /mnt/dev/pts 2>/dev/null
  umount --force /mnt/dev 2>/dev/null
  umount --force /mnt/tmp 2>/dev/null
  umount --force /mnt/run 2>/dev/null
  umount --force /mnt/proc 2>/dev/null

  umount /dev/xvda1 2>/dev/null

  if [[ ${#err} -eq 8 ]]; then
    #echo "if length is 8, all mounts are unmounted"
    break
  fi
done

if [[ ${#err} -ne 8 ]]; then
  echo 'multiple attempts to unmount all /mnt mounts failed, aborting.'
fi

mkfs.ext4 /dev/xvda1
mount /dev/xvda1 /mnt

mkdir -p /mnt/var/lib/pkg
touch /mnt/var/lib/pkg/db

cd /media/crux
echo 'installing core...'
find core \( -name '*.pkg.tar.*' \) -exec pkgadd -r /mnt -f {} \;
echo 'installing opt...'
find opt \( -name '*.pkg.tar.*' \) -exec pkgadd -r /mnt -f {} \;
echo 'installing xorg...'
find xorg \( -name '*.pkg.tar.*' \) -exec pkgadd -r /mnt -f {} \;

