# Infrastructure Installation and IT Orchestration

![*Good thing we avoided that one...*](images/Chapter-Header/Chapter-13/2038-2.png "2038")

## Objectives

* Linux Orchestration and Automation tools
  * Vagrant
  * Packer
  * Automation tools
  * Secrets Management
  
## Outcomes

At the conclusion of this chapter you will have a basic understanding of how to use infrastructure automation and orchestration tools.  You will be familiar and able to explain the concept of immutable infrastructure and will be able to use Linux commands for enabling cloud native development technologies.

## Automation and HashiCorp

One of the main things that computers are good at is executing repetitive tasks.  One of the things humans seem to dislike is repeating the same task.  Let's give a practical example; there is a divide between the developers (devs) and the operations (ops) people when it comes to software and infrastructure (dev + ops = devops).  Developers need hardware to test their code on and then more hardware to run their code in production.  Operations people have to maintain those systems and the code and the lifecycle of the application.  Developers started to think, could we deploy our infrastructure in the same way we deploy code?  Could we automate the way out of this problem?  A young developer named Mitchell Hashimoto had the same thoughts.  

![*Mitchell Hashimoto*](images/Chapter-13/people/mh.png "mitchell hashimoto")[^153]

Mitchell realized that himself and a good majority of developers where using VirtualBox to run and build test systems on their local machines and laptops. He found that he could be productive by keeping copies of the production servers where his code would reside as a local vm on his system.  He realized their were some limitations to what VirtualBox would allow for in the way of access to the system.  VirtualBox just provided an interface to virtualize an operating system, and had no provisions for quickly deploying or automating an OS deployment--it was still a manual process. He and his company set out to solve this problem by developing opensource software.  They developed this stack of software:

![*HashiCorp Stack*](images/Chapter-13/hashi/hashistack.png "hashi-stack")

