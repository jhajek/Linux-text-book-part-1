#!/bin/bash

brew update
brew install pandoc
brew install pandoc-citeproc
brew install librsvg python homebrew/cask/basictex
sudo tlmgr install collection-fontsrecommended
sudo tlmgr install titlesec

brew install wget

wget https://software.sil.org/downloads/r/charis/CharisSIL-5.000.zip -P /tmp
unzip /tmp/CharisSIL-5.000.zip -d ~/Library/Fonts

wget https://fonts.google.com/download?family=Inconsolata -O /tmp/Inconsolata.zip
unzip /tmp/Inconsolata.zip -d ~/Library/Fonts/Inconsolata
