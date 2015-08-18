#  Hardware and Installation
![Must be a Linux User]( http://imgs.xkcd.com/comics/surgery.png "Understanding the Technology and Philosophy of Unix/Linux")

__Chapter 3 Objectives__

  * Know how the Linux install process works for the two major Linux Distribution families
  * Know how filesystem partitioning works 
  * Understand how to use virtualization platforms for installing Linux distributions
  * Be able to understand the benefits of automated answer files for installs

__Outcomes__

  At the end of this chapter you will understand the Linux installation process and be able to describe the process fully.  A user will also b e familier with the different processor architectures.  You will be aaware of virtualization products and platforms the Linux can be installed upon.

## Installation of Linux Distros

  Part of the power of Linux is that it is *"free to use"*, *"free as in freedom"*  This usually translate into free to use *"cost wise"* as well.  This makes the barrier to entry in using a Linux distro very small.   In the interceeding 21 years the various distros have perfected packaging and installtions has become very simple.  If you are familiar with the Windows or Mac install process then Linux will not be too different.  FreeBSD on the other hand, you will find completely alien but that is another story.  The term for a file used to install a Linux distro is called an *iso*.  An .iso file is actually a standard file type that represents the contents of a CD/DVD-ROM in a single archived file format.  Since it is a standard ISO files can be mounted with in operating systems, the can be read from and even written to CD/DVDs, USB, and SD cards.  THe reason the iso term and format are so tied to Linux historical one.  During the mid 90's as Linux rose to prominence CD-ROM drives and technologies began to become standard amongst PCs.  It made sense to create distributions that were almost the exact size of a CD-ROM beccause it made distribution and copying very easy.  In the early days of Linux it was not uncommon for a distribution to have a mailing address where you could write a letter and request premade CD versions of a distro.

  As USB drives and SD Cards have surpassed Optical Disks in speed and capacity they have come now to represent the favorite install media.  Infact if you think about it many laptops, 2 in 1s, and even desktop PCs and Macs don't even come with an optical drive.  Though many old an still usable PCs still have optical drives.  One of the best tools I have found for creating bootable install media on optical disk or UBS drive is UNetBootin.  The tools takes the difficulty out of making install media.  It even includes and option to manually just-in-time download which ever iso you are looking for and "burn" the iso to the drive.  You may hear the term *"burn"* used in relations to isos, all this means is to transfer or write data from one source to its final source.

  ISO files also have utitility for when you are installing a Linux distribution into a virtualized platform.

## - Virtual Machines
  
  Every operating system has the concept of rings in relation to how systems communicate.  These rings are for privilege seperation and how security is built in to an operating system. With the higher numbered rings be the least privilleged. Traditionally user applications are in ring 4 and the kernel which has the most power is in ring 0.  For instance a program a user write cannot just talk directly to the video card and write to the screen.  The program needs to go through the OS which in turn goes through the kernel allowing or enforcing commands to be executed.  A hypervisor is a new ring that inserts itself between the OS and the kernel--called ring -1.
    
  <a title="Hertzsprung at English Wikipedia [GFDL (http://www.gnu.org/copyleft/fdl.html), CC-BY-SA-3.0 (http://creativecommons.org/licenses/by-sa/3.0/) or CC BY-SA 2.5-2.0-1.0 (http://creativecommons.org/licenses/by-sa/2.5-2.0-1.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3APriv_rings.svg"><img width="256" alt="Priv rings" src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Priv_rings.svg/256px-Priv_rings.svg.png"/></a>
    
 ![Privilege Rings](https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Priv_rings.svg/256px-Priv_rings.svg.png "Hertzsprung at English Wikipedia GFDL http://www.gnu.org/copyleft/fdl.html, CC-BY-SA-3.0 http://creativecommons.org/licenses/by-sa/3.0/ or CC BY-SA 2.5-2.0-1.0 http://creativecommons.org/licenses/by-sa/2.5-2.0-1.0, via Wikimedia Commons")   
    
    
   *"To assist virtualization, VT and Pacifica insert a new privilege level beneath Ring 0. Both add nine new machine code instructions that only work at "Ring -1," intended to be used by the hypervisor."* [Andy Dorman - Informationweek](http://web.archive.org/web/20130530214041/http://www.informationweek.com/intel-vt-vs-amd-pacifica/172302134) 
    
  <a title="By Terendo (Own work) [Public domain], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3AHyper-V.png"><img width="256" alt="Hyper-V" src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Hyper-V.png/256px-Hyper-V.png"/></a>
  
  When dealing with virtualization you are functionally running multiple operating systems at one time.  Technically this is not possible as only one oeprating sysetm can have control at a time - so how can a hyper-visor make this work?  
 
   Insert screen shot of system running Windows and also with Ubuntu and Fedora up and running with task manager

  By having the hypervisor intercepting system calls from the virtualzied operating system.  The way a hypervisor works is not unlike having a professional translator at a business meeting translating between two atendees.  The *"guest"* operating system thinks it has complete control of the hardware - the virtualization software is only showing the guest system a small portion of all the total RAM, CPU, and disk space available.  The hypervisor ina sense offers a pretend kernel to the guest virtualized system.  In turn, the hypervisor translates the system commands to the kernel it has received and translates them to the host operating systems commands.  For example if we are running and Ubuntu Desktop virtualized guest system on a Windows 10 host, the Linux desktop has no way of knowing how to issue a command to use the network card to request a web site because Linux knows its own OS and kernel and Windows is a completely different kernel and operating system.  The virtualziation layer will do this translation for you -- allowing the *"host"* system to think that your guest virtualzied OS is nothing more than an application, and allowing your guest virtualized operating system to think that it own the entire set of hardware.  
  
  The entire concept of virtualization is too large to cover here.  I will try to give you a basic introduction.  The main concept you need to know is that your computer (PC, laptop, Mac) have vastly more power then needed most of the time.  In general you are only actively using your memory, hard drive, and CPU a small fraction of the time.  Even watching a Youtube video or listening to streaming music service doesn't usually tax your system that much.  Virtualization adds the concept of a hypervisor.  A hypervisor is a shim that is inserted into your operating sysetm to intercept system calls to hardware.  The benefit is that a hypervisor can act as a translator for multiple operating systems running simultaniously on one system.  There by maximizing the usage of yoru resources and preventing you from needing 4 or 5 different physical PCs.   

<a title="By Scsami (Own work) [CC0], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3AHyperviseur.png"><img width="256" alt="Hyperviseur" src="https://upload.wikimedia.org/wikipedia/commons/e/e1/Hyperviseur.png"/></a>
  
  __TYPE II__
   
   One is geared assuming you are using an underlying operating systems - such as Windows, Mac, or a Linux distro - thereby off loading all control of the programs to the host OS.  This is usually called desktop virtualization.
 
  There are four main desktop platforms for virtualization:
  
  __Microsoft Hyper-V__
  
  Hyper-V was originally only a server class product release in Windows Server 2012 R2.  Microsoft ported the technology to be able to be used on Windows 8 Professional and Enterprise as well as Windows 10 Professional and Enterprise.  It comes as a free component and is a fully functional implementation of the sever class prodcut.  It has the added benefit of being able to work over a wireless connection too.  Hyper-V is a good product, you can install Windows and Linux virtual machines on it, but Hyper-V can only run on Windows. 
  
  __Oracle VirtualBox__
 
   This prodcut was originally an opensource project that was purchased by Sun and then inherited by Oracle. Though the name is on the project, Oracle has been surprisingly hands off of this project.  Because of that it has grown in usage, features, and utility to become the defacto desktop virtualization tool.  It can run on Mac, Windows, and Linux and allows for seemless transfer of virtual machines across platforms
  
  __VMware Workstation__

   VMware also released a desktop product that is similar to VirtualBox on Windows and Linux called VMware Workstation. This software predated Virtual Box by nearly 5 yearswith a seperate desktop product availalbe for the Mac called VMware Fusion.

__Parallels Desktop for Mac__

  Until 2013 Parallels Desktop was a direct competitor to VMware Workstation of the desktop of Windows and Linux. As of 2013 those products were discontinued in favor of Parallels focusing their desktop product on the Mac.  

 __TYPE I__

   The other is what is called a bare metal hypervisor.  These are usually used in server environments on hardware utilizing multiple core CPUs, mutli-terraBytes of RAM, and multi terrabytes of Hard drive space.  This Hypervisor includes a kernel and mini-operating system tuned just for managing and interfacing with virtual machines.  This book will not cover TYPE I hypervisors or commercial implementations of them.
     
   *  [Microsoft Hyper-V](https://technet.microsoft.com/en-us/library/hh831531.aspx "Hyper-V")
   
   *  [VMware ESXi](http://www.vmware.com/products/vsphere-hypervisor/ "vSphere")

## - Installations and isos

  Now that we understand a bit about what a hypervisor is let us beging the process.  The next pages are going to show you in comparison how to install the latest versions of Fedora and Ubuntu (as of August 10th 2015) Fedora 22 and Ubuntu 15.04.  This will require you to download two isos from their respective download sites. For this install process we will assume that you are using VirtualBox version 5.0.0.  These distributions can be install directly to a hard drive and become the primary operating system. This might be a good exercise if you have an old laptop or PC laying around.  You would be suprised if you asked your relatives or perhaps a company you work for or even a school you might go to what they have in the way of old computers that might still be useful to experiement with Linux installations as well.  There is also the concept of dual booting your PCs with multiple operating systems.   I created a quad-boot system containing Ubuntu, Fedora, Centos, and Windows 10 see article here for how to accomplish this task.  This processes is beyong the scope of this book but link is provided for those interested.

   You also need to be aware of the type of architecture you are installing to.  Is the processor 32 bit or 64 bit?  If it is a 64-bit processor you can install 32-bit operating system but not the other way around.  32-bit processors are usually only low end older Atom processors and older intel chips - pre Core 2 Duo processors.  You can find information about your processor by going to [http://ark.intel.com](http://ark.intel.com] "ARK"). This is Intel's clearing house for all its information about processors and motherboards.  They can tell you all you want to know about a processor.  All but the most secialized or low end chip these days is 64-bit you should be safe with that type of distro.  
   
   The 32-bit distro is most commonly referred to as the x86 or 586, 686 architecture.  The 64-bit architecture is usually referred to as x64, but sometimes x86_64, and even AMD_64 <-- that is not a reference to AMD processors - just a credit in the name as AMD was the first company to implement 64 bit extententions to the x86 instruction set and they caught on and stuck--hence the credit.  Their is one other type of architecture called ARM.  This is noted as aarch and aarch_64 -- ARM is the architecture that runs phones, tablets, and small embedded sytems such as the Raspberry Pi.  It has an entirely different instruction set so the software compiled for this architecture and vis versa is not compatable with the Intel x86 x64  architecture.  
   
   Each distro also has a checksum feature provided by the site that issues the download.  A checksum is a 1 way mathematical function that gives you a unique representation of what the content of the iso should be.  That way if you download and iso from somewhere and the checksum is different then you might be alerted to someone trying to add additonal contents to an iso or perhaps just a corrupted download.  Most distros use a simple md5 hash, but a few, notably Fedora, has moved to more robust hashes using SHA-256 strength hashing.

__Links to get you started__
  
   * [Get Fodora](http://getfedora.org)
     + [Fedora checksum page for Linux and Mac](https://getfedora.org/en/verify "Verify")
     + [Fedora checksum page for Windows](http://docs.fedoraproject.org/en-US/Fedora/22/html/Installation_Guide/sect-verifying-images.html "Verify Windows")
   * [Get Ubuntu](http://ubuntu.com)
     + [Ubuntu checksum page](https://help.ubuntu.com/community/UbuntuHashes "Ubuntu Hashes")
     + [Microsoft Powershell hash checking functions](http://technet.microsoft.com/en-us/library/dn520872.aspx "Powershell Hash checking function")
   * [Get VirtualBox](http://virtualbox.org "VirtualBox")

Here are the commands to execute in Windows in powershell
   
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

Here are the commands executed in Linux


### - Planning Your Install

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
    + Can propriatary programs and codecs be included?
  
### - VirtualBox configurtion        

  If you are using Windows, Mac, or Linux you need to download the appropriate version from the VirtualBox homepage. Version 5.0.2 (August 18th, 2015) is the current version.   
  
 [Feature List for VirtualBox](https://www.virtualbox.org/manual/ch01.html#virtintro "Feature List")

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

### - Create Guest Virtual Machine
  
  Upon completion of a fresh install and luanching of VirtualBox you should see this image: 
  
  ![VirutalBox fresh install](images/virtualbox-fresh.png "Fresh VirtualBox install")
  
  See the [getting started manual](https://www.virtualbox.org/manual/ch01.html "Getting started manual") for a wide range of information.  Unlike some opensource projects this doucmentation is actually very thurogh and useful.  VirtualBox has a list of [supported host operating systems](https://www.virtualbox.org/manual/ch01.html#hostossupport "Supported Host Operating System"), which is basically any operating system you can think of from DOS to Haiku to FreeBSD.

  All things start with the NEW button shown in the picture below.
 
  Name it (auto guess) choose the specific Operating System type and then the specific OS.  What happens if you choose the wrong one?  Two things, 1 you can always go back in the settings option and change it after the virtual machine is powered off.  2. As long as you have the correct OS family everything should be ok--but see the extensions setting at the end of this chapter.
  
  Next is the amount of memeory availalbe - note that this is shared with your underlying OS and whatever you allocate to this guest VM will be unavaialbe to the underlying host OS while the guest VM is powered on. Here you have a choice of how much harddrive space you will allocate to the guest VM.  This space will be treated as a file by the underlying host OS--allowing for easy migration, export, and even cloning of the guest VM.  
 
  You can chose to dynamically allocate your harddrive space or statically allocate it.  The advantage of dynamically allocating is that not all the space will be assigned right away.  The harddrive will grow incrementally as you need space until it hits the maximum you defined.  The disadvantage of this is that if you are creating lots of data there will be overhead processing in continually allocating enough space.  Statically allocating the harddrive space on the otherhand will potentially lessen the number of systems that can go on your harddrive because potentially much space that is allocated is actually unused. 
  
  Next is the harddrive file format.  There are a few competing standards.  If you know you are going to be working in the VirtualBox environment the default VDI is sufficent.  If you know you will be transferring this VirtualMachine to another environment: VMWare (VMDK), Microsoft Hyper-V (VHD), KVM (QCOW,QCOW2, RAW) then you can choose the appropriate type.
  
  Now click finish and you should be ready to go - with your VirtualBox start screen looking something like mine.  Note I have gone through and completed the setup for both Ubuntu 15.04 and Fedora 22 Workstation as seen here.
  
### - Walk Through the Settings 

Before we hit that start button - lets select one of our virtual machines and take a look at the content of the SETTINGS button.  Here we will find all the settings possible related to our virtual machine.  Though not entirely correct - you could think of this similar to a BIOS settings on a PC - and area where we can configure any underlying hardware.

Define settings for new install

Ready to begin

Video and screenshots Links Here

### - Hard Drives and Partitioning

Start the Linux install from iso file

Formatting questions

LVM (see later chapter 13)

Video and screenshots Links Here

### - Installing software

The final process where it asks about additional software to install

Video and screenshots Links Here
   
### - VirtualBox extensions

  You may have noticed that when a guest VM is usccesfully installed the screen resolution maybe very small or the mouse intergration features are not working.  VirtualBox guest additions also enable exclusive features that are not normally availalber in an operating system such as shared folders, cut and paste support, and even support for multiple monitors.  The way to solve this is through something called VirtualBox Guest Additions.   On the VirtualBox menu under INSERT DEVICES you need to select the "Insert Guest Additions CD Image."  
  This is source code and drivers provided by VirtualBox that will add VirtualBox features and hardware to the underlying guest VM.  The guest VM has no idea it is in a virtualized environment and even if it did know Oeprating Systems do no come equipped with drivers to support VIrtualBox.  In this way the drivers are added to the OS in Windows and in Linux the drivers are loaded into the kernel to enhance the experience.
  
  For Windows and Mac as the guest VM OS this is a pretty stright forward install - the attached Guest Additions iso appears within the VM and you simply double click it and run through the menu, reboot, and new features are added.
  
  For Linux you need to compile these extensions into the kernel and some extra tools are needed.
  
  __Debian/Ubuntu__
  
   This goes for any distro that derives from Debian.  You will need to install the following from the commandline to assist with the compiling and installation of VirtualBox drivers.  Apt is the Debian/Ubuntu package manager, we will learn about more in depth in [chapter 10](Package Installation)
   
    sudo apt-get update
    sudo apt-get install build-essential dkms linux-headers-$(uname -r)
    cd /media/cdrom/VBOXGUESTADDITIONS_5.0.2_102096/
    sudo VBOXLinuxAdditions.run

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
     sudo yum install gcc kernel-devel kernel-headers dkms make bzip2 perl
     sudo mkdir /media/VirtualBoxGuestAdditions
     sudo mount -r /dev/cdrom /media/VirtualBoxGuestAdditions 
     cd /media/VirtualBoxGuestAdditions
     # 32-bit and 64-bit systems run following
     ./VBoxLinuxAdditions.run
     sudo reboot

 If successful you can reboot the Linux guest VM and you will notice the changes take place immediately.
 without these additional tools installed you will receive an error message similar to
    
    Building the main Guest Additions Modile[Failed] 
     
### - Automating the Install Answer Process With Preseed and Kickstart  

  All the previous steps took maybe 10 to 15 minutes if you are on a fast machine which is not bad at all.  But let us say you will be creating many virtual machines for research purposes. Or perhaps you will be recreating the same virtual machine many times.  There is a way to automate the install process.  This is called an answer file in the Windows server world.  For Red Hat based systems this is called kickstart and Debian and Ubuntu use a file format called preseed.  None of these formats are compatible with each other but there has been some work to get limited kickstart support for Ubuntu.  
    
  [Debian/Ubuntu pressed template](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html "Preseed")
  
  [Kickstart documentation](https://docs.fedoraproject.org/en-US/Fedora/18/html/Installation_Guide/s1-kickstart2-file.html) - it can be generated from scratch or upon a succesful install a default kickstart is located in /root/anaconda-ks.cfg
  
Link to video on how to run the files

screen shot showing you need to host the file on the web somewhere or include the file in install media

## - Chapter Conclusions and Review

  Through this chapter we gained an understanding of what x86 based virtualizations does.  We learned about the purpose of a hypervisor and how opensource tools such as VirtualBox provide these services.  We learned how to install Ubuntu and Fedora based distros in the most common scenarios.  We learned about VirtualBox features and how to automate Linux installs through kickstart and preseed configuration files.

### - Review Questions

  * Questions go here

### - Podcast Questions 

Listen to the FLOSS podcast number 88 with [Linus Torvalds - http://twit.tv/show/floss-weekly/88](http://twit.tv/show/floss-weekly/88 "FLOSS Linus Torvald")

  *  ~6:32 Who is Linus Torvalds?
  *  ~6:54 Where did he create Linux?
  *  ~7:30 What did Unix have that other operating systems didn't at that time?
  *  ~10:02 Within a few months of Linux first release roughly how many people were interested in Linux?
  *  ~10:30 About what month and what year did this happen?
  *  ~10:40-13:30 What was the initial inspiration to create the Linux Kernal as an open source project? 
  *  ~13:30-14:00 Why was it licensed under the GPL license?
  *  ~20:48 Why didn't Linus want to work for a Linux company? 
  *  ~41:00 More than the technology hurdle what else is needed to get into Linux Kernel Development?
  *  ~46:10 What is the way to become a great programmer?
  *  ~51:17 What is Linus' farewell message to the audience?
  
### - Lab

  * You will need to some research and find the download links for the Linux and BSD based distors below and install them in VirtualBox.  Complete the install and launch a text editor and type your name, the name of the Linux distro, and the message "Hello World."  Assume each instance listed below is 64-bit version.

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
   