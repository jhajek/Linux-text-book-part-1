#!/bin/bash 
set -e
set -v

#######################################################
# This shells script is used for demonstration purposes
# But is fully active and will install multiple pieces of software 
# used for collecting operating system metrics and storing them
# in a timeseries datastore - to be accessed and graphed
##################################################

cat << EOT >> /etc/hosts
# Nodes
192.168.33.100  riemanna riemanna.example.com
192.168.33.101  riemannb riemannb.example.com
192.168.33.102  riemannmc riemannmc.example.com
192.168.33.200  graphitea graphitea.example.com
192.168.33.201  graphiteb graphiteb.example.com
192.168.33.202  graphitemc graphitemc.example.com
EOT

## Command to change hostname
sudo hostnamectl set-hostname graphitemc

# Commands to install graphite, carbon-cache and carbon-relay services,
# and whisper flatfile database
# http://askubuntu.com/questions/549550/installing-graphite-carbon-via-apt-unattended
sudo apt-get update
sudo apt-get install -y apt-transport-https

sudo DEBIAN_FRONTEND=noninteractive apt-get -y --allow-change-held-packages install graphite-carbon python3-whisper

## Command to stop the carbon-cache and carbon-relay services, as we need to edit
# edit their systemd service files later
sudo systemctl stop carbon-cache.service
sudo systemctl stop carbon-relay@1.service

## Command to install gunicorn, which is an applicaiton server which will servce 
# our graphite api on port 8542 - https://gunicorn.org/
sudo apt-get install -y gunicorn

# Dependencies needed to install graphite-api 
# Since we are using the .deb package for graphite-api and not installing via apt-get
# We need to manually retrieve all the dependencies
sudo apt-get install -y python3-cairocffi python3-flask python3-pyparsing python3-tz python3-tzlocal libjs-sphinxdoc sphinx-rtd-theme-common

# These commands install the graphite-api version 1.1.3-6 which fixes our problems...
# We will also install the latest version of python3-structlog which graphite-api 1.1.3-6 requires
# from the Ubuntu 20.10 repo as well
# Turns out the problem is the default package in Ubuntu 20.04 repository for graphite-api 1.1.3-5 
# https://bugs.launchpad.net/ubuntu/+source/graphite-api/+bug/1879148
# The solution was to grab the fixed package from the next version of Ubuntu 20.10, codenamed Groovy Gorilla
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=954600
# Is this normal?  No but its only for the Ubuntu 20.04 Focal distro that this fix wasn't back ported to
# https://packages.ubuntu.com/groovy/graphite-api
# https://packages.ubuntu.com/focal/graphite-api

wget http://archive.ubuntu.com/ubuntu/pool/universe/p/python-structlog/python3-structlog_20.1.0-1_all.deb
sudo dpkg -i ./python3-structlog_20.1.0-1_all.deb
wget http://archive.ubuntu.com/ubuntu/pool/universe/g/graphite-api/graphite-api_1.1.3-6_all.deb
sudo dpkg -i ./graphite-api_1.1.3-6_all.deb

## Command to stop the graphite api service as we need to change out the default
## default graphite-api.service file with out own from our GitHub Repo
sudo systemctl stop graphite-api.service

## Commands to delete the uneeded service files for graphite-api, carbon-cache, and carbon-relay
## Commmand can be typed verbosly or as a single command using {}:
# sudo rm /lib/systemd/system/{carbon-cache,carbon-relay@}.service
sudo rm /lib/systemd/system/carbon-relay@.service
sudo rm /lib/systemd/system/carbon-cache.service  

## Command to install Grafana graphing tool
wget https://dl.grafana.com/oss/release/grafana_7.3.6_amd64.deb
sudo dpkg -i grafana_7.3.6_amd64.deb

## Command to clone your own @hawk ID private repo with all the configuration files
# We need to add
git clone git@github.com:illinoistech-itm/sample-student.git

## Code to copy the new systemd service files from our GitHub repo code to the systemd service directory
sudo cp -v ./sample-student/itmo-453/week-09/service-files/carbon-cache@.service /lib/systemd/system/carbon-cache@.service
sudo cp -v ./sample-student/itmo-453/week-09/service-files/carbon-relay@.service /lib/systemd/system/carbon-relay@.service

## Code to cp our carbon.conf configuration file we created and overwrite the default
sudo cp -v ./sample-student/itmo-453/week-09/graphite/graphitemc/carbon.conf /etc/carbon/carbon.conf

## Code to cp our storage aggregation configuration files and overwrite the default
sudo cp -v ./sample-student/itmo-453/week-09/graphite/graphitemc/storage-schemas.conf /etc/carbon/storage-schemas.conf

## Code to create a blank storage aggregation file (not needed at the moment) but will avoid warning message 
# in the logs
sudo touch /etc/carbon/storage-aggregation.conf

## Ubuntu only - default file to start 2 carbon cache and 1 carbon-relay instances at boot time
sudo cp -v ./sample-student/itmo-453/week-09/graphite/graphitemc/graphite-carbon.default /etc/default/graphite-carbon

## Command to create the graphite-api search index file
sudo touch /var/lib/graphite/api_search_index

## Code to copy our customized Graphite parameter's file and overwrite the default one
sudo cp -v ./sample-student/itmo-453/week-09/graphite/graphitemc/graphite-api.yaml /etc/

## Command to reload all of the daemons and start them
# Daemon-reload must be run each time you change the content of a .service file
sudo systemctl daemon-reload 

# Command to start and enable at boot 2 instances of the carbon-cache
sudo systemctl enable carbon-cache@1.service
sudo systemctl enable carbon-cache@2.service

## Command to start and enable at boot 1 instance of carbon-relay
sudo systemctl enable carbon-relay@1.service

## Command to start and enable at boot the graphite-api--for Ubuntu running on port 8542
## you can check this by running the command:  ss -l
sudo systemctl enable graphite-api.service
sudo systemctl start graphite-api.service

# Command to start and enable the grafana-server, running on port 3000
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
