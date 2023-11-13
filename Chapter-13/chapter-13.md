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

**Command:** `vagrant up --provider virtualbox | hyperv | docker | vmware`

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
1. Repeat the above steps in the centos7 directory and replace the init command in step 3 with: `vagrant init alamlinux/9`
1. In each directory issue the command `vagrant halt` or `vagrant suspend` to power down the VMs

## Packer

### The Problem Packer Solves

By 2010 Vagrant was being used to manage VMs, there was no tool that could be used to quickly and reliably create VMs. This problem was solved by HashiCorp and called [Packer](https://packer.io "Packer.io"). Packer, much like the name suggests, allows you to automate the installation of operating systems. Or better said, "Packer is a tool for creating machine and container images for multiple platforms from a single source configuration[^155]."  Operating systems from Windows to Linux to BSD were all designed to be installed manually.  Unlike installing software, there is no existing operating system when you are installing an operating system, making automatic installation difficult.

Packer attacked this problem by creating its own binary which acts as a supervisor and initiates the proper key sequences to turn a manual install into and automated install via a JSON based build template.  This can take place on multiple formats or platforms and does not even focus on physical machines.  Packer uses already existing answer file technology for Linux, such as Kickstart and Preseed to allow for automated and repeatable installs to create machine images. "A machine image is a single static unit that contains a pre-configured operating system and installed software which is used to quickly create new running machines. Machine image formats change for each platform. Some examples include AMIs for EC2, VMDK/VMX files for VMware, OVF exports for VirtualBox, and others[^155]." Network installs have existed for decades, but this method always assumed a physical 1-to-1 infrastructure, which as you have seen in this class is no longer the only reality.

Having a code based automated configuration now lets you track, audit, and centralize your build template in version control. With minor modifications, you can now have centralized machine image construction and export to various hardware platforms.  You could build a VirtualBox VM, which could be exported to Vagrant or Amazon Web Services, or Docker. Now all of your developers, operations, testers, and QA can have access to the same machine on most any platform. As stated on the [Packer.io](https://packer.io "packer webpage") webpage the advantages of using packer are as follows[^156]:

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
      version = "~> 1"
    }
  }
}

