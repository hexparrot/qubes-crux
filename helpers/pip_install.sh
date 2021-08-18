#!/bin/bash

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip27.py
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip27.py
python3 get-pip.py
pip2 install pyxdg
pip2 install dbus-python 
pip2 install PyGObject
pip3 install xcffib