You can learn more about HashiCorp at this [HashiConf 2017 keynote presentation](https://www.youtube.com/watch?v=b6nn7vLdjo8&list=PL81sUbsFNc5Y-jbEC1y5BWenDoYscVv4t&t=0s&index=2 "Keynote presentation from Mitchell Hashimoto") from Mitchell Hashimoto.

## Vagrant

### The Problem

The problem is that we have high levels of computing available to us yet we are not really using any of it.  Our own laptops are fully powered and used as primary workstations.  Yet when it comes to developers writing code, QA testers, Operations and Security people, these resources are not being used--we have ad-hoc efforts to gain some hardware, any hardware, for testing.  This leads to a fractured development and inconsistent experiences, which often lead to short cuts and compromises that your are forced to pay later.

Enter Mitchell Hashimoto and HashiCorp.  They started in 2010 with a radical mission to automate everything they could into repeatable steps using single tools that handle abstractions.   HashiCorp was platform agnostic and focused on the process of automation.   They succeeded and are now considered the industry leaders in the arena.  Quite frankly there are no other tools that even compete in this space.  [https://www.hashicorp.com/files/DevOps-Defined.pdf](https://www.hashicorp.com/files/DevOps-Defined.pdf "Problem Hashi is solving").

At that time, [HashiCorp](https://hashicorp.com "HashiCorp") was born.  This was in 2010 and Mitchell's first task was easing the deployment, connection, and most importantly abstracting the network address translation between host and guest operating systems.  He created [Vagrant](https://vagrantup.com "Vagrant") to do just this.  Vagrant initially was a VirtualBox only product but has moved to be an abstraction layer now for multiple virtualization and container platforms

### How Vagrant Benefits You[^154]

> *If you are a developer, Vagrant will isolate dependencies and their configuration within a single disposable, consistent environment, without sacrificing any of the tools you are used to working with (editors, browsers, debuggers, etc.). Once you or someone else creates a single Vagrantfile, you just need to vagrant up and everything is installed and configured for you to work. Other members of your team create their development environments from the same configuration, so whether you are working on Linux, Mac OS X, or Windows, all your team members are running code in the same environment, against the same dependencies, all configured the same way. Say goodbye to "works on my machine" bugs.*

> *If you are an operations engineer, Vagrant gives you a disposable environment and consistent workflow for developing and testing infrastructure management scripts. You can quickly test things like shell scripts, Chef cookbooks, Puppet modules, and more using local virtualization such as VirtualBox or VMware. Then, with the same configuration, you can test these scripts on remote clouds such as AWS or RackSpace with the same workflow. Ditch your custom scripts to recycle EC2 instances, stop juggling SSH prompts to various machines, and start using Vagrant to bring sanity to your life.*

> *If you are a designer, Vagrant will automatically set everything up that is required for that web app in order for you to focus on doing what you do best: design. Once a developer configures Vagrant, you do not need to worry about how to get that app running ever again. No more bothering other developers to help you fix your environment so you can test designs. Just check out the code, vagrant up, and start designing.*

Think of Vagrant as an abstraction layer between you and VirtualBox, Hyper-V, Docker, or even VMware desktop.  It is written in the Ruby Language and comes as a self-contained binary that runs across all platforms. For the duration of this chapter I will use VirtualBox as my example.  Vagrant handles this abstraction by using a file concept called a **box** or ```*.box```.  The box file is nothing more than a compressed archive containing a virtual hard drive and a configuration file that tells the Vagrant provider which virtualization software to launch this with. For example a `*.box` file that was made for the VirtualBox provider would contain a `*.vmdk` (hard drive) and an `*.ovf` file (meta-data and Virtual Machine settings file).  Each Vagrant `*.box` file needs a config file called: **Vagrantfile**.  This is an abstraction file to modify settings for the virtual machine at run time.  There is a sample Vagrantfile later in this chapter. These two components are what is needed to run and manage Vagrant boxes.

#### Obtaining a Vagrant Box

There are two ways to obtain a Vagrant Box (*.box file).  The first way would be to obtain pre-made images from a site you trust (remember you are running other people's configuration and software in your place of work -- just be aware).   The first place to look is from Vagrantup.com itself - [https://app.vagrantup.com/boxes/search](https://app.vagrantup.com/boxes/search "Vagrant box search"). Here you can search for boxes of other operating systems and versions even some opensource companies release a pre-configured Vagrant Box all setup for you to test their software all in one place.    Using this facility you can simply run a command from the command line to add this box to your local system. such as: ```vagrant init ubuntu/bionic64``` would automatically construct a `Vagrantfile`, as well as retrieve an Ubuntu Bionic64 box file.  The second way is described later in the chapter; that is to build and add your own box.

#### Vagrant Box Commands

When executing the `vagrant box` command from the command line (in Windows recommend using PowerShell Core) you will see this list of subcommands below, but we will primarily use just the first three:

: `vagrant box` commands

-----------------
   ```add```
   ```list```
  ```remove```  
  ```outdated```
  ```repackage```
  ```update```
-----------------

#### vagrant box add

```bash
vagrant box add
```

The first command **add** is the command we will use to add boxes (either of the two methods) from above.  These are all premade systems made with Packer.io and [distributed by HashiCorp](https://app.vagrantup.com/boxes/search "Vagrant Search").  

The tutorial on vagrantup.com will walk you through this but a small example (try any of these especially if you are not familiar with these platforms).

* ```vagrant box add centos/7``` (Official CentOS 7 Vagrant box release)
* ```vagrant box add debian/buster64``` (Debian provided release of Debian 10 x64)
* ```vagrant box add terrywang/archlinux``` (user provided Arch Linux distro)
* ```vagrant box add laravel/homestead```   (Preconfigured PHP Laravel framework development box)
* ```Vagrant box add generic/Fedora30``` (Fedora 30 server edition)
* ```vagrant box add freebsd/FreeBSD-12.0-CURRENT``` (official FreeBSD vagrant box)
* ```vagrant box add maier/alpine-3.4-x86_64```  (user provided alpine Linux distro)
* ```vagrant box add ubuntu/bionic64``` (Canonical--Ubuntu 18.04 parent company - provided)
* ```vagrant box add ubuntu/xenial64``` (Canonical--Ubuntu 16.04 parent company - provided)

You may need to use a full URL in the case of downloading a Vagrant box that is not provided from HashiCorp box repositories.  This goes for 3rd party and for the boxes your create on your own. We will learn how to make our own in the Packer.io section of this document, but for all purposes the artifacts are the same; a *.box file.  For installing a [Devuan](https://devuan.org/ "Devuan Home Page") box (the distro that resulted from the Debian Civil War/systemd split) here are two ways to execute the commands:

```bash
vagrant box add \
http://devuan.ksx4system.net/devuan_beowulf/minimal-live/devuan_beowulf_3.0.0_amd64_minimal-live.iso \
--name devuan-beowulf

vagrant box add ./itmd521-virtualbox-1503930054.box --name itmd-521
```

Adding a box via URL both ways, requires an additional parameter, ```--name``` (as seen above). The ```--name``` option is something you declare for your use, just don't put any spaces and its best to name the box something related to the actual box;  *"box1"* or *"thebox"* are terrible names.

#### vagrant box list

```vagrant box list```

You can check to see if the vagrant box add command was successful by issuing the command: ```vagrant box list```; looking something like this:  (Note this is my system, yours will vary but the structure will be the same).

```bash
PS C:\Users\Jeremy\Documents\vagrant> vagrant box list
centos-vanilla-1908  (virtualbox, 0)
ubuntu-vanilla-18044 (virtualbox, 0)
ubuntu/bionic64      (virtualbox, 20200324.0.0)
ubuntu/xenial64      (virtualbox, 20200326.0.0)
```

Here you notice that the last two boxes were added directly from the HashiCorp boxes repository (vagrant box add ubuntu/trusty64 and vagrant box add ubuntu/xenial64)

The top two boxes were custom Vagrant boxes I created (we are getting to that part) that are treated as third party boxes.  To add them I issued a command like this:   (The vanilla term is my own convention, it just means this is a default OS install -- no extra packages)

```bash
vagrant box add ./centos-1908-virtualbox-1485312680.box --name centos-7-vanilla
vagrant box add ./ubuntu-18044-virtualbox-1485314496.box --name ubuntu-16041-vanilla
```

#### vagrant box remove

```vagrant box remove```

The same way that you add boxes you can remove them from your list.  You need to know the name of the box that was added, run a vagrant box list command and find the name that way.  The below commands would remove the boxes added in the previous section.

* ```vagrant box remove centos-7-vanilla```
* ```vagrant box remove ubuntu-18044-vanilla```

#### vagrant init

```vagrant init```

Once your Vagrant boxes have been added to your system and Vagrant has them in a list, you can now create a Vagrantfile.  You have one Vagrantfile per-Vagrant box.  It would make the most sense to create a sub-directory with the same box name to house the Vagrantfile.   Then it would make sense to create a folder named after each of these boxes under the directory vagrant.  In this example I created the directory vagrant under Documents.  Why? It seems to make logical sense.

![*Suggested Folder Hierarchy*](images/Chapter-13/vagrant/directory.png "Suggested Directory Structure")

**Note**--for good measure I added a directory called data which will be used for mounting shared drives. Once you have created these folders, cd into one.  For instance take the trusty64 and xenial64.  You would cd into trusty64 directory and type: `vagrant init ubuntu/bionic64`.  This will create a file called `Vagrantfile` that points and works with the trusty64 vagrant box.  The idea behind the Vagrantfile  is that it has a shorthand syntax that is universally translated by Vagrant into specific virtualization platforms.  The Vagrantfile  handles all the properties that could be set (such as RAM, CPU, shared drives, port forwarding, networking, and so forth).   Make sure you issue the `vagrant init` command from inside of the proper folder you just created.

Here is a sample Vagrantfile, which is available in the book source code [files > Chapter-13 > vagrant-init-files](https://github.com/jhajek/Linux-text-book-part-1/tree/master/files/Chapter-13/vagrant-init-files "Vagrantfile"):

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
  # boxes at https://app.vagrantup.com/boxes/search.
  config.vm.box = "ubuntu/bionic64"

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
   config.vm.synced_folder "./data", "/vagrant_data"

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

#### vagrant up

**Command:** ```vagrant up```

Once your Vagrantfile has been created the next step to launch the virtual machine via Vagrant is through the vagrant up command.  You would issue the command from the same directory where the Vagrantfile is located.  A vagrant up command looks in the local directory for a Vagrantfile to begin parsing.  This command is akin to starting the virtual machine directly.  On the first run the Vagrantfile will be parsed and any settings in the virtual machine platform (VirtualBox in our case) will be changed.  On subsequent runs the Vagrantfile will be ignored. **Note** - This command is issued not from inside the virtual machine but from the commandline of the host system.

**Command:**  ```vagrant up --provision```

The ```--provision``` flag tells Vagrant to re-provision and re-read and parse the Vagrantfile and make any additional changes while launching the virtual machine. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

**Command:** ```vagrant up --provider virtualbox | hyperv | docker | vmware```

When using a Vagrant box from HashiCorp or any other it is a good idea to use the --provider flag to tell Vagrant which platform it will be virtualizing.  This is optional but if you experience problems this is a good troubleshooting tip.

#### vagrant reload

**Command:** ```vagrant reload```

This is akin to a reboot or restart of a virtual machine. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

**Command:** ```vagrant reload --provision```

Will restart the system as well as re-read and parse the Vagrantfile. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

#### vagrant suspend

**Command:** ```vagrant suspend```

This will put the virtual machine in suspend or pause move (standby) as opposed to running vagrant halt, which will power the virtual machine off.  Very handy to quickly resume work.  Don't expect the system to automatically put your virtual machine into standby if you are used to just closing the lid of your laptop. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

#### vagrant halt

**Command:**  ```vagrant halt```
Full shutdown of the virtual machine (power off). Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

#### vagrant destroy

**Command:** ```vagrant destroy```

This command is used to destroy the current instance of a virtual machine -- but not remove the source files.  This allows you to issue a vagrant up command and "start from scratch" without rebuilding or reinstalling the Vagrant Box. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

#### vagrant ssh

**Command:** ```vagrant ssh```

This command is issues after the vagrant up command and allows you to establish an SSH session directly into the vagrant box, with a pre-setup username and password, with NO ASK set in the sudoers file, making for seamless entry.  You should never need to access and username or password in Vagrant as that defeats the purpose of Vagrant.  But for completeness's sake it is vagrant:vagrant. NOTE - the vagrant ssh command works perfectly by default on all Linux, MacOS, and Windows 10 hosts.  

#### vagrant plugin install

**Command:** ```vagrant plugin install vagrant-vbguest```

This command specifically enables the automatic installation of the VirtualBox Additions to enable VirtualBox specific features such as shared folders.

### Vagrant Quick Command Tutorial

Here is a small walk through to install 3 different Vagrant boxes:

1. Create a directory called vagrant on your host system (not in a virtual machine)
2. In that directory create 2 sub-directories; `bionic64` and `centos7`
3. Add the box to vagrant with `vagrant box add ubuntu/bionic64` 
4. `cd` to the bionic64 directory and issue this command: `vagrant init ubuntu/bionic64`
5. Issue the command `vagrant up`
6. Upon successful boot, issue the command: `vagrant ssh` to connect to bionic64 virtual machine
7. Repeat the above steps in the centos7 directory and replace the init command with: `vagrant init centos/7`
8. In each directory issue the command `vagrant halt` or `vagrant suspend` to power down the VMs

## Packer

### The Problem Packer Solves

By 2010 Vagrant was being used to manage VMs, there was no tool that could be used to quickly and reliably create VMs.  This problem was solved by HashiCorp and called [Packer](https://packer.io "Packer.io").  Packer, much like the name suggests, allows you to automate the installation of operating systems.  or better said, "Packer is a tool for creating machine and container images for multiple platforms from a single source configuration[^155]."  Operating systems from Windows to Linux to BSD were all designed to be installed manually.  Unlike installing software, there is no existing operating system when you are installing an operating system, making automatic installation difficult.

Packer attacked this problem by creating its own binary which acts as a supervisor and initiates the proper key sequence to turn a manual install into and automated install via a json based build template.  This can take place on multiple formats or platforms and does not even focus on physical machines.  Packer uses already existing answer file technology for Linux, such as Kickstart and Preseed to allow for automated and repeatable installs to create machine images. "A machine image is a single static unit that contains a pre-configured operating system and installed software which is used to quickly create new running machines. Machine image formats change for each platform. Some examples include AMIs for EC2, VMDK/VMX files for VMware, OVF exports for VirtualBox, and others[^155]." Network installs have existed for decades, but this method always assumed a physical 1-to-1 infrastructure, which as you have seen in this class is no longer the only reality.  

Having a code based automated configuration now lets you track, audit, and centralize your build template in version control. With minor modifications, you can now have centralized machine image construction and export to various hardware platforms.  You could build a VirtualBox VM, which could be exported to Vagrant or Amazon Web Services, or Docker. Now all of your developers, operations, testers, and QA can have access to the same machine on most any platform. As stated on the [Packer.io](https://packer.io "packer wrebpage") webpage the advantages of using packer are as follows[^156]:

* **Super fast infrastructure deployment**
  * Packer images allow you to launch completely provisioned and configured machines in seconds rather than several minutes or hours. This benefits not only production, but development as well, since development virtual machines can also be launched in seconds, without waiting for a typically much longer provisioning time.
* **Multi-provider portability**
  * Because Packer creates identical images for multiple platforms, you can run production in AWS, staging/QA in a private cloud like OpenStack, and development in desktop virtualization solutions such as VMware or VirtualBox. Each environment is running an identical machine image, giving ultimate portability.
* **Improved stability**
  * Packer installs and configures all the software for a machine at the time the image is built. If there are bugs in these scripts, they'll be caught early, rather than several minutes after a machine is launched.
* **Greater testability**
  * After a machine image is built, that machine image can be quickly launched and smoke tested to verify that things appear to be working. If they are, you can be confident that any other machines launched from that image will function properly.

Packer examples and example build code [https://github.com/jhajek/packer-vagrant-build-scripts.git](https://github.com/jhajek/packer-vagrant-build-scripts.git "sample packer code repo")

#### Packer - Conventions

HashiCorp essentially built a tool that captures each install step.  These steps are placed into a Packer build template or just template for short.  These templates are constructed using [JSON](https://en.wikipedia.org/wiki/JSON "JSON").   In addition these templates rely on an "Answer File" for completing all of the installation choices and automating the installation.  On Linux this "answer file" is split between the major Linux distribution families:

#### Packer JSON Build Template

Let us look at an example JSON template file: This source can be retrieved from the source code of the book:
[files > Chapter-13 > packer-build-templates > ubuntu18044-vanilla.json ](https://github.com/jhajek/Linux-text-book-part-1/blob/master/files/Chapter-13/packer-build-templates/ubuntu18044-vanilla.json "Packer Template")

```json
{
  "builders": [
    {
      "name": "ubuntu-vanilla-18044-server",
      "vm_name": "ubuntu-vanilla-18044-server",
      "type": "virtualbox-iso",
      "boot_command": [
        "<esc><wait>",
        "<esc><wait>",
        "<enter><wait>",
        "/install/vmlinuz<wait>",
        " auto<wait>",
        " console-setup/ask_detect=false<wait>",
        " console-setup/layoutcode=us<wait>",
        " console-setup/modelcode=pc105<wait>",
        " debconf/frontend=noninteractive<wait>",
        " debian-installer=en_US<wait>",
        " fb=false<wait>",
        " initrd=/install/initrd.gz<wait>",
        " kbd-chooser/method=us<wait>",
        " keyboard-configuration/layout=USA<wait>",
        " keyboard-configuration/variant=USA<wait>",
        " locale=en_US<wait>",
        " netcfg/get_domain=vm<wait>",
        " netcfg/get_hostname=vagrant<wait>",
        " grub-installer/bootdev=/dev/sda<wait>",
        " noapic<wait>",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed/preseed.cfg<wait>",
        " -- <wait>",
        "<enter><wait>"
      ],
      "boot_wait": "10s",
      "disk_size": 20000,
      "guest_os_type": "Ubuntu_64",
      "http_directory": ".",
      "http_port_min": 9001,
      "http_port_max": 9001,
      "iso_urls": [
        "http://cdimage.ubuntu.com/ubuntu/releases/bionic/release/ubuntu-18.04.4-server-amd64.iso"
      ],
      "iso_checksum_type": "sha256",
      "iso_checksum": "e2ecdace33c939527cbc9e8d23576381c493b071107207d2040af72595f8990b",
      "ssh_username": "vagrant",
      "ssh_password": "vagrant",
      "ssh_port": 22,
      "ssh_wait_timeout": "10000s",
      "shutdown_command": "echo 'vagrant'|sudo -S shutdown -P now",
      "guest_additions_mode": "disable",
      "guest_additions_path": "VBoxGuestAdditions_{{.Version}}.iso",
      "virtualbox_version_file": ".vbox_version",
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
      "execute_command": "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'",
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

There are 3 sections we are interested in:

1. builders
1. provisioners
1. post-processors

#### Builders

The majority of this information is taken from [https://www.packer.io/docs/](https://www.packer.io/docs/ "Packer docs"). Builders are the initial syntax needed to build for a single platform.  This forms the bulk of the JSON Key-Value pairs you see above in the sample template I provided.  The Builder of choice above is for VirtualBox initially, but if my target platform had been something else then I could have switched.  Note the syntax will be different for each builder as some require things others do not (Amazon and Azure require account keys for instance).  The builder in the template above is a VirtualBox ISO builder.  That is defined on line 2: ```"type": "virtualbox-iso"```. Many of these values will change or be different depending on the builder you use. Consult the documentation.

[The builders available are:](https://www.packer.io/docs/builders/index.html "Packer builders available")

1. Builders
1. Alicloud ECS
1. Amazon EC2
1. Azure
1. CloudStack
1. DigitalOcean
1. Docker
1. File
1. Google Cloud
1. Hetzner Cloud
1. HyperOne
1. Hyper-V
1. Linode
1. LXC
1. LXD
1. NAVER Cloud
1. Null
1. 1&1
1. OpenStack
1. Oracle
1. Outscale
1. Parallels
1. ProfitBricks
1. QEMU
1. Scaleway
1. Tencent Cloud
1. JDCloud
1. Triton
1. UCloud
1. Vagrant
1. VirtualBox
1. VMware
1. Yandex.Cloud
1. Custom

#### How the Operating System gets installed

In the builder, there is an iso_url and iso_checksum values that will retrieve installation media and run a checksum against it to make sure that the file is not damaged or corrupt.

```json

"iso_urls": ["http://cdimage.ubuntu.com/ubuntu/releases/bionic/release/ubuntu-18.04.4-server-amd64.iso"],
"iso_checksum": "e2ecdace33c939527cbc9e8d23576381c493b071107207d2040af72595f8990b",

```

This URL is the actual remote location of the install media which will be retrieved and cached into a directory named packer_cache.  The iso file will be renamed with the iso_checksum. Subsequent packer_build commands will use this cached iso media.  You can also copy this cached iso file to other directories as long as it is placed in a local ```packer_cache``` directory--this can be used to speed up downloads.

#### Provisioners

Provisioner are tools that you can use to customize your machine image after the base install is finished.  Though tempting to just use the Kickstart or Pressed files to do the custom install--this is not a good idea.  You should leave the "answer files" as clean or basic as possible so that you may reuse them and do your customization here via a provisioner.

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

Provisioners allow you to have multiple provision scripts.  Some people like to split functionality over multiple shell scripts or use multiple methods.  The `shell` provisioner also has the capability to execute inline Linux commands, incase you need to setup some internal structure.  Also you can use this method to copy code into the Virtual Machine you are created.  If you clone a Git repo to your local system, you can copy that application code directly into your virtual machine as Packer is building it.

```json
{
  "type": "shell",
  "execute_command": "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'", 
  "inline": [
    "mkdir -p /home/vagrant/.ssh",
    "mkdir -p /root/.ssh",
    "chmod 600 /home/vagrant/id_rsa_github_deploy_key",
    "cp -v /home/vagrant/id_rsa_github_deploy_key /home/vagrant/.ssh/",
    "cp -v ./applicaiton-code/html /var/www/html/",
    "cp -v ./mysql/.my.cnf /home/vagrant",
  ]
}
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

Here you see I am converting the VirtualBox `.ovf` file into a Vagrant Box file `.box`.   If you leave off the keep_input_artifact option, the initial artifact will be deleted and only the post-processor result will remain.  If you are concerned about hard drive space - set this value to false.

[Post-Processing includes:](https://www.packer.io/docs/post-processors/index.html "Packer.io post-processing options")

1. Alicloud Import
1. Amazon Import
1. Artifice
1. Compress
1. Checksum
1. DigitalOcean Import
1. Docker Import
1. Docker Push
1. Docker Save
1. Docker Tag
1. Exoscale Import
1. Google Compute Export
1. Google Compute Import
1. Manifest
1. Shell (Local)
1. Vagrant
1. Vagrant Cloud
1. vSphere
1. vSphere Template

You can use multiple post-processors if desired.

#### vboxmanage

This command allows you to issue custom VirtualBox commands from within Packer. This is helpful for modifying hardware, such as number of CPUs and memory allocated during the install.  Also you can modify the number of attached disks programmatically.

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

```json
"vboxmanage": [
  [
    "modifyvm",
    "{{.Name}}",
    "--memory",
    "2048"
  ],
  ["createhd", "--filename", "output-virtualbox/packer-virtualbox-disk3.vdi", "--size", "15000", "--format", "VDI", "--variant", "Standard"],
  ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "hdd", "--medium", "output-virtualbox/packer-virtualbox-disk3.vdi"],
  ["createhd", "--filename", "output-virtualbox/packer-virtualbox-disk4.vdi", "--size", "15000", "--format", "VDI", "--variant", "Standard"],
  ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "hdd", "--medium", "output-virtualbox/packer-virtualbox-disk4.vdi"]
]
```

#### Packer, Putting it Together

There are two key commands to use in Packer, assuming you have added the packer executable to your system path.  First type: packer -v and see if you get version information output.

**Command:** ```packer -v```

Execute this command to see if you get a version output.  If this command throws an error -- go back and check the PATH & INSTALL section and make sure you have closed and reopened your shell.  

![*Output of packer -v*](images/Chapter-13/packer/version.png "Output of packer -v")

**Command:**  ```packer validate```

This command will check the syntax of your `*.json` packer template for syntax errors or missing brackets.  It will not check logic but just syntax.  Good idea to run it to make sure everything is in order.  Using the samples provided in the GitHub repo you can validate the *.JSON template with this command:

![*Output of packer validate*](images/Chapter-13/packer/validate.png "Output of packer validate")

**Command:**  ```packer build```

This command will be what is used to execute and run the packer *.json template.

![*Output of packer build*](images/Chapter-13/packer/build.png "Output of packer build")

**Packer Environment Variables:** ```PACKER_CACHE_DIR```

![*Packer Cache Directory on Windows*](images/Chapter-13/packer/cache.png "Packer Cache Directory on Windows")

When running ```packer build``` Packer will cache the the install media--the iso.  You can set this location to a central directory as this will save time downloading the same media over and over. On Windows you can configure the ```PACKER_CACHE_DIR``` by setting a file location in your user account environment variables.  In Linux and Mac you can set an environment variable in your user profile.

#### When Packer Fails

If any part of the Packer build step fails or generates and error, Packer will roll back and delete any artifacts it has created. It won't leave you with broken items. Sometimes Packer fails right on the last step without much of an error message.  In this case I recommend just re-run the packer build command. Upon completion, cd into the build directory that was created during the post-processor process and go back to the beginning of the Vagrant Tutorial and the section regarding using vagrant box add of custom boxes.

### Answer Files

Most operating system installations are designed for a manual install process.  This makes sense as for almost 40 years we have been using PC's (Personal Computers).  A first step in automating the install process is to automate the answering of the installation questions.  This is the most repetitive process of the install, as well as something that is not conducive to the human, as you spend most of your time waiting.  

#### Fedora and Kickstart

The first solution came from Sun in 1994 and was called [Jumpstart](https://en.wikipedia.org/wiki/JumpStart_(Solaris) "jumpstart"). This was used to hold installation information and as a target system was booted, it would communicate to the Jumpstart server and complete the entire install over the network, OS and handle configuration.

The next phase came in Linux with Fedora creating the [Kickstart](https://docs.fedoraproject.org/en-US/fedora/f28/install-guide/appendixes/Kickstart_Syntax_Reference/#appe-kickstart-syntax-reference "Kickstart Reference") answer file system.  Kickstart does not handle the part of OS install, but the OS configuration and software retrieval/installation.  Kickstart files can be generated from a template or scratch or upon a successful install a default kickstart is located in the location ```/root/anaconda-ks.cfg```. Examples and explanation resources can be found here:

* [Fedora Kickstart Reference](https://docs.fedoraproject.org/en-US/fedora/f28/install-guide/appendixes/Kickstart_Syntax_Reference/#appe-kickstart-syntax-reference "Fedora Kickstart Reference")
* [CentOS Kickstart Reference](https://www.centos.org/docs/5/html/Installation_Guide-en-US/ch-kickstart2.html "CentOS Kickstart Reference")

#### Debian, Ubuntu, and Preseed

[Debian/Ubuntu pressed template](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html "Preseed")  Debian created their own answer file system called [preseed].  You can interrupt a manual install and point to a kickstart file, but it needs to be done over the network.  When you are installing an operating system you don't yet have a filesystem to read files from!  

Working example of a preseed and a kickstart file can be found in the source code of the book: ```files > Chapter-13 > packer-build-templates > preseed``` and ```files > Chapter-13 > packer-build-templates > ks```

Preseed Used for all Debian and Ubuntu based server installs - example and explanation resources can be found here:

* [Sample Preseed Template](https://help.ubuntu.com/lts/installation-guide/example-preseed.txt "Preseed Template")
* [Preseed Ubuntu Guide](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html "Preseed Guide")

### Putting Vagrant and Packer together

How then do we build our own artifacts with Packer to manage them?  Here is an end-to-end example using some sample code provided in the source code repo of the book.  This example will use a prepared Packer build template to install and configure a Vanilla version of Ubuntu Server 1804-3.  Then add the prepared Vagrant Box file to Vagrant, create a Vagrantfile and then start the virtual machine and then `ssh` into the box via Vagrant.

```bash

# clone the source code from the book to get the sample files
# git clone https://github.com/jhajek/Linux-text-book-part-1.git
cd Linux-text-book-part-1/Chapter-13/packer-build-templates
packer build ubuntu18044-vanilla.json

# Upon completion of the Packer build...
# Each build has a string representation of the day, month, year to make each
# filename unique, called epoch
vagrant box add ../build/ubuntu18044-vanilla-1574788560.box --name ubuntu-18044-vanilla
cd ../build
mkdir ubuntu-18044-vanilla
vagrant init ubuntu-18044-vanilla
vagrant up
vagrant ssh

```

## Secrets Management

One of the hardest parts of building software applications is managing **secrets**.  Secrets can be anything from a username and a password, a token, or even keys from cloud services.  The important part is that they are important.  If you loose these secrets it could mean the end to a company.  You also have to worry about invalidating them.  If a person leaves, or rotates job, you don't want credentials to walk out the door with you.  Also managing these secrets not just for security but for automation is also a critical part of the infrastructure.

In Linux distros as well as Packer, there are methods for dealing with secrets.  The first obvious example how to we *seed* a root password for a MySQL server?  If you install it, there is always a password prompt?  This precludes you from automating the install.

All Debian based distros have a configuration database called `DEBCONF`.  This can be used to preseed and answers you may have to installation questions that come via `apt-get`.  Here is an example:

```bash
# This is sample code to add to a provisioner
# script that will pre-seed the password for a database.
export DEBIAN_FRONTEND=noninteractive
FIRSTPASS="mariadb-server mysql-server/root_password password ilovebunnies"
SECONDPASS="mariadb-server mysql-server/root_password_again password ilovebunnies"
echo $FIRSTPASS | sudo debconf-set-selections
echo $SECONDPASS | sudo debconf-set-selections
```

This example will set the answer to the root password prompt for MariaDB and or MySQL.  In the above code the password is *ilovebunnies*.  This is an automation improvement, but a security nightmare, as now our **root** password is hardcoded into our code and will then be placed in our GitHub repo for all to see.  We can mitigate this by using ENV variables like this:

```bash
# run this on the command line and the value will be exported to all shells (or set this in your .bashrc)
export $DBPASS="ilovebunnies"
# run this in a shell script
export DEBIAN_FRONTEND=noninteractive
FIRSTPASS="mariadb-server mysql-server/root_password password $DBPASS"
SECONDPASS="mariadb-server mysql-server/root_password_again password $DBPASS"

echo $FIRSTPASS | sudo debconf-set-selections
echo $SECONDPASS | sudo debconf-set-selections
```

This is better but not the best as others on the system or any code that can read ENV variables can now read the password.  Packer has a way to pass ENV variables from a config file.  This is similar to how WordPress is configured.   Adding these lines of code to your Provisioner in your Packer build template allows this:

```json
{
  "type": "shell",
  "execute_command": "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'",
  "script": "../scripts/post_install_itmt430-github-db.sh",
  "environment_vars": [
    "DBPASS={{user `database-root-password`}}",
    "USERPASS={{user `database-user-password`}}",
    "ACCESSFROMIP={{user `database-access-from-ip`}}",
    "DATABASEIP={{user `database-ip`}}",
    "DATABASENAME={{user `database-name`}}",
    "DATABASEUSERNAME={{user `database-user-name`}}"
  ]
}
```

Packer has the ability to set ENV variables upon install.  From the command line you pass an additional `--var-file=` command and Packer will load values from that file.

```bash

packer build --var-file=./variables.json ubuntu18044-vanilla-multi-drives.json

```

```json
{
  "database-root-password": "foo",
  "database-user-password": "bar",
  "database-access-from-ip": "127.0.0.1",
  "database-ip": "127.0.0.1",
  "webserver-ip": "127.0.0.1",
  "database-name": "namegoeshere",
  "database-user-name": "database-username-goes-here"
}
```

There is a consideration here, if you add values to `variables.json` they will still be pushed to your Git repo and you will have the same problem.  When you need to do is create a template.  Essentially the file, `variables-sample.json` is just that a template to show you what values you can enter.  You can copy the file, change the name to `variables.json` for instance.  Then in your Git repo, add an entry to the `.gitignore`.  This file in the root of your Git repo will ignore all files you tell it to.  This way you can distribute your template for secrets and passwords, but now you can retain a local copy that will be exposed via Git. Sample files are provided in the files > Appendix-D > packer-scripts folder.

### How to Manage Secrets

But what happens when your secrets need to be managed by multiple people across a large enterprise, or even a large cloud enterprise?  There is an opensource and enterprise grade product from [HashiCorp called Vault](https://www.vaultproject.io/ "HashiCorp Vault webpage").  It does what is says, essentially cryptographically storing all the secrets you enter into a *vault*, then delegating access to these secrets via API (over HTTP) allowing for the implementation of policy and identity relating to accessing these secrets.  The *vault* can then be attached or mounted into any system and each developer can access their secrets. Vaults use cases are as follows"

Vault tightly controls access to secrets and encryption keys by authenticating against trusted sources of identity such as Active Directory, LDAP, Kubernetes, CloudFoundry, and cloud platforms. Vault enables fine grained authorization of which users and applications are permitted access to secrets and keys.  Vault can be integrated with other platforms as well, Active Directory, AWS IAM profile management, and other platforms.

#### Vault Integration With Packer

For our convenience, Packer has direct integration with Vault.  Once Vault is installed an setup on your [local system](https://www.vaultproject.io/docs/install/index.html "Install Vault") for instance by running the Vault agent you can simply read your secrets in the Packer Build Template, without the secret ever being seen by a person.  There is more to say on this, but the reason we introduce it here is so that you can be exposed to safe practices from the beginning as well as deal with one of the major problems in IT, which is Secrets Management.

```json
{
  "variables": {
    "database-root-password": "{{ vault `secrets/database-root-password` `database-root-password`}}",
    "database-user-password": "{{ vault `secrets/database-user-password` `database-user-password`}}",
    "database-access-from-ip": "{{ vault `secrets/database-access-from-ip` `database-access-from-ip`}}",
    "database-ip": "{{ vault `secrets/database-ip` `database-ip`}}",
    "webserver-ip": "{{ vault `secrets/webserver-ip` `webserver-ip`}}",
    "databaseslave-ip": "{{ vault `secrets/databaseslave-ip` `databaseslave-ip`}}",
    "cache-ip": "{{ vault `secrets/cache-ip` `cache-ip`}}",
    "salt": "{{ vault `secrets/salt` `salt`}}"
  }
  
  {
    "type": "shell",
    "execute_command": "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'",
    "script": "../scripts/post_install_itmt430-github-db.sh",
    "environment_vars": [
      "DBPASS={{user `database-root-password`}}",
      "USERPASS={{user `database-user-password`}}",
      "ACCESSFROMIP={{user `database-access-from-ip`}}",
      "DATABASEIP={{user `database-ip`}}",
      "DATABASENAME={{user `database-name`}}",
      "DATABASEUSERNAME={{user `database-user-name`}}"
    ]
  }
}
```

Packer provides the ability to execute inline Linux commands.  This would be useful for instance in copying code from a Git repo into a Virtual Machine via making an SCP (Secure Copy) connection.

```json
{
  "type": "shell",
  "execute_command": "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'",
  "inline": [
    "mkdir -p /var/www/html",
    "cp -v ../github-repo/php /var/www/html",
    "cp -v ../github-repo/sql /home/vagrant/",
  ]
}
```

### IT Orchestration

In looking at these tools, Vagrant, Packer, Preseed, and Kickstart, we begin to see a world of automation opening up to us.  In a sense these technologies are the culmination of the Unix concepts of small tools doing one things--or shell scripts on steroids, so to speak.  Each of these technologies is beyond the scope of this book, but here are some podcasts and links to learn more about them.

* [SaltStack](https://www.saltstack.com/ "Saltstack")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/262 "SaltStack Podcast")
* [Chef](https://www.chef.io/ "Chef.io")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/219 "Chef Podcast")
* [Puppet](https://puppet.com/ "Puppet")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/93 "Puppet")
* [Ansible](https://www.ansible.com/ "Ansible")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/257 "Ansible Podcast")
* [CfEngine](https://cfengine.com/ "CFengine")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/106 "CFengine Podcast")
  * [Dr. Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist) "Dr Mark Burgess") wrote a book about his research in IT called [In Search of Certainty](http://markburgess.org/certainty.html "In search of certainty the book")
* [Terraform](https://www.hashicorp.com/products/terraform "Terraform")
  * [HashiCorp Terraform Presentation](https://www.youtube.com/watch?v=jdDKjWZ2qbk&index=39&list=PL81sUbsFNc5Y-jbEC1y5BWenDoYscVv4t "Terraform and Packer")

## Chapter Conclusions and Review

In this chapter we learned how a spread in technology led to a desire to automate and ease installation and configuration. A new generation of technology brought a new generation of tools.  These tools are a part of what we called cloud-native, immutable infrastructure, and are the standard ways to deploy operating systems and hardware across the industry.

### Review Questions

1. What is a common title given to IT workers who are responsible for the ongoing operations of applications and their environments?

   a) saints
   b) devs
   c) devops
   d) ops

2. What would describe Mitchell Hashimoto's design goals in created Vagrant?

   a) Automation
   b) Separation of Duties
   c) Profit
   d) Inspection

3. What is the name of the tool originally built as an abstraction layer on top of VirtualBox to deploy virtual machines?

   a) Packer
   b) VirtualBox
   c) Terraform
   d) Vagrant

4. What is the name of the tool originally built as a way to automate the installation of any operating system into an artifact?

   a) Packer
   b) VirtualBox
   c) Terraform
   d) Vagrant

5. What year approximately was Vagrant introduced?

   a) 2019
   b) 2001
   c) 2010
   d) 2015

6. Fill in the blank. Think of Vagrant as _______________ between you and VirtualBox, Hyper-V, Docker, or even VMware desktop.

7. What is the name of the file type Vagrant uses that contains an `vmdk` and and `ovf`?

   a) `*.vdi`
   b) `*.vhd`
   c) `*.box`
   d) `*.zip`

8. Name the file that contains the configuration file for each Vagrant box file.
 
9. What is the correct command to add the Vagrant Box `centos/7`?

   a) `vagrant add box centos/7`
   b) `vagrant box add centos/7`
   c) `vagrant init centos/7`
   d) `vagrant add centos/7`

