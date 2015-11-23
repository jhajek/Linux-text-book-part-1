# Creating, Partitioning, and Mounting Filesystems
![*Easy as cake...*](images/Chapter-Header/Chapter-12/server_problem-2.png "Server Problem")

__Chapter 12 Objectives__

   * Undedstand how to create and be able to attach virtual disks in VirtualBox, to Linux systems
   * Understand how the fdisk command is used to list, modify, and create filesystem partitions
   * Understand the nature of different Linux filesystems, listing their pros and cons
   * Understand Linux tools relating to filesystems, df, mount/umount, mkfs, and the /etc/fstab directory
   * Understand Logical Volume Management and how its partitioning scheme differs from fdisk.
   
__Outcomes__

  At the conclusion of this chapter you will be able to add additional virtual disks to any Linux verison installed in VirtualBox.  You will be able to format devices and create filesystems on newly formatted devices.  You will understand how to partition a device and install filesystems.  This chapter will give you experience with the tools needed to perform these actions.  We will study the LVM -- Linux Volume Manager and its new concept for dealing with disks.  Finalyl we will learn the concept of mounting and unmounting of disks.

## Disk Management in VirtualBox

  At the time of this writing (11/22/15) a single terrabyte Western Digital Blue harddrive was selling for ~$50.  Storage is cheap.  With that in mind, adding storage or capacity is very easy these days--even common place.  Since we are dealing with virtual storage in this book and examples-we can easily attach and detach storage devices because we don't need to add anything physical to the systems.  For this chapter we will assume that you are using Virtual Box 5.0.x, but all of these concepts translate directly to physical storage or another virtualization platform.

 With you virtual machine powered down, lets add some new disks (virtually) to your Linux system.  The first thing to do is locate the *SETTINGS* button on the main menu.
 
![*Virtual Box settings panel*](images/Chapter-12/virtual-box/settings.png "Settings")
\newpage

The next menu to come up will show the *SETTINGS* options and the name of the virtual machine you are working on.

![*Virtual Box settings menu*](images/Chapter-12/virtual-box/settings-menu.png "Settings Menu")
\newpage

Select the *STORAGE* option from the menu on the left--this is where you can attach, detach, and modify virtual disks in Virtual Box.  In most cases these will be hard drives, but there is the ability to attach ISO images to a virtual cd-rom device as well.  That option is in the top half where you see *Controller: IDE*. Under that you might see the term *EMPTY* or you might see a virtualbox-guest-additions.iso attached.  

![*Storage menu*](images/Chapter-12/virtual-box/storage.png "Storage")
\newpage

