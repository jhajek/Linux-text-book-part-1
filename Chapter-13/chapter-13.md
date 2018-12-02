# Infrastructure Installation and IT Orchestration ROUGH DRAFT
![*Good thing we avoided that one...*](images/Chapter-Header/Chapter-13/2038-2.png "2038")

## Objectives

* IT Orchestration and Automation tools
  + Vagrant
  + Packer.io
  + Consul
  + Vault
  + Additional automation tools

## Outcomes

At the conlcusion of this chapter you will have a basic understanding of how to use infrastructure automation and orchestration tools.  You will be familiar and able to explain the concept of immutable infrastructure and will be able to explain cloud native development technologies as well as OS container technology.

### Automation and Hashicorp

One of the main things that computers are good at is executing repetive tasks.  One of the things humans seem to dislike is repeating the same task.  Let's give a practical example; there is a divide between the developers (devs) and the operations (ops) people when it comes to software and infeastructure.  Developers need hardware to test their code on and then more hardware to run their code in production.  Operations people have to maintain those systems and the code and the lifecycle of the application.  Developers started to think, could we deploy our infrastructure in the same way we deploy code?  Could we automate the way out of this problem?  A young developer named Mitchell Hashimoto had the same thoughts.  

![*Mitchell Hashimoto*](images/Chapter-13/people/mh.png "mitchell hashimoto")[^153]

Micthcell realized that himself and a good majority of developers where using VirtualBox to run and build test systems on their local machines and laptops. He found that he could be productive by keeping copies of the production servers where his code would reside as a local vm on his system.  He realized their were some limitations to what VirtualBox would allow for in the way of access to the system.  VirtualBox just provided an interface to virtualize an operating system, and had no provisions for quickly deploying or automating an OS deployment--it was still a manual process. He set out to solve this problem.

![*Hashicorp Stack*](images/Chapter-13/hashi/hashistack.png "hashi-stack")

## Vagrant

### The Problem

The problem is that we have high levels of computing available to us yet we are not really using any of it.  Our own laptops are fully powered and used as primary workstations.  Yet when it comes to developers writing code, QA testers, Operations and Security people, these resources are not being used--we have ad-hoc efforts to gain some hardware, any hardware, for testing.  This leads to a fractured development and inconsistent experiences, which often lead to short cuts and compromises that your are forced to pay later.

