# Linux-text-book-part-1

This is the outline and of intermediate content for Linux Technology and Philosophy based on LPIC II

How to install;

1. You can just open the markdown (.md) in Visual Studio Code Editor (great free editor with Markdown preview support built in and it is cross platform Windows, Mac and Linux!) [Here is the link](https://code.visualstudio.com/)

2. Use Pandoc to build your output. This README assumes you are using Linux, but these instructions can be adapted to build on Mac and Windows since pandoc has multiple distributions

[Install Instructions](http://pandoc.org/installing.html)

## Ubuntu Linux

I would recommend installing Pandoc directly from the latest Debian package.  Located here: [Pandoc Release Page for Pandoc 2.x](https://github.com/jgm/pandoc/releases/ "Pandoc Latest deb package").   You will need to issue a ```dpkg``` command to install the deb package directly.  ```sudo dpkg -i ```

### Linux dependencies - On Debian/Ubuntu

* texlive
* texlive-latex-recommended
* texlive-latex-extra
* texlive-fonts-recommended
* texlive-fonts-extra
* texlive-font-utils
* texlive-xetex
* librsvg2-bin

Install these via this command:
  
```bash
sudo apt-get install texlive texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra texlive-xetex texlive-font-utils librsvg2-bin
```

Additional Fonts are needed. To add the [Charis Sil font](http://packages.sil.org/ "Charis SIL") to Ubuntu can add the repo via these steps:

* ```wget http://packages.sil.org/sil.gpg```
* ```sudo apt-key add sil.gpg```
* ```sudo apt-add-repository "deb http://packages.sil.org/ubuntu/ $(lsb_release -sc) main"```
* ```sudo apt-get update```
* ```sudo apt-get install fonts-sil-charis```

To Install the Inconsolata font:

* ```sudo apt-get install fonts-inconsolata```
* ```sudo fc-cache -fv```

To confirm install from the command line type: ```pandoc -v```

### Linux Dependencies - On Fedora

This is for installing Pandoc 3.x branch. You will need to download the Pandoc binary from [pandoc.org](https://github.com/jgm/pandoc/releases/ "Pandoc GitHub release tab"), do not install via `dnf` or `yum` as those versions are out of date.  


Extract the tarball (tar.gz) and copy the contents of ```./pandoc-3.*/bin/```  to ```/usr/local/bin```. You will need to use `sudo` because ```/usr/local/bin/``` is owned by root. Tested with version 3.x.

* texlive
* texlive-latex-fonts
* texlive-xetex
* texlive-inconsolata-doc
* levien-inconsolata-fonts
* texlive-inconsolata
* texlive-nfssext-cfr.noarch
* texlive-plnfss.noarch
* texlive-psnfss.noarch
* texlive-nfssext-cfr
* sil-charis-compact-fonts
* sil-charis-fonts
* texlive-texliveonfly
* texlive-pdftex
* librsvg2-tools

```bash
sudo dnf install texlive texlive-latex-fonts texlive-xetex texlive-inconsolata-doc levien-inconsolata-fonts texlive-inconsolata texlive-nfssext-cfr.noarch texlive-plnfss.noarch texlive-psnfss.noarch texlive-nfssext-cfr sil-charis-compact-fonts sil-charis-fonts texlive-texliveonfly texlive-pdftex librsvg2-tools
```

To check if the install went correctly type: ```pandoc -v``` on the command line.

## macOS

Install the macOS *missing* package manager - [Homebrew](https://brew.sh "Homebrew install page") and run the instructions located here: [http://pandoc.org/installing.html](http://pandoc.org/installing.html)

```bash
brew install pandoc
brew install pandoc-siteproc
brew install libsvrg homebrew/basictex
sudo tlmgr update --self
sudo tlmgr install collection-fontsrecommended
```

To Install the Charis SIL font:

* ```wget https://software.sil.org/downloads/r/charis/CharisSIL-5.000.zip -P /tmp```
* ```unzip /tmp/CharisSIL-5.000.zip -d ~/Library/Fonts```

To Install the Inconsolata font:

* ```wget https://fonts.google.com/download?family=Inconsolata -O /tmp/Inconsolata.zip```
* ```unzip /tmp/Inconsolata.zip -d ~/Library/Fonts/Inconsolata```

## Windows

You need Pandoc > 3.x and > MikTex 2.9.x to build this book proper as well as the Charis Sil and Inconsolata fonts.

* [Pandoc Windows](https://github.com/jgm/pandoc/releases "Pandoc MSI")
  * It has been tested on Windows 10 with version 2.0, 2.1.3, and 2.5
* [MikTex](http://miktex.org/download "Miktex Download")
* [Inconsolata Font](https://fonts.google.com/specimen/Inconsolata?selection.family=Inconsolata "Inconsolata")
* [Charis Sil Font](https://software.sil.org/charis/download/ "Charis Sil")

In order to enable script execution for PowerShell - run this command from an Administrator enabled PowerShell console:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

You can then run the build script `./build-windows.ps1` from the PowerShell window and this will generate the digital output

On your first build you will receive a Package Installation dialogue from MikTex asking you to install additional packages so as to be able to generate PDFs.

### Windows Errors

If you receive this error:
![*fontspec error*](images/ReadMe/fontspec.png "fontspec error")

The way to remediate it to launch the MikTex Package Manager, search for fontspec, uninstall the ```fontspec``` package, then reinstall it.

### Kindle .mobi

~~~To generate .mobi files for use on Kindle devices or apps, you need to install ```Kindlegen``` from [Amazon here](https://www.amazon.com/gp/feature.html?docId=1000765211).  This executable converts epub file formats to .mobi which works in the Amazon Kindle Works on Windows, MacOS, and Linux.~~~

#### Reading ePUBs

On Windows there are a few less than ideal options for Reading epub files.

* Online cross Platform ePub Reader [Flow OSS](https://www.flowoss.com/ "Flow OSS website")
* [Mignaway Epub Reader](https://github.com/mignaway/EpubReader "Website Mignaway epub reader")
  * This is a new one under development but looks really good
* Browser Extensions and Plugins
  * [Firefox](https://addons.mozilla.org/en-US/firefox/search/?q=epub "Browser extensions for FireFox")
  * [Chrome](https://chrome.google.com/webstore/search/epub?utm_source=ext_app_menu "Chrome Webstore extensions")
  * [Edge](https://microsoftedge.microsoft.com/addons "Website MS Edge browser extensions")
* [Nook app](https://www.microsoft.com/en-us/p/nook-books-magazines-newspapers-comics/9wzdncrfj33h?activetab=pivot:overviewtab "nook app for Microsoft Store") from Microsoft Store