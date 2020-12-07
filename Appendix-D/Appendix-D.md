# Appendix E - Git Tutorial

![*Git commit messages--after developing this book I understand this completely*](images/Chapter-Header/Appendix-E/git_commit-2.png "Git Commit")

This is a tutorial for installing Git and Git-it tutorial on Windows 10 and macOS.  

## Installing Git

[Git](https://git-scm.org "Gits site") is a piece of software that allows for distributed version control.  Version control is an idea that started with giving a central repository for controlling access to source control. Version control is a way that all source code for a project can be stored in a central place.   With the rise of the internet, the concept of DVCS--distributed version control software, implemented the bring-over, merge, and modify model. Currently the industry standard VCS software is Git.  Git should not be confused with GitHub.  Git is the opensource version control software and GitHub is a commercial implementation of the Git software.

Git can be installed on any operating system via an installer, but I recommend to install it via a third party package manger.

### Windows 10 - Git Installation via Chocolatey

[The Chocolatey Windows 10 package manager](https://chocolatey.org "chocolatey package manager install page") allows for scripted installs of applications.  This tool is convenient for installing common applications such as Firefox, Android Studio, Java JDK, VS code, VirtualBox and other commonly installed tools.  You need to enable PowerShell scripts, which is shown via [the install instructions](https://chocolatey.org/install "Chocolatey install instructions").  Using a package manager allows for having scripted installations as well as a function to update software in place from the command line.

From PowerShell (not console or terminal!) with Administrative privileges, run this command to install chocolatey:

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol `
= [System.Net.ServicePointManager]::SecurityProtocol `
-bor 3072; iex ((New-Object `
System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Upon finishing this command you will need to close the PowerShell terminal and reopen it with Administrative privileges again.  Once you have this done you can use the ```choco``` command to install Git amongst other software. Lets install some software we will use during the class.

```PowerShell
# from an admin console
choco install git vscode powershell-core
# You can also install VirtualBox via choco
```

Once this is successful make sure to close the PowerShell console that was launched with Administrator privileges.  Open a PowerShell Core console with regular user permissions.  Then we can download and extract the [Git-it Tutorial](https://github.com/jlord/git-it-electron/ "Git-it install Page"). Git-it is a desktop (Mac, Windows and Linux) app that teaches you how to use Git and GitHub on the command line.  Releases can be found under the [Release Tab](https://github.com/jlord/git-it-electron/releases "Git-it Download Releases").  Extract the file, and navigate to the `Git-it.exe`:

![*Git-it Executable*](images/Appendix-E/git-it-windows-executable.png "Image of Git-it executable")

### macOS - Git Installation via Homebrew

[Homebrew](https://brew.sh/ "macOS Homebrew webpage") is a third party package manager available for macOS.  This functions as a needed package manager and a way to install needed packages via an automated fashion. Using a package manager allows for having scripted installations as well as a function to update software in place from the command line.

To install `Homebrew` or `brew` run the below command:

```bash
/bin/bash -c \
"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

For installing Git on a Mac, open the `terminal` app.  Run the command:

```bash
brew install git
brew cask install visual-studio-code
```

## Git-it Tutorial

Now you can proceed to complete the Git-it Tutorial.  As you complete the exercises, the *Challenges Completed* circles will fill in.  Complete all the exercises and take a snapshot of the completed work.  You will need a PowerShell or a macOS Terminal open while working on this tool.

![*Git-it Challenges*](images/Appendix-E/completed.png "Git-it challanges completed image")

This tutorial covers the major functionality of version control: init, add, commit, push, and pull.

* Get Git
* Repository
* Commit To It
* GitHubbin
* Remote Control
* Forks And Clones
* Branches Aren't Just For Birds
* It's A Small World
* Pull Never Out Of Date
* Requesting You Pull Please
* Merge Tada
