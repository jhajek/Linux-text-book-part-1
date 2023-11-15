#!/bin/bash

sudo apt-get -y update
sudo apt-get install wget git
if [ -e ./pandoc-3.1.3-1-amd64.deb ]
  then
    sudo dpkg -i pandoc-3.1.3-1-amd64.deb
    rm ./pandoc-3.1.3-1-amd64.deb
  else
    wget https://github.com/jgm/pandoc/releases/download/3.1.3/pandoc-3.1.3-1-amd64.deb
    sudo dpkg -i pandoc-3.1.3-1-amd64.deb
    rm ./pandoc-3.1.3-1-amd64.deb
fi

sudo apt-get install -y texlive texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra texlive-xetex texlive-font-utils librsvg2-bin  texlive-science-doc texlive-science

wget http://packages.sil.org/sil.gpg
sudo apt-key add sil.gpg
sudo apt-add-repository -y "deb http://packages.sil.org/ubuntu/ $(lsb_release -sc) main"
sudo apt-get update
sudo apt-get -y install fonts-sil-charis

sudo apt-get -y install fonts-inconsolata
sudo fc-cache -fv

echo "Pandoc has been installed. +)"
