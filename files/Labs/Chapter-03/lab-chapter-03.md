# Lab - Chapter 03

## Virtual Machine Creation - part I

Following the demonstrations in section 3.6.3 and the installation information in section 3.6.1, you will need to find the download links for the Linux and BSD ISOs listed. You will need to install the latest version of [VirtualBox 7.x](https://virtualbox.org "VirtualBox Download site") in order to complete this exercise; it can be installed via Chocolatey or Brew package managers as well. If you are using an M1 Mac, you will need to purchase a copy of a comparable software called [Parallels Virtualization for M1 Macs](https://www.parallels.com/ "Parallels virtualization for M1 Mac").

Complete each install fully and then using the correct package manager install the program `neofetch` and take a screenshot of the results. There are 18 different distributions listed for Intel based x86 Windows and Macs. There are 11 different distributions listed for M-series Mac Hardware. If a version number is not listed, assume the latest version.

### Parallels

If you are using `Parallels` complete the necessary installs and adjust VirtualBox deliverables where appropriate.

### Screenshots

For those using x86_64 Intel Windows and Macs install the following ISOs, install `neofetch` and take a screenshot of the results placing the screenshot below the required item list.

* Debian Based
  * Ubuntu 24.04 Desktop edition
  * Lubuntu 24.04 Desktop edition
  * Xubuntu 24.04 Desktop edition
  * Ubuntu 24.04 Server edition
  * Trisquel Linux
  * Xebian
  * Ubuntu KDE Neon

* Red Hat Based
  * Fedora 40 - Workstation edition
  * AlmaLinux 9.x
  * UltraMarine OS

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
  * Debian 12.x

For those using Parallels virtualization on M1/M2 mac -- look for the `aarch` or `arm` distribution, not `amd_64`.

* Debian Based ARM
  * Ubuntu 22.04 or 24.40 Desktop edition
  * Ubuntu 22.04 or 24.04 Server edition
  * Peppermint OS

* Red Hat Based ARM
  * Fedora 40 - Workstation edition 
  * AlmaLinux 9.x 
  * Rocky Linux

* BSD based ARM
  * FreeBSD

* Other Linux Distros ARM
  * Kali Linux
  * Manjaro Linux (SteamOS is based on)

* Network Based Install ARM
  * openSUSE Leap
  * Debian 12.x

### Compile Apache Web Server - part II

Let's compile something to see how this works. This link is to the Apache webserver version 2.4.x latest source code: [http://httpd.apache.org/docs/2.4/install.html](http://httpd.apache.org/docs/2.4/install.html "Apache Webserver Instructions"). Let's install some pre-requisites:

```bash
# Pre-reqs needed first -- assumuing Ubuntu 20.04
sudo apt install build-essential libapr1 libapr1-dev libaprutil1 \
libaprutil1-dev libpcre3 libpcre3-dev
# Command to retrieve the source code
wget https://dlcdn.apache.org/httpd/httpd-2.4.62.tar.gz
# Command to unzip the source code
tar -xvzf httpd-2.4.62
# command to change directory to extracted source code
cd httpd-2.4.62
# commands to build
./configure
make
sudo make install
sudo /usr/local/apache2/bin/apachectl -k start
```

Now open a web browser in the virtual machine and navigate to http://127.0.0.1 and you should see the message: "It Works!" Take a Screenshot of these results.

#### Compile Apache Screeshot

Place screenshot here

### Compile Ladybird browser - part III

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
