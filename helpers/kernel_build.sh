#!/bin/bash

# extract kernel version from dirnames
name=$(ls -dAv1 /usr/src/*/ | tail -1)
nums=${name#*-}
VERS=${nums%?}

cd /usr/src/linux-${VERS}
make clean
make olddefconfig
make -j 2
make modules
make modules_install
cp arch/x86_64/boot/bzImage /boot/vmlinuz-${VERS}
cp System.map /boot/System.map-${VERS}
cp .config /boot/config-${VERS}
make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include

# ensure this occurs, no matter what the current installed state is
(cd /usr/ports/qubes-crux/u2mfn; pkgmk -f -d -i -u)
depmod -a

# create the initramfs ensuring u2mfn inclusion
dracut --force

grub-mkconfig > /boot/grub/grub.cfg

