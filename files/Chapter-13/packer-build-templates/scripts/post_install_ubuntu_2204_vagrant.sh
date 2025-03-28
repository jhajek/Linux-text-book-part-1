#!/bin/bash 
set -e
set -v

##################################################
# Add User customizations below here
##################################################
sudo apt update
sudo apt install -y links rsync
echo "Created by me!" >> /home/vagrant/success.txt

# Customization to disable password auth over ssh
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config.d/diable-password-auth.conf
