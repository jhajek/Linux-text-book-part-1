#!/bin/bash 
set -e
set -v

# Dependencies needed to install the graphite-api 
# We need to manually retrieve all the dependencies
sudo apt install python-pip python-setuptools python-dev

sudo apt install python-cairocffi python-flask python-pyparsing python-tz python-tzlocal libjs-sphinxdoc sphinx-rtd-theme-common

