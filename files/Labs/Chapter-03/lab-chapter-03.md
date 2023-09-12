# Chapter 03 Labs

This lab has two parts that need to be completed in order.

## Objectives

* Explore installing multiple industry standard Linux distros

## Outcomes

At the conclusion of this lab you will have installed ~20 operating Linux based distributions as Virtual Machines. You will explored the major paradigms of the two major Linux distro families. You will have mastered the installation process and been exposed to various Linux distro paradigms.

### Part One

You will need to do some research and find the download links for the Linux and BSD based distros below and install them in VirtualBox. You will need to install the latest version of [VirtualBox 7.x](https://virtualbox.org "VirtualBox Download site") in order to complete this exercise; it can be installed via Chocolatey or Brew package managers as well. If you are using an M1 Mac, you will need to purchase a copy of a comparable software called [Parallels Virtualization for M1 Macs](https://www.parallels.com/ "Parallels virtualization for M1 Mac").

Complete each install to disk--there should NOT be an INSTALL ICON on the desktop -- your screenshot is taken after a complete install is finished and a reboot has taken place. Assume each instance listed below is 64-bit version. Take a screen shot of each desktop after logging in. There are 20 different distributions listed. If a version number is not listed, assume the latest version unless noted.

#### Paralles and UTM

If you are using `Paralles` or `UTM` complete the neccesary installs and adjust VirtualBox deliverables where appropriate.

#### Screenshots

![*Sample Deliverable*](images/Chapter-03/lab-example/virtualbox-ubuntu.png "Sample Deliverable")

For those using x86_64 Intel Windows and Macs

* Debian Based
  * Ubuntu 22.04 Desktop edition
  * Lubuntu 22.04 Desktop edition
  * Xubuntu 22.04 Desktop edition
  * Ubuntu 22.04 Server edition
  * Trisquel Linux
  * PureOS
  * Xebian
  * Ubuntu KDE Neon

* Red Hat Based
  * Fedora 38 - Workstation edition
  * AlmaLinux 9.x
  * UltraMarine OS
  * Microsoft MarinerCBL

* Illumos / Solaris Based
  * OmniOS - Community Edition

* BSD based
  * FreeBSD

* Linux
  * MX Linux
  * Pop!_OS
  * Kali Linux
  * Manjaro Linux (SteamOS is based on)

* Network Based Install
  * openSUSE Leap
  * Debian 12.x - Bookworm
  
For those using Parallels virtualization or UTM on M1/M2 mac -- look for the `aarch` or `arm` distribution, not `amd_64`.

* Debian Based ARM
  * Ubuntu 22.04 Desktop edition
  * Ubuntu 22.04 Server edition
  * Peppermint OS
  * Ubuntu KDE Neon

* Red Hat Based ARM
  * Fedora 38 - Workstation edition 
  * AlmaLinux 9.x 
  * Rocky Linux

* BSD based ARM
  * FreeBSD

* Other Linux Distros ARM
  * MX Linux
  * Pop!_OS
  * Kali Linux
  * Alpine Linux
  * Manjaro Linux (SteamOS is based on)
  * Endeavor OS

* Network Based Install ARM
  * openSUSE Leap
  * Debian 12.x

### Part 2

You will need to install the Virtualbox, Parallels, or UTM Guest Additions in each virtual machine listed below following the instructions in section 3.9.4. For the deliverable you will be placing a screenshot directly below each bullet point
  * Ubuntu Desktop
  * Fedora Desktop
  * Debian Desktop
  * Pop!_OS 
  * Manjaro Desktop

* To show the successful install of the guest additions, maximize the screen and take the screenshot showing the installed guest additions. These are the example before and after maximized images:
    * ![Before Guest Additions](images/Chapter-03/guest-additions-install/before-guest-additions.png "Before Guest Additions Install")
    * ![After Guest Additions](images/Chapter-03/guest-additions-install/after-guest-additions.png "After Guest Additions Install")
* You may also add a screenshot of the execution of the terminal command `lsmod | grep vboxguest`
  * Which will return blank or no answer without guest additions modules loaded
  * It will return `vboxguest` and a unique process number after installation