source "virtualbox-iso" "ubuntu-22043-server" {
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
  iso_checksum  = "file:https://mirrors.edge.kernel.org/ubuntu-releases/22.04.3/SHA256SUMS"
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
  sources = ["source.virtualbox-iso.ubuntu-22043-server"]

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

This URL is the actual remote location of the install media which will be retrieved and cached into a directory named packer_cache. The iso file will be renamed with the iso_checksum. Subsequent packer_build commands will use this cached iso media. In Windows and MacOS you can define a central Environement variable called `PACKER_CACHE_DIR` to enable centralized iso caching.

### Source Block

The source block takes two options, the type of virtual machine artifact you are making and the name you are giving this block. A build template can include multiple blocks for building multiple vms simultaniously.

```json
{
source "virtualbox-iso" "ubuntu-22043-server"
}
```

This block contains the code needed to swithc the manual operating install process into an automated process, but providing the key sequences to type through Packer and the URL to an answer file. Packer hosts its own embeded webserver for this purpose that runs for just the duration of the `packer build` command.

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
  iso_checksum = "file:https://mirrors.edge.kernel.org/ubuntu-releases/22.04.3/SHA256SUMS"
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
  sources = ["source.virtualbox-iso.ubuntu-22043-server"]

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
sources = ["source.virtualbox-iso.ubuntu-22043-server"]

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

This final part of the build block is where you can convert your original artifact into 1 of the 30_ other virtualization formats that come built in with Packer. This is one of the cheif benefits that you can build a virtulmachine for VirtulaBox, Paralles, Proxmox, VMware, and Amazon EC2 all from a single source.

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
    "cp -v ./applicaiton-code/html /var/www/html/",
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
    authorized-keys:
      - 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key'    
  late-commands:
    - sed -i 's/^#*\(send dhcp-client-identifier\).*$/\1 = hardware;/' /target/etc/dhcp/dhclient.conf
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
cd Linux-text-book-part-1/files/Chapter-13/packer-build-templates/ubuntu_22043_vanilla
packer init .
packer validate .
packer build .

# Upon completion of the Packer build...
# Each build has a string representation of the day, month, year to make each
# filename unique, called epoch (your *.box name will be different)
vagrant box add ../build/ubuntu-22043-server-20231103191942.box --name vanilla-ubuntu-server
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

The tool we want to introduce is [Hashicorp Vault](https://www.hashicorp.com/products/vault "webpage for Vault"). Vaults job is to manage access to secrets and protect sensitive data with identity-based security. Vault is no longer distributed as opensource, recently moving to the BUSL license, but is still worth using.

### How to Manage Secrets

Vault can manage secrets needed by multiple people across a large enterprise, or even a large cloud enterprise. Vault does what is says, essentially cryptographically storing all the secrets you enter into a *vault*, then delegating access to these secrets via API (over HTTP) allowing for the implementation of policy and identity relating to accessing these secrets. The *vault* can then be attached or mounted into any system and each developer can access their secrets. Vaults use cases are as follows"

Vault tightly controls access to secrets and encryption keys by authenticating against trusted sources of identity such as Active Directory, LDAP, Kubernetes, CloudFoundry, and cloud platforms. Vault enables fine grained authorization of which users and applications are permitted access to secrets and keys.  Vault can be integrated with other platforms as well, Active Directory, AWS IAM profile management, and other platforms.

#### Vault Integration With Packer

For our convenience, Packer has direct integration with Vault. Once Vault is installed an setup on your [local system](https://www.vaultproject.io/docs/install/index.html "Install Vault") for instance by running the Vault agent you can simply read your secrets in the Packer Build Template, without the secret ever being seen by a person. There is more to say on this, but the reason we introduce it here is so that you can be exposed to safe practices from the beginning as well as deal with one of the major problems in IT, which is Secrets Management.

```json
source "virtualbox-iso" "ubuntu-22043-server" {
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
  iso_checksum  = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
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
  sources = ["source.virtualbox-iso.ubuntu-22043-server"]

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

### Vault Setup Windows

From your terminal you will need to execute the command `notepad $profile` to open your user profile and we will need to add some variables. This is the Windows equivilent of adding variables to the linux .bashrc file. These three values will need to added and will be determined as part of the Vault setup. Make sure you close all your terminals and open them up again to reprocess these new values in each terminal window.

```powershell
$Env:VAULT_ADDR = 'https://192.168.56.99:8200'
$Env:VAULT_SKIP_VERIFY = "true"
$Env:VAULT_TOKEN="hvs.CAESIJGG7..................."
```

### Vault Setup MacOS

Using MacOS (Intel or M1) edit the `~/.zprofile` for the `Z shell` and add these values. Remember to source the changes `. ~/.zprofile` after making the changes

```bash
export VAULT_ADDR = 'https://192.168.56.99:8200'
export VAULT_SKIP_VERIFY = "true"
export VAULT_TOKEN="hvs.CAESIJGG7..................."
```

### Building the Vault

To start we need to build the Vault before we can put secrets in. In this case we will use the provided Packer build template provided to you to in the sample files of Chapter 13. You will build a Vagrant Box for Ubuntu Server and then manually install the Vault Software. You can use the `ubuntu_22043_vanilla` or `ubuntu_22043_m1_mac` to build a new virtual machine. Refer to the Packer section on how to build this Vagrant Box and how to add the Box to Vagrant's control.



### IT Orchestration

In looking at these tools, Vagrant, Packer, Preseed, and Kickstart, we begin to see a world of automation opening up to us.  In a sense these technologies are the culmination of the Unix concepts of small tools doing one things--or shell scripts on steroids, so to speak.  Each of these technologies is beyond the scope of this book, but here are some podcasts and links to learn more about them.  Some relate to installing traditional virtual machines, some to bare metal installs, others assume cloud platforms.

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
1. ~39:05 According to the speaker, with container based systems, in what terms must we think in?
1. ~40:00 Why is scheduling containers inside of Virtual Machines a bad idea?
1. ~What are Joyent's thoughts regarding Virtual Machines in the application stack?

### Lab

#### Part 1

Create a folder structure for 1 Ubuntu Bionic64 vagrant box and 1 CentOS 7 vagrant box.  In each of these folders use the ```vagrant init``` command to create a ```Vagrantfile```.  Upon succesfully executing the `vagrant up` command in both directories, take a screenshot of the output of the ```vagrant box list``` command.

#### Part 2

Run the packer json build templates for CentOS 7 and Ubuntu 18.04 from the textbook source code located in ```files > Chapter 13 > packer-build-tempates```, for each template execute ```packer build centos-7-vanilla-json``` and ```packer build ubuntu18045-vanilla.json```.  Once these Vagrant boxes are built, use the ```vagrant box add``` command to add them to your Vagrant system.  Run the ```vagrant init``` command with the proper options to create a Vagrantfile and then run the ```vagrant up``` command to instantiate the box. Issue the command ```vagrant ssh``` and once logged in take a screenshot of the output of the command ```free --giga``` to list the amount of memory in the virtual machine.

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
