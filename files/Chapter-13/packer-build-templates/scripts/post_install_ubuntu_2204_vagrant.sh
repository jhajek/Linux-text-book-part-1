#!/bin/bash 
set -e
set -v

##################################################
# Add User customizations below here
##################################################
sudo apt update
sudo apt install -y links rysnc
echo "Created by me!" >> /home/vagrant/success.txt
