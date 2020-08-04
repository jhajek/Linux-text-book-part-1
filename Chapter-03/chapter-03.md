# Hardware and Installation
![*Must be a Linux User...*](images/Chapter-Header/Chapter-03/surgery.png  "Understanding the Technology and Philosophy of Unix/Linux")

## Objectives

* Understand and know how to complete the Linux and BSD Operating System Install Process for the major distributions
* Be able to compare and contrast the two major Linux distribution families' install processes with the BSD install process
* Understand the term *distribution* and *distro*
* Understand the standard installation formats, full ISOs, minimal install ISOs, and net-installer ISOs and the different
* Understand how to use industry standard virtualization platforms for installing distributions
* Learn the features of dnf, yum, and apt to install packages and dependencies in Linux
* Understand how to use GNU tools gcc and make for compiling source code
* Understand how to use the Python language interpreter in order to run Python-based install scripts
* Compiling code from source

## Outcomes

At the end of this chapter you will understand how to complete multiple installations of all the major Linux and BSD platforms.  You will be comfortable using the industry standard virtualization platform to enable rapid install of these operating systems.  You will also be familiar with and be able to differentiate between processor architectures available. You will be able to install packages and manage dependencies through using standard package managers dnf, yum, and apt.  You will also be comfortable compiling software from source using a tar ball and python setup tools.

## Installation of a Linux Distribution

The byproduct of opensource and free software is that the actual source code is freely available.  You can download almost all of the major Linux and BSD operating systems at no cost, because of the GPL.  This makes the barrier to entry using a Linux distro very small. As noted previously, in the early days of Linux, installation was not very user friendly. Over the past two decades, however, the various distros have perfected software packaging and installation has since become very simple and extremely user friendly.  Later in this chapter, we will install various distributions as part of the lab assignment.

