#  Hardware and Installation
![*Must be a Linux User...*]( http://imgs.xkcd.com/comics/surgery.png "Understanding the Technology and Philosophy of Unix/Linux")

__Chapter 3 Objectives__

  * Know how the Linux install process works for the two major Linux Distribution families
  * Know what a Linux distribution (distro) is
  * Know about Linux 32-bit and 64-bit architectures an the standard installation format for a distribution
  * Understand how to use virtualization platforms for installing Linux distributions

__Outcomes__

  At the end of this chapter you will understand the Linux installation process and be able to describe the process fully.  A user will also be familiar with the different processor architectures.  You will be aware of virtualization products and platforms the Linux can be installed upon. You will be able to complete a Linux operating system install.

## Installation of Linux Distros

  Part of the power of Linux is that it is *"free to use"*, *"free as in freedom"*  This usually translates into free to use *"cost-wise"* as well.  This makes the barrier to entry in using a Linux distro very small.   In the interceding 21 years the various distros have perfected packaging and installation has become very simple.  If you are familiar with the Windows or Mac install process then Linux will not be too different.  FreeBSD on the other hand, you will find completely alien but that is another story.  The term for a file used to install a Linux distro is called an *ISO*.  An [ISO (*"eye-so"*)](https://en.wikipedia.org/wiki/ISO_9660 "ISO 9600 standard") file is actually a standard file type that represents the contents of a CD/DVD-ROM in a single archived file format.  Since it is a standard, ISO files can be mounted within operating systems, they can be read from and even written or *"burned"* to CD/DVDs, USB, and SD cards.  The reason the ISO term and format are tied to the Linux Distro installtion process is a historical one.  During the mid 90's as Linux rose to prominence at the same time CD-ROM technology began to become affordable and the method of data distribution that replaced floppy and Zip disks amongst PCs.  It made sense to create distributions that were almost the exact size of a CD-ROM because it made distributing and copying very easy Linux very easy.  In the early days of Linux it was not uncommon for a distribution to have a mailing address where you could write a letter and request premade CD versions of a distro.

  As USB drives and SD Cards have since surpassed Optical Disks in speed and capacity they have come to represent the default install media.  In fact if you think about it many laptops, 2-in-1s, and even desktop PCs and Macs don't even come with an optical drive anymore.  Though many old and still usable PCs have optical drives.  One of the best tools I have found for creating bootable install media on optical disk or USB drives is [UNetbootin](http://unetbootin.github.io/ "UNetbootin").  
  
  ![*UNetbootin initial screen*](images/Chapter-03/unetbootin.png "UNetbootin")
  
  This tools takes away the difficulty out of making install media and with two clicks makes it happen.  It even includes an option to manually just-in-time download whichever ISO you are looking for and "burn" the it to the media of your choice.  You may hear the term *"burn"* used in relations to ISOs, all this means is to transfer or write data from one source to its extracted final source.

  While you can burn ISO filed to media for installation on a desktop or laptop, ISO files also have utiility for installing a Linux distribution into a virtualization Platform.

## Virtual Machines
  
  Every operating system is made up of multiple components as we mentioned in chapter 2.  These components are separated by privilege rings. These rings are for privilege separation and are built in security for the operating system. With the higher numbered rings being the least privileged. Traditionally user applications are in ring 4 (sometimes called ["*userland*" or *"user space"*](https://en.wikipedia.org/wiki/User_space "user space") and the kernel which has the most power is in ring 0.  For instance a program a user writes cannot just talk directly to the video card and write to the video memory for the screen.  The program needs to go through the OS which in turn goes through the kernel allowing or enforcing commands to be executed.  How then does virtualization fit in? Virtualization or called a [hypervisor](https://en.wikipedia.org/wiki/Hypervisor "Hypervisor") is a new ring that inserts itself between the OS and the kernel to intercept commands and is called ring -1.
 
 
 __One Ring to Rule Them All...Operating System Rings__ [^19]
    
   ![*Operating System Rings*](https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Priv_rings.svg/500px-Priv_rings.svg.png "One Ring")
   
  We could spend an entire semester studying virtualization and I hope you do.  But for the moment what we need to know is that this ring assist is done by the CPU processor having extra instructions on how to handle multiple operating systems residing on one system through virtualization.  "To do this AMD and Intel introduced extensions to assist virtualization, [VT-x and AMD-V](https://en.wikipedia.org/wiki/X86_virtualization#Intel_virtualization_.28VT-x.29 "x86 virtualization") (called Pacifica). Both instruction sets added nine new machine code instructions that only work at "Ring -1," intended to be used by the hypervisor" [Andy Dorman - Informationweek.](http://web.archive.org/web/20130530214041/http://www.informationweek.com/intel-vt-vs-amd-pacifica/172302134 "x86 extensions")   When dealing with virtualization you are functionally running multiple operating systems at one time.  Technically this is not possible as only one operating system can have control at a time - so how can a hypervisor make this work?  
   
    
   __Virtualization Diagram__ [^20]  


  ![*Virtulization Diagram*](https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Hyper-V.png/640px-Hyper-V.png "Virtulization Diagram")
  
  
  By having the hypervisor intercepting system calls from the virtualzied operating system this allows for multiple operating systems to co-exist one one comptuer unaware of each other.  The way a hypervisor works is not unlike having a professional translator at a business meeting translating between two attendees.  The hypervisor essentially creates two classes of operating systems.  The "*host*" and potentially multiple "*guests*".  The *"guest"* operating system thinks it has complete control of the hardware - but the virtualization software is only showing the guest system a small portion of all the total RAM, CPU, and disk space available.  The hypervisor offers a *"pretend kernel"* to the guest virtualized system.  In turn, the hypervisor translates the system commands to the kernel it has received and translates them to the host operating systems commands.  
  
  For example if we are running an Ubuntu Desktop virtualized guest system on a Windows 10 host, the Linux desktop has no way of knowing how to issue a command to use the network card to request a website because Linux knows its own OS and kernel and Windows is a completely different kernel and operating system.  The virtualization layer will do the translation for you -- allowing the *"host"* system to think that your guest virtualized operating system is nothing more than a native application, and allowing your guest virtualized operating system to think that it owns the entire set of hardware.  
  
  The main concept of virtualization you need to know is that your computer (PC, laptop, Mac) has vastly more power then is needed most of the time.  In general you are only actively using your memory, hard drive, and CPU a small fraction of the time.  Even watching a Youtube video or listening to streaming music service doesn't usually tax your system that much. The benefit of virtualization is that a hypervisor can act as a translator for multiple operating systems running simultaneously on one system.  Thereby maximizing the usage of your resources and preventing you from needing 4 or 5 different physical PCs.   


__Hypervisor Levels__ [^21]

![*Server and Desktop Virtualization*](https://upload.wikimedia.org/wikipedia/commons/e/e1/Hyperviseur.png "Server and Desktop Virtualization")
   
 __TYPE II Hypervisor - Hosted or Desktop Virtualization__
   
   There are basically two types of virtualization.  We will be dealing with TYPE II exclusively to help us in our mastery of Linux. This type assumes you are using an underlying operating systems such as Windows, Mac, or a Linux distro.  In this case the host operating system handles all of the resource management and task scheduling plus you have the added overhead of sharing the hardware with the installed host operating system.  In addition you can have multiple hypervisors installed but only one can be active at a time.  In general it is best to install only one hypervisor though there are some small edits/hacks that can be done to get [Hyper-V and VirtualBox to run together](http://www.hanselman.com/blog/SwitchEasilyBetweenVirtualBoxAndHyperVWithABCDEditBootEntryInWindows81.aspx "Hyper-V and VirtualBox") on Windows.   
 
  There are four major desktop platforms for virtualization:
  
  __Microsoft Hyper-V__
  
  Hyper-V was originally only a server class product released on Windows Server 2008 R2.  Microsoft ported the technology to be able to be used in Windows 8 and 10 Professional and Enterprise editions for free.  It comes as a add on service component and is a fully functional implementation of the sever class product.  It has the added benefit of being able to work over a wireless connection geared towards desktops.  Hyper-V is a good product, you can install Windows and Linux virtual machines on it, but Hyper-V only run on Windows.  
  
  __Oracle VirtualBox__
 
   This prodcut was originally an opensource project that was purchased by Sun and then inherited by Oracle. Though the name is on the project, Oracle has been surprisingly hands off of this project.  Because of that it has grown in usage, features, and utility to become the defacto desktop virtualization tool.  It can run on Mac, Windows, and Linux and allows for seamless transfer of virtual machines across platforms
  
  __VMware Workstation__

   VMware also released a desktop product that is similar to VirtualBox on Windows and Linux called VMware Workstation. This software predated VirtualBox by nearly 5 years with a separate desktop product available for the Mac called VMware Fusion.

__Parallels Desktop for Mac__

  Until 2013 Parallels Desktop was a direct competitor to VMware Workstation on the desktop of Windows and Linux. As of 2013 those products were discontinued in favor of Parallels focusing their desktop product on the Mac.  

__TYPE I Hypervisor - Bare Metal or Native Virtualization__

   TYPE I is used in server environments on hardware utilizing multiple core CPUs, mutli-terabytes of RAM, and multi-terabytes of hard drive space.  A TYPE I hypervisor includes a kernel and tiny purpose driven mini-operating system tuned just for managing and interfacing with virtual machines.  The kernel itself is the hypervisor also tuned with all unnecessary features removed.  This book will not cover TYPE II hypervisors or commercial implementations of them.
     
   *  [Microsoft Hyper-V](https://technet.microsoft.com/en-us/library/hh831531.aspx "Hyper-V")
   
   *  [VMware ESXi](http://www.vmware.com/products/vsphere-hypervisor/ "vSphere")

## Installations and ISOs

  Now that we covered a bit about what a hypervisor is, let us begin the install process using VirtualBox.  The next pages are going to show you in comparison how to install the latest versions of Fedora and Ubuntu (as of August 10th 2015) Fedora 22 and Ubuntu Desktop 15.04.  This will require you to download two ISOs from their respective download sites. For this install process we will assume that you are using VirtualBox version 5.x.x branch but if you have any of the 4.x.x branch there shouldn't be any issues.   It might be a good exercise if you have an old laptop or PC laying around to make some installable media (CR-ROM or Flash drive via Unetbootin) and install one of these distributions directly as the primary operating system.  Finding old laptops is easier than you might think. Try asking your relatives (especially around back-to-school and Christmas), a company you work for, or even a school you go to what they have in the way of unused laptops. Laptops/desktops can have a second life and can still be useful to experiment with Linux installations even if the hardware is not the latest or greatest.  Another option to consider is dual-booting or triple-booting your system, we will not cover that option here.  If you do try it, back up your data first, you never know what could go wrong. I created a [quad-boot system](https://forge.sat.iit.edu/2015/05/quad-boot-your-pc-ubuntu-15-04-centos-6-6-fedora-21-windows-10/ "Quad Boot") containing Ubuntu, Fedora, Centos, and Windows 10 see article here for how to accomplish this task.  This processes is beyond the scope of this book but the link is provided for those interested.

   You also need to be aware of the type of architecture you are installing to.  Is the processor 32-bit or 64-bit?  If it is a 64-bit processor you can install 32-bit operating system but not the other way around.  32-bit processors are usually only low end older Atom processors and older intel chips - pre Core 2 Duo processors.  You can find information about your processor by going to [http://ark.intel.com](http://ark.intel.com] "ARK"). This is Intel's clearing house for all its information about processors and motherboards.  They can tell you all you want to know about a processor.  All but the most specialized or low end chip these days is 64-bit you should be safe with that type of distro.  
   
   The 32-bit distro is most commonly referred to as the x86 or 586, 686 architecture.  The 64-bit architecture is usually referred to as x64, but sometimes x86_64, and even AMD_64 <-- that is not a reference to AMD processors - just a credit in the name as AMD was the first company to implement 64-bit extensions to the 32-bit x86 instruction set--hence the credit.  There is one other type of architecture called ARM or AARCH, AARCH64.  This is the ARM architecture that runs phones, tablets, and small embedded systems such as the Raspberry Pi.  It has an entirely different instruction set so the software compiled for this architecture is not compatible with the Intel x86-x64 architecture.  
   
   Each distro also has a checksum feature provided by the site that issues the download.  A checksum is a one way mathematical function that gives you a unique representation of what the content of the iso should be.  That way if you download and ISO from somewhere and the checksum is different then you might be alerted to someone trying to add additonal contents to an ISO or perhaps just a corrupted download.  Most distros use a simple md5 hash, but a few, notably Fedora, has moved to more robust hashes using the SHA-256 hash.

__Links to get you started__
  
   * [Get Fedora](http://getfedora.org)
     + [Fedora checksum page for Linux and Mac](https://getfedora.org/en/verify "Verify")
     + [Fedora checksum page for Windows](http://docs.fedoraproject.org/en-US/Fedora/22/html/Installation_Guide/sect-verifying-images.html "Verify Windows")
   * [Get Ubuntu](http://ubuntu.com)
     + [Ubuntu checksum page](https://help.ubuntu.com/community/UbuntuHashes "Ubuntu Hashes")
     + [Microsoft Powershell hash checking functions](http://technet.microsoft.com/en-us/library/dn520872.aspx "Powershell Hash checking function")
   * [Get VirtualBox](http://virtualbox.org "VirtualBox")

Here are the commands to execute in Windows in powershell:
   
```powershell
Get-FileHash .\ubuntu-15.04-desktop-amd64.iso -Algorithm MD5 | format-list
```
    Algorithm : MD5
    Hash      : 53C869EBA8686007239A650D903847FD
    Path      : C:\Users\palad\Downloads\isos\ubuntu-15.04-desktop-amd64.iso

```powershell
Get-FileHash .\Fedora-Live-Workstation-x86_64-22-3.iso -Algorithm SHA256 | format-list
```
    Algorithm : SHA256
    Hash      : 615ABFC89709A46A078DD1D39638019AA66F62B0FF8325334F1AF100551BB6CF
    Path      : C:\Users\palad\Downloads\isos\Fedora-Live-Workstation-x86_64-22-3.iso

Here are the checksum commands and output to be executed if you are running on an already installed version of Linux or Mac OSX from the terminal:

```bash
md5sum ./ubuntu-15.04-desktop-amd64.iso
```
    
    53c869eba8686007239a650d903847fd ./ubuntu-15.04-desktop-amd64.iso
    
```bash
sha256sum ./Fedora-Live-Workstation-x86_64-22-3.iso
```
    615abfc89709a46a078dd1d39638019aa66f62b0ff8325334f1aF100551bb6cf ./Fedora-Live-Workstation-x86_64-22-3.iso  

### Planning Your Install

  Before beginning there are a series of questions you should ask yourself, "What do I need in this distro?"
  
  *  Strict Security such as SE Linux?
  *  Stable release with long term support?
  *  Will this be a desktop install or server install?  GUI or no GUI?
  *  What software will you be needing?
    + Serving web pages?
    + Building Android applications?
    + Hacking your neighbor's wi-fi?
  *  What processor do I have, 32-bit or 64-bit?  How much RAM do I have or need?
  *  Is this an old PC or laptop I am using--does it lack processor extensions that can aid in rendering multi-media efficiently? 
    + [SSE](https://en.wikipedia.org/wiki/Streaming_SIMD_Extensions "SSE")
    + [AVX](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions "AVX")
  *  Licensing for business?
    + Does it need to be GPL compliant?
    + Can proprietary programs and codecs be included?
  
### Create Your First Guest Virtual Machine
  
  Upon completion of a fresh install and launching of VirtualBox you should see this image: 
  
  ![*VirtualBox fresh install*](images/Chapter-03/virtulabox-fresh-install-550.png "Fresh VirtualBox install")
  
  See the [getting started manual](https://www.virtualbox.org/manual/ch01.html "Getting started manual") for a wide range of information.  Unlike some opensource projects this documentation is actually very thorough and useful.  VirtualBox has a list of [supported host operating systems](https://www.virtualbox.org/manual/ch01.html#hostossupport "Supported Host Operating System"), which is basically any operating system you can think of from DOS to Haiku to FreeBSD.

  Let us walk through the initial installtion process.  The first step to begin is with the *NEW button*.  The next step is where we give our guest virtual machine a name.  VirtualBox has long had support that if you type the type of the operating system in the system name - VirtualBox will auto detect the instance type and version.  If you see the sample below I typed "Ubuntu-15-04-Desktop" and "Fedora-22-workstation." As you type in the title that has the name in it VirtualBox will auto-detect and switch the type and version automatically.  
  
  ![*Create New Ubuntu Instance Dialog*](images/Chapter-03/create-and-name-450.png "Create New Instance Dialog")
  
  ![*Create New Fedora Instance Dialog*](images/Chapter-03/fedora-install-450.png "Create New Instance Dialog")
    
  What happens if you choose the wrong type or version?  Two things, __first__ if you chose the wrong edition of Linux most things will work but the virtualization layer will not be optimized, try to avoid it.  You can always go back into the *SETTINGS* menu option and change it after the virtual machine is powered off.  __Second__ If you select the wrong version, (32-bit instead of 64-bit) you will receive an error from the BIOS as the operating system loads explaining that it cannot continue.
  
  Next is the amount of memory available - note that this memory is shared with your underlying OS as described with TYPE II hypervisors. Whatever you allocate to this guest VM will be unavailable to the underlying host OS while the guest VM is powered on. Note the slider, each system to install VirtualBox on will have a different slider based on the amount of memory you can allocate.  The recommended amount of memory is at least one gigabyte but more likely two gigabytes will be better.  You can also *"over-provision"* memory by making multiple virtual machines whose memory totals beyond your system's memory by not having them running all at once.
  
  ![*Memory Selection Dialog*](images/Chapter-03/memory-selection-550.png "Memory Selection Dialog")
  
  The next step is to select the amount of virtual hard drive allocation.  Here you have a choice of how much hard drive space you will allocate to the guest VM.  This space will be treated as a file by the underlying host OS--allowing for easy migration, export, and even cloning of the guest VM.  

  ![*Hard disk Allocation*](images/Chapter-03/hard-disk-550.png "Harddisk allocation")
  
  Next is the hard drive file format.  There are a few competing standards.  If you know you are going to be working in the VirtualBox environment then the default VDI type is sufficient.  If you know you will be transferring this Virtual Machine to another environment: VMware (VMDK), Microsoft Hyper-V (VHD), KVM (QCOW,QCOW2, RAW) then you can choose the appropriate type.
  
  ![*Drive Type*](images/Chapter-03/disk-type-550.png "Drive Type")
    
   You can chose to dynamically allocate your hard drive space or statically allocate it.  The advantage of dynamically allocating is that not all the space will be assigned right away.  The hard drive will grow incrementally as you need space until it hits the maximum you defined.  The disadvantage of this is that if you are creating lots of data there will be an overhead processing in continually allocating space.  Statically allocating the hard drive space on the other hand will potentially lessen the number of systems that can go on your hard drive because potentially much space that is allocated is actually unused. Virtual hard drives for the guest OSes are treated as files from the point host OSes. 
  
   ![*Disk Type*](images/Chapter-03/disk-size-550.png "Disk Type")

   The final option dialog is where you can choose where to store your virtual machine's virtual harddrive. Usually the default is fine unless you know you need to store the hard drive on a separate partition or disk.   Also VirtualBox will make a suggestion on a recommended virtual hard drive size.   

   ![*Disk Size Slider*](images/Chapter-03/disk-slider-550.png "Disk Slider")
   
   ![*Completed Install*](images/Chapter-03/finish-550.png "Success")
  
   Now click *finish* and you should be ready to go.  
    
### Walk Through the Settings 

![*Virtual Machine Settings*](images/Chapter-03/settings.png "Virtual Machine Settings")

Before we hit the start button - lets select one of our virtual machines and take a look at the content of the SETTINGS button.  Here we will find all the settings possible related to our virtual machine.  Though not entirely correct - you could think of this similar to a BIOS settings on a PC - and area where we can configure any underlying hardware.  The most common options you will deal with are described as follows:

General

: Setting that handle meta-data about the virtual machine

System 

: Settings to change amount of RAM and processors - enabling or diabling chipset drivers and CPU features

Display

: Settings to change how the display settings work

Storage

: Settings related to disk drives.

Network

: Settings related to changing or adding new network interfaces or network types.\

### Installing Ubuntu

  Hitting the *START* button on your virtual machine install for Ubuntu 15.04 Desktop will bring you to a *WELCOME* screen.  Here you will be presented with the option to choose your install language.  As well as presented with two options:  *TRY UBUNTU* or *INSTALL UBUNTU*.  The option *TRY UBUNTU* will load the actual Ubuntu operating system but load it into RAM and not install it on your hard drive.  This is helpful because it gives you the option to use Ubuntu fully without permanently installing it.  Note that all data is stored in memory so nothing will survive a reboot - but this may be a good tool for doing online banking with.  The Live option also has the option to go into an install mode via a desktop icon. 
  
  ![*Live or Install Mode*](images/Chapter-03/ubuntu-install/live-install-450.png "Live Install")

  Under the *INSTALL* option Ubuntu will present you with multiple option tests that need to be passed before install.  Things such as enough available hard drive space, is your computer plugged into a power source, and do you have an internet connection?  In addition you will be prompted if you want to install proprietery codecs automatically during install?  
  
  ![*Preparing to Install*](images/Chapter-03/ubuntu-install/preparing-to-install-450.png "Preparing to Install")

  This would include things such as Adobe Flash, codecs to playback MP3, and potentially proprietary AMD or NVIDEA graphics drivers.  Your choice and these can always be added later on demand.  The final option is to install updates while downloading - this will add time to the install but also save you from having to launch the update script upon first login. 
  
  For installation type you will be presented with default options such as *ERASE DISK AND INSTALL UBUNTU*.  In addition there are options for enabling full disk encryption for securing your install data.  The third option listed is to install using the LVM method of partitioning, which will be covered in chapter 12.  The fourth option is for a custom partitioning, which is helpful in cases when you are installing multiple operating systems and create a multi-boot system.  
  
   ![*Installation Type*](images/Chapter-03/ubuntu-install/installation-type-450.png "Installation Type")
  
  At the completion of this dialog box you will be asked to confirm the automatically generated partitions created by the system.  A Linux system needs a minimum of 2 partitions to function but 3 are recommended.  Those partitions are / (pronounced root), /boot (where all the files needed to start the OS are located, and swap (which is an on disk based RAM supplement partition.  
 
  ![*Confirm Partitions*](images/Chapter-03/ubuntu-install/write-changes-to-the-disk-450.png "Confirm Partitions")
  
  The next parts of the installation contain pretty straight-forward parts: time zone selection, keyboard layout, and account creation and password setup.  Note that Ubuntu doesn't create any root user by default, which ever user you create first is automatically placed into the sudo group -- which is similar to a super user.  For a discussion of password strength and strategies [see this cartoon](http://imgs.xkcd.com/comics/password_strength.png "Password Strength Argument"). You can also see the install details by clicking the small white triangle to reveal the verbose output of the process.  
   
   ![*Install Details*](images/Chapter-03/ubuntu-install/installing-system-tab.png "Install Details")

### Installing Fedora

  Similarly on Fedora 22 you will be presented with the option to *Start Fedora Live* or go into troubleshooting mode.  You will be presented with an install screen similar above: *TRY FEDORA* or *INSTALL TO HARD DRIVE*. Fedora 22 will initially present you with a language screen option.  After choosing your default language the next step is the *installation summary*. 
  
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
  
  You can click the *Finish Install* button to complete the install.  You will be presented with a final *Quit* button which will exit the installer and drop you back into the *Live* desktop.  In order to reboot the system you need to open the system menu via the downwards facing white triangle in the upper right hand corner. The reboot icon is located under the traditional power icon.  Once restarted congratulations you have successfully installed and can begin using your installed Fedora 22 system.  
  
### VirtualBox Extensions

  You may have noticed that when a guest VM is successfully installed the screen resolution may be very small and the mouse integration features are not working. By default VirtualBox doesn't know what your host systems underlying hardware is.  So it guesses by providing a lowest common denominator set of hardware drivers, usually for pretty old, but well known set of hardware.  In order to install higher quality drivers to enable more features VirtualBox provides something called *"guest additions"* to enable exclusive features that are not normally available in an operating system.  These featuers include things such as shared folders, cut and paste support, and even support for multiple monitors and higher resolutions.     
  
  VirtualBox guest additions can be installed by selecting an installed virtual machine and selecting the menu item under __DEVICES__ then select the "Insert Guest Additions CD Image."  For Windows and Mac as the guest VM OS this is a pretty straight forward install - the attached Guest Additions iso appears within the VM and you simply double click it and run through the menu, reboot, and new features are added. For Linux you need to compile these extensions into the kernel and some extra tools are needed.
  
  __Ubuntu__
  
   This goes for any distro that derives from Debian.  You will need to install the following from the commandline to assist with the compiling and installation of VirtualBox drivers.  Apt is the Debian/Ubuntu package manager, we will learn about more in depth in [chapter 10](Package Installation). These instructions assume you are using VirtualBox 5.0.2, you will need to adjust the version numbers and path name if you are using a different version.
   
    sudo apt-get update
    sudo apt-get install build-essential dkms linux-headers-$(uname -r)
    cd /media/$USER/VBOXGUESTADDITIONS_5.0.2_102096/
    sudo VBoxLinuxAdditions.run
    sudo reboot

 __Red Hat__
 
 On Fedora 22 using dnf 
 
     sudo dnf update kernel*
     sudo reboot
     sudo mkdir /media/VirtualBoxGuestAdditions
     sudo mount -r /dev/cdrom /media/VirtualBoxGuestAdditions
     sudo dnf install -y gcc gcc-c++ kernel-devel kernel-headers dkms make bzip2 perl
     cd /media/VirtualBoxGuestAdditions
     # 32-bit and 64-bit systems run following
     ./VBoxLinuxAdditions.run
     sudo reboot
     
 On Centos, RHEL, and older Fedora distros using yum
 
     sudo yum update kernel*
     sudo reboot
     sudo yum install gcc kernel-devel kernel-headers dkms make bzip2 perl
     sudo mkdir /media/VirtualBoxGuestAdditions
     sudo mount -r /dev/cdrom /media/VirtualBoxGuestAdditions 
     cd /media/VirtualBoxGuestAdditions
     # 32-bit and 64-bit systems run following
     ./VBoxLinuxAdditions.run
     sudo reboot

 If successful you can reboot the Linux guest VM and you will notice the changes take place immediately.  If some of these commands are not familiar that is ok - we will cover them all in later chapters. Without these additional tools installed you will receive an error message similar to this:
    
    Building the main Guest Additions Module[Failed] 

### VirtualBox Features       

  If you are using Windows, Mac, or Linux you need to download the appropriate version from the VirtualBox homepage. Version 5.0.2 (August 18th, 2015) is the current version.   
  
 [*Feature List for VirtualBox*](https://www.virtualbox.org/manual/ch01.html#virtintro "Feature List")

*  Guest multiprocessing (SMP). 
*  USB device support. 
*  Seamless windowing
*  Shared folders
*  Hardware compatibility. 
*  Full ACPI support. 
*  Multiscreen resolutions. 
*  Built-in iSCSI support. 
*  PXE Network boot. 
*  Remote machine display
*  Video and screenshot capture within virtual machines

## Chapter Conclusions and Review

  Through this chapter we gained an understanding of what x86 based virtualizations does.  We learned about the purpose of a hypervisor and how opensource tools such as VirtualBox provide these services.  We learned how to install Ubuntu and Fedora based distros in the most common scenarios.  We learned about VirtualBox features and how to install Linux.

### Review Questions

1)	What is the term for the industry standard file format that is used to install a Linux distro?
  a. ISO
  b. ZIP
  c. Disk-ISO
  d. Distro
2)	What is currently the most common Linux install media type?
  a. CD-ROMs
  b. Network based installs
  c. USB
  d. Thunderbolt
3) What is the name of the most common tool used to create bootable Linux install media?
  a. Pendrive Linux
  b. Penguin Linux Maker
  c. UNetbootin
  d. Image Magick
4)	What is the technology that is inserted between ring 1 and ring 0 that enables virtualization?

5)	The operating system that the hypervisor resides on is called the _________ system

6)	Hosted or desktop virtualization is called what type of hypervisor?

7)	Bare Metal or Native Virtualization is called what type of hypervisor?

8)	Each Linux installation distro provides a mechanism to compare what you downloaded with what you expected to download, what is that called?
  a. mount point
  b. checksum
  c. receipt
  d. mdsum
9) What is the name of the driver package you can install in VirtualBox in order to enable features such as shared clipboard, larger screen resolution, and mouse pointer integration?
  a. Kernel modules
  b. Kernel drivers
  c. VirtualBox extensions
  d. ISO extensions
10) What is the name for a Linux installation that runs in memory?
  a. Rapid CD
  b. Live ISO 
  c. Install Disk
  d. Trick question 

### Podcast Questions 

Listen to the FLOSS podcast number 130 with the [VirtualBox Developers - http://twit.tv/floss/130](http://twit.tv/floss/130) 

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
  * ~51:30 Why can't you virtualize Mac OSX on VirtualBox?


### Lab

  You will need to do some research and find the download links for the Linux and BSD based distros below and install them in VirtualBox.  Complete each install and launch a text editor and type your name, the name of the Linux distro, and the message "Hello World."  Assume each instance listed below is 64-bit version. Take a screen shot of each successful install.
  
    + Debian Based
        - Ubuntu 15.04 Desktop edition
        - Linux Mint 17 
        - Lubuntu 15.04 Desktop edition 
        - gNewSense 3.1  
        - Debian 8 
        
    + Red Hat Based
        - Fedora 21
        - Fedora 22
        - Centos 7
        - One Fedora spin of your choice
        
    + BSD based
        - FreeBSD 10.2
        - OpenBSD 5.7
        
 ![*Sample Deliverable*](images/Chapter-03/lab-sample-512-by-250.png "Sample Deliverable")
         
#### Footnotes   
  
[^19]: <a title="wikipedia:User:Hertzsprung" class="extiw" href="//en.wikipedia.org/wiki/User:Hertzsprung">Hertzsprung</a> at <a title="wikipedia:" class="extiw" href="//en.wikipedia.org/wiki/">English Wikipedia</a> [<a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a>, <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a> or <a href="http://creativecommons.org/licenses/by-sa/2.5-2.0-1.0">CC BY-SA 2.5-2.0-1.0</a>], <a href="https://commons.wikimedia.org/wiki/File%3APriv_rings.svg">via Wikimedia Commons</a>

[^20]: By Terendo (Own work) [Public domain], via Wikimedia Commons <a href="https://commons.wikimedia.org/wiki/File%3AHyper-V.png">https://commons.wikimedia.org/wiki/File%3AHyper-V.png</a>
    
[^21]: By Scsami (Own work) [CC0], via Wikimedia Commons" <a href="https://commons.wikimedia.org/wiki/File%3AHyperviseur.png">https://commons.wikimedia.org/wiki/File%3AHyperviseur.png</a>
 
[^22]: By Xander (own work, (not derivative from the movies))  Public domain <a href="https://commons.wikimedia.org/wiki/File%3AUnico_Anello.png">via Wikimedia Commons</a>
    
    