10. What is the command used to list all Vagrant Boxes being managed by Vagrant?

    a) `vagrant list box`
    b) `vagrant boxes list`
    c) `vagrant box list`
    d) `vagrant list`

11. What is the correct command to initialize a Vagrant file for Vagrant Box named `centos/7` that has already been added to the system?

    a) `vagrant init`
    b) `vagrant init centos/7`
    c) `vagrant box add centos/7`
    d) `vagrant init 7`

12. What is the Vagrant command to start or turn on a Vagrant Box?

13. What is the Vagrant command to restart a Vagrant Box?

14. What is the Vagrant command to shutdown or poweroff a Vagrant Box?

15. For Packer.io, what is the descriptive name of the json file used for building artifacts?

    a) image template
    b) machine.json
    c) build template
    d) provisioner

16. What is the name of the stage that runs after the builder portion of a build template?

    a) imager
    b) provisioner
    c) vboxmanage
    d) post-processor

17. What is the name of the stage that runs after building and provisioning of Packer artifacts is complete?

    a) imager
    b) provisioner
    c) vboxmanage
    d) post-processor

18. If there is an error in any part of the Packer build command what will happen?

    a) nothing
    b) an error will be logged but the process will continue
    c) the command will terminate and any artifacts will be deleted
    d) the user will be prompted