How would one install a Linux distro on a computer?  The first thing you need is an *ISO*. An [ISO (*"eye-so"*)](https://en.wikipedia.org/wiki/ISO_9660 "ISO 9600 standard") file is actually a standard file type that represents the contents of a CD/DVD-ROM in a single archived file format, like a zip file.  Think of ISOs as carrying mechanisms for the content of a disk based installer.  The reason the ISO term and format are tied to the Linux Distro installation process is a historical one.  During the mid 90s Linux rose to prominence at the same time as CD-ROM technology began to become affordable and became the method of data distribution that replaced floppy and Zip disks amongst PCs.  It made sense to create distributions that were almost the exact size of a CD-ROM because it made distributing and copying very easy Linux very easy. In this way Linux spread rapidly.

ISO files can be burned or written to various types of media.  CD-ROMs, DVD-ROMs, and more recently USB drives and SD Cards. As of August 2018 you would be hard pressed to find an optical drive on a laptop, 2-in-1s, or even a desktop PC. Though many older and still usable PCs have optical drives.  One of the best tools I have found for creating bootable install media on USB drives or SD Cards is [etcher.io](https://etcher.io/ "Etcher").

![*Etcher init screen*](images/Chapter-03/etcher/etcher-io.png "Etcher")

### Importance of ISOs

This tools takes away the difficulty out of making install media.  You may hear the term *"burn"* used in relation to ISOs, all this means is to transfer or write data from one source to its extracted final source.

While you can burn ISO files to media for installation on a desktop or laptop, ISO files also have utility for installing a Linux distribution into a virtualization platform.

## Virtual Machines

Every operating system is made up of multiple components as we mentioned in chapter 2.  These components are separated by privilege rings. These rings are for process privilege separation and are builtin security for the operating system. With the higher numbered rings being the least privileged. Traditionally user applications are in ring 4 (sometimes called ["*userland*" or *"user space"*](https://en.wikipedia.org/wiki/User_space "user space") and the kernel which has the most power is in ring 0.  For instance a program a user writes cannot just talk directly to the video card and write to the video memory for the screen.  The program needs to go through the OS which in turn goes through the kernel allowing or enforcing commands to be executed.  How then does virtualization fit in? Virtualization or called a [hypervisor](https://en.wikipedia.org/wiki/Hypervisor "Hypervisor") is a new ring that inserts itself between the OS and the kernel to intercept commands and is called ring -1.

### One Ring to Rule Them All...Operating System Rings

![*Operating System Rings*](images/Chapter-03/Hypervisor/500px-Priv_rings.svg.png "One Ring")

Virtualization works because your x86 CPU (AMD and Intel) enables it at the CPU[^19].  To do this, AMD and Intel introduced extensions, [VT-x and AMD-V](https://en.wikipedia.org/wiki/X86_virtualization#Intel_virtualization_.28VT-x.29 "x86 virtualization") (called Pacifica), to assist virtualization. Both instruction sets added "nine new machine code instructions that only work at 'Ring -1,' intended to be used by the hypervisor" ([Andy Dorman - Informationweek](http://web.archive.org/web/20130530214041/http://www.informationweek.com/intel-vt-vs-amd-pacifica/172302134 "x86 extensions")).  When using virtualization, you are functionally running multiple operating systems at one time.  Technically this is not possible as only one operating system can have control of your hardware at a time - so how does a hypervisor and virtualization make this work?  

### Virtualization Diagram

![*Virtualization Diagram*](images/Chapter-03/Hypervisor/640px-Hyper-V.png "Virtualization Diagram")

By having the hypervisor intercepting system calls from the virtualized operating system this allows for multiple operating systems to co-exist on one computer unaware of each other[^20].  The way a hypervisor works is not unlike having a professional translator at a business meeting translating between two attendees.  The hypervisor essentially creates two classes of operating systems.  The "*host*" and potentially multiple "*guests*".  The *"guest"* operating system thinks it has complete control of the hardware - but the virtualization software is only showing the guest system a small portion of all the total RAM, CPU, and disk space available.  The hypervisor offers a *"virtualized kernel and drivers"* to the guest operating system.  In turn, the hypervisor translates the system commands to the kernel it has received and translates them to the host operating systems commands.  

For example if we were running an Ubuntu 14.04.5 Desktop virtualized guest system on a Windows 10 host, the Linux desktop has no way of knowing how to issue a command to use the network card to request a website because Linux knows its own OS and kernel and Windows is a completely different kernel and operating system.  The virtualization layer will do the translation for you -- allowing the *"host"* system to think that your guest virtualized operating system is nothing more than a native application, and allowing your guest virtualized operating system to think that it owns the entire set of hardware.  

The main concept of virtualization you need to know is that your computer (PC, laptop, Mac) has vastly more power then is needed most of the time. The benefit of virtualization is that a hypervisor can act as a translator for multiple operating systems running simultaneously on one system.  Thereby maximizing the usage of your resources and preventing you from needing 4 or 5 different physical PCs.  See Chapter 14-15 for application and development uses of Virtualization.

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

Until 2013 Parallels Desktop was a direct competitor to VMware Workstation on the desktop of Windows and Linux. As of 2013 those products were discontinued in favor of Parallels focusing their desktop product on the Mac.  

#### Windows Subsystem for Linux 2

"WSL 2 uses the latest and greatest in virtualization technology to run its Linux kernel inside of a lightweight utility virtual machine (VM). However, WSL 2 will NOT be a traditional VM experience. When you think of a VM, you probably think of something that is slow to boot up, exists in a very isolated environment, consumes lots of computer resources and requires your time to manage it. WSL 2 does not have these attributes. It will still give the remarkable benefits of WSL 1: High levels of integration between Windows and Linux, extremely fast boot times, small resource footprint, and best of all will require no VM configuration or management."  [https://devblogs.microsoft.com/commandline/announcing-wsl-2/](https://devblogs.microsoft.com/commandline/announcing-wsl-2/ "WSL 2").

### TYPE I Hypervisor - Bare Metal or Native Virtualization

TYPE I is used in server environments on hardware utilizing multiple core CPUs, multiple terabytes of RAM, and multiple terabytes of hard drive space.  A TYPE I hypervisor includes a kernel and tiny purpose driven mini-operating system tuned just for managing and interfacing with virtual machines.  The kernel itself is the hypervisor also tuned with all unnecessary features removed.  This book will not cover TYPE I hypervisors or commercial implementations of them.

* [Microsoft Hyper-V](https://technet.microsoft.com/en-us/library/hh831531.aspx "Hyper-V")
* [VMware ESXi](http://www.vmware.com/products/vsphere-hypervisor/ "vSphere")
* [KVM](https://www.linux-kvm.org/page/Main_Page "KVM homepage")
* [XEN](https://xenproject.org/ "Xen Project")

## Installations and ISOs

Now that we covered a bit about what a hypervisor is, let us begin the install process using VirtualBox.  The next pages are going to show you in comparison how to install the latest version of [Fedora Workstation](https://getfedora.org/ "Fedora Workstation") and latest [Ubuntu (LTS)](https://wiki.ubuntu.com/LTS "Ubuntu Long Term Support Link").  This will require you to download two ISOs from their respective download sites. For this install process we will assume that you are using VirtualBox version 5.1.x or later branch.   It might be a good exercise if you have an old laptop or PC laying around to make some installable media (CR-ROM or Flash drive via Etcher) and install one of these distributions directly as the primary operating system.  Finding old laptops is easier than you might think. Try asking your relatives (especially around back-to-school and Christmas), a company you work for, or even a school you go to. Laptops/desktops can have a second life and can still be useful to experiment with Linux installations even if the hardware is not the latest or greatest.  Another option to consider is dual-booting or triple-booting your system, we will not cover that option here.  

If you do try it, back up your data first, you never know what could go wrong. I created a [quad-boot system](https://forge.sat.iit.edu/2015/05/quad-boot-your-pc-ubuntu-15-04-centos-6-6-fedora-21-windows-10/ "Quad Boot") containing Ubuntu, Fedora, CentOS, and Windows 10.  This processes is beyond the scope of this book but the link is provided for those interested.

You also need to be aware of the type of architecture you are installing to. In the past we had to determine if the CPU was   32-bit or 64-bit?  In modern Linux distros, 32-bit distros are going away because of the lack of 32 bit chips being produced.  You can find information about your processor by going to [http://ark.intel.com](http://ark.intel.com] "ARK"). This is Intel's clearing house for all its information about processors and motherboards.  They can tell you all you want to know about a processor.  All but the most specialized or low end chip these days is 64-bit you should be safe with that type of distro.  

The 32-bit distro is most commonly referred to as the x86 or 586, 686 architecture.  The 64-bit architecture is usually referred to as x64, but sometimes *x86_64*, and even *AMD_64*, that is not a reference to AMD processors - just a credit in the name as AMD was the first company to implement 64-bit extensions to the 32-bit x86 instruction set--hence the credit.  There is one other type of architecture called ARM or AARCH, AARCH64.  This is the ARM architecture that runs phones, tablets, and small embedded systems such as the Raspberry Pi.  It has an entirely different instruction set so the software compiled for this architecture is not compatible with the Intel x86-x64 architecture.  

Each distro also has a checksum feature provided by the site that issues the download.  A checksum is a one way mathematical function that gives you a unique representation of what the content of the ISO should be.  That way if you download an ISO from somewhere and the checksum is different then you might be alerted to someone trying to add additional contents or perhaps just a corrupted download.  Most distros use the SHA-256 hash, but for legacy purposes you still see md5 hashes.

### Links to get you started

* [Get Fedora](https://getfedora.org "Get Fedora")
  * [Fedora checksum page for Linux and Mac](https://getfedora.org/en/verify "Verify")
* [Get Ubuntu](https://ubuntu.com "ubuntu")
  * [Ubuntu checksum page](https://help.ubuntu.com/community/UbuntuHashes "Ubuntu Hashes")
  * [Microsoft Powershell hash checking functions](http://technet.microsoft.com/en-us/library/dn520872.aspx "Powershell Hash checking function")
* [Linux Distro Mirrors](https://mirrors.kernel.org "Linux Distro Mirrors")
* [Get VirtualBox](http://virtualbox.org "VirtualBox")

Here are the commands to execute in Windows in Powershell:

```powershell
Get-FileHash .\ubuntu-18.04.2-desktop-amd64.iso -Algorithm MD5 | format-list
```

Output: ```69809DC7E058B81BC781FE3E24D3204F```

```powershell
Get-FileHash .\ubuntu-18.04.2-desktop-amd64.iso -Algorithm SHA256 | format-list
```

Output: ```22580B9F3B186CC66818E60F44C46F795D708A1AD86B9225C458413B638459C4```

---

Here are the checksum commands and output to be executed if you are running on an already installed version of Linux or Mac OSX from the terminal:

```bash
md5sum ./Fedora-Workstation-Live-x86_64-30-1.2.iso
```

Output: ```94c63f564a81d3450d1c606bfe5d0327```

```bash
sha256sum ./Fedora-Workstation-Live-x86_64-30-1.2.iso
```

Output: ```a4e2c49368860887f1cc1166b0613232d4d5de6b46f29c9756bc7cfd5e13f39f```

Can you find the MD5 and SHA-256 of the sample PDF lolcated in the book source code, in the folder ```files -> Chapter-03 -> Understanding-Free-and-Opensource-Operating-Systems-Part-I-sample.pdf```?

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
  * Developer platform?
  * Server edition (no gui)
  * Building Clusters, Cloud Computing, Serverless Computing, Virtual Machine farms
* What processor do I have, 32-bit, 64-bit, ARM?  How much RAM do I have or need?
* Is this an old PC or laptop I am using--does it lack processor extensions that can aid in rendering media efficiently?
  * [SSE](https://en.wikipedia.org/wiki/Streaming_SIMD_Extensions "SSE")
  * [AVX](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions "AVX")
* Licensing for business?
  * Does it need to be GPL compliant?
  * Can proprietary programs and codecs be included?

### Create Your First Guest Virtual Machine

Upon completion of a fresh install and launching of VirtualBox you should see this image:

![*VirtualBox fresh install*](images/Chapter-03/virtulabox-fresh-install-550.png "Fresh VirtualBox install")

See the [getting started manual](https://www.virtualbox.org/manual/ch01.html "Getting started manual") for a wide range of information.  Unlike some opensource projects this documentation is actually very thorough and useful.  VirtualBox has a list of [supported host operating systems](https://www.virtualbox.org/manual/ch01.html#hostossupport "Supported Host Operating System"), which is basically any operating system you can think of from DOS to Haiku to FreeBSD.

Let us walk through the initial installation process.  The first step to begin is with the *NEW* button.  The next step is where we give our guest virtual machine a name.  VirtualBox has long had support that if you type the type of the operating system in the system name - VirtualBox will auto detect the instance type and version.  If you see the sample below I typed "Ubuntu-18-04-Desktop" and "Fedora-30-workstation." As you type in the title that has the name in it VirtualBox will auto-detect and switch the type and version automatically.  

![*Create New Ubuntu Instance Dialog*](images/Chapter-03/VirtualBox-Install/virtualbox-name-and-operating-system-ubuntu.png "Create New Instance Dialog")

![*Create New Fedora Instance Dialog*](images/Chapter-03/VirtualBox-Install/virtualbox-name-and-operating-system-fedora.png "Create New Instance Dialog")

What happens if you choose the wrong type or version?  Two things: __first__, if you chose the wrong edition of Linux most things will work but the virtualization layer will not be optimized, try to avoid it.  You can always go back into the *SETTINGS* menu option and change it after the virtual machine is powered off.  __Second__, if you select the wrong version, (32-bit instead of 64-bit) you will receive an error from the BIOS as the operating system loads explaining that it cannot continue.

Next is the amount of memory available - note that this memory is shared with your underlying OS as described with TYPE II hypervisors. Whatever you allocate to this guest VM will be unavailable to the underlying host OS while the guest VM is powered on. Note the slider, each system to install VirtualBox on will have a different slider based on the amount of memory you can allocate.  The recommended amount of memory is at least one gigabyte but more likely two gigabytes will be better.  You can also *"over-provision"* memory by making multiple virtual machines whose memory totals beyond your system's memory by not having them running all at once.

![*Memory Selection Dialog*](images/Chapter-03/VirtualBox-Install/virtualbox-memory-size.png "Memory Selection Dialog")

The next step is to select the amount of virtual hard drive allocation.  Here you have a choice of how much hard drive space you will allocate to the guest VM.  This space will be treated as a file by the underlying host OS--allowing for easy migration, export, and even cloning of the guest VM.  

![*Hard disk Allocation*](images/Chapter-03/VirtualBox-Install/virtualbox-file-location-and-size.png "Harddisk allocation")

Next is the hard drive file format.  There are a few competing standards.  If you know you are going to be working in the VirtualBox environment then the default VDI type is sufficient.  If you know you will be transferring this Virtual Machine to another environment: VMware (VMDK), and Microsoft Hyper-V (VHD) then you can choose the appropriate type.

![*Drive Type*](images/Chapter-03/VirtualBox-Install/virtualbox-hard-disk-file-type.png "Drive Type")

You can choose to dynamically allocate your hard drive space or statically allocate it.  The advantage of dynamically allocating is that not all the space will be assigned right away.  The hard drive will grow incrementally as you need space until it hits the maximum you defined.  The disadvantage of this is that if you are creating lots of data there will be an overhead processing in continually allocating space.  Statically allocating the hard drive space on the other hand will potentially lessen the number of systems that can go on your hard drive because potentially much space that is allocated is actually unused. Virtual hard drives for the guest OSes are treated as files from the point host OSes.

![*Disk Type*](images/Chapter-03/VirtualBox-Install/virtualbox-storage-on-physical-disk.png "Disk Type")

The final option dialog is where you can choose where to store your virtual machine's virtual hard drive. Usually the default is fine unless you know you need to store the hard drive on a separate partition or disk.   Also VirtualBox will make a suggestion on a recommended virtual hard drive size.

Now click *finish* and you should be ready to go.  

### Walk Through the Settings

![*Virtual Machine Settings*](images/Chapter-03/settings.png "Virtual Machine Settings")

Before we hit the start button - let us select one of our virtual machines and take a look at the content of the SETTINGS button.  Here we will find all the settings possible related to our virtual machine.  Though not entirely correct - you could think of this similar to a BIOS settings on a PC - and area where we can configure any underlying hardware.  The most common options you will deal with are described as follows:

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

Hitting the *START* button on your virtual machine install for Ubuntu 15.04 Desktop will bring you to a *WELCOME* screen.  Here you will be presented with the option to choose your install language.  As well as presented with two options:  *TRY UBUNTU* or *INSTALL UBUNTU*.  The option *TRY UBUNTU* will load the actual Ubuntu operating system but load it into RAM and not install it on your hard drive.  This is helpful because it gives you the option to use Ubuntu fully without permanently installing it.  Note that all data is stored in memory so nothing will survive a reboot - but this may be a good tool for doing online banking with.  The Live option also has the option to go into an install mode via a desktop icon.

![*Live or Install Mode*](images/Chapter-03/ubuntu-install/live-install-450.png "Live Install")

Under the *INSTALL* option Ubuntu will present you with multiple option tests that need to be passed before install.  Things such as enough available hard drive space, is your computer plugged into a power source, and do you have an internet connection?  In addition you will be prompted if you want to install proprietary codecs automatically during install?  

![*Preparing to Install*](images/Chapter-03/ubuntu-install/preparing-to-install-450.png "Preparing to Install")

This would include things such as Adobe Flash, codecs to playback MP3, and potentially proprietary AMD or NVIDEA graphics drivers.  Your choice and these can always be added later on demand.  The final option is to install updates while downloading - this will add time to the install but also save you from having to launch the update script upon first login.

For installation type you will be presented with default options such as *ERASE DISK AND INSTALL UBUNTU*.  In addition there are options for enabling full disk encryption for securing your install data.  The third option listed is to install using the LVM method of partitioning, which will be covered in chapter 12.  The fourth option is for a custom partitioning, which is helpful in cases when you are installing multiple operating systems and create a multi-boot system.  

![*Installation Type*](images/Chapter-03/ubuntu-install/installation-type-450.png "Installation Type")

At the completion of this dialog box you will be asked to confirm the automatically generated partitions created by the system.  A Linux system needs a minimum of 2 partitions to function but 3 are recommended.  Those partitions are / (pronounced root), /boot (where all the files needed to start the OS are located, and swap (which is an on disk based RAM supplement partition.  

![*Confirm Partitions*](images/Chapter-03/ubuntu-install/write-changes-to-the-disk-450.png "Confirm Partitions")

The next parts of the installation contain pretty straight-forward parts: time zone selection, keyboard layout, and account creation and password setup.  Note that Ubuntu doesn't create any root user by default, which ever user you create first is automatically placed into the ```sudo group``` -- which is similar to a super user.  For a discussion of password strength and strategies [see this cartoon](http://imgs.xkcd.com/comics/password_strength.png "Password Strength Argument"). You can also see the install details by clicking the small white triangle to reveal the verbose output of the process.  

![*Install Details*](images/Chapter-03/ubuntu-install/installing-system-tab.png "Install Details")

### Installing Fedora

Similarly on Fedora 26 you will be presented with the option to *Start Fedora Live* or go into troubleshooting mode.  You will be presented with an install screen similar above: *TRY FEDORA* or *INSTALL TO HARD DRIVE*. Fedora 26 will initially present you with a language screen option.  After choosing your default language the next step is the *installation summary*.

![*Installation Summary*](images/Chapter-03/fedora-install/installation-summary-800-by-200.png "Installation Summary")

You will note 4 categories: keyboard, time and date, network and hostname, and installation destination.  The first three options should all be filled out by default, the last option installation destination will have an orange notification icon next to it.  This means we need to double click on this section and enter a sub-menu before we can continue.  

![*Device Selection*](images/Chapter-03/fedora-install/device-selection-370-by-200.png "Device Selection")

This warning icon is a forcing mechanism to make you review these settings.  You will see visual icons of all the hard disks available for installation.  The one with a white checkmark is the disk where the __"/"__ (root) partition will be installed. If the default selections are satisfactory then you can click __DONE__ button at the top to the screen and continue.   Otherwise at the bottom of the screen are the detailed installation options, which include encryption, LVM, and external installation drives such as over iSCSI or NFS.

![*Specialized Details*](images/Chapter-03/fedora-install/specialized-disks-330-by-200.png "Specialized Details")

Now you can click "*begin installation*".

![*Begin Installation*](images/Chapter-03/fedora-install/begin-installation.png "Being Installation")

While the disk partitioner is running and the install process is beginning.  The next screen will prompt you to create a __root__ user password and also to create a non-root user account.  In the Unix/Linux world the __root__ user is akin to the administrator account in Windows, meaning you have all the power to do anything you want to the system.  So use __root__ account sparingly.  You notice a fundamental difference, Ubuntu will not even give you a __root__ account, they make you elevate your privileges, called __sudo__ each time.  Fedora *trusts* you and will give you the __root__ user, trusting you not to destroy the system.   In this case you need to give yourself a strong __root__  password and it is good practice to create a local non-root user account.  

![*User Accounts*](images/Chapter-03/fedora-install/user-settings-630-by-100.png "User Accounts")

Under the create user dialog box, you will notice a key check box that is circled in red below: *Make this user administrator*.  This allows your user account to be able to use the *sudo* command to elevate up to root user privileges.  This is considered far safer than using the __root__ user continually.  

![*Create User With Sudo*](images/Chapter-03/fedora-install/create-user-with-sudo-390-by-200.png "Create User With Sudo")

You can click the *Finish Install* button to complete the install.  You will be presented with a final *Quit* button which will exit the installer and drop you back into the *Live* desktop.  In order to reboot the system you need to open the system menu via the downwards facing white triangle in the upper right hand corner. The reboot icon is located under the traditional power icon.  Once restarted congratulations you have successfully installed and can begin using your installed Fedora 26 system.  

### VirtualBox Extensions

You may have noticed that when a guest VM is successfully installed the screen resolution may be very small and the mouse integration features are not working. By default VirtualBox doesn't know what your host systems underlying hardware is.  So it guesses by providing a lowest common denominator set of hardware drivers, usually for pretty old, but well known set of hardware.  In order to install higher quality drivers to enable more features VirtualBox provides something called *"guest additions"* to enable exclusive features that are not normally available in an operating system.  These features include things such as shared folders, cut and paste support, and even support for multiple monitors and higher resolutions.

VirtualBox Guest Additions can be installed by selecting an installed virtual machine and selecting the menu item under __DEVICES__ then select the "Insert Guest Additions CD Image."  For Windows and Mac as the guest VM OS this is a pretty straight forward install - the attached Guest Additions ISO appears within the VM and you simply double click it and run through the menu, reboot, and new features are added. For Linux you need to compile these extensions into the kernel and some extra tools are needed.

#### Package Managers for installing software

This goes for any distro that derive from Debian.  You will need to install the following from the commandline to assist with the compiling and installation of VirtualBox drivers.  In order to do this we will talk about the various features, tool, and processes of installing software.   Generally this is done via **package managers**.

## Package Managers

![*Always check the package dependencies...*](images/Chapter-03/package-managers/debian_main-2.png "Dependencies")

One of the initial claims against using Linux and Unix was that software install was a nightmare.  Software had been distributed in tarballs (\*.tar.gz) that were convenient but lacked any knowledge of system state. So you could compile source code but the code had no idea ahead of time if the proper software libraries were installed in the correct locations or if the proper versions of those libraries were installed. And each additional library had its own dependencies and those had dependencies too.  You see how this could get ugly quickly.  Initially there was a build system developed by a companion of Thompson and Ritchie's named Stuart Feldman; named ```make```. He was also an author of the first Fortran 77 compiler, and he was part of the original group at Bell Labs that created the Unix operating system. Feldman was the Vice President of Computer Science at IBM Research. He was also Vice President, Engineering, East Coast, at Google for a time [^105].  

Feldman realized building software was difficult and created the ```make``` build system.  The ```make``` system uses a file named ```makefile``` that includes instructions and ordered steps that can be repeated every time software is built.  This allows software to be portable across systems (in theory).  The utility ```make``` is the binary that automatically builds executable programs and libraries from source code by reading the *makefiles*[^106]. Here is an example  makefile:

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

Clear as mud right?  Like many things in the Unix world, the ```makefile``` system has been modified and augmented but still persists as the way software project are built and installed some 30 years later. Makefiles have an arcane syntax that few people enjoy and over the years ```make``` has been often rewritten.   In 1988 the GNU project had released their Free Software version of ```make``` called GNU Make or ```gmake```. GNU make is included in all standard Linux distributions and is even required for compiling the Linux Kernel.  There are other versions of ```make``` including the Unix version, ```pmake``` and ```bmake``` on the BSD Unix variants, there is a cross platform build tool called ```cmake``` and even Microsoft has its own build tool that can be used called ```nmake```.

### Package Managers

This style of software installation put a high barrier to who could practically use Unix/Linux.  Linux distributions took to making software installation and distribution easier by introducing something initially called __Package Managers__.  These were meant to eliminate all of the above process by solving two key problems. First it would solve the re-compilation of code and supporting of make and build tools--you technically wouldn't even need any C compiler or build tools installed.  Second package managers would solve the dependency issues by keeping track of the dependency trail and be smart enough to follow that trail before installation.

#### .deb

The first package manager was __dpkg__ which was created by Matt Welsh, Carl Streeter and Ian Murdock (founder of Debian) in 1994 as a replacement for an earlier primitive package manager.  The program ```dpkg``` is used to install, remove, and provide information about .deb packages.

A Debian package (or ```.deb``` file) is really just made up of two tarballs [^107].  One is the control data which is listed as such:

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

The most important line being the __Depends__ option which controls dependencies and can prevent installation if these conditions cannot be met.  The second component includes the binary or pre-compiled portion of the code.  Using ```dpkg``` is a clear step above using tarballs and compiling the code yourself. 

Recently with Oracle changing the nature of how Java is supported with the transition from Java 8 and 11 and into the future, concerned companies created their own OpenJDK for download that will be supported.  One such instance is [Amazon Corretto](https://aws.amazon.com/corretto/ "Amazon Corretto OpenJDK").  These releases are created in ```.deb``` packages.  Let's download one and install it using a simple command called ```wget``` or you can open a web browser and download the package and install it manually.   Click on the link and save the ```.deb``` file on Ubuntu. Now using the ```dpkg``` command we can install the package manually (note there may be an error message about a missing dependency).

> __Example Usage:__

```bash
# From the command line terminal after you have downloaded the file on a Debian based system:
wget java-1.8.0-amazon-corretto-jdk_8.222.10-1_amd64.deb
sudo dpkg -i ./java-1.8.0-amazon-corretto-jdk_8.222.10-1_amd64.deb
# This method will retrieve the .rpm file directly from the internet and pass it to the rpm command on CentOS or Red Hat systems.
sudo rpm -iv https://d3pxv6yz143wms.cloudfront.net/8.222.10.1/java-1.8.0-amazon-corretto-devel-1.8.0_222.b10-1.x86_64.rpm
```

You can download a .deb or .rpm file from the Vivaldi browser website: [https://vivaldi.com/download/](https://vivaldi.com/download/ "Vivaldi.com") Vivaldi is a new browser from the team that brought us Opera browser.  The packages are not available in APT or RPM, you download the .deb or .rpm. file directly and install through dpkg in Ubuntu's case. In the command below we will introduce the install command or the ```-i``` flag, which stands for __install__.

> __Example Usage:__  

```bash
sudo dpkg -i ./vivaldi-stable_2.6.1566.49-1_amd64.deb
sudo rpm -iv ./vivaldi-stable-2.6.1566.49-1.x86_64.rpm
```

After executing this command you will receive an error message. What is it telling you and why?  You will notice that dpkg found that it had a *dependency*, can you locate that *dependency* on [http://packages.ubuntu.com](http://packages.ubuntu.com "packages")?

__Example Usage:__

```bash
sudo dpkg -i ./links_2.8-2_amd64.deb
```

Note that this command installs properly without any error message. [http://packages.ubuntu.com/](http://packages.ubuntu.com/ "links")

__Example Usage:__   There are other flags but the most common are these:

* ```sudo dpkg -r or --remove```
* ```sudo dpkg -P or --purge```
* ```sudo dpkg -l or --list```
* ```sudo dpkg --status links```

__Example Usage:__ Let's use the ```dpkg``` command to list all kernel versions we have installed and the ```purge``` command to remove those old kernels entirely.  

```bash
sudo apt-get dist-upgrade
sudo dpkg -l | grep linux-image
# x.x.-xx is the version that is not the most recent version as deleting that will
# make your system unbootable.
# uname -a will tell you the current kernel version
sudo dpkg --purge linux-image-x.x.x-xx-generic

# Sometimes there are kernel dependencies and this command will fail
# In those cases you can use the command below to remove the old kernel images
# and free space on your /boot partition.

sudo apt-get remove linux-image-x.x.x-xx-generic
```

#### RPM

 A few years after dpkg became standard on Debian based distros, the Red Hat Linux created their own package manager out of necessity in 1998 and called it RPM (Originally Red Hat Package Manager - now known as RPM Package Manager.)  It is used across Fedora and RHEL derivatives.  RPM is also used on IBM's AIX Unix distribution.  RPM code and FAQ can be found at [http://rpm.opg](http://rpm.org "RPM.org") [^113].

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

Similar to the previous example let us download the Vivaldi RPM and install it locally.  [https://vivaldi.com/download/](https://vivaldi.com/download/ "Vivaldi.com").  After selecting the Vivaldi 64 bit rpm and using the ```-i``` flag to install it, what error message is printed?  

Let's try another rpm.  This one is a software called *denyhosts* this is a brute force banning tool that will lock out IP addresses that attempt to brute force connect to your server.  The rpm is located at [http://pkgs.repoforge.com/denyhosts](http://pkgs.repoforge.com/denyhosts "Denyhosts").  You can download the `denyhosts-2.6.5-el6.rf.noarch.rpm`.  When you run the rpm based installer what happens?  Why?

#### Installers

As you can see from above package managers were a great step forward in making Linux usable beyond the ranks of Thompson, Ritchie, and Stallman.  But they still don't handle the dependency issue--they don't understand the context of auto-dependency retrieval.  Various solutions were created but every Linux distro has pretty much settled on two families of Installers--those that match the major families.  Fedora based distros use Yum and now use DNF (as of Fedora 23) and Debian based distros use APT.  

### APT

Apt (for Advanced Package Tool) is a set of core tools inside Debian. Apt makes it possible to:

* Install applications
* Remove applications
* Keep your applications up to date

The APT installer was released in 1998, the same time that Red Hat released its package manager (giving Debian a leg up and a few years head-start).  APT was the out growth of a research project called *Deity* run by the Debian developers.  It was planned to be a large GUI-like project, but it turns out that the APT CLI was implemented with such finesse and simplicity that all GUI plans were dropped.  APT is mentioned as one of the key user based features for Debian based distros and Debian's founder Ian Murdock considers APT to be one of the best contributions of Linux [^108].  APT stands for the Advanced Packaging Toolkit.  APT will interface with *dpkg* and has many similar commands but extends the functionality of dpkg in a critical way.  

APT, which basically resolves dependency problems and retrieves the requested packages, works with dpkg under the hood. The main commands of APT are as follows:

* ```apt-get update``` -- used to make sure your system is pointed to the latest repository versions. You should always run this before taking any other actions.
* ```apt-get install``` -- used to install the application of choice
* ```apt-get remove``` -- used to remove the application of choice
* ```apt-cache search [pattern]``` -- used to search all your repositories for an app matching the given pattern
* ```apt-get upgrade``` -- used to perform an upgrade of all current packages that have updates available (note in Yum this is the command update)
* ```apt-get dist-upgrade``` -- this performs the same as the upgrade but will also update the kernel version and headers as well
* ```do-release-upgrade``` -- this will update the entire distribution and move it to the next incremental version (Ubuntu 18.04 to 18.10)

#### Repositories

APT relies on the concept of repositories in order to find software and resolve dependencies. For apt, a repository is a directory containing packages along with an index file. This can be specified as a networked or local based location. The Debian project keeps a central repository of over 25,000 software packages ready for download and installation.  This includes ability to add non-free software repositories as well.    You can add additional repositories via the ```add-apt-repository``` command.  This is used to add community maintained PPA's--which stand for *personal package archive.*  These are for packages maintained outside of Debian's rigorous package checking standards and 1 to 2 year release window. Hence the cartoon at the beginning of the chapter.  

The package system and architecture is on of the reasons for Debian's long standing existence and credibility.  The system just works. Ubuntu is a Debian derivative that utilizes this archive of packages.  Remember that the founder of Ubuntu, Mark Shuttleworth, had been a Debian contributor at one point. Ubuntu builds on top of Debian's 25,000 packages by maintaining additional *downstream* repositories that add additional software and repositories to make up the Ubuntu distribution.  Ubuntu is a little more liberal on including non-free drivers for mainly high-end video cards.  Users can then add additional repositories or PPA's of their own choosing to extend APT functionality and expand that package base.  

Seeing as you may want to access a more recent build of an application that may not be in the standard Debian/Ubuntu distribution or not even submitted to a repository because the version is moving too fast or the maintainer just didn't want to package it up.  For example if you want to install a newer version of the php language on your system, you have to wait for another version of the OS or you can find the maintainer's repository and add their PPA directly.  That way when you can update in real time with them or even install beta software. The example below will add the php5 latest repository for installation.  

You can manually edit the file ```/etc/apt/sources.list``` as well and enter PPAs manually.  Once a new PPA has been added you need to run ```sudo apt-get update``` so APT can see the new repositories and add them to it's cache.

> __Example Usage:__  Ubuntu 18.04.2 installs php 7.2 by default, but if you wanted to use or test php 7.3 you would need to add an additional repository or PPA to enable the php7.3 package to be installed. Try the below sequence:

```bash
sudo apt-get update
sudo apt-get install php7.3
# What happens after the above command?
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.3
php -v
```

> __Example Usage:__ There is an Apache2 repository (PPA) that can be added to get the latest version of Apache2.  Run the command ```apache2 -v```, then add this repository ```sudo add-apt-repository ppa:ondrej/apache2``` and ```sudo apt-get update```. Now execute ```sudo apt-get upgrade``` to upgrade the Apache server.  Now execute ```apache2 -v``` to show the new version.  

There is also a PPA for Linux-libre.  Linux-libre is a GNU package that is a modified version of the Linux kernel. The aim of the project is to remove from non-free or significantly obfuscated code[^111] from the Linux kernel. The downside of removing proprietary firmware from the kernel is that it will cause lose functionality for certain hardware that does not have a free software replacement available. This affects certain sound, video, TV tuner, and network (especially wireless) cards.

The resulting combination of the GNU Operating System and the kernel named Linux is the GNU+Linux operating system, although many (incorrectly) refer to it as ["Linux"](http://www.gnu.org/gnu/linux-and-gnu.html "GNU/Linux")[^112].

> __Example Usage:__ Let's set our kernel free... The full instructions are at this website:  [https://jxself.org/linux-libre/](https://jxself.org/linux-libre/ "Libre-Linux")  Once successful, reboot your system and/while holding down shift - you should see the menu in the image below appear. Choose *Advanced Options For Ubuntu* and you will see your GNU/Libre kernels.  Try to boot from one.

These are the short steps:

* To use this repository first add it to your system. Run this command:
  * ```sudo apt edit-sources```
* And add the line:
  * ```deb http://linux-libre.fsfla.org/pub/linux-libre/freesh/ freesh main```
* You should also fetch and install the GPG key with which the repository is signed:
  * ```wget https://jxself.org/gpg.inc```
* Check that it's the right key:
  * ```gpg --with-fingerprint gpg.inc```
* Make sure that you see:
  * ```Key fingerprint = F611 A908 FFA1 65C6 9958 4ED4 9D0D B31B 545A 3198```
* As long as it matches configure the package manager to trust the key and then delete the temporary copy:
  * ```sudo apt-key add gpg.inc```
* Now you will now be able to update your package manager and install Linux-libre:
  * ```sudo apt update```
  * ```sudo apt install linux-libre-5.2```
  * ```sudo apt install linux-libre```
  * ```sudo apt install linux-libre-lts```

![*Linux-Libre*](images/Chapter-03/linux-libre/kernel-linux-libre.png "libre.png")

Here is a list of all the configuration and cache files related to APT and their location:

* ```/etc/apt/sources.list```: Locations to fetch packages from.
* ```/etc/apt/sources.list.d/```: Additional source list fragments.
* ```/etc/apt/apt.conf```: APT configuration file.
* ```/etc/apt/apt.conf.d/```: APT configuration file fragments.
* ```/etc/apt/preferences```: version preferences file. This is where you would specify "pinning", i.e. a preference to get certain packages from a separate source or from a different version of a distribution.
* ```/var/cache/apt/archives/```: storage area for retrieved package files.
* ```/var/cache/apt/archives/partial/```: storage area for package files in transit.
* ```/var/lib/apt/lists/```: storage area for state information for each package resource specified in sources.list
* ```/var/lib/apt/lists/partial/```: storage area for state information in transit.

### yum & dnf

Fedora based Linux is in a bit of a transition. Its enterprise products RHEL and CentOS are still using the YUM installer.  Fedora 22 and 23 still have YUM for backward support but have moved to using DNF to handle the installation of packages and dependency resolution.  YUM is supported in Fedora 22 but now deprecated and DNF is the preferred installer, with YUM to be removed down the line. RPM based distros had used a tool called ```up2date``` prior to 2003.  An opensource tool from a distro called Yellow Dog Linux lead to the creation of YUP (Yellow Dog Updater) which was then improved to become YUM (Yellow Dog Updater Modified) by the year 2003 and by 2005 every distro using RPM had moved to YUM.  Yellow Dog Linux was first released in the spring of 1999 for the Apple Macintosh PowerPC-based computers and continues today as a Linux for high-end POWER7 workstations. A successor to YUM is named DNF which somehow stands for *dandified yum*. It was released in Fedora 18 and is quickly becoming the Fedora package manager of choice.  YUM is still available on RHEL and CentOS but as companies move to the version 7 platform, this will begin to change too. Yum will be eventually replaced by DNF.  Both YUM and DNF use repositories that are maintained by Red Hat or CentOS or even their RHEL repos.

You can find the installed repositories in ```/etc/yum.repos.d```.  Each file listed will contain information about the URL where it retrieves repos.  There is also an ability to set priorities as to which repo is checked first.  As we did in previous chapters, we added RPM repos.  The most famous package for adding additional software is RPMForge, [http://rpmfusion.org/](http://rpmfusion.org/ "RPMForge").  Taken directly from their website, *"RPMFusion ships packages that Fedora and Red Hat don't want to ship standard with their distro."* This includes free software as well as non-free software that cannot be shipped due to the GPL nature of Fedora.  

![*Installed Repositories Fedora 30*](images/Chapter-03/yum/etc-yum.png "YUM")

[FFmpeg](https://en.wikipedia.org/wiki/FFmpeg "FFMpeg") is a free software project, the product of which is a vast software suite of libraries and programs for handling video, audio, and other multimedia files and streams.   If we try to install it via ```sudo dnf install ffmpeg``` we get this message, why?  

![*Unable to Find a Match*](images/Chapter-03/yum/unable.png "Unable to find a match")

First we want to check if we have the correct RPM name.  We can search through our repos looking for the name by typing the ```sudo dnf search [fF]mpeg*``` command.  This will return two results--the package and a related dependency and watch out, RPM also tends to be case-sensitive.

To enable the download the RPMFusion repos for adding additional software of free and non-free type you can type the following commands:

```bash
sudo dnf install http://download1.rpmfusion.org/free/fedora/\
rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
```

```bash
sudo dnf install http://download1.rpmfusion.org/nonfree/fedora/\
rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

Note for RHEL/CentOS the installation URL is slightly different:

```bash
sudo yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/el/updates/7/x86_64/r/rpmfusion-free-release-7-4.noarch.rpm
sudo yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-30.noarch.rpm
```

```bash
sudo yum install http://download1.rpmfusion.org/free/el/updates/7/x86_64/r/rpmfusion-free-release-7-4.noarch.rpm
sudo yum install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-30.noarch.rpm
```

If you are using CentOS or RHEL you need to first install the **EL-Repo** before the RPMFusion, but not for Fedora.  No it isn't Spanish for *"the repo"*, but stands for Enterprise Linux Repo--located at [http://elrepo.org/tiki/tiki-index.php](http://elrepo.org/tiki/tiki-index.php "El-repo").  The ELRepo Project focuses on hardware related packages to enhance your experience with Enterprise Linux. This includes filesystem drivers, graphics drivers, network drivers, sound drivers, webcam and video drivers.  This book will not focus on the RHEL update and RPM repos but I wanted to make you aware of it.  

Once those RPMFusion repos have been added you can now retry the example above and install, FFMpeg, Denyhosts, and Links.  Unlike Ubuntu and Debian where we need to update the repositories - DNF and YUM will auto handle that.
\newpage

> __Example Usage:__ You can install additional packages now that you have the RPMFusion repos added.  Try to install links the webbrowser that failed when we tried to install it.  The command is ```sudo dnf install links```.  The command ```sudo dnf remove links``` will uninstall it.  The command ```sudo dnf upgrade``` will upgrade all packages that have updates pending.  You can now use DNF to [upgrade your system](http://fedoraproject.org/wiki/DNF_system_upgrade "upgrade") as well.   These are the series of commands to install the DNF upgrade plugin and then execute the process.

* ```sudo dnf update --refresh```
* ```sudo dnf install dnf-plugin-system-upgrade```
* ```sudo dnf system-upgrade download --releasever=31```
* ```sudo dnf system-upgrade reboot```

## New Package Managers

The one thing that you can say the mobile revolution brought into computing is the concept of an "app store."  Apple obviously came first, Google Play Store, and even the Microsoft Store took root.  The concept of an app store is pretty ubiquitous at this point.  These platforms are not based on free and opensource, they are called "walled gardens," because you are free to install any software as long as it comes from the curated app store.  On a fundamental level Linux is conceptually not compatible with the concept of an app store.  But the concept that an app store provides, controlling/standardizing software versions, ease of install/remove, and basic sandbox security technology for apps--the benefits cannot be overlooked in regards to usability.  To this end two standardized methods were developed: flatpak and snaps.  Snaps were created by Ubuntu and is account based across Linux distros that support the snapd library.  Flatpak is the competing standard championed by Red Hat.  

### Snaps and snapd

This is from Ubuntu and is geared towards their ecosystem.  The technology is housed at a neutral organization site called [snapcraft](https://snapcraft.io/ "Snapcraft").

Snaps have the advantage of since it is account based (like the App Store or Microsoft Store) you can register your snaps and then instantly download them on another machine that supports snaps.

Snaps, similar to the appstore concept, allows you to:

* Simple to package leveraging your existing tools
* Automatic updates for everyone
* Reach tens of millions of Linux systems
* Roll back versions effortlessly
* Integrate easily with build and CI infrastructure
* Free for open and closed source projects

> Let's sign up for an Ubuntu One account [so we can use snaps](https://docs.snapcraft.io/core/install-ubuntu "Ubuntu snaps").  

* Let's install Android Studio via snaps
  * ```sudo snap install android-studio```

### flatpak

Supported on all Linux operating systems and functions like an app store -- where you can install, remove, and update packages all from a single command - [Flatpak](https://www.flatpak.org/ "Flatpak").  You can see software available at [Flathub](https://flathub.org/home "Flathub").

Flatpak essentially connects the concepts of repositories and app packages, but the drawback is that flatpak manages its own applications and list of installed applications.

Let's install some flatpak applications:  The first thing is to install the flatpak package as it does not come standard in any Linux Distro. [That is done at the Flatpak repo page](https://www.flatpak.org/setup/ "flatpak"). Let's try it with an Ubuntu distribution:

```bash
sudo add-apt-repository ppa:alexlarsson/flatpak
sudo apt update
sudo apt install flatpak
```

The Flatpak plugin for the Software app makes it possible to install apps without needing the command line. To install, run:

```sudo apt install gnome-software-plugin-flatpak```

Add the Flathub repository:
```flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo```

Now let's look at how its done in RHEL/CentOS Linux:

```sudo yum install flatpak```

Add the Flathub repository

```flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo```

Once that is done here is an example of installing Flatpaks with Ubuntu based distro:

* sudo flatpak install flathub com.spotify.Client
* sudo flatpak install flathub org.gimp.GIMP
* sudo flatpak install flathub com.visualstudio.code
* sudo flatpak install flathub com.google.AndroidStudio

These apps appear on your start menu after a logout and log back in.  They can also be launched via the ```flatpak``` command from the commandline. Note that from the command line you don't run these as ```sudo```.  You can find the official flatpak name by issuing the command: ```flatpak list```.

* flatpak run com.google.AndroidStudio
* flatpak run com.visualstudio.code
* flatpak run org.gimp.GIMP
* flatpak run com.spotify.Client

## Compiling and Installing source code

In addition to packages you may still want to compile software from source.  This way you can take advantage of the latest compiler optimizations and CPU support.  Or compile older versions that have a feature you need that is no longer supported as a package any more.

Let's take a look at this link.  This is the Apache webserver version 2.4.x latest source code and instructions for compiling software. [http://httpd.apache.org/docs/current/install.html](http://httpd.apache.org/docs/current/install.html "Apache").  Follow the link and download the source code, extract it and let's go about compiling the software.   The first step is to run the ```./configure``` command.  This script does what is called a sanity check, and checks to make sure your system has the correct tools to build the software--some configure scripts will also check for dependencies.  You may need to install APR and APR-Util via the package manager or via source as instructed.

### GNU GCC

The main tool needed is the GNU C compiler or GCC for short.  This was one of the first items that Richard Stallman created in the GNU project and to this day is needed for building the Linux Kernel and is the standard build tool for Free Software.  There are competing software stacks and compilers, as of version 10 the FreeBSD project deprecated GCC and chose the [Clang](https://en.wikipedia.org/wiki/Clang "Clang") project, originally designed by Apple to support [Xcode](https://en.wikipedia.org/wiki/Xcode "Xcode"), instead. Apple abandoned the GCC compiler because of the restrictions placed on it by GPLv3, which is an interesting side effect of GPLv3. The GCC compiler has grown to include other languages over the years as well.  You can install the GCC compiler and all the additional build tools in Debian/Ubuntu by typing: ```sudo apt-get build-essential```.  In Fedora you would add these two commands; ```sudo yum groupinstall 'Development Tools'``` and ```sudo yum groupinstall 'Development Libraries'```.  You can compile code directly by invoking the gcc or ```g++``` command.

### GNU Make

As mentioned prior the GNU make command is used to actually compile the C code and all the directives stated in the build file.  That compiled source is then placed into the proper system directories by the ```make install``` command.  This command needs *superuser* privileges to move files to directories not owned by the user, but the ```make``` command doesn't need sudo--resist the temptation! The ```--prefix=``` is the default location where you want to store the compiled apache binaries, it defaults to ```/usr/local```.

```bash
./configure  
make  
sudo make install  
```

### Using Python to Install Python Based Programs

In addition to compiling software and using package managers the Python language has become common in its application usage and has its own installers for applications.  Looking at the Denyhosts project on their GitHub account, [https://github.com/denyhosts/denyhosts](https://github.com/denyhosts/denyhosts "Denyhosts") you will see the latest source code version 3.0 available but not in an RPM or DEB package but as a python install package.  We simply need to clone the repository down and enter the directory we just cloned.   We can then install the software, similar to the GCC build tools, by executing just this command: ```sudo python setup.py install```.  Note you may need a dependency depending on what system you are on - the installer will tell you what you need in addition to making this work.

You can see an example of how to install Python language packages (eggs).  Take for example the packages required to install [dronekit.io](http://dronekit.io "drone kit").  Drone kit is an API for controlling [3D Robotics](https://www.3drobotics.com "drones") drones.  To [install their Python development packages](http://python.dronekit.io/guide/quick_start.html#installation "Python packages") you need to use ```pip``` the Python Package Installer.

```sudo apt-get install python-pip python-dev```

```bash
sudo pip install dronekit
sudo pip install dronekit-sitl
```

![*Dronekit.io install*](images/Chapter-03/python-install/python-pip.png "Python PIP")

### Using Rust

The [Rust programming language](https://www.rust-lang.org/ "Rust-lang") is a new candidate to supplement or replace the C language.  Various people have undertaken to replace the GNU coretools with Rust based versions.   These tutorials will help you download and compile these tools with Rust.

To install the Rust-lang ```curl https://sh.rustup.rs -sSf | sh```

[https://github.com/uutils/coreutils](https://github.com/uutils/coreutils "Build Core-utils")

[https://github.com/sharkdp/fd](https://github.com/sharkdp/fd "fd-find build using Rust")

### Installing VirtualBox Additions Package

> "The Guest Additions are designed to be installed inside a virtual machine after the guest operating system has been installed. They consist of device drivers and system applications that optimize the guest operating system for better performance and usability." [https://www.virtualbox.org/manual/ch04.html](https://www.virtualbox.org/manual/ch04.html "Source")

The Guest Additions offer the following features:

* Mouse pointer integration
* Shared folders
* Better video support
  * Finally, if the Guest Additions are installed, 3D graphics and 2D video for guest applications can be accelerated; see Section 4.5, “Hardware-accelerated graphics”.
* Seamless windows
* Time synchronization
* Shared clipboard
* Automated logons (credentials passing)

#### Ubuntu 18.04 and 20.04

```bash
# Assuming using VirtualBox 6.1.x
sudo apt-get update
sudo apt-get install build-essential dkms linux-headers-$(uname -r)
cd /media/$USER/VBox_GAs_6.1.12
sudo ./VBoxLinuxAdditions.run
sudo reboot
```

#### Debian 10.x

```bash
# Assuming using VirtualBox 6.1.x
sudo apt-get update
sudo apt-get install build-essential dkms linux-headers-$(uname -r)
sudo mkdir -p /mnt/virtualboxga
sudo mount -r /dev/cdrom /mnt/virtualboxga
cd /mnt/virtualboxga
sudo ./VBoxLinuxAdditions.run
sudo reboot
```

#### Red Hat Fedora 32

```bash
# Assuming using VirtualBox 6.1.x
sudo dnf update kernel*
sudo reboot
sudo mkdir -p /media/virtualboxga
sudo mount -r /dev/cdrom /media/virtualboxga
sudo dnf install -y gcc gcc-c++ kernel-devel kernel-headers dkms make bzip2 perl
cd /media/virtualboxga
sudo ./VBoxLinuxAdditions.run
sudo reboot
```

#### CentOS 7 & 8 using yum

```bash
sudo yum update kernel*
sudo reboot
sudo yum install gcc kernel-devel kernel-headers dkms make bzip2 perl
sudo mkdir -p /media/virtualboxga
sudo mount -r /dev/cdrom /media/virtualboxga
cd /media/virtualboxga
sudo ./VBoxLinuxAdditions.run
sudo reboot
```

If successful you can reboot the Linux guest VM and you will notice the changes take place immediately.  If some of these commands are not familiar that is ok - we will cover them all in later chapters. Without these additional tools installed you will receive an error message similar to this:

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

Through this chapter we gained an understanding of what x86-based virtualization does.  We learned about the purpose of a hypervisor and how opensource tools such as VirtualBox provide these services.  We learned how to install Ubuntu and Fedora based distros in the most common scenarios.  We learned about VirtualBox features and how to install Linux.

### Review Questions

1) What is the term for the industry standard file format that is used to install a Linux distro?
  a. ISO
  b. ZIP
  c. Disk-ISO
  d. Distro
2) What is currently the most common Linux install media type?
  a. CD-ROMs
  b. Network based installs
  c. USB
  d. Thunderbolt
3) What is the name of recommended tool used to create bootable Linux install media?
  a. Pendrive Linux
  b. etcher.io
  c. UNetbootin
  d. Image Magick
4) What is the technology that is inserted between ring 1 and ring 0 that enables virtualization?

5) The operating system that the hypervisor resides on is called the _________ system?

6) Hosted or desktop virtualization is called what type of hypervisor?

7) Bare Metal or Native Virtualization is called what type of hypervisor?

8) Each Linux installation distro provides a mechanism to compare what you downloaded with what you expected to download, what is that called?
  a. mount point
  b. checksum
  c. receipt
  d. mdsum
9) What is the name of the driver package you can install in VirtualBox in order to enable features such as shared clipboard, larger screen resolution, and mouse pointer integration?
  a. Kernel modules
  b. Kernel drivers
  c. VirtualBox extensions
  d. ISO extensions
10) What is the name for a Linux distribution that runs in memory?
  a. Rapid CD
  b. Live ISO
  c. Install Disk
  d. Trick question
11) What feature doesn't dpkg handle/support?
  a. Removing software
  b. Installing dependencies
  c. Versioning
  d. Author Information
12) What is the APT command to add an additional software repository in Ubuntu/Debian, named: `ppa:linux-libre/ppa`, to your APT system?
  a. `sudo add-repository ppa:linux-libre/ppa`
  b. `sudo add-apt-repository ppa:linux-libre/ppa`
  c. `sudo apt-add-repository ppa:linux-libre/ppa`
  d. `sudo apt-add ppa:linux-libre/ppa`  
13) Which distro(s) supports the .deb package?
  a. Ubuntu only
  b. Debian Family
  c. Debian and Red Hat
  d. None of the above
14) Which distro(s) supports the RPM package?
  a. CentOS only
  b. Red Hat Family
  c. Debian and Red Hat
  d. None of the above
15) We talked about using GCC to compile and install software, what was the other language/package manager discussed in the chapter?
  a. G++
  b. APT
  c. Python
  d. None of the above

16) Describe the purpose of VirtualBox Guest Additions?

17) What is the RPM command to install a package from the command line?
  a. rpm -qa *.rpm
  b. rpm install *.rpm
  c. rpm -q *.rpm
  d. rpm -i *.rpm

18) After building software from source and running the ```./configure``` command, what is the next step?
  a. Run the ```make install``` command
  b. Run the ```sudo make install``` command
  c. Run the ```install``` command
  d. Run the ```make``` command

19) What is the name of the new package managers developed by Canonical and Red Hat?
  a.  flatpak and apt
  b.  flatpak and snap
  c.  snapcraft and flatter
  d.  dnf and apt

20) What is the DNF command used to install addtional software repositories? Use this URL to an RPM: http://download1.rpmfusion.org/free/el/updates/7/x86_64/r/rpmfusion-free-release-7-4.noarch.rpm
  a. sudo dnf install repo http://download1.rpmfusion.org/free/el/updates/7/x86_64/r/rpmfusion-free-release-7-4.noarch.rpm
  b. sudo dnf http://download1.rpmfusion.org/free/el/updates/7/x86_64/r/rpmfusion-free-release-7-4.noarch.rpm
  c. sudo dnf install http://download1.rpmfusion.org/free/el/updates/7/x86_64/r/rpmfusion-free-release-7-4.noarch.rpm
  d. sudo install http://download1.rpmfusion.org/free/el/updates/7/x86_64/r/rpmfusion-free-release-7-4.noarch.rpm

### Podcast Questions

Listen/watch the FLOSS podcast number 130 with the [VirtualBox Developers - http://twit.tv/floss/130](http://twit.tv/floss/130)

* ~2:35 Who is Andy Hall and Achim Hasenmuller?
* ~3:00 What is Simon Phipps relationship to the VirtualBox project?
* ~4:45 What does VirtualBox do in Andy Hall's words?
* ~6:30 What other company previously owned VirtualBox?
* ~11:20 According to Simon, what is the definition of open core?
* ~14:17 How does VirtualBox fit into Oracle's business model?
* ~16:15 As of the time of the podcast (2010) how many downloads did VirtualBox have?
* ~20:25 How does VirtualBox handle virtualized I/O?
* ~22:40 What did Intel and AMD introduce to help ease virtualization in VirtualBox?
* ~26:00 What two models of network card did VirtualBox choose to represent their virtual hardware and why?
* ~27:40 What does VirtualBox almost get native performance on?
* ~29:29 How does VirtualBox treat USB devices in Guest OSes?
* ~31:00 What are 4 virtual networking modes in VirtualBox?
* ~32:30 What is the difference between NAT and Bridged networking?
* ~39:30 What Type of hypervisor is VirtualBox?
* ~51:30 Why can't you virtualize Mac OSX on VirtualBox (as of 2014)?

### Lab

You will need to do some research and find the download links for the Linux and BSD based distros below and install them in VirtualBox.  Complete each install to disk.  Assume each instance listed below is 64-bit version. Take a screen shot of each desktop after logging in.

* Debian Based
  * Ubuntu 18.04 Desktop edition
  * Lubuntu 18.04 Desktop edition
  * Trisquel Linux
  * Debian 10.x
  * PureOS 8.x

* Red Hat Based
  * Fedora 30 - Workstation edition
  * CentOS 7.x - minimal install

* BSD based
  * OmniOS Community Edition

* Other Linux
  * Alpine Linux
  * MX Linux
  * Arch Linux
  * Intel Clear Linux Desktop

* Network Based Install
  * openSuse Tumbleweed

#### Ubuntu 18.04 Desktop

![*Sample Deliverable*](images/Chapter-03/lab-example/virtualbox-ubuntu.png "Sample Deliverable")

#### Footnotes

[^19]: <a title="wikipedia:User:Hertzsprung" class="extiw" href="//en.wikipedia.org/wiki/User:Hertzsprung">Hertzsprung</a> at <a title="wikipedia:" class="extiw" href="//en.wikipedia.org/wiki/">English Wikipedia</a> [<a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a>, <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a> or <a href="http://creativecommons.org/licenses/by-sa/2.5-2.0-1.0">CC BY-SA 2.5-2.0-1.0</a>], <a href="https://commons.wikimedia.org/wiki/File%3APriv_rings.svg">via Wikimedia Commons</a>

[^20]: By Terendo (Own work) [Public domain], via Wikimedia Commons <a href="https://commons.wikimedia.org/wiki/File%3AHyper-V.png">https://commons.wikimedia.org/wiki/File%3AHyper-V.png</a>

[^21]: By Scsami (Own work) [CC0], via Wikimedia Commons" <a href="https://commons.wikimedia.org/wiki/File%3AHyperviseur.png">https://commons.wikimedia.org/wiki/File%3AHyperviseur.png</a>

[^22]: By Xander (own work, (not derivative from the movies))  Public domain <a href="https://commons.wikimedia.org/wiki/File%3AUnico_Anello.png">via Wikimedia Commons</a>

[^105]: [https://en.wikipedia.org/wiki/Stuart_Feldman](https://en.wikipedia.org/wiki/Stuart_Feldman)  

[^106]: [https://en.wikipedia.org/wiki/Make_(software)](https://en.wikipedia.org/wiki/Make_\(software\))  

[^107]: [https://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics](https://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics)  

[^108]: [https://wiki.debian.org/Apt](https://wiki.debian.org/Apt)  

[^109]: [http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them](http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them)  

[^110]: [http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them/40351#40351](http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them/40351#40351)

[^111]: [https://en.wikipedia.org/wiki/Linux-libre](https://en.wikipedia.org/wiki/Linux-libre)  

[^112]: [https://launchpad.net/~linux-libre/+archive/ubuntu/ppa](https://launchpad.net/~linux-libre/+archive/ubuntu/ppa)  

[^113]: [https://wiki.debian.org/RPM](https://wiki.debian.org/RPM)  
