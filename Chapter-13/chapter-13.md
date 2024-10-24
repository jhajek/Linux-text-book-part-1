# Infrastructure Installation and IT Orchestration

![*Good thing we avoided that one...*](images/Chapter-Header/Chapter-13/automation.png "https://xkcd.com/1319/ automation")

## Objectives

* Explain the problem that automation tooling for Linux provides
* Identity Current orchestration and automation tools
* Explain the role of Hashicorp in the realm of automation tools
* Describe the process to automate the installation of Linux Operating Systems 
* Explain the concept of secrets management in automation
* Identify a solution for deploying complete applications using automation tooling on Linux
  
## Outcomes

At the conclusion of this chapter you will have a basic understanding of how to use infrastructure automation and orchestration tools. You will be familiar and able to explain the concept of immutable infrastructure and will be able to use Linux commands for enabling cloud native development technologies.

## Automation and HashiCorp

One of the main things that computers are good at is executing repetitive tasks. One of the things humans seem to dislike is repeating the same task. Let's give a practical example; there is a divide between the developers (devs) and the operations (ops) people when it comes to software and infrastructure (dev + ops = devops). Developers need hardware to test their code on and then more hardware to run their code in production. Operations people have to maintain those systems and the code and the lifecycle of the application. Developers started to think, could we deploy our infrastructure in the same way we deploy code? Could we automate our way out of this problem?

### Mitchel Hashimoto

![*Mitchell Hashimoto*](images/Chapter-13/people/mh.png "mitchell hashimoto")

