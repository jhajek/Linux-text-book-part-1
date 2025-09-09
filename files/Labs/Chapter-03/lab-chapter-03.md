# Lab - Chapter 03

This lab has two parts that need to be completed. Use the provided template for submitting your screenshots as part of the deliverable.

## Objectives

* Explore installing multiple industry standard Linux distros

## Outcomes

At the conclusion of this lab you will have installed ~10-20 Linux based operating system distributions (distros) as Virtual Machines. You will have explored the major paradigms of the two major Linux distro families. You will have mastered the installation process and been exposed to various Linux distro paradigms.

### Virtual Machine Creation - part I

Following the demonstrations in section 3.6.3 and the installation information in section 3.6.1, you will need to find the download links for the Linux and BSD ISOs listed. You will need to install the latest version of [VirtualBox 7.x](https://virtualbox.org "VirtualBox Download site") in order to complete this exercise. 

If you are using an M-series Mac, you will need to purchase a copy of a comparable software called [Parallels Virtualization for Apple Silicon Macs](https://www.parallels.com/ "Parallels virtualization for M1 Mac").

Complete each install fully and then using the correct package manager install the program `fastfetch` and take a screenshot of the results. There are 15 different distributions listed for Intel based x86 Windows and Macs. There are 11 different distributions listed for M-series Mac Hardware. If a version number is not listed, assume the latest version.

#### Parallels

If you are using `Parallels` complete the necessary installs and adjust VirtualBox deliverables where appropriate.

### Screenshots

For those using x86_64 Intel Windows and Macs install the following ISOs, install the package `fastfetch` via the package manger and take a screenshot of the results adding them to the document below each unit.

* Debian Based
  * Ubuntu Desktop edition
  * Lubuntu Desktop edition
  * Ubuntu Server edition
  * Trisquel Linux
  * Xebian
  * Ubuntu KDE Neon

* Red Hat Based
  * Fedora Workstation edition
  * AlmaLinux

* BSD based
  * FreeBSD

* Linux
  * MX Linux
  * Pop!_OS
  * Kali Linux
  * Manjaro Linux (SteamOS is based on)

* Network Based Install
  * openSUSE Leap
  * Debian

For those using Parallels virtualization on [Apple Silicon](https://en.wikipedia.org/wiki/Apple_silicon "wiki article for Apple Silicon") -- look for the `aarch` or `arm` distribution, NOT `amd_64`.

* Debian Based ARM
  * Ubuntu Desktop edition
  * Ubuntu Server edition
  * Peppermint OS

* Red Hat Based ARM
  * Fedora Workstation edition 
  * AlmaLinux
  * Rocky Linux

* BSD based ARM
  * FreeBSD

* Other Linux Distros ARM
  * Kali Linux
  * Rhino Linux

* Network Based Install ARM
  * openSUSE Leap
  * Debian

### Compile Ladybird browser - part II

This one is a bit more complex, but there is a new funded opensource browser called: [Ladybird](https://ladybird.org/ "ladybird browser site"). This is a new idea to break the browser duopoly we currently have, and bring back browsers to be what they were designed to do, browse, not be an add platform. Ladybird is in alpha so expect some bugs but you can compile it.

* Clone the current source code into an Ubuntu desktop VM
  * See [https://github.com/LadybirdBrowser/ladybird](https://github.com/LadybirdBrowser/ladybird "github source code repo")
  * Install the package for `git` via the `apt` package manager
  * Issue the `git clone https://github.com/LadybirdBrowser/ladybird.git` command
* Follow the [build instructions](https://github.com/LadybirdBrowser/ladybird/blob/master/Documentation/BuildInstructionsLadybird.md "ladybird browser build instructions")
  * Make sure to install all required Ubuntu dependencies
  * `cd` into the `ladybird` directory
  * Issue the `./Meta/ladybird.sh run ladybird` command to begin compile and running

#### Screenshot of Compiled Ladybird Browser

Place screenshot of compiled and running Ladybird Browser open to http://www.iit.edu

#### Deliverable

Create a folder in your local repo under the `itmo-556` folder named: `labs`. Create a sub-folder under this folder named: `week-03` -- mind the spelling and no spaces! Add your template file to this directory and push it to your private GitHub repo. Submit the URL to this document as your Canvas deliverable.

#### Troubleshooting

Pay attention to error messages and scan through them and a little back for a hint. Usually a certain package/library is missing and is required to be installed.
