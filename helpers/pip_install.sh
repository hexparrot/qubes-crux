#!/bin/bash

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
python3 get-pip.py
pip2 install pyxdg
pip2 install dbus-python 
pip2 install PyGObject
pip3 install xcffib

