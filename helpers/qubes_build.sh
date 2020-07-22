#!/bin/bash

# enable contrib ports tree
mv /etc/ports/contrib.rsync.inactive /etc/ports/contrib.rsync
ports -u

# install prereqs for xen
echo 'CRUX rolling release' > /etc/redhat-release
(cd /usr/ports/contrib/lsb-release; pkgmk -d -i)
(cd /usr/ports/qubes-crux/bcc; pkgmk -d -i)
(cd /usr/ports/contrib/iasl; pkgmk -d -i)
(cd /usr/ports/qubes-crux/yajl; pkgmk -d -i)
(cd /usr/ports/qubes-crux/qubes-vmm-xen; pkgmk -d -i)

(cd /usr/ports/qubes-crux/qubes-core-vchan-xen; pkgmk -d -i)

# pip installations necessary for qubes-linux-utils
./pip_install.sh
(cd /usr/ports/contrib/dracut; pkgmk -d -i)
(cd /usr/ports/qubes-crux/qubes-linux-utils; pkgmk -d -i)

# qcal + use new fstab
(cd /usr/ports/contrib/pandoc-bin; pkgmk -d -i)
(cd /usr/ports/qubes-crux/qubes-core-agent-linux; pkgmk -d -i)
cp /etc/fstab.qubes /etc/fstab

(cd /usr/ports/qubes-crux/qubes-gui-common; pkgmk -d -i)
(cd /usr/ports/qubes-crux/qubes-core-qubesdb; pkgmk -d -i)

# prereqs for qgal
(cd /usr/ports/opt/libsndfile; pkgmk -d -i -if)
(cd /usr/ports/opt/pulseaudio; pkgmk -d -i)
(cd /usr/ports/contrib/libmnl; pkgmk -d -i)
(cd /usr/ports/contrib/ethtool; pkgmk -d -i)
(cd /usr/ports/qubes-crux/qubes-gui-agent-linux; pkgmk -d -i)

# build u2mfn module
(cd /usr/ports/qubes-crux/u2mfn; pkgmk -d -i)
depmod -a

# turn on all the services in rc.conf
mv /etc/rc.conf /etc/rc.conf.bak
cp /etc/init.d/qubes-* /etc/rc.d/
cp -r dest/* /
