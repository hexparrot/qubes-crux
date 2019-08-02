#!/bin/bash

KERNEL_VERSION=5.1.15

(cd /usr/ports/qubes-crux/u2mfn; pkgmk -d -i)
depmod -a

grub-mkconfig > /boot/grub/grub.cfg

