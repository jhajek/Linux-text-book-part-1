#!/bin/bash

#Update timezone to UTC on Centos 6
#https://serverfault.com/questions/489574/where-is-the-utc-timezone-in-centos
#sudo rm -f /etc/localtime
#sudo ln -s /usr/share/zoneinfo/UTC /etc/localtime

#sudo reboot

sudo timedatectl set-timezone UTC