We will be working with attaching virtual hard drives so we are interested in the bottom portion of the menu which is identified by *Controller: SATA* which is your [Serial ATA](https://en.wikipedia.org/wiki/Serial_ATA "Serial ATA") hard drive bus connection.  As a refresher, Serial ATA is the protocol and databus in which the operating system communicates and recieves data with your hard drive. Go ahead and highlight the SATA Controller entry.  

In order to add a new hard drive to your virtual machine, click the blue HDD icon with a __+__ sign at the bottom of the menu. 

![*Add Storage Icon*](images/Chapter-12/virtual-box/add-storage-icon.png "Storage Icon")

Upon completion of that step a new menu will pop out of the HDD icon and give you and option to *Add Hard Disk*.

![*Add Storage*](images/Chapter-12/virtual-box/add-storage.png "Add Storage")
\newpage

Once you have selected *Add Hard Disk* a familiar set of screens come up, these are the same screens you walked through in chapter 2, and the same set of screens you walk through when setting up a new virtual machine.  You are presented first with an option to create a new disk or attach an existing one.  Usually you want to create a new disk.  

![*Create New Disk*](images/Chapter-12/virtual-box/create-new.png "Create New")

Once that is selected you will be presented with the virtual disk type screen.  Since we will be working with Virtual Box, the default setting of VDI (VirtualBox Disk Image) will be the best selection.  But if you know this VM will be moving to antother platform--you may want to choose accordingly. 

![*VDI step-through*](images/Chapter-12/virtual-box/vdi.png "VDI")
\newpage

The next page allows you to choose either a dynamic or staticly allocated hard drive.  Dynamic is usually the best when you are working on a laptop or other development system, as you will be creating and destroying virtual machine rapidly, and static allocations of multiple gigabytes can become an issue after some time due to your disk filling up.

![*Dynamic Filesystem*](images/Chapter-12/virtual-box/dynamic.png "Dynamic")
\newpage

This next screen allows you to change the location of where the virtual hard disk will be stored, as well as adjust the size of this new partition.  
![*Hard drive size*](images/Chapter-12/virtual-box/size.png "Size")
\newpage

Once you see the screen below - it means you have succesfully created a new virtual hard drive and have attached it to your virtual machine.  You can reverse the above operations by highlighing the virtual disk drive of choice and selecting the HDD icon with the minus sign and that will delete the hard drive.  But I recommend against that as your operating system won't know what happened and that could cause system instability.  Always best to unmount a partition from inside the operating system first before deleting the virtual hard drive. By highlighting the new disk or existing one, you can see the meta-data about the disk.

![*Succesfully added new disk*](images/Chapter-12/virtual-box/new-disk.png "New")

![*Disk Information*](images/Chapter-12/virtual-box/information.png "Information")

Adding a virtual disk is only the first step, there are three more steps before we can use this disk.  We need to partition the disk, create a filesystem, and then mount the disk so that it can be used by your operating system. 

## Disk Partitioning and Formatting

  According to the ```fdisk``` man page, ```fdisk``` is a dialog-driven program for the creation and manipulation of patition tables.  The term __parition__ in relation to a hard drive is an important concept.   You can think of a brand new hard drive as a large plot of land, multiple acres of land.  The land itself in that form is not very useful, just as a new hard drive added into your system is not very useful.  Just as that land needs to be partitioned up into different uses and functions, a hard drive needs to know where it'
  s partitions are.    Each disk can have multiple partitions.  
  
  Linux inherited a way to name each device and reference certain partitions attached to a system.  Windows simply uses the letter C, D, E, and so forth.  Linux and Unix use a device/partition nomeclature.  You can see this currently by typing the ```lsblk``` command, which will print out currently all the block devices, their device name and their partitions in a nice tree based format. 
  
![*lsblk output from a virtual machine with 2 additional drives attached*](images/Chapter-12/fdisk/lsblk.png "lsblk")

Here you will note that the drives are references by the prefix __sdx__ with the __x__ being the alphabet letter in incremental order.  Meaning that the first disk drive that your system detects in labeled __sda__, the next one would be __sdb__, and can you guess what the third and fourth system would be?  In the image above you notice that __sda__ has 3 partitions, sda1, sda2, and sda5.  These three partitions were created at installation time by the default Linux installer.  The first partition you can see has the character ```/``` in the far right column.  That is where the __root__ partition is mounted (meaning your entire filesystem). The second partition is where the ```/boot``` partition is mounted, and the final partition says __SWAP__ in the far right meaning this is a Linux SWAP partition--used by the operating system for moving data in and out of RAM in chunks at a time or called *pages*.

You can create partitions on a new disk for a fresh OS installation or just create a single partition to contain data.  The program mentioned above to create partitions is a program called ```fdisk```.  The ```fdisk``` command is considered an essential and standard Linux tool and is part of the [util-linux](https://en.wikipedia.org/wiki/Util-linux "Util Linux") package.  The best command to get started with when dealing with new disks and creating partitions is ```sudo fdisk -l```.  This commmand will list the current existing disks and any partitions they may have.  It will also report the undetermined state of any newly attached disks.  See the image below for a sample output.  If you are using Fedora 22/23 you will see a bit of a different output, you will see partitions labeled __LVM__ which will be explained at the end of the chapter.  Ubuntu has the option to use ```fdisk``` traditional partitioning by default.

![*sudo fdisk -l*](images/Chapter-12/fdisk/valid-parition.png "fdisk")  

![*sudo fdisk -l*](images/Chapter-12/fdisk/not-valid-parition.png "fdisk")    

The history of the Linux ```fdisk``` command goes way back.  Stemming from the early 1990's Hard drives at that time using the standard BIOS of the day were only allowed 4 __primary partitions__ on the operating system.  At those times, hard drives were small, and devices were expensive, and things we take for granted now, like optical drives, didn't really exist, so 4 primary partitions was thought to be more than anyone would ever need.  A primary partition could be broken up into an __extended partition__. Then each __extended partition__ could be further sub-divided into as many __logical partitions__ that fit on the drive.  At that time only one __primary partition__ could be active (or bootable and seeable) at a time, all other primary partitions would be hidden from the currently active operating system.  In this world ```fidsk``` was built, hence its concern with partitioning.  There has been an improvement since 2000 called LVM, which is covered and thankfully used almost exclusively now by default.

To work/modify a device that has no exsiting partitions (say ```sdb``` in the image above). From the TLDP documentation regarding how to use ```fdisk```: [^122]  

*"fdisk is started by typing (as root) fdisk device at the command prompt. Device might be something like /dev/hda or /dev/sda (see Section 2.1.1). The basic fdisk commands you need are:"* 

  * p print the partition table 
  * n create a new partition 
  * d delete a partition 
  * q quit without saving changes 
  * w write the new partition table and exit 

To succesfully create a partition on a new drive, let's select ```sdb``` in the example above.  The command ```sudo fdisk /dev/sdb``` will enter into ```fdisk``` and operate on this device.  Remember all *devices* are accessed through file handles in the ```/dev``` directory. Upon executing this command you are greeted with a status message reporting that the partition type cannot be detected or is not valid.  The error message seems a bit dated because you notice that it mentions DOS, SUN, SGI, and OSF--all outdated or unused partition types.  Similar to different languages or dialects, a partition also has to speak to an Operating system, and each operating system does it a bit different because of how particiualr filesystems are architected.  Fortunately this is a simple choice for us as we only need a Linux and a Linux SWAP partition for our uses--the rest are just artifacts of the past.

![*sudo fdisk /dev/sdb*](images/Chapter-12/fdisk/fdisk.png "fdisk")
  
  Always type __m__ for menu because the single letter commands are not intuitive.  
  
![*m for menu*](images/Chapter-12/fdisk/m-for-menu.png "Menu")
  
  If you type the letter __l__ you will see the entire list of possible partitions, we are onyl interested in the value hex 82 and 83.  The next command to type is __p__ for printing out the current partition table--which will be blank.

![*p for print*](images/Chapter-12/fdisk/p-for-print.png "Print")


  
### Filesystems

  ext2, ext3, ext4, XFS, BTRFS, ZFS 
  
### Disk related tools

  df and dh  
  
## Mounting and Unmounting of disks

  mount, umount, /etc/fstab    

## Logical Volume Manager

  repeat the previous sections with LVM commands
  
  LVM created in 1998
   
## Chapter Conclusions and Review

   In this chapter we learned and mastered the tools and concepts needed to manage, create, and format disks in Linux.  We learned how to inspect and how to mount and umount these drives from our system.
 
### Review Questions

  Questions go here

### Podcast Questions

 Questions go here

### Lab

 Lab goes here 
 
#### Footnotes
 
[^122]: [http://tldp.org/HOWTO/Partition/fdisk_partitioning.html](http://tldp.org/HOWTO/Partition/fdisk_partitioning.html)


 
 