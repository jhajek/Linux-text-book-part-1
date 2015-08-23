# Linux-text-book-part-1
This is the outline and of intermediate content for Linux Technology and Philosophy based on LPIC II


How to install;

1.  You can just open the markdown (.md) in Visual Studio Code Editor (great free editor with Markdown preview support built in and it is cross platform Windows, Mac and Linux!) [Here is the link](https://code.visualstudio.com/)

2.  Use Pandoc to build your output (This README assumes you are using Linux, but these instructions can be adapted to build on Mac and Windows since pandoc has multiple distributions

[Install Instructions](http://pandoc.org/installing.html)

> Linux
> For 64-bit Debian and Ubuntu, we provide a debian package on the download page. This will install the pandoc and pandoc-citeproc executables and man pages. If you use an RPM-based distro, you may be able to install this deb using alien.
> Or, try your package manager. Pandoc is in the Debian, Ubuntu, Slackware, Arch, Fedora, NiXOS, openSUSE, and gentoo repositories. Note, however, that versions in the repositories are often old.
> If the version in your repository is too old and you cannot use the deb we provide, you can install from source, using the instructions below under Installing from source. Note that most distros have the Haskell platform in their package repositories. For example, on Debian/Ubuntu, you can install it with apt-get install haskell-platform.
> For PDF output, you’ll need LaTeX. We recommend installing TeX Live via your package manager. (On Debian/Ubuntu, apt-get install texlive.)

[Getting-Started](http://pandoc.org/getting-started.html)

> Windows 
You need Pandoc 1.15.x  and MikTex 2.9.x to build this book proper

[Pandoc Windows pandoc-1.15.0.6.msi](https://github.com/jgm/pandoc/releases/tag/1.15.0.6 "Pandoc MSI")

[MikTex](http://miktex.org/download "Miktex Download")

In order to enable script execution for Powershell - run this command from an Administrator enabled Powershell console:

```powershell
Set-ExecutionPolicy RemoteSigned```

You can then run the build script ./build-windows.ps1 from the powershell window and this will generate the digital output