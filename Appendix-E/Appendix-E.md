# Appendix E - Linux Virtual Machine Installation Walk-through

![*Git commit messages--after developing this book I understand this completely*](images/Chapter-Header/Appendix-E/fight.png "Image of XKCD cartoon number 340 Fight")

This is an appendix detailing installation of `Ubuntu Desktop`, `Debian Desktop` and `Fedora Workstation` on x86 based `VirtualBox` and M-series ARM based `Parallels`.

## Virtual Box x86

Installing Linux Operating systems on `x86`, `x86_64`, or `AMD64` based machines-- Intel and AMD and Intel based MacOS.

\newpage

### Ubuntu 25.04

![Ubuntu 25.04 Live CD welcome screen](images/Appendix-E/ubuntu/welcome.png "image of live CD welcome screen.")

![Ubuntu 25.04 Language Choice](images/Appendix-E/ubuntu/lang.png "image of language choice.")

\newpage

![Ubuntu 25.04 Update Installer](images/Appendix-E/ubuntu/update-installer.png "image of installer update.")

![Ubuntu 25.04 Launch Installer or use Live CD](images/Appendix-E/ubuntu/interactive-install.png "image of Launch Installer or use Live CD.")

\newpage

![Ubuntu 25.04 Type of Installation Choice](images/Appendix-E/ubuntu/typeofinstallation.png "image of type of installation choice.")

![Ubuntu 25.04 Type of default applications installed](images/Appendix-E/ubuntu/applications.png "image of default Applications Installed.")

\newpage

![Ubuntu 25.04 Option to install additional drivers](images/Appendix-E/ubuntu/drivers.png "image of option to install additional drivers.")

![Ubuntu 25.04 Disk Setup Options](images/Appendix-E/ubuntu/disksetup.png "image of type of disk setup.")

\newpage

![Ubuntu 25.04 Option to encrypt drives](images/Appendix-E/ubuntu/encrypt.png "image of option to encrypt drives.")

![Ubuntu 25.04 Create encryption passphrase](images/Appendix-E/ubuntu/encryption.png "image of Create encryption passphrase.")

\newpage

![Ubuntu 25.04 Create User Account](images/Appendix-E/ubuntu/create-account.png "image of Create User Account.")

![Ubuntu 25.04 Ready to Install](images/Appendix-E/ubuntu/readytoinstall.png "image of last check before install.")

\newpage

![Ubuntu 25.04 First Boot After Install Encryption Unlock](images/Appendix-E/ubuntu/boot-unlock.png "image of First Boot After Install Encryption Unlock.")

![Ubuntu 25.04 Launching the terminal and running the Package Manager: Apt](images/Appendix-E/ubuntu/update.png "image of Launching the terminal and running the Package Manager: Apt.")

\newpage

### Fedora 42

![*Fedora 42 Start Live*](images/Appendix-E/fedora/start-live.png "image of Start Live")

![*Fedora 42 Try or Install*](images/Appendix-E/fedora/try-or-install.png "image of Try or Install Fedora 42")

\newpage

![*Fedora 42 Language Select*](images/Appendix-E/fedora/lang.png "image of Language select")

![*Fedora 42 Partitioning of Disks*](images/Appendix-E/fedora/install.png "image of partitioning of disks")

\newpage

![*Fedora 42 Installing...*](images/Appendix-E/fedora/installing.png "image of installing")

![*Fedora 42 The Install has finished*](images/Appendix-E/fedora/finished.png "image of the completed install")

### Debian 13


### Debian 12

## Instructions

*WELCOME* screen. Here you will be presented with the option to choose your install language. As well as presented with two options: *TRY UBUNTU* or *INSTALL UBUNTU*. The option *TRY UBUNTU* will load the actual Ubuntu operating system but load it into RAM and not install it on your hard drive. This is helpful because it gives you the option to use Ubuntu fully without permanently installing it. Note that all data is stored in memory so nothing will survive a reboot - but this may be a good tool for doing online banking with. The Live option also has the option to go into an install mode via a desktop icon.

![*Live or Install Mode*](images/Chapter-03/ubuntu-install/live-install.png "Live Install")

For installation type you will be presented with default options such as *ERASE DISK AND INSTALL UBUNTU*. In addition there are options for enabling full disk encryption for securing your install data. The third option listed is to install using the LVM method of partitioning, which will be covered in chapter 12. The fourth option is for a custom partitioning, which is helpful in cases when you are installing multiple operating systems and create a multi-boot system.

![*Confirm Partitions*](images/Chapter-03/ubuntu-install/installation-type.png "Installation Type")

At the completion of this dialog box you will be asked to confirm the automatically generated partitions created by the system. A Linux system needs a minimum of 2 partitions to function but 3 are recommended. Those partitions are / (pronounced root), /boot where all the files needed to start the OS are located, and swap which is an on disk based RAM supplement partition.

![*Installation Type*](images/Chapter-03/ubuntu-install/updates-and-other-software.png "Updates and Other Software")

The next parts of the installation contain pretty straight-forward parts: time zone selection, keyboard layout, and account creation and password setup. Note that Ubuntu doesn't create any root user by default, which ever user you create first is automatically placed into the **sudo** group, which is a super user. For a discussion of password strength and strategies [see this cartoon](http://imgs.xkcd.com/comics/password_strength.png "Password Strength Argument"). You can also see the install details by clicking the small white triangle to reveal the verbose output of the process

![*Install Details*](images/Chapter-03/ubuntu-install/user-account.png "User Account Details")

### Installing Fedora

Similarly on Fedora you will be presented with the option to *Start Fedora Live* or go into troubleshooting mode. You will be presented with an install screen similar above: *TRY FEDORA* or *INSTALL TO HARD DRIVE*. Fedora 32 will initially present you with a language screen option. After choosing your default language the next step is the *installation summary*.

![*Installation Summary*](images/Chapter-03/fedora-install/installation-summary.png "Installation Summary")

You will note 3 categories: keyboard, time and date, and installation destination. The first three options should all be filled out by default, the last option installation destination will have an orange notification icon next to it. This means we need to double click on this section and enter a sub-menu before we can continue.

![*Device Selection*](images/Chapter-03/fedora-install/device-selection-370-by-200.png "Device Selection")

This warning icon is a forcing mechanism to make you review these settings. You will see visual icons of all the hard disks available for installation. The one with a white checkmark is the disk where the __"/"__ (root) partition will be installed. If the default selections are satisfactory then you can click __DONE__ button at the top to the screen and continue.  Otherwise at the bottom of the screen are the detailed installation options, which include encryption, LVM, and external installation drives such as over iSCSI or NFS.

![*Specialized Details*](images/Chapter-03/fedora-install/specialized-disks-330-by-200.png "Specialized Details")

Now you can click "*begin installation*".

The installation will finish without prompting you for creating a user. This will be done on the subsequent reboot as part of the setup process. You will be prompted with optional dialogs, and then a user creation dialog where you will create a user account that will be given admin privileges and/or the ability to log into a corporate account that is managed by a central LDAP or Active Directory (single sign-on).

![*Create User With Sudo*](images/Chapter-03/fedora-install/user-account-fedora.png "Create User With Sudo")

## Parallels M-series Arm

### Ubuntu 25.04

### Fedora 42

### Debian 13

### Debian 12