19. What is the generic name of the file that is provided to Packer to help it complete the manual question part of the install?

    a) secret file
    b) answer file
    c) question file
    d) pxe file

20. What are the respective names of the Red Hat and Debian based answer files?

    a) jumpstart and preseed
    b) kickstart and jumpstart
    c) kickstart and preseed
    d) Chef and Puppet

### Podcast Questions

See the presentation at: [https://www.youtube.com/watch?v=xXWaECk9XqM](https://www.youtube.com/watch?v=xXWaECk9XqM "Bryan Cantrill HashiConf 2017 Presentation"): The Container Revolution: Reflections After the First Decade by Bryan Cantrill.

1. ~0:30 Where does/did Bryan work, who recently bought that company, and what do they do?
1. ~1:33 What is the birth date of containers?
1. ~3:25 What was the next iteration of containers?
1. ~3:49 What is the purpose of a Jail?
1. ~5:10 What did Sun call their full application environment they created in 2002?
1. ~6:13 What is every application running on?
1. ~8:43 What did Amazon announce in 2006?
1. ~9:00 In 2006 what technology was Joyent using to run its Public Cloud? In 2006 what technology was Amazon using to run its Public Cloud?
1. ~9:25 What became de facto for the cloud?
1. ~11:18 What happens to the RAM when you give it to an operating system?
1. ~14:40 What does Joyent's Manta service allow you to do with containers and objects?
1. ~18:58 What command hadn't been created in 1986?
1. ~21:45 When did the world figure out containers and what was this product?
1. ~22:57 Why did the container revolution start with Docker?
1. ~24:07 Containers allow developers to do what?
1. ~26:00 What is Triton and what does it do?
1. ~31:42 What are the two approaches to the container ecosystem, and what is the difference?
1. ~33:25 What is the "Hashi" ethos?
1. ~37:00 What was the mistake that happened with the pilot-operated relief valve at 3 Mile Island?
1. ~39:05 Accroding to the speaker, with container based systems, in what terms must we think in?
1. ~40:00 Why is scheduling containers inside of Virtual Machines a bad idea?
1. ~What are Joyent's thoughts regarding Virtual Machines in the application stack?

### Lab

#### Part 1

Create a folder structure for 1 Ubuntu Bionic64 vagrant box and 1 CentOS 7 vagrant box.  In each of these folders use the ```vagrant init``` command to create a ```Vagrantfile```.  Upon succesfully executing the `vagrant up` command in both directories, take a screenshot of the output of the ```vagrant box list``` command.

#### Part 2

Run the packer json build templates for CentOS 7 and Ubuntu 18.04 from the textbook source code located in ```files > Chapter 13 > packer-build-tempates```, for each template execute ```packer build centos-7-vanilla-json``` and ```packer build ubuntu18041-vanilla.json```.  Once these Vagrant boxes are built, use the ```vagrant box add``` command to add them to your Vagrant system.  Run the ```vagrant init``` command with the proper options to create a Vagrantfile and then run the ```vagrant up``` command to instantiate the box. Issue the command ```vagrant ssh``` and once logged in take a screenshot of the output of the command ```free --giga``` to list the amount of memory in the virtual machine.

Upon completion take a screenshot of the output of the ```vagrant box list``` command to show that these steps completed successfully.

#### Part 3

Edit the Vagrantfile for both Vagrant boxes to run at 3072 RAM (3 GB) each.  Issue the command to reload and re-provision the virtual machines.  Upon successfully issuing this command, issue the ```vagrant ssh``` command and again execute the ```free --giga``` command to show that the memory adjustment actually took place. Take a screenshot of the results.

#### Part 4

Utilize the ```vagrant destroy``` command.  On each of the four Vagrant boxes that have been created in the previous steps, execute the command to install the Apache2 webserver:

* ```sudo apt-get install apache2```
* ```sudo yum install httpd```

Take a screenshot of the output of the ```sudo systemctl status apache2``` or ```sudo systemctl status httpd``` command. Exit the Vagrant box.  Issue a ```vagrant destroy``` command, then a ```vagrant up``` command.  Issue the ```vagrant ssh``` command and reissue the above systemctl commands to show that all 4 boxes have been destroyed and rebuilt.  Take a screenshot of the results.

#### Footnotes

[^153]: [http://d13pix9kaak6wt.cloudfront.net/background/users/m/i/t/mitchellh_1370739801_5.jpg](http://d13pix9kaak6wt.cloudfront.net/background/users/m/i/t/mitchellh_1370739801_5.jpg "Mitchell Hashimoto")

[^154]: [https://www.vagrantup.com/docs/why-vagrant/](https://www.vagrantup.com/docs/why-vagrant/ "Why try Vagrant?")

[^155]: [https://www.packer.io/intro/index.html](https://www.packer.io/intro/index.html "Pacjer.io")

[^156]: [https://www.packer.io/intro/why.html](https://www.packer.io/intro/why.html "Why Use Packer?")
