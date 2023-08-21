# Appendix D - Software and Version Control Setup Tutorial

![*Git commit messages--after developing this book I understand this completely*](images/Chapter-Header/Appendix-D/git_commit-2.png "Git Commit")

This is a tutorial for installing Git and configuring GitHub on Windows 10/11 and macOS.  

## Installing Git

[Git](https://git-scm.org "Gits site") is a piece of software that allows for distributed version control. [Version control](https://en.wikipedia.org/wiki/Version_control_system "Wikipedia Article on Version Control") is an idea that starts with having a central repository for controlling access to source code. Version control is a way that all source code, media, documentation, and supporting scripts for a project can be stored in a central place--with its history and changes all managed and recorded. This is usually a remote location and referred to as the **single source of truth**. With the rise of the internet, the concept of DVCS--**distributed version control software**, implemented the bring-over, merge, and modify model. Currently the industry standard [DVCS](https://en.wikipedia.org/wiki/Distributed_version_control "Wikipedia Article on DCVS") software is `Git`. Git should not be confused with `GitHub`. Git is opensource version control software and GitHub is a commercial implementation with a management portal for Git software, [owned by Microsoft](https://news.microsoft.com/announcement/microsoft-acquires-github/ "Article Microsoft buys GitHub").

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

Once you have successfully installed the `git` program and an editor ([VS Code](https://code.visualstudio.com/ "URL to download VS Code") is recommended) with first party Version Control integration you are ready to begin. As a note, though a good piece of software, we will not be using the GitHub Desktop software for this tutorial--everything can be done via your Shell and your editor.

You will have previously submitted your GitHub ID and received an invite to an private GitHub repo provided by the professor as part of their GitHub Organization. It will be in the form of: https://github.com/illinoistech-itm/HAWKID: accept this invitation. You will be greeted with a webpage that will show your **repository**, also known as a **repo**. This site, located on GitHub.com, will be your **source of truth** for all your markdown documents and code. From here we need to make a local copy of the repo so we can begin to interact with your remote repo.

#### Structure of a Git Repo

At first glance, Git and GitHub seem to just be an online file storage system, like Google Docs. The illusion of file storage is just for you to be able to visualize the repo contents in a familiar fashion. In reality [Git is not storing individual files](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F "web link Git Book"), it is storing an original copy and then additional deltas or changes to that file, that can be applied to reconstruct your document. If you make 1000 changes to some source code file, your Git Repo is only storing the changes from the previous state, not 1000 copies of the file. This allows you to inspect the history of all the code committed to your repo as well as roll back in time to previous states in the history. Online file storage cannot do that.

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

In October of 2021, GitHub, realizing how important it is to protect access to code repositories.  Most large companies are using GitHub and if a hacker were able to get into your source code, this would be a valuable prize.

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

Now lets make a key pair.

#### Generate a Public-key crypto key pair

We will be using the `ssh-keygen` command to generate your key pair. The command is the same on all platforms and will generate two keys for us, a **public key** and a **private key**. From PowerShell or the Mac or Linux Terminal run the following command:

```bash
ssh-keygen -t ed25519
```

A few things to watch out for, remember that Windows is **NOT** case sensitive, but Mac and Linux are case sensitive. Meaning of Mac, Git and git are not the same values, but on Windows they are.

```bash
# Note on Windows the divider: "\" is different than Mac and Linux 
# Mac and Linux use the "/"
# This example is on a Windows system
# The username on Windows in this case is: palad
Generating public/private ed25519 key pair.
Enter file in which to save the key (C:\Users\palad/.ssh/id_ed25519):
# Mac example would look like this
# The username on the Mac in this case is: palad
Generating public/private ed25519 key pair.
Enter file in which to save the key (/Users/palad/.ssh/id_ed25519):
```

The value in the parenthesis is the default value. If you were to hit the "ENTER" key it would place your Public and Private Key files in the directory and name the file accordingly. Lets modify this entry so you can identify each key pair and its purpose later.

At the prompt we will type the following and it will look like this:

```bash
# Remember, No spaces in the file name!
# Windows
Enter file in which to save the key ...: C:\Users\palad/.ssh/id_ed25519_556_github_key
# Mac\Linux
Enter file in which to save the key ...: /Users/palad/.ssh/id_ed25519_556_github_key
```

The next prompt will ask you to enter a **passphrase**, this is an additional password that can be attached to a private key and would be required to use the private key for authentication. This can be a good idea as it is an extra layer of security against physical theft of your private key file. But in the use case we are working we are going to opt not to use it and handle security in a different method. In this case you can hit the "ENTER" key twice and it will not add a passphrase to your private key.

```bash
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

You will now see some output similar to this:

```bash
Your identification has been saved in c:\Users\palad/.ssh/id_ed25519_556_github_key.
Your public key has been saved in c:\Users\palad/.ssh/id_ed25519_556_github_key.pub.
The key fingerprint is:
SHA256:3LR4sEpKQgbA6LT7yOP54QcAUJ5/BaDEY/zgo3YWrOA palad@lenovo-laptop
The key's randomart image is:
+--[ED25519 256]--+
|O+o ...          |
|o**o   .         |
|+oO+    o .      |
|.*o+.  o * .     |
|o.=.+ o S +      |
|.E * + . .       |
|o =.o .          |
| +o...           |
|.ooo.            |
+----[SHA256]-----+
```

We are interested in the first two lines of the output. They show the file location of the public and private key. The key fingerprint is not the content of the key. By default all operating systems, Windows, Mac, and Linux store key pairs in a hidden directory in your home directory called: `.ssh`.

```bash
# Location of private and public keys -- note the public key has a .pub extension
# The private key has no default extension
Your identification has been saved in c:\Users\palad/.ssh/id_ed25519_556_github_key.
Your public key has been saved in c:\Users\palad/.ssh/id_ed25519_556_github_key.pub
```

In order to make secure connections to GitHub we are going to need to add the content of the .pub Public key into your GitHub account. We can do this via copy and paste:

```bash
# display the content of the .pub file -- note the location of the file
# On Windows:
type c:\Users\palad/.ssh/id_ed25519_556_github_key.pub
# On Mac/Linux
cat /Users/palad/.ssh/id_ed25519_556_github_key.pub
# You will receive output similar to this
# Don't worry the public key is meant to be openly distributed
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILOgJFa4p2bLzbiqSfin87zzrFC29vULvMXd+MrwHbL0
palad@lenovo-laptop
```

#### Add Your Public Key to GitHub

Now that we have a public key generated, copy the displayed content. We will now access the private GitHub repo assigned to you. Mine would be: [https://github.com/illinoistech-itm/jhajek](https://github.com/illinoistech-itm/jhajek "jhajek public GitHub repo"). This site is marked public so anyone can view it. Your repo will be a private repo that only you and the instructor can see and requires authentication to access.

The steps listed here will help add your Public Key to your GitHub account for authentication. To begin, select the circle icon in the upper right corner to expand the option menu.

![*Log into your GitHub Account*](images/Appendix-D/tutorial/github-menu.png "Your GitHub account settings")

In this new menu near the bottom of the list your will see the **Settings** option.

![*Select the Settings Option*](images/Appendix-D/tutorial/settings.png "Select the Settings Option")

A new set of settings options will appear, we want to select on the left-hand side middle of the page, **SSH and GPG Keys**.

![*Select the SSH and GPG Keys option*](images/Appendix-D/tutorial/ssh.png "Select the SSH and GPG Keys option")

\newpage

On the right hand side of the new page, there will be a green **New SSH Key** button.

![*Select Green New Key Button*](images/Appendix-D/tutorial/new.png "Select Green New Key Button")

You will be presented with two text-boxes. The first is a title -- this is a comment that you can enter so you know where this key came from. I would recommend titling it based on two things: where is the key located (your laptop or desktop) and what is it for (the class number). This way you will give yourself a clue to the private keys location if you ever forget.

![*Enter a descriptive title for the key*](images/Appendix-D/tutorial/title.png "Enter a descriptive title for the key")

Paste the contents of the *.pub* file into the box labeled **Key** and hit the submit button. Your public key is now associated with your GitHub account to be used for authentication. Submit the key by hitting the green **Add SSH key** button.

![*Paste the content of your Public key*](images/Appendix-D/tutorial/key.png "Paste the content of your Public key")

\newpage

#### Create the config file in your .ssh directory

The last thing we need to do is create a file named `config` inside of your `.ssh` directory. This file is a shortcut convention where you can store values related to making SSH connections. This saves time typing on the command line all of the values needed to use our Private Key when we authenticate to GitHub. We will initiate this key pair via SSH. For those not familiar with SSH:

> *[The Secure Shell Protocol (SSH)](https://en.wikipedia.org/wiki/Secure_Shell "Wikipedia SSH article") is a cryptographic network protocol for operating network services securely over an unsecured network.[1] Its most notable applications are remote login and command-line execution.*

The `.ssh` directory is located in your home directory. For Windows this will be the path, `C:\Users\YOURUSERNAME\.ssh` on Mac and Linux it will be `/Users/YOURUSERNAME/.ssh`. On both operating systems you can use the `~` sign as a shortcut.

Let us create our `config` file. From the shell, lets type the command to open VS Code and create a file named, `config` in our `.ssh` directory.

```bash
# This command changes your directory to the correct location
cd ~/.ssh
# This command uses VS Code to create a file named: config
code config
```

Once VS Code is open you can now edit the `config` file. We need to put four entries into this file, though there are more values and entries that can be added, for now these four will do. The file is case-sensitive:

```bash
# Comments are allowed by using the # sign
# This line tells SSH to use these values whenever a connection is made
# to github.com
Host github.com
  # This is the username or ID you created for GitHub
  User jhajek
  Hostname github.com
  # This command tells SSH which Private key to use when making an SSH 
  # connection to GitHub
  IdentityFile ~/.ssh/id_ed25519_556_github_key
```

#### Cloning via SSH

Now we are set and ready to clone your remote repository to your local repository. To do this we need to open the shell on your computer. One of the hardest things in computing is *naming things*.  This includes where to store them. For instance should you use the Documents directory and create a new folder based on the class name? Some people prefer to create a folder per-semester. Whichever way you choose to do it remember a few things:

1. Be consistent in your naming and in the location your are storing things
1. Try not to use the Desktop folder -- have a dedicated storage location so you can reason about where you put things
1. Try not to use iCloud or OneDrive based disks that are backed up to the cloud as you already have a remote repository
1. No spaces in filenames or folder names...[ever](https://jeremyhajek.com/2011/07/15/spaces-will-always-kill-you.html "Blog post. Spaces will always kill you")

In my case I will create a new directory named `itmo-556` under my documents directory. You can use the File Explorer or the Finder in Mac to create files, but it is preferable to get comfortable with the commandline or shell. Opening PowerShell (or Terminal on a Mac) you will enter a series of commands:

```bash
# The cd command changes directory -- navigates down the tree
cd Documents
# The mkdir command makes a new directory
mkdir itmo-556
# The cd command moves you into the directory you just created
cd itmo-556
# This is the command that we use to make a clone of our remote repository
# Note: your URL will be different, change accordingly
git clone git@github.com:illinoistech-itm/sample-student.git
# Issue the cd command into the repo you just cloned (the name before the .git)
cd sample-student
# Issue the ls command to list the content of the just cloned directory
ls
# What do you see?
```

#### Opening your Repository to work with

Git is a commandline tool and it's many commands and features are replicated within the development IDEs such as VS Code, Atom, or Sublime editors. In our case we will be using VS Code. Our first step is to open the repository you just cloned to your system.

Once VS Code is open, click the `File` option and select `Open Folder`. Git doesn't see files, that is a concession to humans, who understand files, Git only sees `repositories` so to work with Git we always need to open a folder. In this case I will navigate to `~/Documents/itmo-556/sample-student` and click the `Select Folder` button. Remember, we are not opening individual files--we are opening a repository.

VS Code will open your just cloned repository, you will see an empty `Readme.md` file in the file manager (upper left) lets select this and begin to edit this file. The tutorial assignment requires you to edit your `Readme.md` to make a markdown document. This Readme.md will contain these elements written in Markdown. This is the [Markdown cheat sheet reference](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet "Markdown cheatsheet").

The document will include:

* h1 with your name
  * a picture of you
  * a picture of something that describes you
* h2 Where are you from?
  * Tell us where you are from
* h2 IT Interests
  * Tell us what you IT Interests and or skills are
* h2 Something Interesting About You
  * Tell us something interesting about you
* What was your first computing device?

Here is a completed sample: [https://github.com/illinoistech-itm/jhajek/blob/master/README.md](https://github.com/illinoistech-itm/jhajek/blob/master/README.md "Professor's GitHub Repo Sample"). **Note**, I will have more folders then you because I have sample code for more classes.

#### Git commands

Git has a concept of code repositories. Changes to code are stored only as the changes plus the originals. Each time code is committed, you are not storing a new version of a file, but only the deltas from each change. Git can reconstruct the original file by applying all the changes to present you with the current file. After a `git clone` command you now have a local copy of your remote repo. The repository located on GitHub is called your **remote repo**.

Most Git commands execute on your local repo. As files are changed and you save these changes, you will need to first commit your code to your local repo. Each time a change of code is committed you must add a commit message. This is a 140 character note that you leave to yourself or team members to briefly explain what changes were made. Once the commit message has been added and the changes have been committed. The last step is to do a `git push` command which will push your deltas (changes) to the `remote repo` and synchronize the local and the remote repos.

The basic commands we will be using in this tutorial are as follows:

* `git clone`
* `git add`
* `git commit`
* `git push`

#### Committing code to your remote repo

Once your Markdown document, `Readme.md` has been created and updated you will notice in VS Code that a number in a blue circle appears over the third icon down. This is the source control management pane. Let's click on this icon. You will see under the **Source Control** header a message box, a commit button, and a Changes list. Go ahead and add a short `commit message` and hit the `Commit` button (or `Ctrl + Enter` as a shortcut). This will commit your changes to the local repository. The final step is to click the three triple dots next to the refresh icon above the Message box. Select the `Push` option, this will `push` your changes to the remote GitHub repo.

You can see your changes synchronized to the remote repository by visiting the URL to your private GitHub repository. Go ahead and complete creating the Markdown tutorial.

#### Create a .gitignore file

Every Git repository needs a `.gitignore` file. This file tells Git to ignore certain files. These are files that are too large, binary format, or things like security keys and passwords, that we don't want to be committing to our Git Repos. We will create a file named: `.gitignore` and place the following values into it and add, commit, and push the file to your private repo.

```bash
# Files, Folders, security keys, and Binaries to ignore

*.vdi
*.box
.vagrant/
*console.log
packer-cache/
packer_cache/
*.pem
*~$
*.ova
output*/
vagrant.d/
*.iso
variables.pkr.hcl
*.priv
variables.json
.DS_Store
id_ed25519*
id_rsa*
id_rsa.pub
.Vagrantfile*
Vagrantfile~
config.default.yml
```

#### Conclusion

In this tutorial we introduced the concepts of Version Control and Public Key Encryption.  We introduced using Git and GitHub to facilitate our use of version control. Then we introduced how to add Public Key Encryption for accessing our remote repos via SSH. We learned to configure our local systems and local repos and we cloned a private repo using Git. Finally we learned and created a markdown document and a .gitignore file, committed changes to the local repo, and successfully pushed our changes to the remote repository.