Enter Mitchell Hashimoto and Hashicorp.  They started in 2010 with a radical mission to automate everything they could into repeatable steps using single tools that handle abstractions.   Hashicorp was platform agnostic and focused on the process of automation.   They succeeded and are now considered the industry leaders in the arena.  Quite frankly there are no other tools that even compete in this space.  [https://www.hashicorp.com/files/DevOps-Defined.pdf](https://www.hashicorp.com/files/DevOps-Defined.pdf "Problem Hashi is solving").

At that time, [Hashicorp](https://hashicorp.com "Hashicorp") was born.  This was in 2010 and Mitchell's first task was easing the deployment, connection, and most importantly abstracting the network address translation bewtween host and guest operating systems.  He created [Vagrant](https://vagrantup.com "Vagrant") to do just this.  Vagrant initally was a VritualBox only porduct but has moved to be an abstraction layer now for multiple virtualization and container platforms

### How Vagrant Benefits You[^154]

* *If you are a developer, Vagrant will isolate dependencies and their configuration within a single disposable, consistent environment, without sacrificing any of the tools you are used to working with (editors, browsers, debuggers, etc.). Once you or someone else creates a single Vagrantfile, you just need to vagrant up and everything is installed and configured for you to work. Other members of your team create their development environments from the same configuration, so whether you are working on Linux, Mac OS X, or Windows, all your team members are running code in the same environment, against the same dependencies, all configured the same way. Say goodbye to "works on my machine" bugs.*
* *If you are an operations engineer, Vagrant gives you a disposable environment and consistent workflow for developing and testing infrastructure management scripts. You can quickly test things like shell scripts, Chef cookbooks, Puppet modules, and more using local virtualization such as VirtualBox or VMware. Then, with the same configuration, you can test these scripts on remote clouds such as AWS or RackSpace with the same workflow. Ditch your custom scripts to recycle EC2 instances, stop juggling SSH prompts to various machines, and start using Vagrant to bring sanity to your life.*
* *If you are a designer, Vagrant will automatically set everything up that is required for that web app in order for you to focus on doing what you do best: design. Once a developer configures Vagrant, you do not need to worry about how to get that app running ever again. No more bothering other developers to help you fix your environment so you can test designs. Just check out the code, vagrant up, and start designing.*

Think of Vagrant as an abstraction layer between you and VirtualBox, Hyper-V, Docker, or even Vmware desktop.  It is written in the Ruby Language and comes as a self-contained binary that runs accross all platforms. For the duration of this chapter I will use VirtualBox as my example.  Vagrant handles this abstraction by using a file concept called a **box** or ```*.box```.  The box file is nothing more than a compressed archive containing a virtual harddrive and a configuration file that tells the Vagrant providor which virtuaization software to launch this with. For example a *.box file that was made for the Virtualbox provider would contain the *.vmdk (hard drive) and the *.ovf file (meta-data and Virtual Machine settings file).  Each Vagrant box fil eneeds a config file called: **Vagrantfile**.  This is an abstraction file to modify settingings for the virtual machine at run time.  There is a sample Vagrantfile later in this chapter. These two components are what is needed to run and manage Vagrant boxes.

There are two ways to obtain a Vagrant Box (*.box file).  The first way would be to obtain pre-made images from a site you trust (remember you are running other people's configuration and software in your place of work -- just be aware).   The first place to look is from Vagrantup.com itself - [https://atlas.hashicorp.com/boxes/search](https://atlas.hashicorp.com/boxes/search "Vagrant box search"). Here you can search for boxes of other operating systems and versions even some opensource companies release a pre-configured Vagrant Box all setup for you to test their software all in one place.    Using this facility you can simply run a command from the command line to add this box to your local system. such as: ```vagrant init ubuntu/xenial64``` would automatically construct a Vagrantfile, as well as retreive an Ubuntu Xenial64 box file.

The second way to is add it manually

#### Adding Vagrant Boxes

When executing the vagrant box command from the command line (in Windows recommend using powershell) you will see this list of subcommands as the output:

   * ```add```
   * ```list```
   * ```outdated```
   * ```remove```
   * ```repackage```
   * ```update```

```vagrant box add```

The first command **add** is the command we will use to add boxes (either of the two methods) from above.  These are all premade systems made with Packer.io and [distributed by Hashicorp](https://app.vagrantup.com/boxes/search "Vagrant Search").  

The tutorial on vagrantup.com will walk you through this but a small example (try any of these especially if you are not familiar with these platforms).

* ```vagrant box add centos/7``` (Official Centos 7 Vagrant box release)
* ```vagrant box add debian/jessie64``` (Debian provided release of Jessie Debian 8 x64)
* ```vagrant box add terrywang/archlinux``` (user provided Arch Linux distro)
* ```vagrant box add concourse/lite```   (concourse software package provided and preconfigured)
* ```Vagrant box add generic/Fedora29``` (Fedora 29 server edition)
* ```vagrant box add freebsd/FreeBSD-11.0-CURRENT``` (official FreeBSD vagrant box)
* ```vagrant box add maier/alpine-3.4-x86_64```  (user provided alpine Linux distro)
* ```vagrant box add ubuntu/xenial64``` (Canonical--Ubuntu parent company - provided)

You may need to use a full URL in the case of downloading a Vagrant box that is not provided from Hashicorp box repositories.  This goes for 3rd party and for the boxes your create on your own. We will learn how to make our own in the Packer.io section of this document, but for all purposes the artifacts are the same; a *.box file.  For installing a Devuan box (the distro that resulted from the Debian Civil War/systemd split) here are two ways to execute the commands:

```vagrant box add http://devuan.ksx4system.net/devuan_jessie_beta/devuan_jessie_1.0.0-beta_amd64_vagrant.box --name devuan-jessie```

```vagrant box add ./itmd521-virtualbox-1503930054.box --name itmd-521```

Adding a box via URL both ways, requires an additional parameter, ```--name``` (as seen above). The ```--name``` option is something you declare for your use, just don't put any spaces and its best to name the box something related to the actual box;  box1 or thebox are terrible names.

```vagrant box list```

You can check to see if the vagrant box add command was successful by issuing the command: ```vagrant box list```; looking something like this:  (note this is my system yours will vary but the structure will be the same).

```bash
PS C:\Users\Jeremy\Documents\vagrant> vagrant box list
centos-vanilla-1611  (virtualbox, 0)
ubuntu-vanilla-16041 (virtualbox, 0)
ubuntu/trusty64      (virtualbox, 20161121.0.0)
ubuntu/xenial64      (virtualbox, 20170119.1.0)
```

Here you notice that the last two boxes were added directly from the Hashicorp boxes repository (vagrant box add ubuntu/trusty64 and vagrant box add ubuntu/xenial64)

The top two boxes were custom Vagrant boxes I created (we are getting to that part) that are treated as third party boxes.  To add them I issued a command like this:   (The vanilla term is my own convention, it just means this is a default OS install -- no extra packages)

```bash
vagrant box add ./centos-vanilla-1611-server-virtualbox-1485312680.box --name centos-7-vanilla
vagrant box add ./ubuntu-vanilla-16041-server-virtualbox-1485314496.box --name ubuntu-16041-vanilla
```

```vagrant box remove```

The same way that you add boxes you can remove them from your list.  You need to know the name of the box that was added, run a vagrant box list command and find the name that way.  The below commands would remove the boxes added in the previous section.

* ```vagrant box remove centos-7-vanilla```
* ```vagrant box remove ubuntu-16041-vanilla```

**Command:** ```vagrant init```

Once your Vagrant boxes have been added to your system and Vagrant has them in a list, you can now create a Vagrantfile.  You have one Vagrantfile per-Vagrant box.  It would make the most sense to create a sub-directory with the same box name to house the Vagrantfile.

For instance if the output of the command ```vagrant box list```:

```bash
PS C:\Users\Jeremy\Documents\vagrant> vagrant box list
centos-vanilla-1611  (virtualbox, 0)
ubuntu-vanilla-16041 (virtualbox, 0)
ubuntu/trusty64      (virtualbox, 20161121.0.0)
ubuntu/xenial64      (virtualbox, 20170119.1.0)
```

Then it would make sense to create a folder named after each of these boxes under the directory vagrant.  NOTE - I arbitrarily created the directory vagrant under Documents.  Why? It seems to make logical sense.  See screenshot:

![*Suggested Folder Hierarchy*](images/Chapter-13/vagrant/directory.png "Suggested Directory Structure")

**Note**--for good measure I added a directory called data which will be used for mounting shared drives--I will explain in a bit. Once you have created these folders, cd into one.  For instance take the trusty64 and xenial64.  You would cd into trusty64 directory and type: vagrant init ubuntu/trusty64.  This will create a file called Vagrantfile that points and works with the trusty64 vagrant box.  The idea behind the Vagrantfile  is that it has a shorthand syntax that is universally translated by Vagrant into specific virtualization platforms.  The Vagrantfile  handles all the properties that could be set (such as RAM, CPU, shared drives, port forwarding, networking, and so forth).   Make sure you issue the vagrant init command from inside of the proper folder you just created.

Here is a sample Vagrantfile, which is available in the book source code [files > Chapter-13 > vagrant-init-files](https://github.com/jhajek/Linux-text-book-part-1/tree/master/files/Chapter-13/vagrant-init-files "Vagrantfile"), from my system that was built when I issued the command: ```vagrant init ubuntu/xenial64```:

```ruby

# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
   config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
   config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
   config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
     vb.memory = "2048"
   end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end

```

**Command:** ```vagrant up```

Once your Vagrantfile has been created the next step to launch the virtual machine via Vagrant is through the vagrant up command.  You would issue the command from the same directory where the Vagrantfile is located.  A vagrant up command looks in the local directory for a Vagrantfile to begin parsing.  This command is akin to starting the virtual machine directly.  On the first run the Vagrantfile will be parsed and any settings in the virtual machine platform (Virtual Box in our case) will be changed.  On subsequent runs the Vagrantfile will be ignored. **Note** - This command is issues not from inside the virtual machine but from the commandline of the host system.

**Command:**  ```vagrant up --provision```

The ```--provision``` flag tells Vagrant to re-provision and re-read and parse the Vagrantfile and make any additional changes while launching the virtual machine. Note - This command is issues not from inside the virtual machine but from the commandline of the host system.

**Command:** ```vagrant up --provider virtualbox | hyperv | docker | vmware```

When using a Vagrant box from Hashicorp or any other it is a good idea to use the --provider flag to tell Vagrant which platform it will be virtualizing.  This is optional but if you experience problems this is a good troubleshooting tip.

**Command:** ```vagrant reload```

This is akin to a reboot or restart of a virtual machine. Note - This command is issues not from inside the virtual machine but from the commandline of the host system.  Note - This command is issues not from inside the virtual machine but from the commandline of the host system.

**Command:** ```vagrant reload --provision```

Will restart the system as well as re-read and parse the Vagrantfile. Note - This command is issues not from inside the virtual machine but from the commandline of the host system.

**Command:** ```vagrant suspend```

This will put the virtual machine in suspend or pause move (standby) as opposed to running vagrant halt, which will power the virtual machine off.  Very handy to quickly resume work.  Don't expect the system to automatically put your virtual machine into standby if you are used to just closing the lid of your laptop. Note - This command is issues not from inside the virtual machine but from the commandline of the host system.

**Command:**  ```vagrant halt```
Full shutdown of the virtual machine (power off). Note - This command is issues not from inside the virtual machine but from the commandline of the host system. Note - This command is issues not from inside the virtual machine but from the commandline of the host system.

**Command:** ```vagrant destroy```

This command is used to destroy the current instance of a virtual machine -- but not remove the source files.  This allows you to issue a vagrant up command and "start from scratch" without rebuilding or reinstalling the Vagrant Box. Note - This command is issues not from inside the virtual machine but from the commandline of the host system.

**Command:** ```vagrant ssh```

This command is issues after the vagrant up command and allows you to establish an SSH session directly into the vagrant box, with a pre-setup username and password, with NO ASK set in the sudoers file, making for seamless entry.  You should never need to access and username or password in Vagrant as that defeats the purpose of Vagrant.  But for completeness's sake it is vagrant:vagrant. NOTE - the vagrant ssh command works perfectly by default on all Linux, MacOS, and Windows 10 hosts.  

## Packer

### The Problem Packer Solves

While by 2010 Vagrant was being used to manage VMs, there was no tool that could be used to quickly and reliably create VMs.  This problem was solved by Hashicorp and is called [Packer](https://packer.io "Packer.io").  Packer, much like the name suggests, allows you to automate the installtion of operating systems.  or better said, "Packer is a tool for creating machine and container images for multiple platforms from a single source configuration[^155]."  Operating systems from Windows to Linux to BSD were all designed to be installed manually.  This makes sense if you think about it, unlike installing software, there is no existing operating sytsem when you are installing an operating system, making automatic installation difficult--especially since having a constant network connection is a relatively recent occurance.

Packer solved this problem by allowing you to create machine images. "A machine image is a single static unit that contains a pre-configured operating system and installed software which is used to quickly create new running machines. Machine image formats change for each platform. Some examples include AMIs for EC2, VMDK/VMX files for VMware, OVF exports for VirtualBox, etc[^155]."

A few technologies for network based installs exist, but even these assume their is a physcial computer to correlate to.  Packer went one step further by allowing you to speficify all the answers to the installation questions, you could now have a repeatable installation.  You could now audit this install as well as take this same install (with minor modifications) and make artifacts that can exist on different platforms.  You could build a VirtualBox VM and at the same time have an Amazon Web Services artifact so that all of your developers, operations, testers, and QA can have access to the same machine.

As stated on the Packer.io webpage the advantages of using packer are as follows[^156]:

* **Super fast infrastructure deployment**
  + Packer images allow you to launch completely provisioned and configured machines in seconds rather than several minutes or hours. This benefits not only production, but development as well, since development virtual machines can also be launched in seconds, without waiting for a typically much longer provisioning time.
* **Multi-provider portability**
  + Because Packer creates identical images for multiple platforms, you can run production in AWS, staging/QA in a private cloud like OpenStack, and development in desktop virtualization solutions such as VMware or VirtualBox. Each environment is running an identical machine image, giving ultimate portability.
* **Improved stability**
  + Packer installs and configures all the software for a machine at the time the image is built. If there are bugs in these scripts, they'll be caught early, rather than several minutes after a machine is launched.
* **Greater testability**
  + After a machine image is built, that machine image can be quickly launched and smoke tested to verify that things appear to be working. If they are, you can be confident that any other machines launched from that image will function properly.

Packer examples and example build code [https://github.com/jhajek/packer-vagrant-build-scripts.git](https://github.com/jhajek/packer-vagrant-build-scripts.git "sample packer code repo")

#### Packer - Conventions

Hashicorp essentially built a tool that captures each install step.  These steps are placed into a Packer build template or just template for short.  These templates are constructed using [JSON](https://en.wikipedia.org/wiki/JSON "JSON").   In addition these templates rely on an "Answer File" for completing all of the installation choices and automating the installation.  On Linux this "answer file" is split between the major Linux distribution families:

#### Packer JSON Build Template

Let us look at an example JSON template file: This source can be retrieved from:
[https://github.com/jhajek/packer-vagrant-build-scripts/blob/master/packer/vanilla-install/ubuntu16043-vanilla.json](https://github.com/jhajek/packer-vagrant-build-scripts/blob/master/packer/vanilla-install/ubuntu16043-vanilla.json "Packer Template")

```json

{
  "builders": [{
    "name": "ubuntu-vanilla-16043-server",
    "type": "virtualbox-iso",
    "guest_os_type": "Ubuntu_64",
    "guest_additions_mode": "disable",
    "iso_url": "http://mirrors.kernel.org/ubuntu-releases/16.04.5/ubuntu-16.04.5-server-amd64.iso",
    "iso_checksum": "c94de1cc2e10160f325eb54638a5b5aa38f181d60ee33dae9578d96d932ee5f8",
    "iso_checksum_type": "sha256",
    "http_directory" : ".",
    "http_port_min" : 9001,
    "http_port_max" : 9001,
    "ssh_username": "vagrant",
    "ssh_password": "vagrant",
    "ssh_wait_timeout": "30m",
    "communicator": "ssh",
    "ssh_pty": "true",
    "shutdown_command": "echo 'vagrant' | sudo -S shutdown -P now",
    "vm_name": "ubuntu-vanilla-16043-server",
    "hard_drive_interface": "sata",
    "disk_size": 20000,
    "boot_wait": "5s",
  "boot_command" : [
    "<enter><f6><esc>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs>",
    "<bs><bs><bs>",
    "/install/vmlinuz noapic ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed/preseed.cfg ",
    "debian-installer=en_US auto locale=en_US kbd-chooser/method=us ",
    "hostname=pleasechangeme ",
    "fb=false debconf/frontend=noninteractive ",
    "keyboard-configuration/modelcode=SKIP keyboard-configuration/layout=USA ",
    "keyboard-configuration/variant=USA console-setup/ask_detect=false ",
    "initrd=/install/initrd.gz -- <enter>"
  ],  
  "vboxmanage": [
    [
      "modifyvm",
      "{{.Name}}",
      "--memory",
      "2048"
    ]
  ]
  }
],
  "provisioners": [
    {
      "type": "shell",
      "execute_command" : "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'",
      "script": "../scripts/post_install_vagrant.sh"
    }
  ],
  "post-processors": [
    {
      "type": "vagrant",
      "keep_input_artifact": false,
      "output": "../build/{{.BuildName}}-{{.Provider}}-{{timestamp}}.box"  
    }
  ]
}

```

There are 4 section we are interested in:

1. builders
1. provisioners
1. post-processors
1. vboxmanage
+ listed but is not required and is an artifact related to VirtualBox

#### Builders

The majority of this information is taken from [https://www.packer.io/docs/](https://www.packer.io/docs/ "Packer docs"). Builders are the initial syntax needed to build for a single platform.  This forms the bulk of the JSON Key-Value pairs you see above in the sample template I provided.  The Builder of choice above is for VirtualBox initially, but if my target platform had been something else then I could have switched.  Note the syntax will be different for each builder as some require things others do not (Amazon and Azure require account keys for instance).  The builder in the template above is a Virtualbox ISO builder.  That is defined on line 2: ```"type": "virtualbox-iso"```. Many of these values will change or be different depending on the builder you use. Consult the documentation.

The builders available are:

1. Amazon EC2 (AMI)
1. Azure
1. Cloudstack
1. Digital Ocean
1. Docker
1. Google Compute Engine
1. Hyper-V
1. OpenStack
1. Parallels
1. QEMU
1. Triton (Joyent/Samsung Public Cloud)
1. VirtualBox (both iso and ovf)
1. Vmware

#### Provisioners

Provisioner are tools that you can use to customize your machine image after the base install is finished.  Though tempting to just use the Kickstart or Pressed files to do the custom install--this is not a good idea.  You should leave the "answer files" as clean or basic as possible so that you may reuse them and do your customization here via a provisionser.

```json

"provisioners": [
  {
    "type": "shell",
    "execute_command" : "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'",
    "script": "../scripts/post_install_vagrant.sh"
  }
]

```

In the sample above I chose to implement an inline shell command, "execute command" and then via a shell script.  Shell scripts are very easy to use and flexible.  Provisioners can also be connected to use Provisioning 3rd party tools such as Puppet, Chef, Salt, Ansible, as well as PowerShell.  These tools are called Orchestration tools and I would recommend checking them out if your interest or job lies in this domain.

If you are using Packer to build Vagrant boxes, this code below is needed to be included in a shell script that is run in the provisioners block via a script key-value pair.  Contents would look like below, and you would add any additional code after these lines.  This is nothing but a shell script so any Linux commands you would normally execute in a shell script can be executed here.

```bash

#!/bin/bash
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is vagrant
echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/init-users
sudo cat /etc/sudoers.d/init-users

# Installing vagrant keys
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
sudo mkdir -p /home/vagrant/.ssh
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh/authorized_keys
echo "All Done!"

# Add additional code here

```

#### Post-Processors

Packer has the ability to build a virtual machine or OS Container once and export it to many different types of platforms in a single execution stretch.  The initial artifact can be exported and converted across all of the formats listed below.  Therein lies the power of Packer as you can deploy your production environment to any platform for any person: Dev, QA, Test, Ops, Sec, and so forth.

Once the Build step and Provision step are complete the last step (which is optional) is the post-processor step.  This is where you can convert your base image you built into various other formats.  Note that the directory named "build"  is completely arbitrary and was created by me as it made sense.

```json

"post-processors": [
  {
    "type": "vagrant",
    "keep_input_artifact": true,
    "output": "../build/{{.BuildName}}-{{.Provider}}-{{timestamp}}.box"  
  }
]

```

Here you see I am converting the VirtualBox *.ovf file into a Vagrant Box file *.box.   If you leave off the keep_input_artifact option, the initial artifact will be deleted and only the post-processor result will remain.  If you are concerned about harddrive space - set this value to false.

Types of Post-Processing include:

1. Amazon AMI
1. Atlas (Hashicorp artifact enterprise deployment tool)
1. Compress (simply a compressed archive)
1. Docker
1. Google Compute Engine
1. Vagrant and Vagrant Cloud (cloud based storage and management of Vagrant Boxes)
1. VMWare vShpere

You can use multiple post-processors if desired.

#### vboxmanage

This command is related to using Virtual Box and will change the amount of memory allocated to the Virtual Machine image during the build process.  The amounts listed below have no bearing on the machine image that is produced.

```json

"vboxmanage": [
        [
          "modifyvm",
          "{{.Name}}",
          "--memory",
          "2048"
        ]
    ]

```

#### Packer, Putting it Together

There are two key commands to use in Packer, assuming you have added the packer executable to your system path.  First type: packer -v and see if you get version information output.

**Command:** ```packer -v```

Execute this command to see if you get a version output.  If this command throws an error -- go back and check the PATH & INSTALL section and make sure you have closed and reopened your shell.  

![*Output of packer -v*](images/Chapter-13/packer/version.png "Output of packer -v")

**Command:**  ```packer validate```

This command will check the syntax of your *.json packer template for syntax errors or missing brackets.  It will not check logic but just syntax.  Good idea to run it to make sure everything is in order.  Using the samples provided in the Github repo you can validate the *.JSON template with this command:

![*Output of packer validate*](images/Chapter-13/packer/validate.png "Output of packer validate")

**Command:**  ```packer build```

This command will be what is used to execute and run the packer *.json template.

![*Output of packer build*](images/Chapter-13/packer/build.png "Output of packer build")

**Directory:** ```packer_cache```

![*Packer Cache Directory on Windows*](images/Chapter-13/packer/cache.png "Packer Cache Directory on Windows")

When running packer build on the first time, Packer will use the iso_url and iso_checksum to retrieve you install media, in the sample above it is listed as:

```json

    "iso_url": "http://mirrors.kernel.org/ubuntu-releases/16.04.5/ubuntu-16.04.5-server-amd64.iso",
    "iso_checksum": "c94de1cc2e10160f325eb54638a5b5aa38f181d60ee33dae9578d96d932ee5f8",

```

This URL is the actual remote location of the install media which will be retrieved and cached into a directory named packer_cache.  The iso file will be renamed with the iso_checksum. Subsequent packer_build commands will use this cached iso media.  You can also copy this cached iso file to other directories as long as it is placed in a packer_cache directory--this can be used to speed up downloads.

#### When Packer Fails

If any part of the Packer build step fails or generates and error, Packer will roll back and delete any artifacts it has created. It won't leave you with broken items. Sometimes Packer fails right on the last step without much of an error message.  In this case I recommend just re-run the packer build command. Upon completion, cd into the build directory that was created during the post-processor process and go back to the beginning of the Vagrant Tutorial and the section regarding using vagrant box add of custom boxes.

### Answer Files

Most operating system installations are designed for a manual install process.  This makes sense as for almost 40 years we have been using PC's (Personal Computers).  A first step in automating the install process is to automate the answering of the installation questions.  This is the most repetive process of the install, as well as something that is not conducive to the human, as you spend most of your time waiting.  

#### Fedora and Kickstart

The first solution came from Sun in 1994 and was called [Jumpstart](https://en.wikipedia.org/wiki/JumpStart_(Solaris) "jumpstart"). This was used to hold installtion information and as a target system was booted, it would communicate to the Jumpstart server and complete the entire install over the network, OS and handle configuration.

The next phase came in Linux with Fedora creating the [Kickstart](https://docs.fedoraproject.org/en-US/fedora/f28/install-guide/appendixes/Kickstart_Syntax_Reference/#appe-kickstart-syntax-reference "Kickstart Reference") answer file system.  Kickstart does not handle the part of OS install, but the OS configuration and software retrieval/installation.  Kickstart files can be generated from a template or scratch or upon a successful install a default kickstart is located in the location ```/root/anaconda-ks.cfg```. Examples and explanation resources can be found here:

* [Fedora 28 Kickstart Reference](https://docs.fedoraproject.org/en-US/fedora/f28/install-guide/appendixes/Kickstart_Syntax_Reference/#appe-kickstart-syntax-reference "Foedora 29 Reference")
* [Centos Kickstart Reference](https://www.centos.org/docs/5/html/Installation_Guide-en-US/ch-kickstart2.html "CentOS Kickstart Reference")

#### Debian, Ubuntu, and Preseed

[Debian/Ubuntu pressed template](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html "Preseed")  Debian created their own answer file system called [preeseed].  You can interrupt a manual install and point to a kickstart file, but it needs to be done over the network.  When you are installing an operating system you don't yet have a filesystem to read files from!  

Working example of a preseed and a kickstart file can be found in the source code of the book: ```files > Chapter-13 > packer-build-templates > preseed``` and ```files > Chapter-13 > packer-build-templates > ks```

Preseed Used for all Debian and Ubuntu based server installs - example and explanation resources can be found here:

* [Sample Preseed Template](https://help.ubuntu.com/lts/installation-guide/example-preseed.txt "Preseed Template")
* [Preseed Ubuntu Guide](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html "Preseed Guide")

### Network Based Install Tools

[Cobbler](http://cobbler.github.io/ "Cobber") is a modern version of Jumpstart, which is good for network based install and configuration of static hardware.  It makes use of kickstart and preseed and can be used to install Linux based operating systems over the network via PXE.

[MaaS - Metal as a Service](https://maas.io "Maas.io").  This was built by Canonical (Ubuntu) to manage and deploy systems, it includes and builds upon Cobbler.  

### IT Orchestration

In looking at these tools, Vagrant, Packer, Preseed, and Kickstart, we begin to see a world of automation opening up to us.  In a sense these technologies are the culmination of the Unix concepts of small tools doing one things--or shell scripts on steroids, so to speak.  Each of these technologies is beyond the scope of this book, but here are some podcasts and links to learn more about them.

* [SaltStack](https://www.saltstack.com/ "Saltstack")
  + [Podcast](https://twit.tv/shows/floss-weekly/episodes/262 "SaltStack Podcast")
* [Chef](https://www.chef.io/ "Chef.io")
  + [Podcast](https://twit.tv/shows/floss-weekly/episodes/219 "Chef Podcast")
* [Puppet](https://puppet.com/ "Puppet")
  + [Podcast](https://twit.tv/shows/floss-weekly/episodes/93 "Puppet")
* [Ansible](https://www.ansible.com/ "Ansible")
  + [Podcast](https://twit.tv/shows/floss-weekly/episodes/257 "Ansible Podcast")
* [CfEngine](https://cfengine.com/ "CFengine")
  + [Podcast](https://twit.tv/shows/floss-weekly/episodes/106 "CFengine Podcast")
  + Dr. Mark Burgess wrote a book about his research in IT called [In Search of Certainty](http://markburgess.org/certainty.html "In search of certainty the book")


## Chapter Conclusions and Review

In this chapter we learned how a spread in technology lead to a desire to automate and ease installation and configuration. A new generation of technology brought a new generation of tools.  These tools are a part of what we called cloud-native, immutable infrastructure, and are the standard ways to deploy operating systems and hardware accross the industry.

### Review Questions

  Questions go here

### Podcast Questions

Bryan Cantril Hashiconf Jails the first decade - Woot!

### Lab

Complete Vagrant Tutorial, complete my Packer tutorial, complete Consol tutorial, complete Vault tutorial?

Vagrant provides a tutorial on https://www.vagrantup.com/docs/getting-started/ 



#### Footnotes

[^153]: [http://d13pix9kaak6wt.cloudfront.net/background/users/m/i/t/mitchellh_1370739801_5.jpg](http://d13pix9kaak6wt.cloudfront.net/background/users/m/i/t/mitchellh_1370739801_5.jpg "Mitchell Hashimoto")

[^154]: [https://www.vagrantup.com/docs/why-vagrant/](https://www.vagrantup.com/docs/why-vagrant/ "Why try Vagrant?")

[^155]: [https://www.packer.io/intro/index.html](https://www.packer.io/intro/index.html "Pacjer.io")

[^156]: [https://www.packer.io/intro/why.html](https://www.packer.io/intro/why.html "Why Use Packer?")