In 2010, Mitchell realized that a good majority of developers where using VirtualBox to run and build test systems on their local machines and laptops[^153]. He found that he could be productive creating copies of the production servers where his code would reside as a local VM on his system. VirtualBox just provided an interface to virtualize an operating system, and had no provisions for quickly deploying or automating an OS deployment--it was still a manual process. He and his company set out to solve this problem by developing opensource software that would automate the creation of virtual machines. You can learn more about HashiCorp at this [HashiConf 2017 keynote presentation](https://www.youtube.com/watch?v=b6nn7vLdjo8&list=PL81sUbsFNc5Y-jbEC1y5BWenDoYscVv4t&t=0s&index=2 "Keynote presentation from Mitchell Hashimoto") from Mitchell Hashimoto.

## The Problem Vagrant Solves

At that time, [HashiCorp](https://hashicorp.com "HashiCorp") was born. This was in 2010 and Mitchell's first task was easing the deployment, connection, and most importantly abstracting the network address translation between host and guest operating systems. He created [Vagrant](https://vagrantup.com "Vagrant") to do just this. 

![*HashiCorp Stack*](images/Chapter-13/hashi/hashistack.png "hashi-stack")

### Vagrant as an Abstraction Layer

Think of Vagrant as an abstraction layer between you and VirtualBox, Hyper-V, Parallels, or even VMware Workstation. It is written in the Ruby Language and comes as a self-contained binary that runs across all platforms. Vagrant just acts as an interface to your virtualization software. Vagrant initially was a VirtualBox only product but has moved to be an abstraction layer now for multiple virtualization and container platforms.

* Hyper-V
* Parallels 
* VMware Workstation and Fusion Products
* KVM
* And others via a plugin system

### Obtaining a Vagrant Box

There are two ways to obtain a Vagrant Box (*.box file). The first way would be to obtain pre-made images from a site you trust (remember you are running other people's configuration and software in your place of work -- just be aware). The first place to look is from Vagrantup.com itself - [https://app.vagrantup.com/boxes/search](https://app.vagrantup.com/boxes/search "Vagrant box search"). Here you can search for boxes of other operating systems and versions. Most opensource companies release a pre-configured Vagrant Box all setup for you to test their software in one place.

Using this facility you can simply run a command from the terminal: The command `vagrant init ubuntu/jammy64` would automatically construct a `Vagrantfile`, as well as retrieve an Ubuntu Jammy server based operating system box file. The second way is described later in the chapter; that is to build and add your own boxes.

#### Intel vs Apple Silicon

This tutorial assumes you are using a Windows PC or an Intel based Mac PC. For those using the new Apple Silicon or M1 Macs you will need to see special inserts along the way and will be looking for arm64, arm, or aarch64 based Vagrant boxes. The reason is that the Apple architecture is completely different from the Intel Architecture and you need an Operating system compiled for your own architecture.

### Parallels Pro, M1, and Vagrant

* For M1 Macs you will need to make a purchase of a copy of Parallels Pro or Enterprise edition
  * [https://www.parallels.com/products/desktop/pro/](https://www.parallels.com/products/desktop/pro/ "Parallels Pro Edition")
* [50% off for students and educators Link](https://www.parallels.com/landingpage/pd/education/ "webpage for discount for student and educators")
  * The standard and education edition doesn't contain the commandline interface needed for automation.
* Once Vagrant and Parallels Pro Edition is installed you need to also install the Parallels SDK from the Download Tab in your parallels.com account
  * From the Terminal run the command: `vagrant plugin install vagrant-parallels`
    * This will add the needed plugin to allow you to use Parallels as a default provider for Vagrant
    * This will also work if you have Parallels Pro Edition on an Intel Mac

#### Vagrant .box Format

Vagrant handles its abstraction by using a file concept called a **box** or ```*.box```. The box file is nothing more than a compressed archive containing a virtual hard drive and a configuration file that tells the Vagrant provider which virtualization software to launch this with. For example a `*.box` file that was made for the VirtualBox provider would contain a `*.vmdk` (hard drive) and an `*.ovf` file (meta-data and Virtual Machine settings file). Each Vagrant `*.box` file needs a config file called: **Vagrantfile**. This is an abstraction file to modify settings for the virtual machine at run time. There is a sample Vagrantfile later in this chapter. These two components are what is needed to run and manage Vagrant boxes.

#### vagrant init

We need a `.box` file and we need a `Vagrantfile` to run our virtual machines. You have one `Vagrantfile` per-Vagrant box. The `vagrant init` command is how we create a Vagrantfile. What is a `Vagrantfile`? It is a simple configuration file for a standard set of values that can be reconfigured for virtual machines. By using the `Vagrantfile` abstraction layer you can reuse your configuration across different platforms. Here is a sample Vagrantfile, which is available in the book source code [files > Chapter-13 > vagrant-init-files](https://github.com/jhajek/Linux-text-book-part-1/tree/master/files/Chapter-13/vagrant-init-files "Vagrantfile"):

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
  config.vm.box = "ubuntu/jammy64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
    config.vm.network "private_network", ip: "192.168.56.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "./data", "/vagrant_data"

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

### How Vagrant Benefits You

> *If you are a developer[^154], Vagrant will isolate dependencies and their configuration within a single disposable, consistent environment, without sacrificing any of the tools you are used to working with (editors, browsers, debuggers, etc.). Once you or someone else creates a single Vagrantfile, you just need to vagrant up and everything is installed and configured for you to work. Other members of your team create their development environments from the same configuration, so whether you are working on Linux, Mac OS X, or Windows, all your team members are running code in the same environment, against the same dependencies, all configured the same way. Say goodbye to "works on my machine" bugs.*

> *If you are an operations engineer, Vagrant gives you a disposable environment and consistent workflow for developing and testing infrastructure management scripts. You can quickly test things like shell scripts, Chef cookbooks, Puppet modules, and more using local virtualization such as VirtualBox or VMware. Then, with the same configuration, you can test these scripts on remote clouds such as AWS or RackSpace with the same workflow. Ditch your custom scripts to recycle EC2 instances, stop juggling SSH prompts to various machines, and start using Vagrant to bring sanity to your life.*

> *If you are a designer, Vagrant will automatically set everything up that is required for that web app in order for you to focus on doing what you do best: design. Once a developer configures Vagrant, you do not need to worry about how to get that app running ever again. No more bothering other developers to help you fix your environment so you can test designs. Just check out the code, vagrant up, and start designing.*

#### Storing Vagrantfiles

Let us start by creating a sub-directory with the same box name to house the Vagrantfile.

> *"The primary function of the Vagrantfile is to describe the type of machine required for a project, and how to configure and provision these machines. Vagrantfiles are called Vagrantfiles because the actual literal filename for the file is Vagrantfile."*

> *"Vagrant is meant to run with one Vagrantfile per project, and the Vagrantfile is supposed to be committed to version control. This allows other developers involved in the project to check out the code, run vagrant up, and be on their way. Vagrantfiles are portable across every platform Vagrant supports."*

> "*The syntax of Vagrantfiles is Ruby, but knowledge of the Ruby programming language is not necessary to make modifications to the Vagrantfile, since it is mostly simple variable assignment. In fact, Ruby is not even the most popular community Vagrant is used within, which should help show you that despite not having Ruby knowledge, people are very successful with Vagrant.*"

![*Suggested Folder Hierarchy*](images/Chapter-13/vagrant/directory.png "Suggested Directory Structure")

In this example I created the directory `vagrant` under `Documents`. Once you have created these folders, `cd` into one. For instance take the `jammy64` or `almalinux9` directories. You would `cd` into `jammy64` directory and type: `vagrant init ubuntu/jammy64`. This will create the `Vagrantfile` that points and works with the jammy64 vagrant box. The idea behind the `Vagrantfile` is that it has a shorthand syntax that is universally translated by Vagrant into specific virtualization platforms. The Vagrantfile handles all the properties that could be set (such as RAM, CPU, shared drives, port forwarding, networking, and so forth).

### Vagrant Box Commands

When executing the `vagrant box` command from the command line (in Windows recommend using PowerShell Core) you will see this list of subcommands below, but we will primarily use just the first three:

* `add`
* `list`
* `remove`
* `outdated`
* `repackage`
* `update`

#### vagrant box add

```bash
vagrant box add
```

The first command **add** is the command we will use to add boxes (either of the two methods) from above. These are all premade systems made with Packer.io and [distributed by HashiCorp](https://app.vagrantup.com/boxes/search "Vagrant Search").  

The tutorial on vagrantup.com will walk you through this but a small example (try any of these especially if you are not familiar with these platforms).

* `vagrant box add almalinux/9` (Official Almalinux 9 Red Hat Clone release)
* `vagrant box add rockylinux/9` (Official Rocky Linux 9 Red Hat Clone release)
* `vagrant box add terrywang/archlinux` (user provided Arch Linux distro)
* `Vagrant box add opensuse/Tumbleweed.x86_64` (Suse rolling release official distro)
* `vagrant box add freebsd/FreeBSD-14.0-CURRENT` (official FreeBSD vagrant box)
* `vagrant box add ubuntu/jammy64` (Canonical--Ubuntu 22.04 parent company - provided)
* `vagrant box add debian/bookworm64` (Official Debian Bookworm release)

For those using M1 Macs and Parallels you will need to replace the names of the Boxes in the demos with these two that have been prepared for M1 macs and parallels

* `bento/ubuntu-22.04-arm64`
* `almalinux/9.aarch64`

1. `mkdir jammy64-arm`
1. `cd jammy64-arm`
1. `vagrant init bento/ubuntu-22.04-arm64` 
  
1. `mkdir almalinux9-arm`
1. `cd almalinux9-arm` 
1. `vagrant init almalinux/9.aarch64`

### Vagrant commands

#### vagrant box list

**Command:** `vagrant box list`

You can check to see if the vagrant box add command was successful by issuing the command: `vagrant box list`; looking something like this: (Note this is my system, yours will vary but the structure will be the same).

```bash
PS C:\Users\Jeremy\Documents\vagrant> vagrant box list
almalinux/9                (virtualbox, 9.2.20230513)
debian/bookworm64          (virtualbox, 12.20230615.1)
debian/bullseye64          (virtualbox, 11.20221219.1)
generic/freebsd13          (virtualbox, 4.3.2)
itmd-321                   (virtualbox, 0)
itmd-521                   (virtualbox, 0)
itmo-444                   (virtualbox, 0)
opensuse/Tumbleweed.x86_64 (virtualbox, 1.0.20231026)
ubuntu/jammy64             (virtualbox, 20230720.0.0)
```

#### vagrant box remove

**Command:** `vagrant box remove`

The same way that you add boxes you can remove them from your list.  You need to know the name of the box that was added, run a vagrant box list command and find the name that way.  The below commands would remove the boxes added in the previous section.

* `vagrant box remove almalinux/9`
* `vagrant box remove ubuntu/jammy64`

#### vagrant up

**Command:** `vagrant up`

Once your Vagrantfile has been created the next step to launch the virtual machine via Vagrant is through the vagrant up command.  You would issue the command from the same directory where the Vagrantfile is located. A vagrant up command looks in the local directory for a Vagrantfile to begin parsing. This command is akin to starting the virtual machine directly.  On the first run the Vagrantfile will be parsed and any settings in the virtual machine platform (VirtualBox in our case) will be changed. On subsequent runs the Vagrantfile will be ignored. **Note** - This command is issued not from inside the virtual machine but from the commandline of the host system.

**Command:**  `vagrant up --provision`

The `--provision` flag tells Vagrant to re-provision and re-read and parse the Vagrantfile and make any additional changes while launching the virtual machine. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

**Command:** `vagrant up --provider virtualbox | hyperv | docker | vmware | parallels`

When using a Vagrant box from HashiCorp or any other it is a good idea to use the --provider flag to tell Vagrant which platform it will be virtualizing. This is optional but if you experience problems this is a good troubleshooting tip.

#### vagrant reload

**Command:** `vagrant reload`

This is akin to a reboot or restart of a virtual machine. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

**Command:** `vagrant reload --provision`

Will restart the system as well as re-read and parse the Vagrantfile. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

#### vagrant suspend

**Command:** `vagrant suspend`

This will put the virtual machine in suspend or pause move (standby) as opposed to running vagrant halt, which will power the virtual machine off.  Very handy to quickly resume work.  Don't expect the system to automatically put your virtual machine into standby if you are used to just closing the lid of your laptop. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

#### vagrant halt

**Command:** `vagrant halt`
Full shutdown of the virtual machine (power off). Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

#### vagrant destroy

**Command:** `vagrant destroy`

This command is used to destroy the current instance of a virtual machine -- but not remove the source files.  This allows you to issue a vagrant up command and "start from scratch" without rebuilding or reinstalling the Vagrant Box. Note - This command is issued not from inside the virtual machine but from the commandline of the host system.

#### vagrant ssh

**Command:** `vagrant ssh`

This command is issues after the vagrant up command and allows you to establish an SSH session directly into the vagrant box, with a pre-setup username and password, with NO ASK set in the sudoers file, making for seamless entry.  You should never need to access and username or password in Vagrant as that defeats the purpose of Vagrant.  But for completeness's sake it is vagrant:vagrant. NOTE - the vagrant ssh command works perfectly by default on all Linux, macOS, and Windows 10 hosts.  

#### vagrant plugin install

**Command:** `vagrant plugin install vagrant-vbguest` or `vagrant plugin install vagrant-parallels`

This command specifically enables the automatic installation of the VirtualBox Additions to enable VirtualBox specific features such as shared folders. The second command in needed if using Vagrant on a M1/M2 Mac using Parallels Pro.

### Vagrant Quick Command Tutorial

Here is a small walk through to install 2 different Vagrant boxes:

1. Create a directory called vagrant on your host system (not in a virtual machine)
1. In that directory create 2 sub-directories; `jammy64` and `almalinux9`
1. `cd` to the bionic64 directory and issue this command: `vagrant init ubuntu/jammy64`
1. Issue the command `vagrant up`
1. Upon successful boot, issue the command: `vagrant ssh` to connect to bionic64 virtual machine, then `exit` the ssh session
1. Repeat the above steps in the centos7 directory and replace the init command in step 3 with: `vagrant init almalinux/9`
1. In each directory issue the command `vagrant halt` or `vagrant suspend` to power down the VMs

## Packer

### The Problem Packer Solves

By 2010 Vagrant was being used to manage VMs, there was no tool that could be used to quickly and reliably create VMs. This problem was solved by HashiCorp and called [Packer](https://packer.io "Packer.io"). Packer, much like the name suggests, allows you to automate the installation of operating systems. Or better said, "Packer is a tool for creating machine and container images for multiple platforms from a single source configuration[^155]." Operating systems from Windows to Linux to BSD were all designed to be installed manually.  Unlike installing software, there is no existing operating system when you are installing an operating system, making automatic installation difficult.

Packer attacked this problem by creating its own binary which acts as a supervisor and initiates the proper key sequences to turn a manual install into and automated install via a JSON based build template. This can take place on multiple formats or platforms and does not even focus on physical machines. Packer uses already existing answer file technology for Linux, such as Kickstart and Preseed to allow for automated and repeatable installs to create machine images. "A machine image is a single static unit that contains a pre-configured operating system and installed software which is used to quickly create new running machines. Machine image formats change for each platform. Some examples include AMIs for EC2, VMDK/VMX files for VMware, OVF exports for VirtualBox, and others[^155]." Network installs have existed for decades, but this method always assumed a physical 1-to-1 infrastructure, which as you have seen in this class is no longer the only reality.

Having a code based automated configuration now lets you track, audit, and centralize your build template in version control. With minor modifications, you can now have centralized machine image construction and export to various hardware platforms. You could build a VirtualBox VM, which could be exported to Vagrant or Amazon Web Services, or Docker. Now all of your developers, operations, testers, and QA can have access to the same machine on most any platform. As stated on the [Packer.io](https://packer.io "packer webpage") webpage the advantages of using packer are as follows[^156]:

* **Super fast infrastructure deployment**
  * Packer images allow you to launch completely provisioned and configured machines in seconds rather than several minutes or hours. This benefits not only production, but development as well, since development virtual machines can also be launched in seconds, without waiting for a typically much longer provisioning time.
* **Multi-provider portability**
  * Because Packer creates identical images for multiple platforms, you can run production in AWS, staging/QA in a private cloud like OpenStack, and development in desktop virtualization solutions such as VMware or VirtualBox. Each environment is running an identical machine image, giving ultimate portability.
* **Improved stability**
  * Packer installs and configures all the software for a machine at the time the image is built. If there are bugs in these scripts, they'll be caught early, rather than several minutes after a machine is launched.
* **Greater testability**
  * After a machine image is built, that machine image can be quickly launched and smoke tested to verify that things appear to be working. If they are, you can be confident that any other machines launched from that image will function properly.

#### Packer Conventions

HashiCorp essentially built a tool that captures each install step. These steps are placed into a Packer build template or just template for short. These templates are constructed using [HCL](https://github.com/hashicorp/hcl "wiki page for HCL"). In addition these templates rely on an "Answer File" for completing all of the installation choices and automating the installation. Debian uses `pressed` format, Red Hat clones use `kickstart` and Ubuntu has their own called `subiquity`.

#### Packer HCL Build Template

Let us look at an example HCL template file: This source can be viewed from the source code of the book:
[files > Chapter-13 > packer-build-templates](https://github.com/jhajek/Linux-text-book-part-1/blob/master/files/Chapter-13/packer-build-templates/ "Packer Template")

```json
//############################################################################
//# Packer Virtualbox-iso documentation: 
//# https://developer.hashicorp.com/packer/plugins/builders/virtualbox/iso
//############################################################################
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

packer {
  required_plugins {
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = ">= 1.0.5"
    }
  }
}

source "virtualbox-iso" "ubuntu-22045-server" {
    boot_command = [
        "e<wait>",
        "<down><down><down>",
        "<end><bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
      ]
  boot_wait               = "5s"
  disk_size               = 35000
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  firmware                = "efi"
  hard_drive_interface    = "virtio"
  rtc_time_base           = "UTC"
  // https://www.virtualbox.org/manual/ch06.html
  nic_type                = "virtio"
  iso_checksum  = "file:https://mirrors.edge.kernel.org/ubuntu-releases/22.04.5/SHA256SUMS"
  iso_urls                = "${var.iso_url}"
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_username            = "vagrant"
  ssh_password            = "${var.user-ssh-password}"
  ssh_timeout             = "45m"
  cpus                    = 2
  memory                  = "${var.memory_amount}"
  // Change to --nat-localhostreachable1 forced by 
  // https://github.com/hashicorp/packer/issues/12118
  vboxmanage              = [["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "jammy-server"
  headless                = "${var.headless_build}"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-22045-server"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2204_vagrant.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output = "${var.build_artifact_location}{{ .BuildName }}-${local.timestamp}.box"
  }
}
```

#### Important Packer Blocks

There are 3 blocks we are interested in:

1. source block
1. build block
1. post-processor block

### Builders

The majority of this information is taken from [https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox](https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox "Webpage Packer VirtualBox docs"). We are using the `virtualBox-iso` builder. This builder starts from an ISO file, creates a brand new VirtualBox VM, installs an OS, provisions software within the OS, then exports that machine to create an image. This is best for people who want to start from scratch.  Currently there are ~49 different builders all maintained as external plugins. You download the plugins you need as part of your build template. [The builders available are:](https://developer.hashicorp.com/packer/integrations "Packer builders available")

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

#### How the Operating System gets installed

In the builder, there is an iso_url and iso_checksum values that will retrieve installation media and run a checksum against it to make sure that the file is not damaged or corrupt.

```json
{
iso_checksum = "file:https://mirrors.edge.kernel.org/ubuntu-releases/22.04.3/SHA256SUMS"
iso_urls     = "${var.iso_url}"
}
```

This URL is the actual remote location of the install media which will be retrieved and cached into a directory named packer_cache. The iso file will be renamed with the iso_checksum. Subsequent packer_build commands will use this cached iso media. In Windows and MacOS you can define a central Environment variable called `PACKER_CACHE_DIR` to enable centralized iso caching.

### Source Block

The source block takes two options, the type of virtual machine artifact you are making and the name you are giving this block. A build template can include multiple blocks for building multiple vms simultaneously.

```json
{
source "virtualbox-iso" "ubuntu-22045-server"
}
```

This block contains the code needed to switch the manual operating install process into an automated process, but providing the key sequences to type through Packer and the URL to an answer file. Packer hosts its own embedded webserver for this purpose that runs for just the duration of the `packer build` command.

```json
{
boot_command = [
        "e<wait>",
        "<down><down><down>",
        "<end><bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
      ]
}
```

These remaining values are all the customizable settings you would configure in a manual install or via the Settings menu options. Code such as adding multiple disks or using uefi to book the system.

```json
{
  boot_wait               = "5s"
  disk_size               = 35000
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  # Ubuntu answer file is located in the subiquity/http directory
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  // Boot with UEFI not BIOS
  firmware                = "efi"
  // Use virtio drivers not SATA interface in the VM
  hard_drive_interface    = "virtio"
  // Add three additional harddrives at boot of 15GB each
  disk_additional_size    = [15000,15000,15000]
  rtc_time_base           = "UTC"
  // https://www.virtualbox.org/manual/ch06.html
  nic_type                = "virtio"
  iso_checksum = "file:https://mirrors.edge.kernel.org/ubuntu-releases/22.04.5/SHA256SUMS"
  iso_urls                = "${var.iso_url}"
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  // Username and passowrd configured in the subiquity/http/user-data file
  ssh_username            = "vagrant"
  ssh_password            = "${var.user-ssh-password}"
  // Timeout incase the process takes too long or hangs
  ssh_timeout             = "45m"
  cpus                    = 2
  // Defined in the variables.pkr.hcl standard file 
  memory                  = "${var.memory_amount}"
  // Change to --nat-localhostreachable1 
  // forced by https://github.com/hashicorp/packer/issues/12118
  vboxmanage              = [["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "jammy-server"
  headless                = "${var.headless_build}"
}
```

### Build Block

The Build block is where you tell Packer what to build. You include the source blocks you want to build by name in the format shown using the artifact format and source block name you defined.

```json
build {
  sources = ["source.virtualbox-iso.ubuntu-22045-server"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2204_vagrant.sh"
  }
}
```

#### Provisioners

Provisioner are tools that you can use to customize your machine image after the base install is finished. Though tempting to just use the Kickstart or Pressed files to do the custom install--this is not a good idea. You should leave the "answer files" as clean or basic as possible so that you may reuse them and do your customization here via a provisioner. In this example we use a single shell script, but you can have lists of shell scripts as well as integrate with configuration software

```json
build {
sources = ["source.virtualbox-iso.ubuntu-22045-server"]

provisioner "shell" {
  execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
  script          = "../scripts/post_install_ubuntu_2204_vagrant.sh"
  }
}
```

```json
# Using multiple shell scripts
provisioner "shell" {
  execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
  scripts          = ["../scripts/post_install_ubuntu_2204_vagrant.sh".
                      " ../scripts/install-webserver.sh",
                      " ../scripts/install-database.sh",
                      " ../scripts/create-users.sh]
  }
}
```

#### Post-processors

This final part of the build block is where you can convert your original artifact into 1 of the 30_ other virtualization formats that come built in with Packer. This is one of the chief benefits that you can build a virtual machine for VirtualBox, Parallels, Proxmox, VMware, and Amazon EC2 all from a single source.

Packer has the ability to build a virtual machine or OS Container once and export it to many different types of platforms in a single execution stretch.  The initial artifact can be exported and converted across all of the formats listed below. Therein lies the power of Packer as you can deploy your production environment to any platform for any person: Dev, QA, Test, Ops, Sec, and so forth.

Once the Build step and Provision step are complete the last step (which is optional) is the post-processor step. This is where you can convert your base image you built into various other formats. Note that the directory named "build" is completely arbitrary and was created by me as it made sense.

```json
post-processor "vagrant" {
  keep_input_artifact = false
  output = "../build/{{ .BuildName }}-${local.timestamp}.box"
  }
```

#### Inline Shell Script Execution

Provisioners allow you to have multiple provision scripts. Some people like to split functionality over multiple shell scripts or use multiple methods. The `shell` provisioner also has the capability to execute inline Linux commands, incase you need to setup some internal structure. Also you can use this method to copy code into the Virtual Machine you are created. If you clone a Git repo to your local system, you can copy that application code directly into your virtual machine as Packer is building it.

```json
// Executing inline shell commands
provisioner "shell" {
  execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
"inline" = [
    "mkdir -p /home/vagrant/.ssh",
    "mkdir -p /root/.ssh",
    "chmod 600 /home/vagrant/id_rsa_github_deploy_key",
    "cp -v /home/vagrant/id_rsa_github_deploy_key /home/vagrant/.ssh/",
    "cp -v ./application-code/html /var/www/html/",
    "cp -v ./mysql/.my.cnf /home/vagrant"
  ]
}
```

#### vboxmanage

This command allows you to issue custom VirtualBox commands from within Packer.

```json
// Change forced by https://github.com/hashicorp/packer/issues/12118
vboxmanage = [["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
```

### Packer, Putting it Together

There are two key commands to use in Packer, assuming you have added the packer executable to your system path. First type: packer -v and see if you get version information output.

**Command:** `packer -v`

Execute this command to see if you get a version output. If this command throws an error -- go back and check the PATH & INSTALL section and make sure you have closed and reopened your shell.

```bash
packer --version
```

**Command:** `packer init .`

This command only needs to be run once, the first time before you use a builder. This command will retrieve the plugin needed for your particular builder. Here are two examples using VirtualBox and Parallels.

```json
// https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox
// maintained by HashiCorp
packer {
  required_plugins {
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = ">= 1.0.5"
    }
  }
}
// https://github.com/Parallels/packer-plugin-parallels
// Mainted by Parallels
packer {
  required_plugins {
    parallels = {
      version = ">= 1.1.0"
      source  = "github.com/Parallels/parallels"
    }
  }
}
```

**Command:**  `packer validate .`

This command will check the syntax of your `*.hcl` packer template for syntax errors or missing brackets. It will not check logic but just syntax. Good idea to run it to make sure everything is in order. Using the samples provided in the GitHub repo you can validate the `*.hcl` templates. If all is correct your will receive a message stating: *The configuration is valid*.

```bash
# Assume you are in the directory that has your variables.pkr.hcl file and
# your .pkr.hcl build template
packer validate .
```

**Command:**  `packer build .`

This command will build the `source` blocks mentioned in the `build` block. There are commandline options you can use for building portions of the `build` block and for debugging using the `only` and `except` option.

```bash
packer build .
```

**Packer Environment Variables:** `PACKER_CACHE_DIR`

![*Packer Cache Directory on Windows*](images/Chapter-13/packer/cache.png "Packer Cache Directory on Windows")

When running `packer build` command Packer will cache the the install media--the iso. You can set this location to a central directory as this will save time downloading the same media over and over. On Windows you can configure the `PACKER_CACHE_DIR` by setting a file location in your user account environment variables. In Linux and Mac you can set an environment variable in your user profile.

#### When Packer Fails

If any part of the Packer build step fails or generates and error, Packer will roll back and delete any artifacts it has created. It won't leave you with broken items. Sometimes Packer fails right on the last step without much of an error message.  In this case I recommend just re-run the packer build command. Upon completion, cd into the build directory that was created during the post-processor process and go back to the beginning of the Vagrant Tutorial and the section regarding using vagrant box add of custom boxes.

### Answer Files

Most operating system installations are designed for a manual install process. This makes sense as for almost 40 years we have been using PC's (Personal Computers). A first step in automating the install process is to automate the answering of the installation questions.  This is the most repetitive process of the install, as well as something that is not conducive to the human, as you spend most of your time waiting.  

#### Fedora and Kickstart

The first solution came from Sun in 1994 and was called [Jumpstart](https://en.wikipedia.org/wiki/JumpStart_(Solaris) "jumpstart"). This was used to hold installation information and as a target system was booted, it would communicate to the Jumpstart server and complete the entire install over the network, OS and handle configuration.

The next phase came in Linux with Fedora creating the [Kickstart](https://docs.fedoraproject.org/en-US/fedora/f28/install-guide/appendixes/Kickstart_Syntax_Reference/#appe-kickstart-syntax-reference "Kickstart Reference") answer file system. Kickstart does not handle the part of OS install, but the OS configuration and software retrieval/installation. Kickstart files can be generated from a template or scratch or upon a successful install a default kickstart is located in the location `/root/anaconda-ks.cfg`. Examples and explanation resources can be found here:

* [Fedora Kickstart Reference](https://docs.fedoraproject.org/en-US/fedora/f28/install-guide/appendixes/Kickstart_Syntax_Reference/#appe-kickstart-syntax-reference "Fedora Kickstart Reference")
* [AlmaLinux Kickstart Guide](https://onezeroone.dev/example-almalinux-kickstart/ "CentOS Kickstart Reference")

#### Debian and Preseed

[Debian pressed template](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html "Preseed") Debian created their own answer file system called [preseed]. You can interrupt a manual install and point to a preseed file, but it needs to be done over the network. When you are installing an operating system you don't yet have a filesystem to read files from! Preseed Used for all Debian based server installs - example and explanation resources can be found here:

* [Sample Preseed Template](https://help.ubuntu.com/lts/installation-guide/example-preseed.txt "Preseed Template")

#### Ubuntu and Subiquity

Ubuntu has moved off of using preseed and to a tool named `autoinstall` which is part of the installer named `Subiquity`. [Autoinstalls](https://ubuntu.com/server/docs/install/autoinstall "webpage for autoinstalls") for the new server installer differ from preseeds in the following main ways:

* The format is completely different (cloud-init config, usually YAML, vs. debconf-set-selections format)
* When the answer to a question is not present in a preseed, d-i stops and asks the user for input
  * Autoinstalls are not like this
  * By default, if there is any autoinstall config at all the installer takes the default for any unanswered question (and fails if there is no default).
* You can designate particular sections in the config as “interactive”, which means the installer will still stop and ask about those.

Subiquity installer makes use of `cloud-init` and its Cloud-config can be used to deliver the autoinstall data to the installation environment.

### Ubuntu Subiquity Autoinstaller

```yaml
autoinstall:
  version: 1
  # https://askubuntu.com/questions/1261451/how-to-generate-crypted-password-for-auto-install
  identity:
    hostname: ubuntu-server
    # Generate a new hashed password on the Linux Command Line: 
    # printf 'vagrant' | openssl passwd -6 -salt 'qoazpFv0h6' -stdin
    # The above command will generate the salted password of "vagrant"
    # Output shortened for print 
    password: '$6$qoazpFv0h6$1i0uxiM32aszgrgyYjv/2FLq73.TV2DCHOGi6nuiZoa......'
    username: vagrant
  early-commands:
  # If we install the SSH server using the subiquity `ssh` configuration then 
  # port 22 gets opened up to packer _before the requisite configuration has 
  # been done to allow Packer to SSH on to the guest O/S. This results in a
  # failed build as Packer exceeds its SSH permitted number of SSH handshake
  # attempts.
  #
  # To ensure this doesn't happen we stop the SSH service until right at the
  # end when we re-enable it
  # using a late-command.
    - sudo systemctl stop ssh    
  # Create the default harddrive as LVM so we can extend it later
  storage:
    layout:
      name: lvm
  # Default set of packages to install    
  packages:
    - ubuntu-server-minimal
    - bc
    - curl
    - wget
    - uuid
    - git
    - build-essential
  # How to configure the network
  network:
    network:
      version: 2
      ethernets:
        enp0s3:
          dhcp4: true
          dhcp-identifier: mac
  # Automatically enable the openssh-server and disable password authentication
  ssh:
    allow-pw: false
    install-server: true
    # Adding the Vagrant initial insecure public key - that will be replaced, 
    # new key pair generated, upon launch
    # Key retrieved from
    # https://github.com/hashicorp/vagrant/blob/master/keys/vagrant.pub
    # key content shortened for display purposes...
    authorized-keys:
      - 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQE.... vagrant insecure public key'    
  late-commands:
    - "echo 'Defaults:vagrant !requiretty' > /target/etc/sudoers.d/vagrant"
    - "echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /target/etc/sudoers.d/vagrant"
    - "chmod 440 /target/etc/sudoers.d/vagrant"
    - sudo systemctl start ssh
```

### Putting Vagrant and Packer together

How then do we build our own artifacts with Packer to manage them? Here is an end-to-end example using some sample code provided in the source code repo of the book. This example will use a prepared Packer build template to install and configure a Vanilla version of Ubuntu Server. Then add the prepared Vagrant Box file to Vagrant, create a Vagrantfile and then start the virtual machine and then `ssh` into the box via Vagrant.

```bash

# clone the source code from the book to get the sample files
# git clone https://github.com/jhajek/Linux-text-book-part-1.git
cd Linux-text-book-part-1/files/Chapter-13/packer-build-templates/ubuntu_22045_vanilla
packer init .
packer validate .
packer build .

# Upon completion of the Packer build...
# Each build has a string representation of the day, month, year to make each
# filename unique, called epoch (your *.box name will be different)
vagrant box add ../build/ubuntu-22045-server-20231103191942.box --name vanilla-ubuntu-server
cd ../build
# Good idea to name the directory the same as your Vagrant Box -- so you
# don't lose track of it!
mkdir vanilla-ubuntu-server
# This command will create a Vagrantfile that is associated with the 
# Vagrant Box vanilla-ubuntu-server
vagrant init vanilla-ubuntu-server
# this command will show the *.box files that Vagrant knows about
vagrant box list
vagrant up
vagrant ssh
# Display the OS information and exit the ssh session
cat /etc/os-release
exit
# Power down the Vagrant box
vagrant halt
```

## Secrets Management

One of the hardest parts of building software applications is managing **secrets**. Secrets can be anything from a username and a password, a token, or even keys from cloud services. The important part is that they are important. If you loose these secrets it could mean the end to a company. You also have to worry about invalidating them. If a person leaves, or rotates job, you don't want credentials to walk out the door with you. Also managing these secrets not just for security but for automation is also a critical part of the infrastructure.

### Hashicorp Vault

In Linux distros as well as Packer, there are methods for dealing with secrets. One of the first tasks will be setting passwords for users. This sample will be a simplistic overview as there are dedicated secret managers for public cloud platforms, will be working on a local network and using opensource tooling. 

The tool we want to introduce is [Hashicorp Vault](https://www.hashicorp.com/products/vault "webpage for Vault"). Vault's job is to manage access to secrets and protect sensitive data with identity-based security. Vault is no longer distributed as opensource, recently moving to the [BUSL license](https://www.hashicorp.com/blog/hashicorp-adopts-business-source-license "Article HashiCorp adopts BUSL"), but is still worth using.

### How to Manage Secrets

Vault can manage secrets needed by multiple people across a large enterprise, or even a large cloud enterprise. Vault does what is says, essentially cryptographically storing all the secrets you enter into a *vault*, then delegating access to these secrets via API (over HTTP) allowing for the implementation of policy and identity relating to accessing these secrets. The *vault* can then be attached or mounted into any system and each developer can access their secrets. Vaults use cases are as follows"

Vault tightly controls access to secrets and encryption keys by authenticating against trusted sources of identity such as Active Directory, LDAP, Kubernetes, CloudFoundry, and cloud platforms. Vault enables fine grained authorization of which users and applications are permitted access to secrets and keys. Vault can be integrated with other platforms as well, Active Directory, AWS IAM profile management, and other platforms.

#### Vault Integration With Packer

For our convenience, Packer has direct integration with Vault. Once Vault is installed an setup on your [local system](https://www.vaultproject.io/docs/install/index.html "Install Vault") for instance by running the Vault agent you can simply read your secrets in the Packer Build Template, without the secret ever being seen by a person. There is more to say on this, but the reason we introduce it here is so that you can be exposed to safe practices from the beginning as well as deal with one of the major problems in IT, which is Secrets Management.

```json
source "virtualbox-iso" "ubuntu-22045-server" {
    boot_command = [
        "e<wait>",
        "<down><down><down>",
        "<end><bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
      ]
  boot_wait               = "5s"
  disk_size               = 15000
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum  = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20.......305c0e911d16fd"
  iso_urls                = ["${var.iso_urls}"]
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_username            = "vagrant"
  // Note the use of ${local} as the way to reference vault variables
  ssh_password            = "${local.user-ssh-password}"
  ssh_timeout             = "45m"
  cpus                    = 2
  memory                  = "${var.memory_amount}"
  vboxmanage              = [["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "jammy-server"
  headless                = "${var.headless_build}"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-22045-server"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2204_vagrant.sh"
  }

  // As an example the value for the shell variable is being written to a 
  // textfile -- the value id coming from Vault -- user never sees the value
  provisioner "shell" {
    inline = ["echo $DBUSER", "echo $DBUSER > /home/vagrant/TEST"]
    environment_vars = ["DBUSER=${local.db_user}"]
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "${var.build_artifact_location}{{ .BuildName }}-${local.timestamp}.box"
  }
}
```

### Building the Vault

To start we need to build the Vault before we can put secrets in. In this case we will use the provided Packer build template provided to you to in the sample files of Chapter 13. You will build a Vagrant Box for Ubuntu Server and then manually install the Vault Software. You can use the `ubuntu_22045_vanilla` or `ubuntu_22045_m1_mac` to build a new virtual machine. Refer to the Packer section on how to build this Vagrant Box and how to add the Box to Vagrant's control.

#### Vagrantfile and Vault Install

Before we start the Vagrant box, we need to edit line 35 of the `Vagrantfile` to read: `config.vm.network "private_network", ip: "192.168.56.99"`. This will add a second network interface to our host-only network and subsequent virtual machines will be able to connect to our Vault Server.

Once the vault-server has been built and initialized in Vagrant, we need to Vagrant SSH into our system and [install Vault for Linux Debian/Ubuntu](https://developer.hashicorp.com/vault/install "webpage install Vault for Ubuntu"). Check to make sure the Vault service has started properly and is enabled.

See this link for the proper Ubuntu Linux installation instructions: [https://developer.hashicorp.com/vault/install#Linux](https://developer.hashicorp.com/vault/install#Linux "webpage for vault Linux install")

#### Configuring the Vault-Server

We will need to add two lines to the `.bashrc` file in order to define the Vault listening port internally. Vault only accepts requests via HTTP -- to access the contents of the vault the commands we execute will take place over HTTP locally. Make sure to source the changes to the `~/.bashrc` file after the changes are made so that your terminal can access these values. Use the command: `. ~/.bashrc`.

```bash
# Tells Vault to listen for connections on Local Host
export VAULT_ADDR='https://127.0.0.1:8200'
# Tells vault to skip third part verification of TLS cert
# Accept the self-signed TLS cert
export VAULT_SKIP_VERIFY="true"
```

#### Initialize and Unseal the Vault

The first command to now execute is `sudo systemctl start vault`. Run the systemctl status command and make sure that Vault has begun properly. Now we can begin to create our Vault. The first step is to execute the command: `vault operator init` -- note without any sudo. This will initialize the Vault. The output will be **CRITICAL** as you will see 5 unseal keys and an Initial Root Token, like this:

```
Unseal Key 1: 6R9A28GJ0QLi6DwFZqMzjNNSjq+NxRJFKGKM2saO5555
Unseal Key 2: rdsc3qh85kjQdLy3b7yl+ERz11+BEVUVAvXYZUNw5555
Unseal Key 3: hJ+oShvibUuVgQBT3BIIPxTasKJTfrLXffBZgP8G5555
Unseal Key 4: YUI+GM69hHPm+XD5/YEy4zaKFeS2ZAmdetyijSnm5555
Unseal Key 5: ll4Z2huWIMIT2N6hOLcYsiY2YI2q+64vjXNabAut5555

Initial Root Token: hvs.SVYlCKNg3awUeiZ3xbsV5555
```

You need a threshold of 3 keys to unseal access to the secrets. You should spread these keys amongst administrators if you can. That way no single person can hold all of your companies secrets hostage in case they leave or are unavailable/incapacitated. Save these keys for now in a safe place. The Vault by default is **sealed** and cannot be opened unless 3 of th 5 unseal keys are presented.

Lets now unseal the vault. Execute the command: `vault operator unseal`. You need to execute this command three times and you will be prompted for one of the unseal keys. Copy and paste the key into commandline prompt, note that by default the output will be blank (for security) be careful cutting and pasting.

#### Vault Login

Now that we have unsealed the Vault (the sealed value will have gone from True to False) we can login with the Initial Root token. This is used to initially log in an generate subsequent login tokens. The `vault login` command will prompt you for a Token -- which is the `Initial Root Token` value.

`vault login`

Now that we are logged in, the next step is to initialize a secret storage engine. This defines how the secrets are stored and mapped. We are going to enable a standard engine called `kv` (This stands for Key Value pair storage). Our secrets will be mapped into a mini-file system hierarchy inside the Vault starting at the path `secret/`. This is an arbitrary name that we chose when defining the `-path`.

`vault secrets enable -version=2 -path=secret kv`

#### Vault Policies

The next step is to create a policy that grants permissions for our secrets. We can have many paths defined. In this case we will grant a very libral permission swath to our secret data. Lets create a file named: `ssh-secrets.hcl` in our home directory.

```json
# Dev servers have version 2 of KV secrets engine mounted by default, so will
# need these paths to grant permissions:

path "secret/data/*" {
  capabilities = ["read","create", "update","delete"]
}
```

Now we must upload our policy file from our local system into the Vault and give it a name for reference inside of the Vault.

`vault policy write ssh-secret-policy ./ssh-secrets.hcl`

Next we need to create user access tokens and expiration time for the secrets. This is a fine grained way to give access in short amounts of time. 

```bash
# This will create Access tokens that will be valid for only 
# 15 days or 21600 hours
vault token create -ttl=21600m -policy=ssh-secret-policy
```

This will generate a set of Key/Values. You will want to pay attention to the `token` value. It will look like the Initial Root Token, but will be a longer string similar to: `hvs.CAESIKEylPWlNpOTN.............................ZTRnMxY2`.  Copy this down as well. We will need this value to be configured on our host systems so that we can now remotely access our Vault over our local network.

#### Adding Secrets

```bash
# Commands to store the secrets
vault kv put -mount=secret team00-db DBPASS=letmein DBUSER=controller DATABASENAME=foo
vault kv put -mount=secret team00-ssh SSHPASS=vagrant
```

Now we can finally add our secrets. The command has a strict format. The `vault kv` tells us that this is a Key Value pair. The next part tells us that we want to mount the path `secret/` that we defined earlier in the `vault secrets enable` -path command. The next part, in this example is for a database called `team00-db` that name is the container for all the secrets you want to store or access. The following pieces are series of KV pairs of secrets. We will be accessing these secrets in another Vagrant Box we will be building.

### Setting Vault Environment Variables on Your Host Windows System

From your terminal you will need to execute the command `notepad $profile` to open your user profile and we will need to add some variables. This is the Windows equivilent of adding variables to the linux `.bashrc` file. If the `$profile` doesn't already exist you can create it with this command: `new-item -type file -path $profile`. These three values will need to added and will be determined as part of the Vault setup. Make sure you close all your terminals and open them up again to reprocess these new values in each terminal window.

```powershell
# The 192.168.56.99 is the value we set on line 35 of the 
# Vault-Server Vagrantfile
$Env:VAULT_ADDR = 'https://192.168.56.99:8200'
$Env:VAULT_SKIP_VERIFY = "true"
$Env:VAULT_TOKEN="hvs.CAESIKEylPWlNpOTN.............................ZTRnMxY2"
```

### Setting Vault Environment Variables on Your Host MacOS System

Using MacOS (Intel or M1) edit the `~/.zprofile` for the `Z shell` and add these values. Remember to source the changes `. ~/.zprofile` after making the changes

```bash
# The 192.168.56.99 is the value we set on line 35 of the 
# Vault-Server Vagrantfile
export VAULT_ADDR='https://192.168.56.99:8200'
export VAULT_SKIP_VERIFY="true"
export VAULT_TOKEN="hvs.CAESIKEylPWlNpOTN.............................ZTRnMxY2"
```

### Setting Vault Environment Variables on Your Host Linux System

Using any Linux distro with the Bash Shell edit the `~/.bashrc` file adding these values. Remember to source the changes `. ~/.bashrc` after making the changes

```bash
# The 192.168.56.99 is the value we set on line 35 of the 
# Vault-Server Vagrantfile
export VAULT_ADDR='https://192.168.56.99:8200'
export VAULT_SKIP_VERIFY="true"
export VAULT_TOKEN="hvs.CAESIKEylPWlNpOTN.............................ZTRnMxY2"
```

### Using the Vault Template

Now we should be ready to go and use the secrets we added to Vault. There is an additional Packer Template located in the book sample code under `files` > `Chapter-13` > `packer-build-templates` > `ubuntu_22045_vanilla-vault-example`. You can test to see if you Vault integration works, by issuing the command: `packer validate .` to see the results. If you receive a timeout or connection denied a few things might be happening. You Vault could be sealed or perhaps you have not entered your secrets yet, or you may have not reloaded your terminal variables based on the Vault IP and token settings from the previous section.

To fully test and see the results, let us go ahead and execute the `packer build .` command.  You will notice that we can access the secrets set in the Vault from the `variables.pkr.hcl` file by providing the PATH that was defined and then giving the KEY value.

```json
// Syntax
// https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/contextual/vault
locals {
  user-ssh-password = vault("/secret/data/team00-ssh","SSHPASS")
}

// Syntax
// https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/contextual/vault
locals {
  db_user = vault("/secret/data/team00-db", "DBUSER")
}
```

We can then define these values our main build template as a way to pass secrets securely into our Packer Virtual Machine building process.

`ssh_password            = "${local.user-ssh-password}"`

### IT Orchestration

In looking at these tools, Vagrant, Packer, Preseed, and Kickstart, we begin to see a world of automation opening up to us. In a sense these technologies are the culmination of the Unix concepts of small tools doing one things--or shell scripts on steroids, so to speak. Each of these technologies is beyond the scope of this book, but here are some podcasts and links to learn more about them. Some relate to installing traditional virtual machines, some to bare metal installs, others assume cloud platforms.

* [SaltStack](https://www.saltstack.com/ "Saltstack")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/262 "SaltStack Podcast")
* [Chef](https://www.chef.io/ "Chef.io")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/219 "Chef Podcast")
* [Puppet](https://puppet.com/ "Puppet")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/93 "Puppet")
* [Ansible](https://www.ansible.com/ "Ansible")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/257 "Ansible Podcast")
* [CFEngine](https://cfengine.com/ "CFEngine")
  * [Podcast](https://twit.tv/shows/floss-weekly/episodes/106 "CFEngine Podcast")
  * [Dr. Mark Burgess](https://en.wikipedia.org/wiki/Mark_Burgess_(computer_scientist) "Dr Mark Burgess") wrote a book about his research in IT called [In Search of Certainty](http://markburgess.org/certainty.html "In search of certainty the book")
* [Cobbler](https://cobbler.github.io/ "Cobblerd website")
* [Terraform](https://www.hashicorp.com/products/terraform "Terraform")
  * [HashiCorp Terraform Presentation](https://www.youtube.com/watch?v=jdDKjWZ2qbk&index=39&list=PL81sUbsFNc5Y-jbEC1y5BWenDoYscVv4t "Terraform and Packer")

## Chapter Conclusions and Review

In this chapter we learned how a spread in technology led to a desire to automate and ease installation and configuration. A new generation of technology brought a new generation of tools.  These tools are a part of what we called cloud-native, immutable infrastructure, and are the standard ways to deploy operating systems and hardware across the industry.

### Review Questions

1.  What is a common title given to IT workers who are responsible for the ongoing operations of applications and their environments?
    a.  saints
    b.  devs
    c.  devops
    d.  ops
1.  What would describe Mitchell Hashimoto's design goals in creating Vagrant?
    a.  Automation
    b.  Separation of Duties
    c.  Profit
    d.  Inspection
1.  What is the name of the tool built as an abstraction layer on top of VirtualBox and Parallels to deploy virtual machines?
    a.  Packer
    b.  Vault
    c.  Terraform
    d.  Vagrant
1.  What is the name of the tool built as a way to automate the installation of any Linux operating system?
    a.  Packer
    b.  Vault
    c.  Terraform
    d.  Vagrant
1.  Approximately what year approximately was Vagrant introduced?
    a.  2019
    b.  2001
    c.  2010
    d.  2015
1.  Fill in the blank. Think of Vagrant as an _______________ between you and VirtualBox, Hyper-V, Docker, or Parallels desktop.
    a.  `replacement`
    b.  `suppliment`
    c.  `extension`
    d.  `abstraction`
1.  What is the name of the file type Vagrant uses that contains an `vmdk` and and `ovf`?
    a.  `.vdi`
    b.  `.vhd`
    c.  `.box`
    d.  `.zip`
1.  Name the file that contains the configuration file for each Vagrant box file.
    a.  `vagrantfile`
    b.  `Vagrantfile`
    c.  `config`
    d.  `vagrant.hcl`
1.  What is the correct command to add the Vagrant Box `almalinux/9`?
    a.  `vagrant add box almalinux/9`
    b.  `vagrant box add almalinux/9`
    c.  `vagrant init almalinux/9`
    d.  `vagrant add almalinux/9`
1.  What is the command used to list all Vagrant Boxes being managed by Vagrant?
    a.  `vagrant list box`
    b.  `vagrant boxes list`
    c.  `vagrant box list`
    d.  `vagrant list`
1.  What is the correct command to initialize a Vagrant file for Vagrant Box named `ubuntu/jammy64` as already been added to the system?
    a.  `vagrant init`
    b.  `vagrant init ubuntu/jammy64`
    c.  `vagrant box add ubuntu/jammy64`
    d.  `vagrant init jammy64`
1.  What is the Vagrant command to start or turn on a Vagrant Box?
    a.  `vagrant up`
    b.  `vagrant halt`
    c.  `vagrant status`
    d.  `vagrant on`
1.  What is the Vagrant command to restart a Vagrant Box?
    a.  `vagrant up`
    b.  `vagrant halt`
    c.  `vagrant status`
    d.  `vagrant reload`
1.  What is the Vagrant command to shutdown or poweroff a Vagrant Box?
    a.  `vagrant up`
    b.  `vagrant halt`
    c.  `vagrant status`
    d.  `vagrant reload`
1.  For Packer, select the default name of the .hcl file used for containing variables used in the build template
    a.  template.pkr.hcl
    b.  variables.json
    c.  variables.pkr.hcl
    d.  variables.pkr
1.  Select the name of the stage that runs after the build block in a build template
    a.  source block 
    b.  provisioner
    c.  init-block
    d.  post-processor
1.  What is the name of the stage that runs after building and provisioning of Packer artifacts is complete?
    a.  source block 
    b.  provisioner
    c.  init-block
    d.  post-processor
1.  If there is an error in any part of the Packer build command what will happen?
    a.  nothing
    b.  an error will be logged but the process will continue
    c.  the command will terminate and any broken artifacts will be deleted
    d.  the user will be prompted
1.  Select the Hashicorp software that allows us to securely store and retrieve secrets via HTTP 
    a.  Vagrant 
    b.  Terraform 
    c.  Packer 
    d.  Vault 
1.  Select the first command you need to start interacting with your Vault
    a.  `vault operator unseal`
    b.  `vaul operator init`
    c.  `vault init`
    d.  `vault secrets enable -version=2 -path=secret kv`

### Podcast Questions

See the presentation at: [Vagrant in Five Minutes](https://www.youtube.com/watch?v=wlogPKBEuUM "Youtube This video is a 5 minutes introduction to Vagrant, a tool to automate provisioning of virtual machines."): This video is a 5 minutes introduction to Vagrant, a tool to automate provisioning of virtual machines.

* ~0:28 What are the three virtualization platforms listed?
* ~1:18 Where does Vagrant sit?
* ~1:45 What is a Vagrant provider?
* ~2:23 What is the vagrant template file called?
* ~2:30 What are the three advatages to using a text-based Vagrantfile?
* ~4:35 List the core concepts summarized at the end of the video (just the major items)

### Lab - Chapter 13

#### Part One Prerequisites

Assuming that the command `vagrant --version` gives us output, lets begin by installing our first Vagrant Box.  Open your terminal application and let us `cd` to the Documents directory

```cd Documents```

#### Windows and Intel Based Macs

Here we are going to create a directory to manage our artifact.  It is a good idea to create a directory per virtual machine that we will administer via Vagrant.  You can create a class directory and then sub-directories and or you can place this on a different disk. This I will leave up to you as it is your filesystem and your data--you are the one in charge.

* `mkdir itmo-556` 
* `cd itmo-556`

We will now use Vagrant to retrieve and Ubuntu 22.04 known as Jammy and a AlmaLinux 9 Virtual Machine:

1. `mkdir jammy64`
1. `cd jammy64`
1. `vagrant init ubuntu/jammy64` 
  
1. `mkdir almalinux9`
1. `cd almalinux9` 
1. `vagrant init almalinux/9` 

#### M1 Macs Only

For those using M1 Macs and Parallels you will need to replace the names of the Boxes in the demos with these two that have been prepared for M1 macs and parallels

* `bento/ubuntu-22.04-arm64`
* `almalinux/9.aarch64`

1. `mkdir jammy64-arm`
1. `cd jammy64-arm`
1. `bento/ubuntu-22.04-arm64` 
  
1. `mkdir almalinux9-arm`
1. `cd almalinux9-arm` 
1. `vagrant init almalinux/9.aarch64`

#### Editing Your Vagrantfile

Once these commands are executed -- both under the `jammy64` and `almalinux` directory, you will see a `Vagrantfile` that has been created. Let us take a look at this file.  You can do so via using the commands on MacOS or Windows from the Terminal:

* `code Vagrantfile`
* `vim Vagrantfile`

Line 15 you will see the setting that tells Vagrant which **box** this Vagrantfile manages: `config.vm.box = "ubuntu/jammy64"`.  This value came from the `vagrant init` command typed above. Line 35, which is commented out, will let us configure a **host-only** network between out host system and any guest (virtual) OSes we install. Line 59, 64, and 65 is a loop that allows us to increase the default memory from 1Gb to 2 Gb or 4 Gb.

#### Start a Vagrant Box

From our jammy64 directory, let us start our first Vagrant Box.  From the Terminal type: ```vagrant up```.  What you will see is the Box file with the VirtualBox (or Parallels) vm being extracted and registered with your virtualization software.  Next the system will begin to boot.  The first install will take a bit longer as some additional drivers are being installed.  This only happens on first boot.  

Once this step is successful, we need to establish a connection to the virtual machine via SSH (secure shell). We do this by the command: ```vagrant ssh```, and we are faced with an Ubuntu Server command prompt. What was the password?  What was the IP address?  You don't know and don't need to know as Vagrant has abstracted all of this away and allowed you to get to the focus of all of this -- installing and running software. Open a new Terminal window and repeat the steps above for the AlmaLinux box.

### Part One - Vagrant Commands

* Using the `vagrant init ubuntu/jammy64` command, initialize a Vagrant Box (only has to be done once on a system)
  * Or comparable Vagrant Box on an M1 Mac
* Using the `vagrant up` command, start the virtual machine
* Using the `vagrant ssh` command, connect to the virtual machine via SSH
* Using the `sudo apt-get update` and `sudo apt-get install nginx` command, install the Nginx webserver (pronounced Engine X)
  * Exit the ssh session.
  * Edit the corresponding `Vagrantfile` to enable line 35 a private network interface at 192.168.56.100
  * Edit the corresponding `Vagrantfile` to uncomment line 59, 64, and 65 changing line 64 to 2048 or 4096
* Using the command `vagrant reload --provision` restart the virtual machine
* After the reload command has succeeded, without using the `vagrant ssh` command, open a web-browser on your Host OS to `http://192.168.56.100` to see the **Welcome to Nginx!** message being served from Nginx in your Vagrant Box
* Using the `vagrant halt` to power off the virtual machine, then issue the `vagrant destroy` command to reset the Vagrant Box to its initial state (pre-webserver install)
* Issue the `vagrant up` and `vagrant ssh` command and use the command in the Vagrant Box: `sudo systemctl status nginx` to show that the webserver is not installed.
  * Exit the SSH session
* Issue the command: `vagrant box list` to show that you have successfully gone through the tutorial

### Part Two - Packer Commands

Using the sample code from the text book in: files > Chapter-13 > packer-build-templates, init, validate and build the `ubuntu_22045_vanilla` if you are on Windows or an Intel Mac or the `ubuntu_22045_m1_mac` if you are using Apple Silicon.

One the `.box` file has been successfully built, use the Vagrant commands from this chapter to `add` the box file and to `init` a Vagrantfile. Bring the Vagrant box up and then exit your ssh session and halt the Vagrant box.

### Part Three - Vault Commands

Using the Vagrant Box you built in step two, with in that box -- follow the instructions to install and configure a Vault Server from this chapter with passwords for your SSH and database username and password. In addition create another virtual machine -- this time in the provisioner block shell script run your mysql install script from chapter 12 to install and configure Wordpress (all 11 steps) to create a secure WordPress installation.

#### Footnotes

[^153]: [http://d13pix9kaak6wt.cloudfront.net/background/users/m/i/t/mitchellh_1370739801_5.jpg](http://d13pix9kaak6wt.cloudfront.net/background/users/m/i/t/mitchellh_1370739801_5.jpg "Mitchell Hashimoto")

[^154]: [https://www.vagrantup.com/docs/why-vagrant/](https://www.vagrantup.com/docs/why-vagrant/ "Why try Vagrant?")

[^155]: [https://www.packer.io/intro/index.html](https://www.packer.io/intro/index.html "Pacjer.io")

[^156]: [https://www.packer.io/intro/why.html](https://www.packer.io/intro/why.html "Why Use Packer?")
