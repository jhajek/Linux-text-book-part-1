# Lab - Chapter 13

## Part One Prerequisites

Assuming that the command `vagrant --version` gives us output, lets begin by installing our first Vagrant Box.  Open your terminal application and let us `cd` to the Documents directory

```cd Documents```

### Windows and Intel Based Macs

Here we are going to create a directory to manage our artifact.  It is a good idea to create a directory per virtual machine that we will administer via Vagrant.  You can create a class directory and then sub-directories and or you can place this on a different disk. This I will leave up to you as it is your filesystem and your data--you are the one in charge.

* `mkdir itmt-430-2022` 
* `cd itmt-430-2022`

We will now use Vagrant to retrieve and Ubuntu 22.04 known as Jammy and a AlmaLinux 9 Virtual Machine:

1. `mkdir jammy64`
1. `cd jammy64`
1. `vagrant init ubuntu/jammy64` 
  
1. `mkdir almalinux9`
1. `cd almalinux9` 
1. `vagrant init almalinux/9` 

### M1 Macs Only

For those using M1 Macs and Parallels you will need to replace the names of the Boxes in the demos with these two that have been prepared for M1 macs and parallels

* `bento/ubuntu-22.04-arm64`
* `almalinux/9.aarch64`

1. `mkdir jammy64-arm`
1. `cd jammy64-arm`
1. `bento/ubuntu-22.04-arm64` 
  
1. `mkdir almalinux9-arm`
1. `cd almalinux9-arm` 
1. `vagrant init almalinux/9.aarch64`

### Editing Your Vagrantfile

Once these commands are executed -- both under the `jammy64` and `almalinux` directory, you will see a `Vagrantfile` that has been created. Let us take a look at this file.  You can do so via using the commands on MacOS or Windows from the Terminal:

* `code Vagrantfile`
* `vim Vagrantfile`

Line 15 you will see the setting that tells Vagrant which **box** this Vagrantfile manages: `config.vm.box = "ubuntu/jammy64"`.  This value came from the `vagrant init` command typed above. Line 35, which is commented out, will let us configure a **host-only** network between out host system and any guest (virtual) OSes we install. Line 52, 57, and 58 are a loop that allows us to increase the default memory from 1Gb to 2 Gb or 4 Gb.

### Start a Vagrant Box

From our jammy64 directory, let us start our first Vagrant Box.  From the Terminal type: ```vagrant up```.  What you will see is the Box file with the VirtualBox (or Parallels) vm being extracted and registered with your virtualization software.  Next the system will begin to boot.  The first install will take a bit longer as some additional drivers are being installed.  This only happens on first boot.  

Once this step is successful, we need to establish a connection to the virtual machine via SSH (secure shell). We do this by the command: ```vagrant ssh```, and we are faced with an Ubuntu Server command prompt. What was the password?  What was the IP address?  You don't know and don't need to know as Vagrant has abstracted all of this away and allowed you to get to the focus of all of this -- installing and running software. Open a new Terminal window and repeat the steps above for the AlmaLinux box.

## Part One - Vagrant Commands

* Using the `vagrant init ubuntu/jammy64` command, initialize a Vagrant Box (only has to be done once on a system)
  * Or comparable Vagrant Box on an M1 Mac
* Using the `vagrant up` command, start the virtual machine
* Using the `vagrant ssh` command, connect to the virtual machine via SSH
* Using the `sudo apt-get update` and `sudo apt-get install nginx` command, install the Nginx webserver (pronounced Engine X)
  * Exit the ssh session.
  * Edit the corresponding `Vagrantfile` to enable line 35 a private network interface at 192.168.56.100
  * Edit the corresponding `Vagrantfile` to uncomment line 52, 57, and 58 changing line 57 to 2048 or 4096
* Using the command `vagrant reload --provision` restart the virtual machine
* After the reload command has succeeded, without using the `vagrant ssh` command, open a web-browser on your Host OS to `http://192.168.56.100` to see the **Welcome to Nginx!** message being served from Nginx in your Vagrant Box
* Using the `vagrant halt` to power off the virtual machine, then issue the `vagrant destroy` command to reset the Vagrant Box to its initial state (pre-webserver install)
* Issue the `vagrant up` and `vagrant ssh` command and use the command in the Vagrant Box: `sudo systemctl status nginx` to show that the webserver is not installed.
  * Exit the SSH session
* Issue the command: `vagrant box list` to show that you have successfully gone through the tutorial

## Part Two - Packer Commands

Using the sample code from the text book in: files > Chapter-13 > packer-build-templates, init, validate and build the ubuntu_22043_vanilla if you are on Windows or an Intel Mac or the ubuntu_22043_m1_mac if you are using Apple Silicon.

One the `.box` file has been successfully built, use the Vagrant commands from this chapter to `add` the box file and to `init` a Vagrantfile. Bring the Vagrant box up and then exit your ssh session and halt the Vagrant box.

## Part Three - Vault Commands

Using the Vagrant Box you built in step two, with in that box -- follow the instructions to install and configure a Vault Server from this chapter with passwords for your SSH and database username and password. In addition create another virtual machine -- this time in the provisioner block shell script run your mysql install script from chapter 12 to install and configure Wordpress (all 11 steps) to create a secure WordPress installation.
