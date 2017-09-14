# Linux-text-book-part-1
This is the outline and of intermediate content for Linux Technology and Philosophy based on LPIC II


How to install;

1.  You can just open the markdown (.md) in Visual Studio Code Editor (great free editor with Markdown preview support built in and it is cross platform Windows, Mac and Linux!) [Here is the link](https://code.visualstudio.com/)

2.  Use Pandoc to build your output (This README assumes you are using Linux, but these instructions can be adapted to build on Mac and Windows since pandoc has multiple distributions

[Install Instructions](http://pandoc.org/installing.html)

## Ubuntu Linux
 
I would recommend installing Pandoc directly from the latest Debian package.  Located here: [Latest 1.19.X package](https://github.com/jgm/pandoc/releases/download/1.19.2.1/pandoc-1.19.2.1-1-amd64.deb "Pandoc Latest deb package"). For PDF output, you’ll need LaTeX. We recommend installing TeX Live via your package manager. 

### Linux dependencies - On Debian/Ubuntu
* ```sudo apt-get install texlive texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra``` 
* texlive
* texlive-latex-recommended
* texlive-latex-extra
* texlive-fonts-recommended
* texlive-fonts-extra

To add the [Charis Sil font](http://packages.sil.org/ "Charis SIL") to Ubuntu 16.04 can add the repo via these steps:
* ```wget http://packages.sil.org/sil.gpg```
* ```sudo apt-key add sil.gpg```
* ```sudo apt-add-repository "deb http://packages.sil.org/ubuntu/ $(lsb_release -sc) main"```
* ```sudo apt-get update```
* ```sudo apt-get install fonts-sil-charis```

## Mac OSX
  * [http://pandoc.org/installing.html](http://pandoc.org/installing.html)

## Windows 
You need Pandoc < 1.19.x and > MikTex 2.9.x to build this book proper as well as the Charis Sil and Inconsolata fonts.

*  [Pandoc Windows pandoc-1.19.1 msi](https://github.com/jgm/pandoc/releases/download/1.19.1/pandoc-1.19.1-windows.msi "Pandoc MSI")
*  [MikTex](http://miktex.org/download "Miktex Download")
*  [Inconsolata Font](https://fonts.google.com/specimen/Inconsolata?selection.family=Inconsolata "Inconsolata")
*  [Charis Sil Font](https://software.sil.org/charis/download/ "Charis Sil")

In order to enable script execution for Powershell - run this command from an Administrator enabled Powershell console:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

You can then run the build script ./build-windows.ps1 from the powershell window and this will generate the digital output

On your first build you will receive a Package Installation dialogue from MikTex asking you to install additional packages so as to be able to generate PDFs.

__Kindle .mobi__

To generate .mobi files for use on Kindle devices or apps, you need to install Kindlegen from [here](https://www.amazon.com/gp/feature.html?docId=1000234621) Works on Windows, MacOS, and Linux.

__Reading PDF and ePUB__

You can use any PDF reader, Adobe or the Microsoft Reader built into Windows 8 and 10.   Currently Microsft Edge browser has native ePub support in [Edge Browser](https://blogs.windows.com/windowsexperience/2017/04/20/week-microsoft-edge-browser-built-books-reading/#fhI8gshdmfAGSrIu.97 "ePub").

Or you can use the [FireFox ePub Reader plugin](https://addons.mozilla.org/en-US/firefox/addon/epubreader/ "Plugin to read ePub in FireFox") that lets you read directly from the browser.

ePub and PDF can alsop be read via the Barns and Noble Nook app.  It is available for all platforms, [iOS, Androis, and Windows](http://www.nook.com/nookapp/#appChoices "Nook app").  I use it and can recommend it on any platform.

the iBooks app on iOS works as well for viewing ePubs and PDFs.