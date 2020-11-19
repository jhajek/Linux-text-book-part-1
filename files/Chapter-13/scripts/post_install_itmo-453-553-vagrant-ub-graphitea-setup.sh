#!/bin/bash 
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/init-users
sudo cat /etc/sudoers.d/init-users

# Installing vagrant keys
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
sudo mkdir -p /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh

# Add customizations after this line
##################################################
# Change hostname and /etc/hosts
##################################################
cat << EOT >> /etc/hosts
# Nodes
192.168.33.110 riemanna riemanna.example.com
192.168.33.120 riemannb riemannb.example.com
192.168.33.100 riemannmc riemannmc.example.com
192.168.33.210 graphitea graphitea.example.com
192.168.33.220 graphiteb graphiteb.example.com
192.168.33.200 graphitemc graphitemc.example.com
192.168.33.150 ela1 ela1.example.com
192.168.33.160 ela2 ela2.example.com
192.168.33.170 ela3 ela3.example.com
192.168.33.180 logstash logstash.example.com
192.168.33.10 host1 host1.example.com
192.168.33.11 host2 host2.example.com
EOT

sudo hostnamectl set-hostname graphitea

##################################################
sudo apt-get update
sudo apt-get install -y python3-dev python3-pip python3-setuptools
#http://askubuntu.com/questions/549550/installing-graphite-carbon-via-apt-unattended
sudo DEBIAN_FRONTEND=noninteractive apt-get -y --allow-change-held-packages install graphite-carbon python-whisper
# sudo apt-get install -y graphite-carbon python-whisper
sudo apt-get install -y apt-transport-https 

# P.135 - Listing 4.13: Installing the graphite-api package on Ubuntu
sudo apt-get install -y graphite-api gunicorn3

# https://grafana.com/grafana/download
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_7.1.5_amd64.deb
sudo dpkg -i grafana_7.1.5_amd64.deb

# cloning source code examples for the book
git clone https://github.com/turnbullpress/aom-code.git

# Not needed
# sudo cp -v /home/vagrant/aom-code/4/graphite/graphite-api.service /lib/systemd/system/
# P.137
sudo cp -v /home/vagrant/aom-code/4/graphite/carbon.conf /etc/carbon/
# P.153
sudo cp -v /home/vagrant/aom-code/4/graphite/graphite-carbon.default /etc/default/graphite-carbon
# P.157
sudo systemctl stop carbon-relay@1.service
sudo rm -f /lib/systemd/system/carbon-relay@.service
sudo systemctl stop carbon-cache.service
sudo rm -f /lib/systemd/system/carbon-cache.service
sudo cp -v /home/vagrant/aom-code/4/graphite/carbon-cache@.service /lib/systemd/system/
sudo cp -v /home/vagrant/aom-code/4/graphite/carbon-relay@.service /lib/systemd/system/
# P.159
sudo cp -v /home/vagrant/aom-code/4/graphite/graphite-api.yaml /etc/
sudo touch /var/lib/graphite/api_search_index
sudo touch /etc/carbon/storage-aggregation.conf
##################################################################################################
# Start Services
##################################################################################################
sudo systemctl enable carbon-cache@1.service
sudo systemctl enable carbon-cache@2.service
sudo systemctl start carbon-cache@1.service
sudo systemctl start carbon-cache@2.service

sudo systemctl enable carbon-relay@1.service
sudo systemctl start carbon-relay@1.service

sudo systemctl daemon-reload 
sudo systemctl enable graphite-api
sudo systemctl start graphite-api

sudo systemctl enable grafana-server
sudo systemctl start grafana-server
