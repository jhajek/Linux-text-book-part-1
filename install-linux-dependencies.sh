#!/bin/bash

sudo apt-get -y update
sudo apt-get install wget git
wget https://github.com/jgm/pandoc/releases/download/2.2.2.1/pandoc-2.2.2.1-1-amd64.deb
sudo dpkg -i pandoc-2.2.2.1-1-amd64.deb
sudo apt-get -y install texlive texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra texlive-xetex


wget http://packages.sil.org/sil.gpg
sudo apt-key -y add sil.gpg
sudo apt-add-repository -y "deb http://packages.sil.org/ubuntu/ $(lsb_release -sc) main"
sudo apt-get update
sudo apt-get -y install fonts-sil-charis

sudo apt-get -y install fonts-inconsolata
sudo fc-cache -fv