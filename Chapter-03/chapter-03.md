# Installation of Linux

![*Must be a Linux User...*](images/Chapter-Header/Chapter-03/surgery.png  "Understanding the Technology and Philosophy of Unix/Linux")

## Objectives

* Demonstrate how to complete the Linux and BSD Operating System Install Process for each major distributions
* Define the standard installation formats, full ISOs, minimal install ISOs, and net-installer ISOs and the different
* Demonstrate how to use industry standard virtualization platforms for installing distributions
* Explore the features of dnf, yum, and apt to install packages and dependencies in Linux
* Demonstrate how to use GNU tools gcc and make for compiling source code
* Demonstrate how to use the Python language interpreter in order to run Python-based install scripts

## Outcomes

At the end of this chapter you will understand how to complete multiple installations of all the major Linux and BSD platforms. You will be comfortable using industry standard virtualization platforms to enable rapid install of operating systems. You will also be familiar with and be able to differentiate between processor architectures. You will be able to install packages and manage dependencies through using standard package managers. Finally, you will also be comfortable compiling software from source using a tar ball and python setup-tools.

## Virtual Machines

Every operating system is made up of multiple components as we mentioned in chapter 2. These components are separated by privilege rings. These rings are for process privilege separation and are built in security for the operating system. With the higher numbered rings being the least privileged. Traditionally user applications are in ring 4 (sometimes called ["*userland*" or *"user space"*](https://en.wikipedia.org/wiki/User_space "user space") and the kernel which has the most power is in ring 0.  For instance a program a user writes cannot just talk directly to the video card and write to the video memory for the screen. The program needs to go through the OS which in turn goes through the kernel allowing or enforcing commands to be executed. How then does virtualization fit in? Virtualization or called a [hypervisor](https://en.wikipedia.org/wiki/Hypervisor "Hypervisor") is a new ring that inserts itself between the OS and the kernel to intercept commands and is called ring -1.

### One Ring to Rule Them All...Operating System Rings

![*Operating System Rings*](images/Chapter-03/Hypervisor/500px-Priv_rings.svg.png "One Ring")

Virtualization works because your CPU[^19]. To do this, AMD and Intel introduced extensions, [VT-x and AMD-V](https://en.wikipedia.org/wiki/X86_virtualization#Intel_virtualization_.28VT-x.29 "x86 virtualization") (called Pacifica), to assist virtualization. Both instruction sets add "nine new machine code instructions that only work at 'Ring -1,' intended to be used by the hypervisor" ([Andy Dorman - Informationweek](http://web.archive.org/web/20130530214041/http://www.informationweek.com/intel-vt-vs-amd-pacifica/172302134 "x86 extensions")). When using virtualization, you are functionally running multiple operating systems at one time. Technically this is not possible as only one operating system can have control of your hardware at a time - so how does a hypervisor and virtualization make this work?  

### Virtualization Diagram

![*Virtualization Diagram*](images/Chapter-03/Hypervisor/Hardware_Virtualization.jpg "Virtualization Diagram")

By having the hypervisor intercepting system calls from the virtualized operating system this allows for multiple operating systems to co-exist on one computer unaware of each other[^20].  The way a hypervisor works is not unlike having a professional translator at a business meeting translating between two attendees.  The hypervisor essentially creates two classes of operating systems.  The "*host*" and potentially multiple "*guests*".  The *"guest"* operating system thinks it has complete control of the hardware - but the virtualization software is only showing the guest system a small portion of all the total RAM, CPU, and disk space available.  The hypervisor offers a *"virtualized kernel and drivers"* to the guest operating system.  In turn, the hypervisor translates the system commands to the kernel it has received and translates them to the host operating systems commands.  

For example if we were running an Ubuntu 22.04.3 Desktop virtualized guest system on a Windows 10 host, the Linux desktop has no way of knowing how to issue a command to use the network card to request a website because Windows is a completely different kernel and operating system. The virtualization layer will do the translation for you, allowing the *"host"* system to think that your guest virtualized operating system is nothing more than a native application, and allowing your guest virtualized operating system to think that it owns the entire set of hardware.

The main concept of virtualization you need to know is that your computer (PC, laptop, Mac) has vastly more power then is needed most of the time. The benefit of virtualization is that a hypervisor can act as a translator for multiple operating systems running simultaneously on one system.  Thereby maximizing the usage of your resources and preventing you from needing 4 or 5 different physical PCs.  See Chapter 13 and 14 for application and development uses of Virtualization.

## Hypervisors

![*Server and Desktop Virtualization*](images/Chapter-03/Hypervisor/Hyperviseur.png "Server and Desktop Virtualization")

### TYPE II Hypervisor - Hosted or Desktop Virtualization

There are basically two types of virtualization.  We will be dealing with TYPE II[^21] exclusively to help us in our mastery of Linux. This type assumes you are using an underlying operating systems such as Windows, Mac, or a Linux distro.  In this case the host operating system handles all of the resource management and task scheduling plus you have the added overhead of sharing the hardware with the installed host operating system.  In addition you can have multiple hypervisors installed but only one can be active at a time.  In general it is best to install only one hypervisor though there are some small edits/hacks that can be done to get [Hyper-V and VirtualBox to run together](http://www.hanselman.com/blog/SwitchEasilyBetweenVirtualBoxAndHyperVWithABCDEditBootEntryInWindows81.aspx "Hyper-V and VirtualBox") on Windows. There are four major desktop platforms for virtualization:

#### Microsoft Hyper-V

Hyper-V was originally only a server class product released on Windows Server 2008 R2.  Microsoft ported the technology to be able to be used in Windows 8 and 10 Professional and Enterprise editions for free.  It comes as an add-on component and is a fully functional implementation of the sever class product.  It has the added benefit of being able to work over a wireless connection geared towards desktops.  Hyper-V is a good product, if you have an [Xbox One](https://en.wikipedia.org/wiki/Xbox_One#Software_and_services "Xbox One"), you are using Hyper-V to enable backward compatibility for your games. Hyper-V runs on Windows 8 and 10 and runs Windows, Linux, and BSD virtual machines.

#### Oracle VirtualBox

This product was originally an opensource project that was purchased by Sun and then inherited by Oracle. Though the name is on the project, Oracle has been surprisingly hands off of this project.  Because of that it has grown in usage, features, and utility to become the de facto desktop virtualization tool.  It can run on Mac, Windows, and Linux and allows for seamless transfer of virtual machines across platforms

#### VMware Workstation

VMware also released a desktop product that is similar to VirtualBox on Windows and Linux called VMware Workstation. This software predated VirtualBox by nearly 5 years with a separate desktop product available for the Mac called VMware Fusion.

#### Parallels Desktop for Mac

Until 2013 Parallels Desktop was a direct competitor to VMware Workstation on the desktop of Windows and Linux. As of 2013 those products were discontinued in favor of Parallels focusing their desktop product on the Mac and support Apple Silicon virtualization.

#### Windows Subsystem for Linux 2

"WSL 2 uses the latest and greatest in virtualization technology to run its Linux kernel inside of a lightweight utility virtual machine (VM). WSL 2 became available in Windows 10 version 2004. It runs on the Home and all of the editions of Windows 10 2004, which is different from the Hyper-V product, which only runs on the Professional edition of Windows 10.  WSL 2 ships its own custom optimized Linux Kernel in Windows that virtual machines in WSL 2 will run on. The purpose here is to abstract the underlying hypervisor and provide a simple command line interface to the WSL 2.  Note that only one hypervisor can run at a single time so you can use this platform or VirtualBox but not both at the same time, though there is work ongoing to overcome this limitation.  [https://devblogs.microsoft.com/commandline/announcing-wsl-2/](https://devblogs.microsoft.com/commandline/announcing-wsl-2/ "WSL 2").

### TYPE I Hypervisor - Bare Metal or Native Virtualization

TYPE I is used in server environments on hardware utilizing multiple core CPUs, multiple terabytes of RAM, and multiple terabytes of hard drive space.  A TYPE I hypervisor includes a kernel and tiny purpose driven mini-operating system tuned just for managing and interfacing with virtual machines.  The kernel itself is the hypervisor also tuned with all unnecessary features removed.  This book will not cover TYPE I hypervisors or commercial implementations of them.

* [Microsoft Hyper-V](https://technet.microsoft.com/en-us/library/hh831531.aspx "Hyper-V")
* [VMware ESXi](http://www.vmware.com/products/vsphere-hypervisor/ "vSphere")
* [KVM](https://www.linux-kvm.org/page/Main_Page "KVM homepage")
* [XEN](https://xenproject.org/ "Xen Project")
* [bhyve](https://bhyve.org/ "byhyve virtualixation project")
  * Supported on FreeBSD, macOS, and Illumos

## Installation of a Linux Distribution

The byproduct of opensource and free software is that the actual source code is available. Though you can download all of the major Linux and BSD operating systems at no cost, this is not because of free and opensource software, it is a byproduct of the licenses. We will be downloading and installing 20 plus operating systems in the lab for this chapter. This makes the barrier to entry for using a Linux distro very small. As noted previously, in the early days of Linux, installation was not very user friendly. Over the past two decades, however, the various distros have perfected software packaging and installation has since become very simple and extremely user friendly.

How would one install a Linux distro on a computer?  The first thing you need is an *ISO* file. An [ISO (*"eye-so"*)](https://en.wikipedia.org/wiki/ISO_9660 "ISO 9600 standard") file is actually a standard file type that represents the contents of a CD/DVD-ROM in a single archived file format, like a zip file.  Think of ISOs as carrying mechanisms for the content of a disk based installer. The reason the ISO term and format are tied to the Linux Distro installation process is a historical one. During the mid 90s Linux rose to prominence at the same time as CD-ROM technology began to become affordable and became the method of data distribution that replaced floppy and Zip disks amongst PCs. It made sense to create distributions that were almost the exact size of a CD-ROM because it made distributing and copying very easy Linux very easy. In this way Linux spread rapidly. That limitation has been lifted due to the spread of high-speed internet and the deprecation of CD-ROMS in computers.

ISO files can be burned or written to various types of media. CD-ROMs, DVD-ROMs, and more recently USB drives and SD Cards. As of August 2018 you would be hard pressed to find an optical drive on a laptop, 2-in-1s, or even a desktop PC. Though many older and still usable PCs have optical drives. One of the best tools I have found for creating bootable install media on USB drives or [SD Cards](https://en.wikipedia.org/wiki/SD_card "Wiki page for SD cards") is [etcher.io](https://etcher.io/ "Etcher").

![*Etcher init screen*](images/Chapter-03/etcher/etcher-io.png "Etcher")

The Fedora Project provides its own media writer which can be used with ISOs and has a download feature built into it.  You can download this tool from [the Fedora Project directly](https://getfedora.org/en/workstation/download/ "The Fedora Media Writer").

The RaspberryPi Foundation also has their own media writer, [the RaspberryPi Imager](https://www.raspberrypi.org/downloads/ "RaspberryPi Image Writer website") which makes dealing with SD Card based Operating Systems very convenient.  Their tool also has the auto-download of operating system version feature -- which caches the downloads.

One other tool that is of use is Rufus. [Rufus is](https://rufus.ie/ "Rufus image writer web page"): "A utility that helps format and create bootable USB flash drives, such as USB keys/pendrives, memory sticks, etc."  Rufus is fast and can be used to create Linux images as well as Windows and even DOS boot disks, should the need arise.

### Importance of ISOs

These tools takes away the difficulty out of making install media. You may hear the term *"burn"* used in relation to ISOs, all this means is to transfer or write data from one source to its extracted final source.

While you can burn ISO files to media for installation on a desktop or laptop, ISO files also have utility for installing a Linux distribution into a virtualization platform.


## Installations and ISOs

Now that we covered a bit about what a hypervisor is, let us begin the install process using VirtualBox.  The next pages are going to show you in comparison how to install the latest version of [Fedora Workstation](https://getfedora.org/ "Fedora Workstation") and latest [Ubuntu (LTS)](https://wiki.ubuntu.com/LTS "Ubuntu Long Term Support Link").  This will require you to download two ISOs from their respective download sites. For this install process we will assume that you are using VirtualBox version 6.x or later. It might be a good exercise if you have an old laptop or PC laying around to make some installable media (CR-ROM or Flash drive via Etcher) and install one of these distributions directly as the primary operating system. Finding old laptops is easier than you might think. Try asking your relatives (especially around back-to-school and Christmas), a company you work for, or even a school you go to. Laptops/desktops can have a second life and can still be useful to experiment with Linux installations even if the hardware is not the latest or greatest.  Another option to consider is dual-booting or triple-booting your system, we will not cover that option here.  

If you do try it, back up your data first, you never know what could go wrong. I created a [quad-boot system](https://jeremyhajek.com/2015/06/01/quad-boot-your-pc-ubuntu-15-04-centos-6-6-fedora-21-windows-10.html "Quad Boot") containing Ubuntu, Fedora, CentOS, and Windows 10.  This processes is beyond the scope of this book but the link is provided for those interested.

You also need to be aware of the type of architecture you are installing to. In the past we had to determine if the CPU was 32-bit or 64-bit?  In modern Linux distros, 32-bit distros are mostly a thing of the past due to all CPUs being 64bit. You can find information about your processor by going to [http://ark.intel.com](http://ark.intel.com] "ARK"). This is Intel's clearing house for all its information about processors and motherboards.  They can tell you all you want to know about a processor.  All but the most specialized or low end chip these days is 64-bit you should be safe with that type of distro. 

The 32-bit distro is most commonly referred to as the x86 or 586, 686 architecture. The 64-bit architecture is usually referred to as x64, but sometimes *x86_64*, and even *AMD_64*, that is not a reference to AMD processors - just a credit in the name as AMD was the first company to implement 64-bit extensions to the 32-bit x86 instruction set--hence the name. There is one other type of architecture called ARM or ARMh7, AARCH, AARCH64. This is the ARM architecture that runs phones, tablets, and small embedded systems such as the Raspberry Pi. 

There are ARM based laptops out there such as the [Pinebook Pro](https://www.pine64.org/pinebook-pro/ "Pinebook Pro website") and even Apple has moved their laptops to be ARM based, the M1 macs, as of 2021. It has an entirely different instruction set so the software compiled for this architecture is not compatible with the Intel x86-x64 architecture.

Each distro also has a checksum feature provided by the site that issues the download. A checksum is a one way mathematical function that gives you a unique representation of what the content of the ISO should be. That way if you download an ISO from somewhere and the checksum is different then you might be alerted to someone trying to add additional contents or perhaps just a corrupted download. Most distros use the SHA-256 hash, but for legacy purposes you still see md5 hashes.

* [Get Fedora](https://getfedora.org "Get Fedora")
* [Get Ubuntu](https://ubuntu.com "ubuntu")
  * [Ubuntu checksum page](https://help.ubuntu.com/community/UbuntuHashes "Ubuntu Hashes")
  * [Microsoft PowerShell hash checking functions](http://technet.microsoft.com/en-us/library/dn520872.aspx "Powershell Hash checking function")
* [Linux Distro Mirrors](https://mirrors.kernel.org "Linux Distro Mirrors")
* [Get VirtualBox](http://virtualbox.org "VirtualBox")

### Checksums

Here are the commands to execute in Windows in PowerShell:

```powershell
Get-FileHash .\ubuntu-22.04.2-desktop-amd64.iso -Algorithm SHA256 | format-list
```

Output: ```b98dac940a82b110e6265ca78d1320f1f7103861e922aa1a54e4202686e9bbd3```

Here are the checksum commands and output to be executed if you are running on an already installed version of Linux or Mac OSX from the terminal:

```bash
sha256sum ./Fedora-Workstation-Live-x86_64-38-1.6.iso
```

Output: ```7A444A2E19012023BF0B015AE30135BAFC5FD20F4F333310D42B118745093992```

Can you find `SHA-256` of the sample PDF located in the book source code, in the folder ```files -> Chapter-03 -> text-08052020.pdf```?

### Planning Your Install

Before beginning there are a series of questions you should ask yourself, "What do I need in this distro?"

* Strict Security?
* Ease of use?
* Stable release with long term support?
* Will this be a desktop install or server install?  GUI or no GUI?
* What software will you be needing?
  * Serving web pages?
  * Building Android applications?
  * Hacking your neighbor's Wi-Fi?
  * Developer platform for Coding? Audio and Video?
  * Server edition (no gui)?
  * Building home networks, virtual test beds, Virtual Machine farms?
* What processor do I have 64-bit (Intel or AMD) or ARM (M1 Mac or Raspberry Pi)?
  * How much RAM do I have or need?
* Is this an old PC or laptop I am using--does it lack processor extensions that can aid in rendering media efficiently?
  * [SSE](https://en.wikipedia.org/wiki/Streaming_SIMD_Extensions "SSE")
  * [AVX](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions "AVX")
* Licensing for business?
  * Does it need to be GPL compliant?
  * Can proprietary programs and codecs be included?

### Creating Your First Guest Virtual Machine

Upon completion of a fresh install and launching of VirtualBox you should see this image:

![*VirtualBox fresh install*](images/Chapter-03/VirtualBox-Install/new-installation.png "Fresh VirtualBox install")

See the [getting started manual](https://www.virtualbox.org/manual/ch01.html "Getting started manual") for a wide range of information. Unlike some opensource projects this documentation is actually very thorough and useful. VirtualBox has a list of [supported host operating systems](https://www.virtualbox.org/manual/ch01.html#hostossupport "Supported Host Operating System"), which is basically any operating system you can think of from DOS to Haiku to FreeBSD.

Let us walk through the initial installation process. The first step to begin is with the *NEW* button. The next step is where we give our guest virtual machine a name. VirtualBox has long had support that if you type the type of the operating system in the system name - VirtualBox will auto detect the instance type and version. If you see the sample below I typed "Ubuntu-20-04-Desktop" and "Fedora-34-workstation." As you type in the title that has the name in it VirtualBox will auto-detect and switch the type and version automatically.

![*Create New Ubuntu and Fedora Instance Dialogs*](images/Chapter-03/VirtualBox-Install/name-and-operating-system-two.png "Create New Instance Dialog")

What happens if you choose the wrong type or version? Two things: __first__, if you chose the wrong edition of Linux most things will work but the virtualization layer will not be optimized, try to avoid it. You can always go back into the *SETTINGS* menu option and change it after the virtual machine is powered off. __Second__, if you select the wrong version, (32-bit instead of 64-bit) you will receive an error from the BIOS as the operating system loads explaining that it cannot continue.

Next is the amount of memory available - note that this memory is shared with your underlying OS as described with TYPE II hypervisors. Whatever you allocate to this guest VM will be unavailable to the underlying host OS while the guest VM is powered on. Note the slider, each system to install VirtualBox on will have a different slider based on the amount of memory you can allocate. The recommended amount of memory is at least one gigabyte but two gigabytes or more will be better.

![*Memory Selection Dialog*](images/Chapter-03/VirtualBox-Install/memory-size.png "Memory Selection Dialog")

The next step is the hard drive creation step. In this step we will choose to create a new hard drive now.

![*Drive Type*](images/Chapter-03/VirtualBox-Install/hard-disk.png "Drive Type")

Next is the hard drive file format. There are a few competing standards. If you know you are going to be working in the VirtualBox environment then the default VDI virtual disk type is sufficient.

![*Hard Disk File Type*](images/Chapter-03/VirtualBox-Install/file-type.png "Hard Disk File Type")

You can choose to dynamically allocate your hard drive space or statically allocate it. The advantage of dynamically allocating is that not all the space will be assigned right away. The hard drive will grow incrementally as you need space until it hits the maximum you defined.

![*Disk Type*](images/Chapter-03/VirtualBox-Install/storage-type.png "Disk Type")

The final option dialog is where you can choose where to store your virtual machine's virtual hard drive and the amount of virtual hard drive you want to allocate. Here you have a choice of how much hard drive space you will allocate to the guest VM. This space will be treated as a file by the underlying host OS--allowing for easy migration, export, and even cloning of the guest VM. As a rule of thumb, I generally double the space recommended. Usually the default storage location is fine unless you know you need to store the hard drive on a separate partition or disk.

![*Hard disk Allocation*](images/Chapter-03/VirtualBox-Install/file-location-and-size.png "Harddisk allocation")

Now click *finish* and you should be ready to go. 

### Walk Through the Settings

![*Virtual Machine Settings*](images/Chapter-03/VirtualBox-Install/settings.png "Virtual Machine Settings")

Before we hit the start button - let us select one of our virtual machines and take a look at the content of the SETTINGS button. Here we will find all the settings possible related to our virtual machine. Though not entirely correct - you could think of this similar to a BIOS settings on a PC - and area where we can configure any underlying hardware. The most common options you will deal with are described as follows:

General

: Setting that handle meta-data about the virtual machine

System

: Settings to change amount of RAM and processors - enabling or disabling chipset drivers and CPU features

Display

: Settings to change how the display settings work

Storage

: Settings related to disk drives.

Network

: Settings related to changing or adding new network interfaces or network types.

### Installing Ubuntu

Hitting the *START* button on your virtual machine for Ubuntu 20.04 Desktop will bring you to a screen that asks you to select install media (or ISO file):

![*Select ISO install media*](images/Chapter-03/ubuntu-install/select-iso.png "Select ISO")

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

\newpage

## Package Managers

![*Always check the package dependencies...*](images/Chapter-03/package-managers/debian_main-2.png "Dependencies")

One of the initial claims against using Linux and Unix was that software install was a nightmare. Software had been distributed in `tarballs` (.tar.gz) that were convenient but lacked any knowledge of system state. So you could compile source code but the code had no idea ahead of time if the proper software libraries were installed in the correct locations or if the proper versions of those libraries were installed. And each additional library had its own dependencies and those had dependencies too. You see how this could get ugly quickly. Initially there was a build system developed by a companion of Thompson and Ritchie's named Stuart Feldman; named ```make```. He was also an author of the first Fortran 77 compiler, and he was part of the original group at Bell Labs that created the Unix operating system. Feldman was the Vice President of Computer Science at IBM Research. He was also Vice President, Engineering, East Coast, at Google for a time[^105].

Feldman realized building software was difficult and created the ```make``` build system. The ```make``` system uses a file named ```makefile``` that includes instructions and ordered steps that can be repeated every time software is built. This allows software to be portable across systems (in theory). The utility ```make``` is the binary that automatically builds executable programs and libraries from source code by reading the *makefiles*[^106]. Here is an example `makefile`:

```makefile
     all: helloworld

    helloworld: helloworld.o
  $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

    clean: FRC  
    rm -f helloworld helloworld.o

    # This is an explicit suffix rule. It may be omitted on systems
    # that handle simple rules like this automatically.
    .c.o:
  $(CC) $(CFLAGS) -c $<

    FRC:
    .SUFFIXES: .c
```

Like many things in the Unix world, the ```makefile``` system has been modified and augmented but still persists as the way software project are built and installed some 30 years later. Makefiles have an arcane syntax that few people enjoy and over the years ```make``` has been often rewritten. In 1988 the GNU project had released their Free Software version of ```make``` called GNU Make or ```gmake```. GNU make is included in all standard Linux distributions and is even required for compiling the Linux Kernel. There are other versions of ```make``` including the Unix version, ```pmake``` and ```bmake``` on the BSD Unix variants, there is a cross platform build tool called ```cmake``` and even Microsoft has its own build tool that can be used called ```nmake```.

### Traditional Package Managers

This style of software installation put a high barrier to who could practically use Unix/Linux. Linux distributions took to making software installation and distribution easier by introducing something initially called `Package Managers`. These were meant to eliminate all of the above process by solving two key problems. First it would solve the re-compilation of code and supporting of make and build tools--you technically wouldn't even need any C compiler or build tools installed. Second package managers would solve the dependency issues by keeping track of the dependency trail and be smart enough to follow that trail before installation.

#### .deb

The first package manager was __dpkg__ which was created by Matt Welsh, Carl Streeter and Ian Murdock (founder of Debian) in 1994 as a replacement for an earlier primitive package manager. The program ```dpkg``` is used to install, remove, and provide information about .deb packages.

A Debian package (or ```.deb``` file) is really just made up of two tarballs[^107]. One is the control data which is listed as such:

```yaml
     Package: hello
     Priority: optional
     Section: devel
     Installed-Size: 45
     Maintainer: Adam Heath <doogie@debian.org>
     Architecture: i386
     Version: 1.3-16
     Depends: libc6 (>= 2.1)
     Description: The classic greeting, and a good example
     The GNU hello program produces a familiar, friendly greeting.
```

The most important line being the __Depends__ option which controls dependencies and can prevent installation if these conditions cannot be met. The second component includes the binary or pre-compiled portion of the code. Using ```dpkg``` is a clear step above using tarballs and compiling the code yourself.

Recently with Oracle changing the nature of how Java is supported with the transition from Java 8 and 11 and into the future, concerned companies created their own OpenJDK for download that will be supported. One such instance is [Amazon Corretto](https://aws.amazon.com/corretto/ "Amazon Corretto OpenJDK"). These releases are created in ```.deb``` packages. Let's download one and install it using a simple command called ```wget``` or you can open a web browser and download the package and install it manually.  Click on the link and save the ```.deb``` file on Ubuntu. Now using the ```dpkg``` command we can install the package manually (note there may be an error message about a missing dependency).

#### DEB package install example

```bash
# From the command line terminal after you have downloaded the file
# on a Debian based system:
wget https://corretto.aws/downloads/latest/amazon-corretto-8-x64-linux-jdk.deb
sudo dpkg -i ./java-1.8.0-amazon-corretto-jdk_8.222.10-1_amd64.deb
# This method will retrieve the .rpm file directly from the internet and pass it to
# the rpm command on CentOS or Red Hat systems.
sudo rpm -iv https://corretto.aws/downloads/latest/amazon-corretto-8-x64-linux-jdk.rpm
```

You can download a .deb or .rpm file from the Vivaldi browser website: [https://vivaldi.com/download/](https://vivaldi.com/download/ "Vivaldi.com") Vivaldi is a new browser from the team that brought us Opera browser. The packages are not available in APT or RPM, you download the .deb or .rpm. file directly and install through dpkg in Ubuntu's case. In the command below we will introduce the install command or the ```-i``` flag, which stands for __install__.

#### RPM Package example

```bash
# Download URL at: https://vivaldi.com/download/
sudo dpkg -i ./vivaldi-stable_5.3.2679.70-1_amd64.deb
sudo rpm -iv ./vivaldi-stable_5.3.2679.70-1.x86_64.rpm
# This command involves downloading and installing directly from the web
sudo rpm -i https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.rpm
sudo dpkg -i https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb
```

After executing this command on the Vivaldi packages, you will receive an error message. What is it telling you and why? You will notice that `dpkg` command found that it had a *dependency*, can you locate that *dependency* on [http://packages.ubuntu.com](http://packages.ubuntu.com "packages")? In the commands below we will introduce the install command or the `-i` flag, which stands for `install`.

__Example Usage:__

```bash
sudo dpkg -i ./links_2.8-2_amd64.deb
```

Note that this command installs properly without any error message: [http://packages.ubuntu.com/](http://packages.ubuntu.com/ "links").

__Example Usage:__   There are other flags but the most common are these:

* ```sudo dpkg -r or --remove```
* ```sudo dpkg -P or --purge```
* ```sudo dpkg -l or --list```
* ```sudo dpkg --status links```

__Example Usage:__ Let's use the ```dpkg``` command to list all kernel versions we have installed and the ```purge``` command to remove those old kernels entirely.

```bash
sudo apt dist-upgrade
sudo dpkg -l | grep linux-image
# x.x.-xx is the version that is not the most recent version as deleting that will
# make your system unbootable.
# uname -a will tell you the current kernel version
sudo dpkg --purge linux-image-x.x.x-xx-generic

# Sometimes there are kernel dependencies and this command will fail
# In those cases you can use the command below to remove the old kernel images
# and free space on your /boot partition.

sudo apt remove linux-image-x.x.x-xx-generic
```

#### RPM

 A few years after dpkg became standard on Debian based distros, the Red Hat Linux created their own package manager out of necessity in 1998 and called it RPM (Originally Red Hat Package Manager - now known as RPM Package Manager.) It is used across Fedora and RHEL derivatives. RPM is also used on IBM's AIX Unix distribution. RPM code and FAQ can be found at [http://rpm.opg](http://rpm.org "RPM.org") [^113].

> __Example Usage:__ List all installed packages:
```rpm -qa```

> __Example Usage:__ List information about an installed package:
```rpm -qi pkgname```

> __Example Usage:__ Install a package from a local file:
```rpm -i file.rpm```

> __Example Usage:__ Remove a package from the system:
```rpm -e pkgname```

> __Example Usage:__ Get information about a remote package
```rpm -qpi <url>```

Similar to the previous example let us download the Vivaldi RPM and install it locally. [https://vivaldi.com/download/](https://vivaldi.com/download/ "Vivaldi.com"). After selecting the Vivaldi 64 bit rpm and using the ```-i``` flag to install it, what error message is printed?

Let's try another rpm. This one is called "elrepo," it for Enterprise Linux version RHEL and CentOS. This adds up to date packages and third party repos, adding software that is not part of the stable Enterprise repos. The rpm is located at [http://elrepo.org/tiki/tiki-index.php](http://elrepo.org/tiki/tiki-index.php "elrepo website"). You need a few pre-reqs to make this work.

```bash
# Add the GPG key for the repo to make sure that you are adding the official elrepo
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo dnf install https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm
```

#### Other Package Managers

As you can see that package managers were a great step forward in making Linux usable. But they don't handle the dependency issue--they don't understand the context of auto-dependency retrieval. Various solutions were created and new ones seem to pop up with each new Linux distro. Fedora based distros use yum and now use dnf (as of Fedora 23) and Debian based distros use apt. Others you might encounter:

* [Zypper](https://en.wikipedia.org/wiki/ZYpp "SUSE Zypper web page")
  * `sudo zypper install neofetch`
* [pkg for BSD](https://www.freebsd.org/doc/handbook/pkgng-intro.html "pkg for BSD")
  * `sudo pkg install neofetch`
* [Pacman](https://www.archlinux.org/pacman/ "Pacman web page")
  * To update your systems: `sudo pacman -Syu`
  * To install packages: `sudo pacman -S neofetch`
* [Yum](https://en.wikipedia.org/wiki/Yum_(software) "Wikipage for YUM")
  * Previous installer for Red Hat based systems
  * Functions identical to `dnf`
* [GNU GUIX](https://en.wikipedia.org/wiki/GNU_Guix_System "GNU GUIX webpage")

### APT

Apt (for Advanced Package Tool) is a set of core tools inside Debian. Apt makes it possible to:

* Install applications
* Remove applications
* Keep your applications up to date

The APT installer was released in 1998, the same time that Red Hat released its package manager (giving Debian a leg up and a few years head-start). APT was the out growth of a research project called *Deity* run by the Debian developers. It was planned to be a large GUI-like project, but it turns out that the APT CLI was implemented with such finesse and simplicity that all GUI plans were dropped. APT is mentioned as one of the key user based features for Debian based distros and Debian's founder Ian Murdock considers APT to be one of the best contributions of Linux [^108]. APT stands for the Advanced Packaging Toolkit. APT will interface with *dpkg* and has many similar commands but extends the functionality of dpkg in a critical way.

APT, which basically resolves dependency problems and retrieves the requested packages, works with dpkg under the hood. The main commands of APT are as follows:

* `sudo apt update`
  * Used to make sure your system is pointed to the latest repository versions. You should always run this before taking any other actions.
* `sudo apt install`
  * Used to install the application of choice
* `sudo apt remove`
  * Used to remove the application of choice
* `sudo apt search [pattern]`
  * Used to search all your repositories for an app matching the given pattern
* `sudo apt upgrade`
  * Used to perform an upgrade of all current packages that have updates available (note in Yum this is the command update)
* `sudo apt dist-upgrade`
  * This performs the same as the upgrade but will also update the kernel version and headers as well
* `sudo do-release-upgrade`
  * This will update the entire distribution and move it to the next incremental version (Ubuntu 23.10 to 24.04)

Here is a list of all the configuration and cache files related to APT and their location:

* `/etc/apt/sources.list`: Locations to fetch packages from
* `/etc/apt/sources.list.d/`: Additional source list fragments
* `/etc/apt/apt.conf`: APT configuration file.
* `/etc/apt/apt.conf.d/`: APT configuration file fragments.
* `/etc/apt/preferences`: version preferences file. This is where you would specify "pinning", i.e. a preference to get certain packages from a separate source or from a different version of a distribution.
* `/var/cache/apt/archives/`: storage area for retrieved package files.
* `/var/cache/apt/archives/partial/`: storage area for package files in transit.
* `/var/lib/apt/lists/`: storage area for state information for each package resource specified in sources.list
* `/var/lib/apt/lists/partial/`: storage area for state information in transit.

#### Repositories

APT relies on the concept of repositories in order to find software and resolve dependencies. For apt, a repository is a directory containing packages along with an index file. This can be specified as a networked or local based location. The Debian project keeps a central repository of over 25,000 software packages ready for download and installation. This includes ability to add non-free software repositories as well. You can add additional repositories via the `add-apt-repository`[^109] [^110] command. This is used to add community maintained PPA's--which stand for *personal package archive.* These are for packages maintained outside of Debian's rigorous package checking standards and 1 to 2 year release window. Hence the cartoon at the beginning of the chapter.

The package system and architecture is on of the reasons for Debian's long standing existence and credibility. The system just works. Ubuntu is a Debian derivative that utilizes this archive of packages. Remember that the founder of Ubuntu, Mark Shuttleworth, had been a Debian contributor at one point. Ubuntu builds on top of Debian's 25,000 packages by maintaining additional *downstream* repositories that add additional software and repositories to make up the Ubuntu distribution. Ubuntu is a little more liberal on including non-free drivers for mainly high-end video cards. Users can then add additional repositories or PPA's of their own choosing to extend APT functionality and expand that package base.

Seeing as you may want to access a more recent build of an application that may not be in the standard Debian/Ubuntu distribution or not even submitted to a repository because the version is moving too fast or the maintainer just didn't want to package it up. For example if you want to install a newer version of the Python3 language on your system, you have to wait for another version of the OS.

> __Example Usage:__ For example, Ubuntu 2004 installs Python 3.8.x by default and doesn't update the major version until the next Ubuntu release. But what if you needed to test a newer or older version of Python? Try the below sequence:

```bash
# Check your current Python3 version - 3.8.x on Ubuntu 2004
python3 -V
# Lets add the deadsnakes PPA so we can add different Python3 versions
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.6 python3.9
python3 -V
python3.9 -V
python3.6 -V
```

#### Linux-libre PPA

There is also a PPA for Linux-libre. Linux-libre is a GNU package that is a modified version of the Linux kernel. The aim of the project is to remove from non-free or significantly obfuscated code[^111] from the Linux kernel. The downside of removing proprietary firmware from the kernel is that it will cause lose functionality for certain hardware that does not have a free software replacement available. This affects certain sound, video, TV tuner, and network (especially wireless) cards.

The resulting combination of the GNU Operating System and the kernel named Linux is the GNU+Linux operating system, although many (incorrectly) refer to it as ["Linux"](http://www.gnu.org/gnu/linux-and-gnu.html "GNU/Linux")[^112].

> __Example Usage:__ Let's set our kernel free, FSF style... Following these instructions: [FSF Latin America](https://www.fsfla.org/ikiwiki/selibre/linux-libre/freesh.en.html "web link to article to install Libre-Linux"). Once successful, reboot your system and/while holding down shift - you should see the menu in the image below appear. Choose *Advanced Options For Ubuntu* and you will see your GNU/Libre kernels. Try to boot from one. 

These are the short steps:

* `wget` [https://linux-libre.fsfla.org/pub/linux-libre/freesh/pool/main/f/freesh-archive-keyring/freesh-archive-keyring_1.1_all.deb](https://linux-libre.fsfla.org/pub/linux-libre/freesh/pool/main/f/freesh-archive-keyring/freesh-archive-keyring_1.1_all.deb "link for Libre Linux keyring deb")
* `dpkg -c freesh-archive-keyring_1.1_all.deb`
* `sudo dpkg -i freesh-archive-keyring_1.1_all.deb`
* `gpg --no-default-keyring --keyring /usr/share/keyrings/freesh-archive-keyring.gpg --list-keys`
* `rm freesh-archive-keyring_1.1_all.deb`
* `sudo apt update`
* `sudo apt install linux-libre linux-libre-lts`

![*Linux-Libre*](images/Chapter-03/linux-libre/kernel-linux-libre.png "libre.png")

### yum & dnf

Fedora based Linux is in a bit of a transition. Its enterprise products RHEL and CentOS are still using the YUM installer. Fedora 22 and 23 still have YUM for backward support but have moved to using DNF to handle the installation of packages and dependency resolution. YUM support came in Fedora 22 but is now deprecated. DNF is the preferred installer, with YUM to be removed down the line. RPM based distros had used a tool called ```up2date``` prior to 2003. An opensource tool from a distro called Yellow Dog Linux lead to the creation of YUP (Yellow Dog Updater) which was then improved to become YUM (Yellow Dog Updater Modified) by the year 2003 and by 2005 every distro using RPM had moved to YUM. 

Yellow Dog Linux was first released in the spring of 1999 for the Apple Macintosh PowerPC-based computers and continues today as a Linux for high-end POWER7 workstations. A successor to YUM is named DNF which somehow stands for *dandified yum*. It was released in Fedora 18 and is quickly becoming the Fedora package manager of choice. YUM is still available on RHEL and CentOS but as companies move to version 7 and 8, this will begin to change too. `Yum`  been replaced by `dnf`. Both YUM and DNF use the same repositories.

You can find the installed repositories in `/etc/yum.repos.d`. Each file listed will contain information about the URL where it retrieves repos. There is also an ability to set priorities as to which repo is checked first. As we did in previous chapters, we added RPM repos. The most famous package for adding additional software is RPMForge, [http://rpmfusion.org/](http://rpmfusion.org/ "RPMForge"). Taken directly from their website, *"RPMFusion ships packages that Fedora and Red Hat don't want to ship standard with their distro."* This includes free software as well as non-free software that cannot be shipped due to the GPL nature of Fedora.

![*Installed Repositories Fedora 40*](images/Chapter-03/yum/etc-yum.png "YUM")

[FFmpeg](https://en.wikipedia.org/wiki/FFmpeg "FFMpeg") is a free software project, the product of which is a vast software suite of libraries and programs for handling video, audio, and other multimedia files and streams. If we try to install it via ```sudo dnf install ffmpeg``` we get this message, why?

![*Unable to Find a Match*](images/Chapter-03/yum/unable.png "Unable to find a match")

First we want to check if we have the correct RPM name. We can search through our repos looking for the name by typing the `sudo dnf search [fF]mpeg*` command. This will return two results--the package and a related dependency and watch out, RPM also tends to be case-sensitive.

#### Additional Packages for Enterprise Linux - RPM

Since the Red Hat source code was geared for long term enterprise support the number of packages and availability of packages differs from a unified Debian or Ubuntu Distro. There are two additional package repos you can add to a Rocky Linux, Fedora Linux, or AlmaLinux system.

* [Extra Packages for Enterprise Linux (EPEL)](https://docs.fedoraproject.org/en-US/epel/ "webpage for EPEL")
  * Developed by the and included by the Fedora Project
  * `sudo dnf install epel-release`
  * `sudo dnf install neofetch`
* [ELRepo](https://elrepo.org/ "Website Enterprise Linux Repos")
  * Ships software that Fedora won't or can't
  * `rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org`
  * `sudo dnf install https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm`

#### Upgrade Packages With DNF

The command ```sudo dnf upgrade``` will upgrade all packages that have updates pending. You can now use DNF to [upgrade your system](http://fedoraproject.org/wiki/DNF_system_upgrade "upgrade") as well. These are the series of commands to install the DNF upgrade plugin and then execute the process.

* ```sudo dnf update --refresh```
* ```sudo dnf install dnf-plugin-system-upgrade```
* ```sudo dnf system-upgrade download --releasever=40```
* ```sudo dnf system-upgrade reboot```

## New Package Managers as App Stores

The one thing that you can say the mobile revolution brought into computing is the concept of an "app store." Apple obviously came first, Google Play Store, and even the Microsoft Store took root. The concept of an app store is pretty ubiquitous at this point. These platforms are not based on free and opensource, they are called "walled gardens," because you are free to install any software as long as it comes from the curated app store. On a fundamental level Linux is conceptually not compatible with the concept of an app store. 

But the concept that an app store provides, controlling/standardizing software versions, ease of install/remove, and basic sandbox security technology for apps--the benefits cannot be overlooked in regards to usability. To this end two standardized methods were developed: Flatpak and snaps. Snaps were created by Ubuntu and is account based across Linux distros that support the snapd library. Flatpak is the competing standard championed by Red Hat.

### Snaps and snapd

In 2019 Canonical, the parent company of Ubuntu, introduced a new package manager architecture called Snaps. This architecture includes a package manager process called **snapd**, packages called **snaps**. The technology is housed at a neutral organization site called [snapcraft](https://snapcraft.io/ "Snapcraft").

Snaps are an attempt to create a similar concept to modern App Stores on mobile devices. They allow for updating packages in place and the packages contain all needed dependencies. This is a different focus from simple package managers like APT and RPM. In addition, you can "package" existing applications into Snaps and or distribute them via a Snap account to devices and then instantly download them on another machine that supports snaps. Currently, Ubuntu distributions are the only Linux distros that have Snappy installed by default.

Snaps, similar to the App Store concept, allows you to:

* Simple to package leveraging your existing tools
* Automatic updates for everyone
* Reach tens of millions of Linux systems
* Roll back versions effortlessly
* Integrate easily with build and CI infrastructure
* Free for open and closed source projects

Since Ubuntu Desktop 20.04, some packages when installed via apt, have been redirected to use the appropriate `Snap` package, which has bothered some, and one distro, Linux Mint, has removed `Snaps` all together. `Snaps` can be installed from the commandline or via the Store Icon in the Ubuntu Desktop.

You can open the Ubuntu Software Icon on the Favorites Bar and select some software. Lets install Notepad++. You can also install Snaps from the command line. Open a terminal and issue the below commands to find software package names (since there is no GUI to browse):

```bash
# This command will show your installed Notepad++ snap from the store
sudo snap list
sudo snap find vscode
# You will see a list of output and a column with the term "classic" or not.
# This means that the first version of snap that packages were built for
# did not have the sandboxing technology of a traditional app.
# They are conventional application packages.
```

```bash
# This will install Visual Studio Code
sudo snap install vscode --classic
# To install a note taking app that is not a classic snap
sudo snap install simplenote
# To see all snaps installed
sudo snap list
```

### Flatpak

Supported on all Linux operating systems and functions like an app store -- where you can install, remove, and update packages all from a single command - [Flatpak](https://www.Flatpak.org/ "Flatpak"). You can see software available at [Flathub](https://flathub.org/home "Flathub").

Flatpak essentially connects the concepts of repositories and app packages, but the drawback is that Flatpak manages its own applications and list of installed applications. It is installed as standard since Fedora 32. Let's install some applicataions via Flatpaks. The first thing is to install the FlatHub repository. You can browse the [Flathub.org website](https://flathub.org "website for Flathub"). On other OSes such as Pop!\_OS and OpenSuse, support Flatpak out of the box, but the Flathub repo is not installed by default and can be added with this command:

* Add Flathub to your Flatpak install
  * Most non-Debian/Ubuntu comes with flathub installed
  * `sudo flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo`
* You can use search for your package names just like in `apt` or `dnf`
  * `sudo flatpak search VLC`

#### Installing Flatpaks

Once that is done here is an example of installing Flatpaks from the commandline:

* `sudo flatpak install flathub VLC`
* `sudo flatpak install flathub Discord`
* `sudo flatpak install flathub Blender`
* `sudo flatpak install flathub Obsproject`

These apps appear on your start menu after a logout and log back in. They can also be launched via the `Flatpak` command from the commandline. Note that from the command line you don't run these as `sudo`. You can find the official Flatpak name by issuing the command: `Flatpak list`.

### AppImage

A third new package manager has arisen called [AppImage](https://appimage.org "app image website"). The idea here is for standalone compatibility. AppImages are larger files because they contain all of the necessary libraries to run, packed with the application. This is sometimes called a fat-binary. This eliminates worrying about software library versions as everything is self-contained. This is also a good way to distribute older software that may not run on newer systems. AppImage should have vendor support, but currently doesn't have wide deployment, but the AppImage is supported across most Linux distros due to third party work. AppImages are self-contained binaries so there is no main store or tool for updating, you have to find them and keep an eye on them to make sure they are the latest or most up to date versions.

[AppImageHub](https://appimage.github.io/)

* [AppImage for Visual Studio Code](https://appimage.github.io/Code_OSS/ "AppImage for Visual Studio Code")
* [AppImage for Audio/Video Player](https://appimage.github.io/VLC/ "AppImage for sound editor")
* [AppImage for Calibre e-book manager](https://bintray.com/probono/AppImages/Calibre "ebook manager")
* [2D Animation Studio](https://github.com/synfig/synfig/releases/download/v1.3.15/SynfigStudio-1.3.15-testing-2020.07.23-linux64-b5b32.appimage "app image for animation studio")

## Compiling and Installing source code

In addition to packages you may still want to compile software from source. This way you can take advantage of the latest compiler optimizations and CPU support. Or compile older versions that have a feature you need that is no longer supported as a package any more.

### GNU GCC

The main tool needed is the GNU C compiler or GCC for short. This was one of the first items that Richard Stallman created in the GNU project and to this day is needed for building the Linux Kernel and is the standard build tool for Free Software. There are competing software stacks and compilers, as of version 10 the FreeBSD project deprecated GCC and chose the [Clang](https://en.wikipedia.org/wiki/Clang "Clang") project, originally designed by Apple to support [Xcode](https://en.wikipedia.org/wiki/Xcode "Xcode"), instead. Apple abandoned the GCC compiler because of the restrictions placed on it by GPLv3, which is an interesting side effect of GPLv3. 

The GCC compiler has grown to include other languages over the years as well. You can install the GCC compiler and all the additional build tools in Debian/Ubuntu by typing: 

> `sudo apt install build-essential` 

In Fedora you would add these two commands via `yum` or `dnf`

>  `sudo dnf group install "development tools"`

### GNU Make

As mentioned prior the GNU make command is used to actually compile the C code and all the directives stated in the build file. That compiled source is then placed into the proper system directories by the `make install` command. This command needs *superuser* privileges to move files to directories not owned by the user, but the `make` command doesn't need sudo--resist the temptation! The `--prefix=` is the default location where you want to store the compiled Apache2 binaries, it defaults to `/usr/local/apache2/`.

Let's compile something to see how this works. This link is to the Apache webserver version 2.4.x latest source code: [http://httpd.apache.org/docs/2.4/install.html](http://httpd.apache.org/docs/2.4/install.html "Apache Webserver Instructions"). Let's install some pre-requisites:

```bash
# Pre-reqs needed first -- assumuing Ubuntu 20.04+
sudo apt install build-essential libapr1 libapr1-dev libaprutil1 \
libaprutil1-dev libpcre3 libpcre3-dev libpcre2-dev
# Command to retrieve the source code
wget https://dlcdn.apache.org/httpd/httpd-2.3.62.tar.gz
# Command to unzip the source code
tar -xvzf httpd-2.4.63.tar.gz
# command to change directory to extracted source code
cd httpd-2.4.63
# commands to build
./configure
make
sudo make install
sudo /usr/local/apache2/bin/apachectl -k start
```

Now open a web browser in the virtual machine and navigate to http://127.0.0.1 and you should see the message: "It Works!"

### Using Python to Install Python Based Programs

Python has its own package installer called [**pip**](https://pypi.org/project/pip/ "Python Packager") which allows for software that is written in Python and independent of any Linux package manager to be installed. Pip allows you to install newer versions of a Python package without having to wait for a Linux distro's package manager.

You can see an example of how to install Python language packages (eggs). A popular package is called [OpenCV](https://pypi.org/project/opencv-python/ "Pypi opencv package webpage"), which allow you to do computer vision, object recognition, and image manipulation. We can install this very useful package via `pip`. We can do this by opening the Terminal via the `Activities` tab and run these commands:

```bash
# command to install python3 pip
sudo apt install python3-setuptools python3-pip python3-dev
python3 -m pip install opencv-python
```

There is sample code in the textbook repository. Under the directory `files` > `Chapter-03` and run the command:

```bash
python3 show-image.py
```

### Installing VirtualBox Guest Additions 7.x

You may have noticed that when a guest VM is successfully installed the screen resolution may be very small and the mouse integration features are not working. By default VirtualBox doesn't know what your host system's underlying hardware is. So it guesses by providing a lowest common denominator set of hardware drivers, usually for pretty old, but well known set of hardware. In order to install higher quality drivers to enable more features VirtualBox provides something called *"guest additions"* to enable exclusive features that are not normally available in an operating system. These features include things such as shared folders, cut and paste support, and even support for multiple monitors and higher resolutions.

VirtualBox Guest Additions can be installed by selecting an installed virtual machine and selecting the menu item under `DEVICES` then select the "Insert Guest Additions CD Image." For Windows and Mac as the guest VM OS this is a pretty straight forward install - the attached Guest Additions ISO appears within the VM and you simply double click it and run through the menu, reboot, and new features are added. For Linux you need to compile these extensions into the kernel and some extra tools are needed.

> "The Guest Additions are designed to be installed inside a virtual machine after the guest operating system has been installed. They consist of device drivers and system applications that optimize the guest operating system for better performance and usability." [https://www.virtualbox.org/manual/ch04.html](https://www.virtualbox.org/manual/ch04.html "Source")

The Guest Additions offer the following features:

* Mouse pointer integration
* Shared folders
* Better video support
  * Finally, if the Guest Additions are installed, 3D graphics and 2D video for guest applications can be accelerated; see Section 4.5, “Hardware-accelerated graphics”
* Time synchronization
* Shared clipboard
* Automated logons (credentials passing)

#### Ubuntu Desktop

```bash
# Assuming you are using VirtualBox 7.x and you have inserted 
# the VirtualBox Guest editons iso (under Devices)
sudo apt update
sudo apt install build-essential dkms linux-headers-$(uname -r)
sudo mount /dev/cdrom /media
cd /media
sudo ./VBoxLinuxAdditions.run
sudo reboot
```

#### Ubuntu Server

```bash
# Assuming you are using VirtualBox 7.x and you have inserted 
# the VirtualBox Guest editons iso (under Devices)
sudo apt update
sudo apt install build-essential dkms linux-headers-$(uname -r)
sudo mount /dev/sr0 /media
cd /media
sudo ./VBoxLinuxAdditions.run
sudo reboot
```

#### Debian

```bash
# Assuming you are using VirtualBox 7.x and you have inserted 
# the VirtualBox Guest editons iso (under Devices)
su - root
apt update
apt install build-essential dkms linux-headers-$(uname -r)
cd /media/cdrom0
./VBoxLinuxAdditions.run
reboot
```

#### Red Hat based Fedora, AlmaLinux, Rocky Linux

```bash
# Assuming you are using VirtualBox 7.x and you have inserted 
# the VirtualBox Guest editons iso (under Devices)
sudo dnf update kernel*
sudo reboot
sudo dnf install -y gcc gcc-c++-x86_64-linux-gnu kernel-devel kernel-headers make bzip2
sudo dnf install -y perl
cd /run/media/cdrom/VBox_GAs_7*
sudo ./VBoxLinuxAdditions.run
sudo reboot
```

#### Manjaro and Arch Linux

```bash
# Assuming you are using VirtualBox 7.x and you have inserted 
# the VirtualBox Guest editons iso (under Devices)
#(find your kernel version)
sudo mhwd-kernel -li 
# XX is your kernel version
# Current Manjaro Kernel will report: linux61
sudo pacman -S linuxXX-headers
sudo mount -r /dev/cdrom /mnt
cd /mnt
sudo ./VBoxLinuxAdditions.run
sudo reboot
```
[^22]

#### OpenSUSE

```bash
# Assuming you are using VirtualBox 7.x and you have inserted 
# the VirtualBox Guest editons iso (under Devices)
sudo zypper refresh
sudo zypper update
sudo zypper in kernel-devel gcc make
cd /run/media/linuxconfig/VBox_GAs_7*
sudo ./VBoxLinuxAdditions.run
```
[^ch03f114]

If successful you can reboot the Linux guest VM and you will notice the changes take place immediately. If some of these commands are not familiar that is ok - we will cover them all in later chapters. Without these additional tools installed you will receive an error message similar to this:

```Building the main Guest Additions Module[Failed]```

### VirtualBox Features

If you are using Windows, Mac, or Linux you need to download the appropriate version from the VirtualBox homepage. Version 6.x.x is the [current version](https://www.virtualbox.org/wiki/Downloads "Latest VirtualBox").

[*Feature List for VirtualBox*](https://www.virtualbox.org/manual/ch01.html#virtintro "Feature List")

* Guest multiprocessing (SMP)
* USB device support
* Seamless windowing
* Shared folders
* Hardware compatibility
* Full ACPI support
* Multiscreen resolutions
* Built-in iSCSI support
* PXE Network boot
* Remote machine display
* Video and screenshot capture within virtual machines

## Chapter Conclusions and Review

Through this chapter we gained an understanding of what x86-based virtualization does. We learned about the purpose of a hypervisor and how opensource tools such as VirtualBox provide these services. We learned how to install Ubuntu and Fedora based distros in the most common scenarios. We learned about VirtualBox features and how to install Linux.

### Review Questions

1.  What is the term for the industry standard file format that is used to install a Linux distro?
    a.  ISO
    b.  ZIP
    c.  Disk-ISO
    d.  Distro
1.  What is the name of recommended tool used to create bootable Linux install media?
    a.  Pendrive Linux
    b.  etcher.io
    c.  UNetbootin
    d.  Image Magick
1.  What is the technology that is inserted between ring 1 and ring 0 that enables virtualization?
    a.  Linux
    b.  Windows Subsystem for Linux
    c.  Rings
    d.  Hypervisor
1.  What is the operating system that the hypervisor resides on called?
    a.  Host OS
    b.  Guest OS
    c.  HyperOS
    d.  Linux
1.  Hosted or desktop virtualization is called what type of hypervisor?
    a.  Type I
    b.  Type II
    c.  vt-x
    d.  amd-v
1.  Bare Metal or Native Virtualization is called what type of hypervisor?
    a.  Type I
    b.  Type II
    c.  vt-x
    d.  amd-v
1.  Each Linux installation distro provides a mechanism to compare what you downloaded with what you expected to download, what is that called?
    a.  mount point
    b.  checksum
    c.  receipt
    d.  mdsum
1.  What is the name of the driver package you can install in VirtualBox in order to enable features such as shared clipboard, larger screen resolution, and mouse pointer integration?
    a.  Kernel modules
    b.  Kernel drivers
    c.  VirtualBox guest additions
    d.  ISO extensions
1.  What is the name for a Linux distribution that runs in memory?
    a.  Rapid CD
    b.  Live ISO
    c.  Install Disk
    d.  Trick question
1.  What feature doesn't dpkg handle/support?
    a.  Removing software
    b.  Installing dependencies
    c.  Versioning
    d.  Author Information
1.  Which distro supports the .deb package?
    a.  Ubuntu only
    b.  Debian Family
    c.  Debian and Red Hat
    d.  None of the above
1.  Which distro supports RPM packages?
    a.  Red Hat Clones
    b.  Red Hat Family
    c.  Debian and Red Hat
    d.  None of the above
1.  Describe the purpose of VirtualBox Guest Additions?
    a.  They optimize the host operating system for better performance and usability
    b.  They optimize the guest operating system for better performance and usability
    c.  They optimize the Linux operating system for better performance and usability
    d.  They optimize the Windows operating system for better performance and usability
1.  What is the RPM command to install a package from the command line?
    a.  `rpm -qa *.rpm`
    b.  `rpm install *.rpm`
    c.  `rpm -q *.rpm`
    d.  `rpm -i *.rpm`
1.  After building software from source and running the `./configure` command, what is the next step?
    a.  Run the `make install` command
    b.  Run the `sudo make install` command
    c.  Run the `install` command
    d.  Run the `make` command
1.  What is the name of the new package managers developed by Canonical, makers of Ubuntu?
    a.   flatpak
    b.   snap
    c.   snapcraft
    d.   dnf
1.  What is the name of the new package managers developed by Red Hat?
    a.   flatpak
    b.   snap
    c.   flatter
    d.   apt
1.  What is the name of the Python package manager?
    a.  apt
    b.  pipe
    c.  pip
    d.  dnf
1.  Ubuntu Linux is part of which of the two main Linux families discussed in the chapter?
    a.  Red Hat
    b.  Suse
    c.  Linux
    d.  Debian
1.  Approximately which year was the Debian distribution started?
    a.  1991
    b.  1994
    c.  2004
    d.  2000
1.  What is the name of the location where package managers retrieve software packages from?
    a.  URLs
    b.  Links
    c.  repos
    d.  snaps
1.  When you install an operating system using Virtualbox, how is that operating system referred to?
    a.  Host machine
    b.  Guest OS
    c.  Virtual machine
    d.  Linux machine
1.  What is the name of the package repository most often used with Flatpaks?
    a.  GitHub
    b.  Flathub
    c.  RPM
    d.  APT
1. What is the name of the third party package system that allows for standalone package management?
    a. Flatpaks
    b. Zips
    c. Snaps
    d. AppImage

### Podcast Questions

Watch the YouTube video [Virtual Machines explained in 15 Mins](https://www.youtube.com/watch?v=mQP0wqNT_DI "Virtual Machines explained in 15 Mins by Nana") and answer these questions below.

* ~0:34 - Who is Nana?
* ~2:19 - What is the thing that allows hosting multiple virtual computers on a single physical computer?
* ~2:31 - What is one of the most popular Hypervisors?
* ~2:33 - Who owns this software?
* ~2:40 - Which operating systems does Virtualbox work on?
* ~3:41 - Hardware resources between host and guest operating systems are what?
* ~4:05 - Due to virtualization, the virtual machine thinks that it is a what?
* ~4:56 - 6:08 - Briefly describe the two uses of virtual machines mentioned.
* ~7:00 - Describe a Type II hypervisor
* ~7:50 - Describe a Type I hypervisor
* ~8:13 - What is another name for a Type I hypervisor
* ~8:32 - What are two examples of a Type I hypervisor
* ~9:25 - When you create a Virtual Machine on a cloud provider, what type of hypervisor are you using?
* ~11:33 - Why are companies adopting Virtualization?
* ~12:24 - Without virtualization an OS is what?
* ~14:10 - What is a virtual machine snapshot?
* ~14:40 - What are the three advantages listed in the video about using virtualization?
* ~15:08 - What are the four jobs listed that will be working with virtual machines?

### Lab

This lab has three parts that need to be completed. Use the provided template for submitting your screenshots as part of the deliverable.

#### Objectives

* Explore installing multiple industry standard Linux distros

#### Outcomes

At the conclusion of this lab you will have installed ~10-20 Linux based operating system distributions (distros) as Virtual Machines. You will have explored the major paradigms of the two major Linux distro families. You will have mastered the installation process and been exposed to various Linux distro paradigms.

### Virtual Machine Creation - part I

Following the demonstrations in section 3.6.3 and the installation information in section 3.6.1, you will need to find the download links for the Linux and BSD ISOs listed. You will need to install the latest version of [VirtualBox 7.x](https://virtualbox.org "VirtualBox Download site") in order to complete this exercise; it can be installed via Chocolatey or Brew package managers as well. If you are using an M1 Mac, you will need to purchase a copy of a comparable software called [Parallels Virtualization for Apple Silicon Macs](https://www.parallels.com/ "Parallels virtualization for M1 Mac").

Complete each install fully and then using the correct package manager install the program `neofetch` and take a screenshot of the results. There are 15 different distributions listed for Intel based x86 Windows and Macs. There are 11 different distributions listed for M-series Mac Hardware. If a version number is not listed, assume the latest version.

#### Parallels

If you are using `Parallels` complete the neccesary installs and adjust VirtualBox deliverables where appropriate.

#### Screenshots

For those using x86_64 Intel Windows and Macs install the following ISOs, install the package `neofetch` via the package maanger and take a screenshot of the results adding them to the document below each unit.

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

### Compile Apache Web Server - part II

Let's compile something to see how this works. This link is to the Apache webserver version 2.4.x latest source code: [http://httpd.apache.org/docs/2.4/install.html](http://httpd.apache.org/docs/2.4/install.html "Apache Webserver Instructions"). Let's install some pre-requisites:

```bash
# Pre-reqs needed first -- assumuing Ubuntu 20.04
sudo apt install build-essential libapr1 libapr1-dev libaprutil1 \
libaprutil1-dev libpcre3 libpcre3-dev
# Command to retrieve the source code
wget https://dlcdn.apache.org/httpd/httpd-2.4.63.tar.gz
# Command to unzip the source code
tar -xvzf httpd-2.4.63
# command to change directory to extracted source code
cd httpd-2.4.63
# commands to build
./configure
make
sudo make install
sudo /usr/local/apache2/bin/apachectl -k start
```

Now open a web browser in the virtual machine and navigate to http://127.0.0.1 and you should see the message: "It Works!" Take a Screenshot of these results.

### Compile Ladybird webbrowser - part III

This one is a bit more complex, but there is a new funded opensource browser called: [Ladybird](https://ladybird.org/ "ladybird browser site"). This is a new idea to break the browser duopoly we currently have, and bring back browsers to be what they were designed to do, browse, not be an add platform. Ladybird is in alpha so expect some bugs but you can compile it.

* Clone the current source code into an Ubuntu desktop VM
  * See [https://github.com/LadybirdBrowser/ladybird](https://github.com/LadybirdBrowser/ladybird "github source code repo")
  * Install the package for `git` via the `apt` package manager
  * Issue the `git clone https://github.com/LadybirdBrowser/ladybird.git` command
* Follow the [build instructions](https://github.com/LadybirdBrowser/ladybird/blob/master/Documentation/BuildInstructionsLadybird.md "ladybird browser build instructions")
  * Make sure to install all required Ubuntu dependencies
  * `cd` into the `ladybird` directory
  * Issue the `./Meta/ladybird.sh run ladybird` command to begin compile and running

**Deliverable:** Take a screenshot of the compiled browser with iit.edu open

#### Troubleshooting

Pay attention to error messages and scan through them and a little back for a hint. Usually a certain package/library is missing and is required to be installed.

#### Footnotes

[^19]: <a title="wikipedia:User:Hertzsprung" class="extiw" href="//en.wikipedia.org/wiki/User:Hertzsprung">Hertzsprung</a> at <a title="wikipedia:" class="extiw" href="//en.wikipedia.org/wiki/">English Wikipedia</a> [<a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a>, <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a> or <a href="http://creativecommons.org/licenses/by-sa/2.5-2.0-1.0">CC BY-SA 2.5-2.0-1.0</a>], <a href="https://commons.wikimedia.org/wiki/File%3APriv_rings.svg">via Wikimedia Commons</a>

[^20]: <a href="https://commons.wikimedia.org/wiki/File:Hardware_Virtualization.JPG" title="via Wikimedia Commons">Kwesterh</a>

[^21]: By Scsami (Own work) [CC0], via Wikimedia Commons" <a href="https://commons.wikimedia.org/wiki/File%3AHyperviseur.png">https://commons.wikimedia.org/wiki/File%3AHyperviseur.png</a>

[^22]: <a href="https://techviewleo.com/install-virtualbox-guest-additions-on-manjaro-linux/">How to install Virtual Box Guest Additions on Manjaro Linux</a>

[^105]: [https://en.wikipedia.org/wiki/Stuart_Feldman](https://en.wikipedia.org/wiki/Stuart_Feldman)  

[^106]: [https://en.wikipedia.org/wiki/Make_(software)](https://en.wikipedia.org/wiki/Make_\(software\))  

[^107]: [https://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics](https://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics)  

[^108]: [https://wiki.debian.org/Apt](https://wiki.debian.org/Apt)  

[^109]: [http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them](http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them)  

[^110]: [http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them/40351#40351](http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them/40351#40351)

[^111]: [https://en.wikipedia.org/wiki/Linux-libre](https://en.wikipedia.org/wiki/Linux-libre)  

[^112]: [https://launchpad.net/~linux-libre/+archive/ubuntu/ppa](https://launchpad.net/~linux-libre/+archive/ubuntu/ppa)  

[^113]: [https://wiki.debian.org/RPM](https://wiki.debian.org/RPM)  

[^ch03f114]: [https://linuxconfig.org/install-virtualbox-guest-additions-on-opensuse](https://linuxconfig.org/install-virtualbox-guest-additions-on-opensuse "web article for installing VBox Guest Additions on openSUSE")
