#!/bin/bash 
set -e
set -v

##############################################################################
# What is Vault?
# Secure, store, and tightly control access to tokens, passwords, 
# certificates, encryption keys for protecting secrets, and other sensitive 
# data using a UI, CLI, or HTTP API.
# https://developer.hashicorp.com/vault/install
##############################################################################

wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y vault
