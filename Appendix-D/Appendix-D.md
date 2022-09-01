# Appendix D - Git Tutorial

![*Git commit messages--after developing this book I understand this completely*](images/Chapter-Header/Appendix-E/git_commit-2.png "Git Commit")

This is a tutorial for installing Git and Git-it tutorial on Windows 10 and macOS.  

## Installing Git

[Git](https://git-scm.org "Gits site") is a piece of software that allows for distributed version control. [Version control](https://en.wikipedia.org/wiki/Version_control_system "Wikipedia Article on Version Control") is an idea that starts with having a central repository for controlling access to source code. Version control is a way that all source code, media, documentation, and supporting scripts for a project can be stored in a central place. This is usually a remote location and referred to as the **single source of truth**. With the rise of the internet, the concept of DVCS--**distributed version control software**, implemented the bring-over, merge, and modify model. Currently the industry standard [DVCS](https://en.wikipedia.org/wiki/Distributed_version_control "Wikipedia Article on DCVS") software is `Git`. Git should not be confused with `GitHub`. Git is opensource version control software and GitHub is a commercial implementation with a management portal for Git software, [owned by Microsoft](https://news.microsoft.com/announcement/microsoft-acquires-github/ "Article Microsoft buys GitHub").

Git can be installed on any operating system via an installer, but I recommend to install it via a third party package manger.

### Windows 10 and 11 - Git Installation via Chocolatey

[The Chocolatey Windows 10 package manager](https://chocolatey.org "chocolatey package manager install page") allows for scripted installs of applications.  This tool is convenient for installing common applications such as Firefox, Android Studio, Java JDK, VS code, VirtualBox and other commonly installed tools.  You need to enable PowerShell scripts, which is shown via [the install instructions](https://chocolatey.org/install "Chocolatey install instructions").  Using a package manager allows for having scripted installations as well as a function to update software in place from the command line.

From PowerShell (not CMD!) with Administrative privileges, run this command to install chocolatey:

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol `
= [System.Net.ServicePointManager]::SecurityProtocol `
-bor 3072; iex ((New-Object `
System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Upon finishing this command you will need to close PowerShell and reopen it with Administrative privileges again. Once you have this done you can use the ```choco``` command to install Git amongst other software.

```PowerShell
# from an admin console
choco install git vscode powershell-core
# You can also install VirtualBox via choco too
```

Once this is successful make sure to close the PowerShell console that was launched with Administrator privileges. Open PowerShell console, this time version 7--with the dark blue icon, not the light blue icon. Type the command: `git --version`, if the installation went well you will see version information printed to PowerShell similar to this: `git version 2.20.1.windows.1`

### macOS - Git Installation via Homebrew

[Homebrew](https://brew.sh/ "macOS Homebrew webpage") is a third party package manager available for MacOS. Both Intel Macs and M1 Macs are supported by Homebrew. This functions as a much needed package manager and a way to install needed packages in an automated fashion. Using a package manager allows for having scripted installations as well as a function to update software in place from the command line.

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

## Git Basics

There are many Git Tutorials available on the Internet, some paid, and some free. The main source of documentation is the [Git Book](https://git-scm.com/book/en/v2 "Link to Git Book") from the Git developers and is available on line for free and in a printed edition.  We will be referencing some of that material in this tutorial and adding some more specific details.

### Initial Git Setup

Once you have successfully installed the `git` program as well as an editor (VSCode is recommended) that has first part Version Control integration.  We are good to go. Though a good piece of software, we will not be using the GitHub Desktop software for this tutorial--everything can be done via your Shell and your editor.

You will have previously submitted your GitHub ID and received an invite to an private GitHub repo provided by the professor as part of their GitHub Organization. It will be in the form of: https://github.com/illinoistech-itm/HAWKID.

Accept this invitation. You will be greeted with a webpage that will show your **repository** or **repo** for short. This site, located on GitHub, will be your **source of truth** for all markdown documents and code. From here we need to make a local copy of the repo so we can begin to interact with your remote repo.

#### Structure of a Git Repo

At first glance, Git and GitHub seem to just be an online file storage system, like Google Docs. The illusion of file storage is just for you to be able to process the contents in a familiar fashion. In reality [Git is not storing individual files](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F "web link Git Book"), it is storing an original copy and then additional deltas or changes to that file, that can be applied to reconstruct your document. If you make 1000 changes to some source code, your Git Repo is only storing the changes from the previous state, not 1000 copies of the file. This allows you to inspect the history of all the code committed to your repo as well as roll back in time to previous states in the history. Online file storage cannot do that.

#### Initial Setup

On your local system we now need to configure a few things. First we need to tell `git` a name and contact email so that every time code is committed to a repo, it is tagged with a name and a contact email. This is not so important when it is just you working on some homework, but is important when you are working on a large team or in a large company and want to know who made what change.

Go ahead and open a shell (PowerShell or Terminal on a Mac) and lets execute [a few setup commands for `git`](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup "Web link to getting started first time Git Setup").

```bash
# The first command is to set the user.name for each commmit
git config --global user.name "John Doe"
# The second command is to set the user.email for each commit
git config --global user.email johndoe@example.com
```

This step only has to be done once on your computer after installation of `git`. You can check if the values are set correctly by issuing the command: `git config --list`

#### Git Commands

Git has a rich suite of tools and a large number of options. In this tutorial we are going to cover about seven of the core actions that will make you conversant with git as well as show how to securely setup remote access to your Git repo.  You can always find help for commands by typing: `git --help` or for a specific command: `git add --help`.  Note if you have a GUI a local webpage with the help info will open, if you are on a GUI-less server, then the text will print out to the screen.

* `git add`
  * Add file contents to the index
* `git commit`
  * Record changes to the repository
* `git status`
  * Show the working tree status
* `git push`
  * Update remote refs (remote repos) along with associated objects
* `git pull`
  * Fetch from and integrate with another repository or a local branch
* `git clone`
  * Clone a repository into a new directory
* `git remote`
  * Manage set of tracked repositories

#### Securing your GitHub authentication

In order to authenticate to your own repo we need to select an authentication method. In the past, GitHub used a username and password combo. This was not considered secure as the password and username had to be passed inside the URL of the request. We are all familiar with username and passwords and they are the easiest but the hardest to secure.

In October of 2021, GitHub realizing how important it is to protect access to code repositories.  Most large companies are using GitHub and if a hacker were able to get into your source code, this would be a valuable prize.

So GitHub removed the password authentication method, no longer possible. They replaced it with something called a PAT, [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token "Web Site for GitHub Personal Access Token"). PATs have advantages over username/password combos.

* PATs can be declared, at creation time, as valid for a limited period
  * Default duration is 30 days
  * This cause keys to be cycled
  * Prevents old keys from having long lives -- say after an employee leaves
  * Downside is that many keys have to be managed and distributed
* PATs can also limit the activity a key can do
  * Can be made read-only for instance
  * Can give you fine grain control over who can modify code in a repo
* PATs are actually one large mathematically unique tokens
  * No username or password that can identify you and your organization
  * Just a token
  * Downside - transmitted in your request
* Tokens are good for automated processes and are far better than usernames and passwords

We though are going to go one layer of security deeper. We will be using [Public-key cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography "wikipedia public-key cryptography page") key pairs for SSH. We will be using the [Twisted Edwards Curve Cryptography](https://en.wikipedia.org/wiki/Twisted_Edwards_curve "wikipedia link to Twisted Edwards Curve Cryptography") for the encryption.

#### Public-key cryptography key pairs

Some of these terms may be new to you, some may be familiar. In all cases we will walk you through each step regardless of your experience. The idea behind Public-key cryptography involves two keys to use for authentication in place of passwords and usernames. There is a public key, which is distributed widely and there is a private key, which completes the key and needs to be kept private.

> *The generation of such key pairs depends on cryptographic algorithms which are based on mathematical problems termed one-way functions. Effective security requires keeping the private key private; the public key can be openly distributed without compromising security.*


We will be using the `ssh-keygen` command to generate a key pair.



From PowerShell or the Mac Terminal run the following command:

```bash
ssh-keygen -t ed25519
```

This will launch an interactive prompt that will ask you a few questions about your keypair.
