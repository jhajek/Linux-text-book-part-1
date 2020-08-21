# Appendix E - Git Tutorial

![*Git commit messages--after developing this book I understand this completely*](images/Chapter-Header/Appendix-E/git_commit-2.png "Git Commit")

This is a tutorial for installing Git and Git-It tutorial on Windows 10 and macOS.  

## Installing Git

[Git](https://git-scm.org "Gits site") is a piece of software that allows for distributed version control.  Version control is an idea that started with giving a central repository for controlling access to source control. Version control is a way that all source code for a project can be stored in a central place.   With the rise of the internet, the concept of DVCS--distributed version control software, implemented the bring-over, merge, and modify model. Currently the industry standard VCS software is Git.  Git should not be confused with GitHub.  Git is the opensource version control software and GitHub is a commercial implementation of the Git software.

Git can be installed on any operating system via an installer.  But I recommend to install it via a third party package manger.

### Windows 10 - Chocolatey

[Chocolatey Windows 10 package manager](https://chocolatey.org "chocolatey package manager install page")

Chocolatey is a package manager that allows for scripted installs of applications.  This tool is convenient for installing common applications such as Firefox, Android Studio, Java JDK, VS code, and other commonly installed tools.  You need to enable PowerShell scripts, which is shown via [the install instructions](https://chocolatey.org/install "Chocolatey install instructions").  

From PowerShell (not console or terminal!) with Administrative privileges, run this command to install chocolatey:

```PowerShell
Set-ExecutionPolicy AllSigned
```

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Upon finishing this command you will need to close the PowerShell terminal and reopen it with Administrative privileges again.  Once you have this done you can use the ```choco``` command to install Git amongst other software.

![*Choco install*](images/Appendix-E/powershell-choco.png "Administrator console Choco install of Git")

### macOS - Home Brew

[macOS - Home Brew](https://brew.sh/ "macOS homebrew webpage")
