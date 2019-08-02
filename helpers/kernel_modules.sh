#!/bin/bash

(cd /usr/ports/qubes-crux/u2mfn; pkgmk -d -i)
depmod -a
