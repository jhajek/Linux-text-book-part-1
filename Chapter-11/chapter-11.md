#  Filesystems: Creating, Partitioning, and Mounting
![*Easy as cake...*](images/Chapter-Header/Chapter-11/server_problem-2.png "Server Problem")

### Objectives

   * Compare and contrast different Linux filesystems
   * Understand how to create and attach virtual disks
   * Understand how the ```fdisk``` command is used to list, modify, and create filesystem partitions
   * Understand Linux tools relating to filesystems, disk utilization, and mounting
   * Understand how Logical Volume Management, extents, and disk based partitions differ

### Outcomes

  At the conclusion of this chapter you will be able to add additional virtual disks to any Linux version installed in Virtual Box.  You will be able to format devices and create filesystems on newly formatted devices.  You will understand how to partition a device and install filesystems.  This chapter will give you experience with the tools needed to perform these actions.  We will study the LVM -- Linux Volume Manager and its new concept for dealing with disks.  Finally we will learn the concept of mounting and unmounting of disks.

## Storage Types

In looking at the prices of disk based storage from the Fall of 2015, a single terabyte Western Digital Blue hard drive was selling for ~$50.  In the time since, the proce of storage has only decreased. Storage is cheap and with that in mind, adding *storage* or *capacity* to a system is trivial.  In fact the types of storage available since 2015 have changed drastically.  

### Mechanical Hard Drives HDDs

The orginal, cheapest, and densest storage type in dollars per meagbits is still a mechanical harddrive.  Often refered to as an HDD[^135].  

![*Hard Drive*](images/Chapter-11/hdd/256px-Laptop-hard-drive-exposed.jpg "Hard Drive Internals")

These are made up of spinning platters where bits are stored via magnetic charge.  These systems have down sides in that parts of the surface ware out over time as well as they have mechanical parts (servos) that can fail over time.  They require constant amounts of power and if you scale this over large data centers these costs can quickly add up.  In addition as the size of storage density has increased, the need to develop new storage mediums has arisen.  What was once a single magnetic platter, became three parallel platters, then became five spinning platters, which then became glass platters, which then became vertical electron based storage (somehow they got electrons to stand up instead of lay flat), then moving the latest Helium filled 10 TB disks.   Along the way with this growth technologies such as the SATA 1,2, and 3.x bus technology was introduced for transmitting data faster from the disk to the CPU.  Also on-disk based cache memory was added which was essentially a 16-64mb disk on the disk to cache frequently accessed data.  On top of that [NCQ](https://sata-io.org/developers/sata-ecosystem/native-command-queuing "Native Command Queueing") - Native Command Queueing was introduces which looks at disk requests on the drive and reorders them to reduce round trips that a disk needs to make.  All of this is happening at 5400-7200 rpms, revolutions per minute.

### Solid State Drives SSDs

In early 2012, a new medium called a Solid State Drive, or SSD was relased.  These drives were different than mechanical disks because they relied on Flash Memory (SLC or MLC) and had disk based controllers to address this data.  The imeediate advantage was that electrons move at the speed of light so the access time of any single bit was identical, compared to a mechanical drive which had to rotate into positon to read the correct bits.  The increased speeds dramatically and while the original SSDs storage was low and comparitvely today the dollar per megabit ration is not as good as a HDD, the read based access time was orders of magnitude faster.

  SATA Version              Throughput
---------------------  -----------------------
  SATA revision 3.2      16 Gbit/s 1.97 GB/s
  SATA revision 3.0      6 Gbit/s  600 MB/s
  SATA revision 2.0      3 Gbit/s  300 MB/s
  SATA revision 1.0      1.5 Gbit/s 150 MB/s


![*Standard SSD connector*](images/Chapter-11/ssd/256px-Super_Talent_2.5in_SATA_SSD_SAM64GM25S.jpg "Standard SSD connector")[^134]

The orginal SSD disks were put out by RAM manufactureres and had RAM controller write issues.  The good ones were built by Intel and Samsung.  The other manufactures have caught up and you can get drives in 256, 512, and 1 TB sizes.  Since there are no moving parts the battery or power usage is far reduced from an HDD.  SSDs do have potential issues with ware leveling and block failure, but in the chips controlling these devices the manufactureres have built in protection against failing flash memory chips to spread out the disk writes to prolong their lives. These SSD drives use the standard SATA data trasnfer protocols allowing them to be drop in replacements and allowing the initial bandwidth limitiation that HDDs suffered to be overcome.  

As a price point marketing creation you might see SSHDs which are called Hybrid Drives.  They contain 4 to 16 GB of flash disk and the rest of the drive is a mechanical 3 to 5 platter disk.  This is supposed to give you the advantage of cahcing frequent data on the flash data, but the idea never caught on as the price of SSD and HDD both have dropped drastically, making this solution not neccesary.  

### NVMe

The latest incarnation of SSD disk based technology is [NVMe](https://en.wikipedia.org/wiki/NVM_Express "Wikipedia Article for NVMe") which stands for Non-Volatile Memory Express. These are solid state drives, but instad of sending data over the SATA interface, they conenct directly to the high-speed PCIe bus, just like your video card does.  The advantage is in using the PCIe bus[^136] you gain the ability to transmit in 1 to 4x parallel transfer lanes as opposed to a serial fashion which SATA was designed for.  NVMe comes in expansion card factor and comes in the smaller [M.2 form factor](https://en.wikipedia.org/wiki/M.2 "M.2 form factor")[^137]. The price is high as the technology is still reletively new, but the performance gain is worth the investment.

   PCIe Version     Per Lane Throughput        1x        4x          8x        16x
-----------------  ----------------------  ---------- ---------- ---------- -----------
     PCIe 1.0       2 Gbit/s (250 MB/s)     2 Gbit/s   8 Gbit/s   16 Gbit/s  32 Gbit/s
     PCIe 2.0       4 Gbit/s (500 MB/s)     4 Gbit/s   16 Gbit/s  32 Gbit/s  64 Gbit/s
     PCIe 3.0       7 Gbit/s                7 Gbit/s   28 Gbit/s  56 Gbit/s  112 Gbit/s
     PCIe 4.0       15 Gbit/s               15 Gbit/s  60 Gbit/s  120 Gbit/s 240 Gbit/s

![*mini-Sata and M.2*](images/Chapter-11/ssd/M.2_and_mSATA_SSDs_comparison.jpg "mini-Sata and M.2")

The future of disk is something of a hybrid between ram and solid state/flash memory.  Intel launched trademakred platform called [Optane](https://www.howtogeek.com/317294/what-is-intel-optane-memory/ "Intel Optane").  The target is cloud based servers running OS Containers and Virtualized platforms.  The idea is to increase the speed of hard disk to the point that is is close to or equal in speed to RAM (Non-volitile memory).  There by elimating potential system bottleneck and making the platform of memory a sinlge platform.  As of 2018 the cost and technology is still a bit prohibitive, but this is where the industry will move in the next 5 to 10 years.

### Virtual Hard Drives

When dealing with Virtual Machines, we can attach and detach storage very easily.  With large deployments of VmWare, and Cloud based services, in place disk cna be reformated and used to attach virtual disks to a virtual machine - with the added ability to manipulate these hard drives as if they were simple files.

### Disk Management in VirtualBox

For this chapter we will assume that you are using Virtual Box 5.x, but these concepts apply to any virtual machine or Hypervisor.  This also assumes you have free space on your computer.  Since the point of this lab is to explore and not prouction usage, you may want to get an external USB drive and use that for this chapter so as not to fill up your hard drive.

With your Ubuntu or Fedora virtual machine powered down, let's add some new disks (virtually) to your Linux system.  The first thing to do is locate the *SETTINGS* button on the VirtualBox main menu.

![*Virtual Box settings panel*](images/Chapter-11/virtual-box/settings.png "Settings")

The next menu to come up will show the *SETTINGS* options and the name of the virtual machine you are working on.

![*Virtual Box settings menu*](images/Chapter-11/virtual-box/settings-menu.png "Settings Menu")

\newpage

Select the *STORAGE* option from the menu on the left--this is where you can attach, detach, and modify virtual disks in Virtual Box.  In most cases these will be hard drives, but there is the ability to attach ISO images to a virtual cd-rom device as well.  That option is in the top half where you see *Controller: IDE*. Under that you might see the term *EMPTY* or you might see a virtualbox-guest-additions.iso attached. 

![*Storage menu*](images/Chapter-11/virtual-box/storage.png "Storage")
\newpage

We will be working with attaching virtual hard drives so we are interested in the bottom portion of the menu which is identified by *Controller: SATA* which is your [Serial ATA](https://en.wikipedia.org/wiki/Serial_ATA "Serial ATA") hard drive bus connection.  As a refresher, Serial ATA is the name of the signalling protocol the operating system uses to retrieve data from a hard drive. Go ahead and highlight the SATA Controller entry.  

In order to add a new hard drive to your virtual machine, click the blue HDD icon with a __+__ sign at the bottom of the menu.

![*Add Storage Icon*](images/Chapter-11/virtual-box/add-storage-icon.png "Storage Icon")

Upon completion of that step a new menu will pop out of the HDD icon and give you and option to *Add Hard Disk*.

![*Add Storage*](images/Chapter-11/virtual-box/add-storage.png "Add Storage")
\newpage

Once you have selected *Add Hard Disk* a familiar set of screens come up, these are the same screens you walked through in chapter 2, and the same set of screens you walk through when setting up a new virtual machine.  You are presented first with an option to create a new disk or attach an existing one.  Usually you want to create a new disk.  

![*Create New Disk*](images/Chapter-11/virtual-box/create-new.png "Create New")

Once that is selected you will be presented with the virtual disk type screen.  Since we will be working with Virtual Box, the default setting of VDI (VirtualBox Disk Image) will be the best selection.  But if you know this VM will be moving to another platform--you may want to choose accordingly.

![*VDI step-through*](images/Chapter-11/virtual-box/vdi.png "VDI")
\newpage

The next page allows you to choose either a dynamic or static allocated hard drive.  Dynamic is usually the best when you are working on a laptop or other development system, as you will be creating and destroying virtual machine rapidly, and static allocations of multiple gigabytes can become an issue after some time due to your disk filling up.

![*Dynamic Filesystem*](images/Chapter-11/virtual-box/dynamic.png "Dynamic")
\newpage

This next screen allows you to change the location of where the virtual hard disk will be stored, as well as adjust the size of this new partition.  
![*Hard Drive Size*](images/Chapter-11/virtual-box/size.png "Size")
\newpage

Once you see the screen below - it means you have successfully created a new virtual hard drive and have attached it to your virtual machine.  You can reverse the above operations by highlighting the virtual disk drive of choice and selecting the HDD icon with the minus sign and that will delete the hard drive.  But I recommend against that as your operating system won't know what happened and that could cause system instability.  Always best to unmount a partition from inside the operating system first before deleting the virtual hard drive. By highlighting the new disk or existing one, you can see the meta-data about the disk.

![*Succesfully Added New disk*](images/Chapter-11/virtual-box/new-disk.png "New")

![*Disk Information*](images/Chapter-11/virtual-box/information.png "Information")

Adding a virtual disk is only the first step, there are three more steps before we can use this disk.  We need to:

1) partition the disk
1) create a filesystem
1) and then mount the disk so that it can be used by your operating system.

## Disk Partitioning and Formatting

According to the ```fdisk``` man page, ```fdisk``` is a dialog-driven program for the creation and manipulation of partition tables.  The term __partition__ in relation to a hard drive is an important concept.   You can think of a brand new hard drive as a large plot of land, multiple acres of land.  The land itself in that form is not very useful, just as a new hard drive added into your system is not very useful.  Just as that land needs to be partitioned up into different uses and functions, a hard drive needs to know where it's partitions are.    Each disk can have multiple partitions.  

Linux inherited a way to name each device and reference certain partitions attached to a system.  Windows simply uses the letter C, D, E, and so forth.  Linux and Unix use a device/partition nomenclature.  You can see this currently by typing the ```lsblk``` command, which will print out currently all the block devices, their device name and their partitions in a nice tree based format.

![*lsblk output from a virtual machine with 2 additional drives attached*](images/Chapter-11/fdisk/lsblk.png "lsblk")

Here you will note that the drives are references by the prefix __sdx__ with the __x__ being the alphabet letter in incremental order.  Meaning that the first disk drive that your system detects in labeled __sda__, the next one would be __sdb__, and can you guess what the third and fourth system would be?  In the image above you notice that __sda__ has 3 partitions, sda1, sda2, and sda5.  These three partitions were created at installation time by the default Linux installer.  The first partition you can see has the character ```/``` in the far right column.  That is where the __root__ partition is mounted (meaning your entire filesystem). The second partition is where the ```/boot``` partition is mounted, and the final partition says __SWAP__ in the far right meaning this is a Linux SWAP partition--used by the operating system for moving data in and out of RAM in chunks at a time or called *pages*.

You can create partitions on a new disk for a fresh OS installation or just create a single partition to contain data.  The program mentioned above to create partitions is a program called ```fdisk```.  The ```fdisk``` command is considered an essential and standard Linux tool and is part of the [util-linux](https://en.wikipedia.org/wiki/Util-linux "Util Linux") package.  The best command to get started with when dealing with new disks and creating partitions is ```sudo fdisk -l```.  This command will list the current existing disks and any partitions they may have.  It will also report the undetermined state of any newly attached disks.  See the image below for a sample output.  If you are using Fedora 22/23 you will see a bit of a different output, you will see partitions labeled __LVM__ which will be explained at the end of the chapter.  
\newpage

![*sudo fdisk -l*](images/Chapter-11/fdisk/valid-partition.png "fdisk")  

![*sudo fdisk -l*](images/Chapter-11/fdisk/not-valid-partition.png "fdisk")    

The history of the Linux ```fdisk``` command goes way back.  Stemming from the early 1990's Hard drives at that time using the standard BIOS of the day were only allowed 4 __primary partitions__ on the operating system.  At those times, hard drives were small, and devices were expensive, and things we take for granted now, like optical drives, didn't really exist, so 4 primary partitions was thought to be more than anyone would ever need.  A primary partition could be broken up into an __extended partition__. Then each __extended partition__ could be further sub-divided into as many __logical partitions__ that fit on the drive.  At that time only one __primary partition__ could be active (or bootable and seeable) at a time, all other primary partitions would be hidden from the currently active operating system.  In this world ```fidsk``` was built, hence its concern with partitioning.  There has been an improvement since 2000 called LVM, which is covered and thankfully used almost exclusively now by default.

To work/modify a device that has no existing partitions (say ```sdb``` in the image above). From the TLDP documentation regarding how to use ```fdisk```: [^122]  

*"fdisk is started by typing (as root) fdisk device at the command prompt. Device might be something like /dev/hda or /dev/sda (see Section 2.1.1). The basic fdisk commands you need are:"*

  * p print the partition table
  * n create a new partition
  * d delete a partition
  * q quit without saving changes
  * w write the new partition table and exit

To successfully create a partition on a new drive, let's select ```sdb``` in the example above.  The command ```sudo fdisk /dev/sdb``` will enter into ```fdisk``` and operate on this device.  Remember all *devices* are accessed through file handles in the ```/dev``` directory. Upon executing this command you are greeted with a status message reporting that the partition type cannot be detected or is not valid.  The error message seems a bit dated because you notice that it mentions DOS, SUN, SGI, and OSF--all outdated or unused partition types.  Similar to different languages or dialects, a partition also has to speak to an Operating system, and each operating system does it a bit different because of how particular filesystems are architected.  Fortunately this is a simple choice for us as we only need a Linux and a Linux SWAP partition for our uses--the rest are just artifacts of the past.

![*sudo fdisk /dev/sdb*](images/Chapter-11/fdisk/fdisk.png "fdisk")

  Always type __m__ for menu because the single letter commands are not intuitive.  

![*m for menu*](images/Chapter-11/fdisk/m-for-menu.png "Menu")

  If you type the letter __l__ you will see the entire list of possible partitions, we are only interested in the value hex 82 and 83.  The next command to type is __p__ for printing out the current partition table--which will be blank.

\newpage

![*p for print*](images/Chapter-11/fdisk/p-for-print.png "Print")

The next step is to type the __n__ command to create a new partition.  You will be presented with two choices for your new partition.  In this case you can select __primary partition__.  In most cases in creating data drives you can select primary partitions without concern.  If you find yourself creating many data drives or creating triple and quad bootable systems (multiple operating systems)  then you will want to conserve those primary partitions and use __extended/logical__ partitioning.  

![*n is for new partition*](images/Chapter-11/fdisk/n-for-new.png "New")

You are then presented with a series of options to choose a partition number, the beginning sector of your partition (usually best to choose the default) and the finishing sector (how big do you want your disk).  You can specify in a known quantity of K=kilobytes, M=megabytes, G=Gigabytes and prefacing that value with a __+__.  Selecting the default for the option of last sector will automatically fill up your disk with 1 single large partition.

![*New Partition Options*](images/Chapter-11/fdisk/n-options.png "Options")

Let's see if our partition was created successfully.  You can type __m__ to display the menu again or type the __p__ directly to print out the current partition table.  You will notice that it has been modified.

![*Successful Partition Creation*](images/Chapter-11/fdisk/p-finished.png "Finished")

\newpage

Everything looks good, but DON'T QUIT YET!  If you type __q__ now your changes will not be saved, and no partition information will be written.   Now you need to type __w__ to write the new partition data to the disk you are working on. The __w__ command will write and quit out automatically for you. After writing this partition data, you will see if show up in the ```sudo fdisk -l``` command.  After you see your new partition in ```fdisk``` of ```lsblk``` you are ready to move on to the next step of formatting a partition with a filesystem.

![*Write the Partition table data to disk*](images/Chapter-11/fdisk/w-for-write.png "Write")

### Drawbacks of disk partitions

Using the ```fdisk``` command does have its drawbacks.  The tool was designed in the day when systems had 1 or 2 hard drives.  Filesystems handled small files and the idea of large files partitions that spanned multiple disks was not possible due to software and processor limitations.  But we see with the cost of disk alone, systems having 24 or more hard drives is not unheard of.  Most filesystems were disgned around the limitations of ```fdisk``` and since then new solutions have been designed to overcome the limitations of partitions such as LVM and filesystem extents, which we will cover at the end of this chapter.

## Filesystems

To extend our analogy of a disk drive being like land, and a partition being like different lots of land sold off to different people, then a filesystem would be the actual building that is built on the property to make use of the land, be it farm land, nature preserve, solar plant, or factory.  A __filesystem__ is the way that an operating system addresses, stores, and retrieves data stored on a disk.  It is an in-between layer so the operating system can have an addressing scheme for data, without having to know the exact mapping of the particular disk drive in question.

If you have used Windows before you are familiar with Fat32 and NTFS filesystems. Since Windows is created and curated by Microsoft, there has only been two different filesystems in the history of Windows.  Linux on the other-hand supports multiple different filesystems that serve many different purposes.  

### ext/ext2

The MINIX filesystem was the first Linux based filesystem released in 1991.  It was borrowed conceptually from the Minix operating system that Andrew Tanenbaum had created. It had severe limitations since MINIX filesystem was engineered to be *ultra* backwards compatible--hence had 16 bit offsets and had a maximum partition size of 64 megabytes.  By 1992 and Linux 0.96c a new filesystem replacement called __ext__ was created and brought into Linux as the native filesytem.   By January of 1993, __ext2__ had been created and additional features added, including future proofing the system by adding unused options that could later on be tested and added as need arose.  Like most operating systems, data is broken up into __blocks__, which is the smallest sized piece of data that can be read or written [^123].  

: Limits of ext2

----------------------  ------- ------- ------- -------   
Block size:              1 KiB   2 KiB   4 KiB   8 KiB
max. file size:          16 GiB 256 GiB  2 TiB   2 TiB
max. filesystem size:    4 TiB  8 TiB    16 TiB  32 TiB
----------------------  ------- ------- ------- -------   

Traditionally your ```/boot``` partition is formatted as __ext2__ because it is only used for a short time to load your *initrd* and *kernel image* into memory, so the overhead of __ext4__ is not needed.  You can use the built in ```sudo mkfs``` command to format a partition with __ext2__.

### ext3/ext4

As filesystems became larger and the amount of data being written increased, the chances for data corruption or writes to fail became more evident and critical.  The CPU could now handle to overhead of managing data writes to disk to ensure that those operations actually happened.

 *"A journaling file system is a file system that keeps track of changes not yet committed to the file system's main part by recording the intentions of such changes in a data structure known as a "journal", which is usually a circular log. In the event of a system crash or power failure, such file systems can be brought back online quicker with lower likelihood of becoming corrupted[^124][^125]."*

Not to be confused with journald from systemd, the __ext3__ filesystem, introduced to the Linux kernel the journaling feature in 2001. Being an extension basically of __ext2__, __ext3__ began to inherit legacy problems of __ext__ and __ext2__ as thwy were now over a decade old.  

: Limits of ext3

Block size   Max file size   Max file system size
----------- --------------- ----------------------
  1 KiB         16 GiB             4 TiB
  2 KiB         256 GiB            8 TiB
  4 KiB         2 TiB             16 TiB
----------- --------------- ----------------------  

By 2008 it became appearant that ext3 has reached the end of its development, and [Theodore Ts'o](https://en.wikipedia.org/wiki/Theodore_Ts%27o "Ts'o") announced that __ext4__ would extend the __ext__ filesystem a bit longer, but the growth of __ext__ had hit the end, and a newer filesystem needed to be developed to handle the larger sets of data and the massively improved hardware that existed since 1992, when ext was developed.

Ext4 saw the capacity extension of __ext3__ and introduction to __extents__. The __ext4__ filesystem can support volumes with sizes up to 1 exibyte (EiB) and files with sizes up to 16 tebibytes (TiB).

In ext4, __extents__ replaced the traditional block mapping scheme used by ext2 and ext3. An extent is a range of contiguous physical blocks, improving large file performance and reducing fragmentation. A single extent in __ext4__ can map up to 128 MiB of contiguous space with a 4 KiB block size [^126].  

Theodore Ts'o is a respected developer in the open source community, who currently is the maintainer of __ext4__ and is employed by Google to develop filesystems.  __Ext4__ is the current default file system for most Linux distros.  It is well tested and a well known quantity and is currently used by Google in Android devices as well.  To format a partition using the __ext4__ filesystem you would simply type ```mkfs.etx4```  and the partition will be formatted. You normally don't format entire devices, just partitions, which can take up entire disks. There are three additional competing filesystems that fill the voids left by __ext4__.

## Logical Volume Manager

In order to enhance processing you may in your partitioning decisions want to place certain portions of the file-system on different disks.  For instance you may want to place the ```/var``` directory on a different disk so that system log writing doesn't slow down data stored int he users home directories.  You may be installing a MySQL database and want to move the default storage to a second disk you just mounted to reduce write ware on your hard disks.  These are good strategies to employ, but what happens as the hard disks in those examples begin to fill up?  How do you migrate or add larger disks?

The question is under standard partitioning you don't. You simply backup, reinstall, and reformat the entire drive.  This is very time consuming and a risky operation that is usually not taken lightly.  What to do?  A solution to this problem and the limitations of traditional disk partitions is called LVM, [Logical Volume Management](http://tldp.org/HOWTO/LVM-HOWTO/ "LVM"), created in 1998.  LVM version 2 is the current full featured version baked in to the [Linux kernel since version 2.6](https://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux) "LVM 2").

LVM is a different way to look at partitions and file-systems.  Instead of the standard way of partitioning up disks, instead we are dealing with multiple large disks.  As technology progressed, we took our single large disk that we had split into partitions with __fdisk__ and now we supplemented it with multiple disks in place of those partitions.  The Linux kernel needed a new way to manage those multiple disks, especially in regards to a single file system.  *"Logical volume management provides a higher-level view of the disk storage on a computer system than the traditional view of disks and partitions. This gives the system administrator much more flexibility in allocating storage to applications and users[^130]."*  In order to install LVM2 on Fedora/Centos and Ubuntu you can type:

* ```sudo apt-get install lvm2```
* ```sudo dnf install lvm2```
* ```sudo yum install lvm2```

\newpage

![*LVM diagram*](images/Chapter-11/LVM/LVM.png "LVM")

This diagram creates three concepts to know when dealing with LVM:

*  Volume Group (VG) - The Volume Group is the highest level abstraction used within the LVM. It gathers together a collection of Logical Volumes and Physical Volumes into one administrative unit [^131].
*  Physical Volume (PV) - A physical volume is typically a hard disk, though it may well just be a device that 'looks' like a hard disk (eg. a software raid device) [^132].
*  Logical Volume (LV) -  The equivalent of a disk partition in a non-LVM system. The LV is visible as a standard block device; as such the LV can contain a file system (eg. /home) [^133].
    + Physical Extent (PE) - This is the unit of storage (blocks) that a PV is split into
    + Logical Extent (LE) - This matches the PE and is used when multiple PVs are added to an LG, to make the *logical disk*.  The LVM counts how many extents are possible and makes this its *disk* so to speak.

### Physical Volumes

The first thing to do in creating an LVM partition is to figure out what kind of disks you have and what kind of partition scheme you want to use.  Note that you can choose to use the entire disk ```/dev/sdb``` for instance or you can create a partition on the disk for use with LVM; if you do make sure to create the partition of type __0x8E__ LVM and not a standard Linux partition. In order to use entire disks you need to use the ```pvcreate``` command to *create* physical volumes, same case with the partition.

### Volume Groups

Once you have added the disks/partitions to the PV, now you need to create a Volume Group (VG) to add those PVs to.  The command to add PVs to an LG is: ```vgcreate VOLUME-GROUP-NAME /dev/sdx /dev/sdy```. You can extend this volume group by simply adding another ```pvcreate /dev/sdx1``` command for example and then using the ```vgextend VOLUME-GROUP-NAME /dev/sdz```.  There is also a ```vgreduce``` command that will remove a PV from a Volume Group.  The volume group allows for a single logical management unit for multiple disk/partitions.  This is useful as well for adding additional storage and removing storage devices that may have failed or are not performing at required parameters.  

### Logical Volumes

From within our Volume Group (VG) we can now carve out smaller LV (Logical Volumes).  The nice part here is that the Logical Volumes don't have to match any partition or disk size--since they are logically based on the combined size of the Volume Group which has extents mapped across those disks.  Use the command ```lvcreate -n LOGICAL-VOLUME-NAME --size 250G VOLUME-GROUP-TO-ATTACH-TO```. The ```vgdisplay``` command will show what had been created and what is attached to where. There are options to make the LV striped extents as opposed to Linear, but that is an application based decision.  Since LVs are logical they can also be extended and reduced on the fly--that alone is a better replacement for standard partitioning.  The command ```lvextend -L 50G /dev/VOLUME-GROUP-NAME/LOGICAL-VOLUME-NAME``` will extend the LV to become 50 GB in size.  Using ```-L+50G``` will add 50 additional gigabytes to an existing LV's size.

Once you have successfully created an LV, now it needs a file-system installed.  Here you can add XFS, Btrfs, ZFS, Ext4, Ext2, or any other file-system.   You would use the ```mkfs``` proper tool for your filesystem.  Once you have the file-system created then you need a mount point just as with traditional partitions and mounting.  Each file-system type (XFS, Btrfs, Ext4, etc etc) has tools that allow you to extend the file-system automatically without the need to reformat the entire system, if the underlying LV or traditional partition is modified.  Not all file-systems have the built in ability to shrink an existing partition.

One definite feature not included in traditional partitioning is the concept of ```snapshots```.  Now ```snapshots``` exist at the file-system level too in (Btrfs and ZFS, but not XFS or ext4 they are too old.  The command ```sudo lvcreate -s -n NAME-OF-SNAPSHOT -L 5g VOLUME-GROUP-NAME``` creates a LV volume that is a snapshot or COW, Copy-on-Write partition.  It often can be smaller, because this new LV is only going to copy the changes, or deltas, from the original LV, not duplicating data but sharing it between the two LVs.   This delta can be merged back in, returning you to a point in time state, via the ```sudo lvconvert --merge``` command.  Also snapshot can be *promoted* to be a full LV that can be copied and mounted itself as a full LV.

LVM is a sperate component from traditional filesystems and was seen as a stop gap method until newer filesystems could be created that would effectively do the samething as LVM + Ext4. Filesystems like XFS, btrfs, or ZFS have been developed and integrated to the Linux Kernel.

### Filesystem Snapshots

When dealing with LVM there is an ability to provide a snapshot, that is a point in time exact copy of a logical volume[^139].  Assuming your have your physical volumes, your volume groups, and logical volumes created, lets now create a snapshot of a logical volume (assume that we formated the logical volume with ext4 and mounted it to ```/mnt/disk1```).  

```bash
cd /mnt/disk1
# command to create a random file of 5MB
head -c 5MB /dev/urandom > datafile.txt
ls -l
# Picking up from the tutorial at http://tldp.org/HOWTO/LVM-HOWTO/snapshots_backup.html
lvcreate -L592M -s -n disk-backup /dev/volgroupname/logicalvolname
# Type the random command to change the data since the original snapshot
head -c 25MB /dev/urandom >> datafile.txt
# You will now have a new device called /dev/volgroupname/disk-backup
# Mount this to /mnt/disk2
sudo mkdir -p /mnt/disk2
sudo mount -t ext4 /dev/volgroupname/disk-backup /mnt/disk2
cd /mnt/disk2
ls -l
ls -l /mnt/disk1
# What do you see?  Why?
```

You can remove the snapshots by unmounting the partition ```umount``` and the using the ```lvremove``` command.  How would you do this same process using ext4 without LVM?  

### XFS

XFS is a robust and highly-scalable single host 64-bit journaling file system. It is entirely extent-based, so it supports very large files and file system sizes. The maximum supported file system size is 100 TB. The number of files an XFS system can hold is limited only by the space available in the file system[^127].

XFS was originally created by SGI (Silicon Graphics Inc) back in 1993 to be a high-end Unix work station filesystem.  SGI was the company that made computers in the 1990's for high end move special effects and graphical simulation.  They had their own version of Unix called IRIX, and needed a filesystem capable of handling large files at that time, and places like NASA which had large amounts of data to store and access.  SGI created XFS to suit that need.  XFS excels in the execution of parallel input/output (I/O) operations due to its design, which is based on allocation groups (a type of subdivision of the physical volumes in which XFS is used-also shortened to AGs). Because of this, XFS enables extreme scalability of I/O threads, file system bandwidth, and size of files and of the file system itself when spanning multiple physical storage devices[^127].

XFS was ported to Linux in 2001, as SGI and IRIX went out of business and the filesystem languished.  It was opensourced and GPL'd in 2002.  RedHat began to see this filesystem as an alternative to ext4 and more mature than other replacements since it had over 10 years of development from the start to handle large scale files.  RedHat also hired many of the SGI engineers and developers who created this filesystem and brought back into production quality.  RedHat began with RHEL 7 to deprecate ext4 as the default filesystem and implement XFS as their standard filesystem.  

XFS is notoriously bad at being used by an everyday computer because its strength is build on using a system storing large database files or archiving large files.  You can install the tools needed to make a partion of the XFS format by typing ```sudo apt-get install xfsprogs```; the XFS tools are already installed on Fedora and CentOS by default.  You can create an XFS filesystem using the ```sudo mkfs.xfs``` command.  We can grow an XFS filesystem with the command ```xfs_growfs /mount/point -D size```.  

### Btrfs

Theodore Ts'o has recommended moving to Btrfs (pronounced *butter fs*) as a replacement for ext4 moving forward, but development on btrfs is still in beta and not quite stable for production.   Btrfs uses copy-on-write, which is a strategy where as multiple processes using the same piece of data, don't make copies of it each, but use pointers to the initial data, thereby speeding up the system, reducing the number of writes needed. The project was initially created by Oracle in 2007, for use on their own storage products, but was GPL'd and now many companies contribute to the codebase.  Development continued on Btrfs after Oracle aquried the ZFS filesystem when they bought Sun. The project is marked stable and included in the Linux kernel since July of 2013.  

Chris Mason, the principal Btrfs author, has stated that the goal was, *"to let Linux scale for the storage that will be available. Scaling is not just about addressing the storage but also means being able to administer and to manage it with a clean interface that lets people see what's being used and makes it more reliable[^128]."*

Btrfs adds support for resource pooling and using extents to make logical drives across physical devices. It also includes snapshoting of files--for point in time restore and in place cloning, and checksuming and becomes a replacement for LVM + Ext4.  In order to format a system using Btrfs you need to install ```btrfs-tools``` on Ubuntu and ```btrfs-progs``` on Fedora.  Suse Linux is the only major Linux distribution that has adopted btrfs as the default filesystem on their [Enterprise Edition Linux](https://www.suse.com/documentation/sles-12/singlehtml/stor_admin/stor_admin.html#sec.filesystems.major.btrfs "Suse Linux adopts btrfs as default"). Though Facebook has made a signigficant investment and use of Btrfs and though they are not a Linux Distro company, they have [a large vested interest in Btrfs](https://facebookmicrosites.github.io/btrfs/ "Facebook uses btrfs"). [Oracle maintains the documentation for btrfs](https://docs.oracle.com/cd/E37670_01/E37355/html/ol_create_btrfs.html "Oracle maintains the documentation for btrfs").

  * ```sudo dnf install btrfs-progs```
  * ```sudo yum install btrfs-progs```
  * ```sudo apt-get install btrfs-tools```

### ZFS

A third alternative is a filesystem originally developed by Sun, called ZFS.  ZFS is an elegantly designed filesystem.   *"ZFS is a combined file system and logical volume manager designed by Sun Microsystems. The features of ZFS include protection against data corruption, support for high storage capacities, efficient data compression, integration of the concepts of filesystem and volume management, snapshots and copy-on-write clones, continuous integrity checking and automatic repair, Software based RAID, (RAID-Z)[^129]."*

ZFS was developed by Sun and inherited by Oracle.  It is not licensed under the GPL but under a Sun/Oracle license called [CDDL](https://en.wikipedia.org/wiki/Common_Development_and_Distribution_License "CDDL"), which is similar to the GPL, but allowed Sun and Oracle to include propriatary parts of the operating system with opensource code. This prevented ZFS from being adopted natively into the Linux kernel because of the GPL incompatability.  The argument of integrating CDDL based ZFS code into GPLv2 Linux Kernel was extensive with the FSF coming down in opposition of Ubuntu's interpretation of the GPL.

* [GPL Violations Related to Combining ZFS and Linux](https://sfconservancy.org/blog/2016/feb/25/zfs-and-linux/ "GPL Violations Related to Combining ZFS and Linux")
* [Interpreting, enforcing and changing the GNU GPL, as applied to combining Linux and ZFS](https://www.fsf.org/licensing/zfs-and-linux "Interpreting, enforcing and changing the GNU GPL, as applied to combining Linux and ZFS")
* [Ubuntu ZFS announcement](https://blog.ubuntu.com/2016/02/16/zfs-is-the-fs-for-containers-in-ubuntu-16-04 "Ubuntu ZFS Annoucement")

FreeBSD didn't have this restriction under the BSD license and they have had native kernel based support for ZFS since version 9 of FreeBSD and ZFS is a supported filesystem type on MacOS. As of Ubuntu 16.04, you can install ZFS via apt-get and include the CDDL licensed ZFS code on Linux as a loadable kernel module.  Ubuntu now supports the root parition being ZFS as well.  Here is an example to install the ZFS module, load the module, and then format and create a zpool logical mirror (RAID1) in a few steps,  tutorial comes from here: [https://wiki.ubuntu.com/Kernel/Reference/ZFS](https://wiki.ubuntu.com/Kernel/Reference/ZFS "ZFS Tutorial").

```bash
sudo apt install zfsutils-linux  
# In addition to be able to have ZFS on root, install:
sudo apt install zfs-initramfs

# Now check to see if the zfs module is loaded
 modprobe zfs
 lsmod | grep zfs
# change the value of sdX and sdZ to the actual device names (your entire unformated devices)
# the name "tank" is used in the tutorial -- I replaced it with mydatapool.
 sudo zpool create mydatapool mirror /dev/sdX /dev/sdZ
 lsblk
 zfs list
 df -h | grep mydatapool
```  

ZFS doesn't have native support for Fedora OS, seeing as they put their weight behind XFS and are even depricating btrfs from future RHEL releases.   A third party project called [ZFS on Linux](https://github.com/zfsonlinux/zfs/wiki/Fedora "ZFS on Linux") supports third party packages for deployment and testing on various Linux distros.  There was even a ZFS developer port who brought [ZFS to Windows](https://github.com/openzfsonwindows/ZFSin "ZFS on Windows").

Much like LVM, ZFS native support for snapshots.  ZFS has a series of commands such as:

* ```zpool```
  + create, list, destroy, status
  + creates a datapool
* ```zfs```
  + create, list, destroy
  + used to create a ZFS filesystem on a zpool
* ```zfs snapshot```
  + volume@snapname
  + ```zfs snapshot mydatapool@snap1```
  + ```zfs list -t snapshot```
* ```zfs rollback```

ZFS also has a mechanism to send and receive snapshots, which done in a small enough increments essentially creates a serialized synchronization feature.  This can be done on the same system as well as over a network conenction to a remote computer.  Try to do that on ext4.  To syncrhonize a ZFS filesystem:

* first create a snapshot of a zpool 
* Using the ```zfs send``` and ```zfs receive``` commands via a pipe you can send your snapshot to become another partiton
    +  ```zfs send datapool@today | zfs recv backuppool/backup```.  
* You can pipe the command over ```ssh``` to restore to a remote system
    + ```zfs send datapool@today | ssh user@hostname sudo zfs recv backuppool/backup```.

#### ZFS ZIL and SLOG

"*ZFS Intent Log, or ZIL- A logging mechanism where all of the data to be the written is stored, then later flushed as a transactional write. Similar in function to a journal for journaled filesystems, like ext3 or ext4. Typically stored on platter disk. Consists of a ZIL header, which points to a list of records, ZIL blocks and a ZIL trailer. The ZIL behaves differently for different writes. For writes smaller than 64KB (by default), the ZIL stores the write data. For writes larger, the write is not stored in the ZIL, and the ZIL maintains pointers to the synched data that is stored in the log record[^140]*".

"*Separate Intent Log, or SLOG- A separate logging device that caches the synchronous parts of the ZIL before flushing them to slower disk. This would either be a battery-backed DRAM drive or a fast SSD. The SLOG only caches synchronous data, and does not cache asynchronous data. Asynchronous data will flush directly to spinning disk. Further, blocks are written a block-at-a-time, rather than as simultaneous transactions to the SLOG. If the SLOG exists, the ZIL will be moved to it rather than residing on platter disk. Everything in the SLOG will always be in system memory[^140]*".

#### Additional ZFS Features

In addition there is an L2ARC cache for caching most recent and most frequently used data blocks.  This is a serpate SSD based disk and can speed up data access[^141] [^142].  The ZIL and the L2ARC if not defined on seperate disks will take a small portion of the each zpool created.  This is fine for low volume disk writes, but puts extra overhead on the system.  If you have fast SSDs that are small in size, say 30 to 80 GB, you can stripe them and place the L2ARC cache and or ZIL on these disks.  ZIL is a write only function and L2ARC cache becomes read predominant.   Using a zpool called datapool we are attaching two additional disk /dev/sde and /dev/sdf. You can add the directives for the log and cache after the zpool create command:  ```zpool add datapool cache /dev/sde2 /dev/sdf2 log mirror /dev/sde1 /dev/sdf1```.  You can use the /dev/ locations of disks, but disks can move around and be renamed.  It is often better to use the unique user ID or uuid for a disk, which doesn't change.  You can see your UUIDs with the ```blkid``` command[^141].

ZFS supports disk scrubbing.  Which will check every block of data against its own checksum meta-data and clean up andy silent corruption. ZFS has a known good list of checksums of all blocks of data, and is constantly watching for corruption of data. Scrubs do not happen automatically but can be scheduled to run periodically.  You can check the status of a disk with the command ```zpool status datapool``` and execute a scrub command ```zpool scrub datapool```.

ZFS can enable transparent compression using GZIP or LZ4 with a simple set command: ```zfs set compression=lz4 tank/log```.  This can help and there is little overhead.  Finally ZFS supports data-deduplication on a file basis.  Essentially if enabled each file is hased with sha-256 and any files that match, only 1 of the files is kept, the others have markers pointing back to this original file.  This saves the overall amount of data you are storing and can reduce costs but the cost is high in amount of ram needed to store the de-dupe tables.  

#### Finding a physical disk

![*HP HP EVA4400 storage array*](images/Chapter-11/disk/278px-HP_EVA4400-1.jpg "HP storage array")[^144]

ZFS, btrfs, and LVM have the ability to remove disks from pools and volumes.   The trouble is you can remove the disk logically--but how do you identify which physcial disk it is?  Luckily each disk has a serial number printed on the top of it.  When working in these scenarios you should have all of these serial numbers written down as well as the location of where that disk is.   You can find the serial numebr of the disk via the ```hdparm``` tool.  This script would enumerate through all of the disks you have on a sysetm and print the values out.  Note the a, b, c, are a list of the device names.  In this case there is hard drive ```/dev/sda``` through ```/dev/sdg```[^143] run the commmand on your system and see what comes out.  Depending on what processor you have, older Intel CPUs (2nd Gen Core i), might not report the disk serial number correctly for a virtualized hard drive on Ubuntu 16.04 and 18.04, but reporting correctly on Virtualized Fedora 28 and 29.

```bash

for i in a b c d e f g;
do 
echo -n "/dev/sd$i: " 
hdparm -I /dev/sd$i | awk '/Serial Number/ {print $3}'
done
```

```bash
#If you are missing those tools, just install following packages
sudo apt-get install hdparm
sudo apt-get install smartmontools
sudo apt-get install lshw

# These commands all will show you information relating to the disk serial number
# https://unix.stackexchange.com/questions/121757/harddisk-serial-number-from-terminal
sudo lshw -class disk
sudo smartctl -i /dev/sda
lsblk --nodeps -o name,serial
```

### HFS+, UFS, and APFS

The BSD systems has its own filesystem, UFS, [the Unix File System](http://www.ivoras.net/blog/tree/2013-10-24.why-ufs-in-freebsd-is-great.html "Unix Filesystem"). This filesystem was native to Unix going back to the System 7 Unix release.  Though UFS has been updated since and is officially UFS2, which was released around 1994 when BSD split from Unix due to the AT&T lawsuit.  UFS2 is considered similar to ext4 on Linux in capabilities at the current time.  FreeBSD and then other BSDs adopted ZFS to be able to extend the filesyste, capability of UFS.  All Illumos, or OpenSolaris based distros use ZFS natively as well.

Apple had been using their own filesystem called HFS+ which was introduced in 1998 in MacOS 8.1 in 1998.  Features were added over time and in each release to keep the filesystem with feature parity for ext4.  This was used as the standard file system on all Mac and iOS devices until 2016/2017 when a new Apple designed filesystem was released accross devices. Why a new filesystem?  Think about it, by 2016 what was the primary device that Apple was selling compared to 1998?  What type of storage media had HFS+ been designed for?   What type of storage media was running on the new Apple systems? Apple had another thing to taut in their new filesystem, that was encryption build in by default.

Though Apple Was one of the first companies to [port ZFS to MacOS](http://dtrace.org/blogs/ahl/2016/06/15/apple_and_zfs/ "Apple ports ZFS to MacOS"), which is BSD based, eventually they decided to deploy a new filesystem called APFS (apple filesystem) which has a mix of ZFS like features that were home grown by Apple and more importantly not under the control of another company or any particular free or opensource licenses.  The goal for Apple was to use this filesystem accross their platform, from MacOS to iOS devices with a focus on Flash bashed (SSD and NVMe) devices that HFS+ wasn't designed for.  The system has a similar feature set to ZFs and btrfs such as encryption and snapshots, but [is missing data integrity](http://dtrace.org/blogs/ahl/2016/06/19/apfs-part1/ "Review of APFS").

### DragonFly BSD and Hammer FS

DragonFly BSD developer Matthew Dillion has been spearheading the development of his own distributed cluster based filesystem called [Hammer](https://www.dragonflybsd.org/hammer/ "Hammer Filesystem").  His goal is to have finer grained snapshoting--even per file on a constant basis and make snapshots almost a constant occurance across the filesystem for easy migration of a filesystem to a Hammer slave.   Work has recently finished on the Hammer 2 FS which is bringing this idea closer to reality, Hammer 2 is available as a stable filesystem, but not yet ready for production on a cluster.

## Mounting and Unmounting of disks

Once a disk is partitioned, and formatted with a filesystem, it now needs to be mounted.   The concept of mounting came from the UNIX days of carrying a large reel of magnetic tape, and physically mounting it on a tape reader.  You can see all the mount points currently attached to your system by typing ```/etc/mtab```.  A filesystem needs to be mounted to a directory location.  Technically your root filesystem is mounted to the ```/``` partition.  

In the previous examples we we have created partitions and filesystem, now let us mount them.  The first step we need to do is provide a mount point.  Traditionally that is done in the ```/mnt``` directory.  You should create your __mountpoints__ here.   Let's type ```sudo mkdir -p /mnt/data-drive```.  The name *data-drive* is an arbitrary name I have given my newly created __mountpoint__.  The ```-p``` flag will auto-create any subdirectory under ```/mnt``` that doesn't already exist.  Why did I type ```sudo```?  Who owns the ```/mnt``` directory?  

Once this directory is created, you can use the ```mount``` command like this: ```sudo mount -t ext4 /dev/sdb /mnt/data-drive```.  The ```-t``` flag tells this mount that the filesystem is of type __ext4__ and the operating system needs to know so that it can interface correctly with the filesystem.  Once this is done, the directory will still be owned by root, you probably need to change the ownership of the directory so that you own and can write to it. How would you do that based on last chapter?  You could type ```sudo chown jeremy:jeremy /mnt/data-drive```, assuming your username is *jeremy*.

The partition can be unmounted by typing the ```umount``` command--yes it is missing the __n__.  Be careful you don't try to unmount the device while your pwd is in a directory on that mount--otherwise you will get a *device is busy error.*

### /etc/fstab  

The ```/etc/fstab``` file controls the automatic mounting of your filesystems at boot.  Every time your system boots, technically each partition is remounted every time too.  If you create your own filesystem and want it mounted automatically on boot, then you would need to add an entry here. The ```/etc/fstab``` file has 6 columns containing values listed here: ```<device> <mount point> <fs type> <options> <dump> <pass>```.

An example entry could contain these values: ```/dev/sdb1 /mnt/data-drive  ext4  defaults  0   0```.  Devices now are typically listed by their UUID, which can be found by typing ```ls -l /dev/disk/by-uuid```.  That is the actual command not a place holder. This is where the long strings you see in the ```/etc/fstab``` file in place of the device name.  There are many options that can be set in the place of ```defaults``` as well, such as:

1. sync/async - All I/O to the file system should be done (a)synchronously.
2. auto - The filesystem can be mounted automatically (at bootup, or when mount is passed the -a option). This is really unnecessary as this is the default action of mount -a anyway.
3. noauto - The filesystem will NOT be automatically mounted at startup, or when mount passed -a. You must explicitly mount the filesystem.
4. dev/nodev - Interpret/Do not interpret character or block special devices on the file system.
5. exec / noexec - Permit/Prevent the execution of binaries from the filesystem.
6. suid/nosuid - Permit/Block the operation of suid, and sgid bits.
7. ro - Mount read-only.
8. rw - Mount read-write.
9. user - Permit any user to mount the filesystem. This automatically implies noexec, nosuid,nodev unless overridden.
10. nouser - Only permit root to mount the filesystem. This is also a default setting.
11. defaults - Use default settings. Equivalent to rw, suid, dev, exec, auto, nouser, async.
12. netdev - this is a network device, mount it after bringing up the network. Only valid with fstype nfs.

### iSCSI

The [iSCSI protocol](https://en.wikipedia.org/wiki/ISCSI "iSCSI") is a reimplemntation of the SCSI disk communication protocol.  SCSI was an alternative that could move data faster than the then ATA (pre-SATA) standard.  Once SATA became available the SCSI based hardware was more expensive and was replaced by cheaper SATA and more standardized USB (for external devices). The SCSI bus was faster than the standardized ATA bus, but required a specialized adapter card and specialized cable to connect devices and external peripherals.  Think of it pre-USB (circa 1998).  This made SCSI desirable but expensive.  Also the SCSI standard continued to improve throughput but at the cost of not being backwards compatabile with older and other versions of SCSI, each had its own cabes and connectors. By the year 2000 the SCSI protocol was well known and heavily invested in for server class hardware.  In that year IBM and Cisco standardized the iSCSI protocol.  iSCSI integrated SCSI commands to external targets over Ethernet/IP.  Allowing you to seperate your disks from storage and access them over a local network via the iSCSI protocol.  Disks were formatted as LVMs or directly as a ZFS, btrfs, or XFS based drives and then presented as __iSCSI targets__ over the network. iSCSI has two components, the __iSCSI target__ and the __iSCSi initiator__. The system that connects to a target in an __initiator__.   iSCSI devices can replace the need for SAN technology (Storage Area Networks) and work on commodity hardware over basic ethernet cables and switches.  

This allows you top separate your storage and your compute.  You can even use iSCSI disks as your main harddrive and configure this during install time on most major Linux distros. All modern Oses come with support for being either a target or an innitiator.  A company called [iXsystems](https://www.ixsystems.com/ "iXsystems") has made a business out of providing ZFS based iSCSI storage devices running FreeBSD and TrueOS.

### systemd mounting units

Usually systemd will strive to absorb functions, but according to the man page for systemd.mount, *"Mounts listed in /etc/fstab will be converted into native units dynamically at boot and when the configuration of the system manager is reloaded. In general, configuring mount points through /etc/fstab is the preferred approach. See systemd-fstab-generator(8) for details about the conversion.*"   ZFS will takecare of automounting its own partitions.  Btrfs you will need to add an entry using the UUID instead of the dev name which you can find via the ```blkid``` command.

If you wanted to maintain mount points in systemd you can create a **.mount** file like this example[^138].  The file name is located in the comment below as the content of the ```What=``` directive is the output of the command ```blkid```, but could be a ```/dev/name``` as well.

```bash
# vi /etc/systemd/system/var-lib-docker.mount
[Unit]
Description=Docker mount

[Mount]
What=/dev/disk/by-uuid/5813cd72-ff30-44bc-a7a3-27c68fe3e6c7
Where=/var/lib/docker
Type=btrfs
Options=defaults

[Install]
WantedBy=multi-user.target
```

### Disk related tools

There are two useful commands to use in regards to understanding the disk resource use in regards to the filesystem.  The ```df``` command will list the disk usage.   There is an optional ```-H``` and ```-h``` which presents the file-system usage in Gigabytes (-H is metric: giga, -h is binary, gibi).  When you use ```df``` without any directories, it will list all file-systems.  The command below lists the file-system that contains the user's home directory: ```/home/controller```.

![*df -H /home/controller*](images/Chapter-11/du/df-h.png "df")  

The ```du``` command is disk usage.  This is a helpful command to show the exact *byte-count* that each file is actually using.  When using ls -l Linux reports only 4096 kb for a directories size, this does not actually reflect the size of the content inside the directory.  The ```du``` command will do that for you.  

\newpage

![*du -H --exlude=".\*" /home/controller*](images/Chapter-11/du/du-h.png "du")  

## Chapter Conclusions and Review

In this chapter we learned and mastered the tools and concepts needed to manage, create, and format disks in Linux.  We learned how to inspect and how to mount and umount these drives from our system.  We learned about the standard Linux file-systems and new advanced file-systems.  Finally we learned about file-system tools and the use of Logical Volume Management.  Finally we learned about the concept of volume management snapshotting.  You have been prepared to with the basics of how to manage and understand the file-system on your Linux distro.

### Review Questions

1) What is the fdisk program?
a) a dialog-driven program for the creation and manipulation of partition tables.
b) a filesystem creation tool
c) a tool for formatting floppy disks
d) a tool for removing disks from a system

2) What is the default Virtual Box disk type?
a) VDI
b) HDD
c) COW
d) VDD

3) After attaching a new virtual disk what is the next step?
a) partitioning
b) make a filesystem
c) mount a filesystem
d) add an extent

4) Which command will print out currently all the block devices, their device name, and their partitions in a nice tree based format.
a) lspci
b) lsblk
c) lsusb
d) lstree

5) fdisk is part of what package?
a) utils
b) GNU
c) utils-linux
d) utils-unix

6) What would be the name of the second sata disk attached to your system?
a) sda
b) sdb
c) sdc
d) sdd

7) What is the name of the first native Linux filesystem released in 1992?
a) ext2
b) minix
c) ext4
d) ext

8) What is the name of the current default Linux Filesystem?
a) ext
b) btrfs
c) ext3
d) ext4

9) Ext4 breaks up data into __________, which is the smallest sized piece of data that can be read or written?
a) sectors
b) tracks
c) blocks
d) clusters

10) If you use the ext2 filesystem and choose a 4 KiB block, what is the maximum filesystem size?
a) 2 TiB
b) 16 TiB
c) 4 TiB
d) 4 GiB

11) What is the name of the maintainer of the ext4 filesystem?
a) Brian Kernighan
b) Theodore Ts'o
c) Andrew Tanenbaum
d) Google

12) What is the name of the filesystem that the ext4 maintainer, Theodore Ts'o, is recommending to replace ext4?
a) XFS
b) Btrfs
c) ZFS
d) HAMMER

13) What is the name of the filesystem that RedHat adopted on their RHEL 7 platform to replace ext4 and support better performance on large filesystems?
a) ZFS
b) XFS
c) Btrfs
d) HAMMER

14) What is the name of the package needed to install on Ubuntu to be able to create XFS filesystems?
a) sudo apt-get install xfsprogrs
b) sudo apt-get install zprogs
c) sudo apt-get install file-progs
d) sudo apt-get install zfsprogs

15) What is the name of the combined filesystem and logical volume manager designed by Sun Microsystems?
a) XFS
b) SunFS
c) ZFS
d) Btrfs

16) Which command is valid for making an ext4 filesystem on a partition /dev/sdb1
a) sudo mkfs.ext4 /dev/sdb
b) sudo mkfs.ext4 /dev/sdb1
c) sudo mkfs /dev/sdb1
d) sudo makefs

17) What is the command to mount an ext4 filesystem, /dev/sdb1 on a mount point /mnt/data-drive-2?
a) sudo mnt /dev/sdb1 /mnt/data-drive-2
b) sudo mnt -t ext4 /dev/sdb1 /mnt/data-drive-2
c) sudo mount -t ext4 /dev/sdb1 /mnt/data-drive-2
d) sudo mount /dev/sdb1 /mnt/data-drive-2

18) What is the command used to list the current mountpoints, that will be mounted automatically at boot?
a) /etc/mtab
b) /etc/default/grub.conf
c) /etc/fstab
d) /etc/tab

19) What is the command used to create a LVM physical volume?
a) pvcreate
b) pvck
c) pvadd
d) pvscan

20) What is the command used to create a LVM volume group?
a) vgcreate
b) vgck
c) vgdisplay
d) vgmknodes

### Podcast Questions

[DragonFly BSD](https://dragonflybsd.org "Dragon Fly BSD") - Listen to this podcast: [https://ia802605.us.archive.org/9/items/bsdtalk248/bsdtalk248.mp3](https://ia802605.us.archive.org/9/items/bsdtalk248/bsdtalk248.mp3 "DragonFly BSD")  

* ~1:25 What did DragonFly BSD drop with the 4.0 release?
* ~1:40 What was the other major feature that DragonFly BSD added?
* ~3:40 What modification did they add to the Packet Filter?
* ~10:00 What is the largest system DragonFly BSD has access to?
* ~11:45 What is the difference between DragonFly BSD's network stack compared to BSD and Linux?
* ~13:25 What is the limitations of the Hammer 1 Filesystem?
* ~13:45 What features will Hammer 2 Filesystem add?
* ~15:45 What is the intended use case of Hammer 2 FS?
* ~18:00 What sub-system is still in the works needed to make DragonFly BSD a stable work station?
* ~25:00 What is package-ng?
* ~30:00 How does DragonFly BSD handle suspend and resume functions common to laptops?
* ~35:50 What is the growing issue about systemd in relation to BSD?
* ~38:00 Of the 20,000 packages available in DragonFly BSD where are they primarily targeted?
* ~38:30 Out of FreeBSD, OpenBSD, NetBSD, and DragonFly -- what is each project focusing on?
* ~40:23 How does GPL based Linux software cross over into BSD distros?

### Lab

Objectives

  * Creating virtual disks in Virtual Box
  * Creating new partitions in fdisk
  * Creating new filesystems with mkfs
  * Creating new filesystems in ZFS
  * Mounting new filesystems
  * Editing /etc/fstab to make our mounts permanent

Outcomes

At the conclusion of this lab you will have successfully created a new virtual disk in Virtual Box, created new partitions using fdisk, formatted those partitions using mkfs, XFS, and ZFS, and mounted all those partitions manually and automatically using the /etc/fstab.

For each of the bullet points take a screenshot of the output of the commands to display the content to demostrate the concepts.  Note - make your screenshot efficient, and capture only relevant data along with numbering the output.  

1. Create 1 virtual drive
a. Use fdisk to create a primary partition
b. Format it with ext4
c. Mount it to /mnt/disk1
d. Add it to your fstab
2. Create 2 virtual drives
a. Create a single volume group named vg-group
b. Create 1 logical volume named lv-group
c. Format it with XFS
d. Mount it to /mnt/disk2
e. Add the lv-group to your fstab
3. Using the same LVM as before
a. add an additional virtualbox disk and the create a LVM physical disk
b. Grow the volume group and logical volume
c. Grow the XFS file system
4. Using LVM of the previous exercise on the logical volume lv-group create a 25 mb text file named datadump.txt
a. Following this tutorial: [http://tldp.org/HOWTO/LVM-HOWTO/snapshotintro.html](http://tldp.org/HOWTO/LVM-HOWTO/snapshotintro.html "LVM Snapshot intro") create an LVM snapshot of the logical volume named lv-backup
b. Mount the snapshot to /mnt/disk3 (create this location if not existing)
c. ```ls -l``` the contents of /mnt/disk3  
5. Install a copy of FreeBSD 11
a. Attach two additional virtual disks
b. Create a zpool stripe containing both disks
c. Execute a zpool list command to display the contents of the zpool
6. Using Ubuntu 18.04 set networking to bridged mode (take note of your public IP by typing: ```ip a sh```
a. Attach a virtual disk
b. Using this tutorial: [https://www.hiroom2.com/2018/05/05/ubuntu-1804-tgt-en/](https://www.hiroom2.com/2018/05/05/ubuntu-1804-tgt-en/ "Configure iSCSI target") configure the system using as an ISCSI target  
c. Use the proper iscsi command to list the current targets
7. Using a second Ubuntu 18.04 instance with its network mode set to bridged (note the public IP)
a. Using this tutorial: [https://help.ubuntu.com/lts/serverguide/iscsi-initiator.html](https://help.ubuntu.com/lts/serverguide/iscsi-initiator.html "Configure iSCSI initiator") configure and complete iSCSI initiator
b. List the currently available iSCSI targets on your network
c. Create two files on the connected iSCSI target - file1.txt and file2.txt and list those files
8. Create 3 Virtual disks and install the ZFS package
a. Attach it to an existing Ubuntu 18.04 system
b. Create a zpool stripe with two disks name it datapool
c. Execute a zpool list command
d. Expand the capacity of the zpool by adding the third disk in
e. Execute the ```zpool list``` command
f. Now take the first disk out of the zpool
g. Execute the ```zpool list``` command
9. From the previous exercise using your ZFS pool named datapool create a 25 megabyte file named datadump.txt
a. Attach a third virtual disk to the system and create a zpool named backup
b. Execute the ```ls -l``` command to display the file and its size
c. Take a ZFS snapshot of the datapool named @today
d. Using the ZFS send and recv commands copy the @today snapshot to the zpool named backup
e. Execute ```ls -l``` command on the zpool backup
f. Using the commandline, append an additional 25 mb to ```/datapool/datadump.txt```
g. Execute an ```ls -l``` on zpool datapool and backup to compare the two files
10. On the same Ubuntu 18.04 system create a systemd mount.unit file for both ZFS partitions created in the previous exercise.
a. List both contents here
b. Reboot the system and make sure it works
11. Using the 2 Ubuntu 18.04 systems you used in exercises 7 and 8 create a 25 megabyte file named databasedump.txt on the zpool datapool
a. On the first system (the system without zpool datapool) create a datapool name backuppool (you might need to attach a virtual disk to do this)
b. Take a snapshot of the zpool datapool and name it @now
c. Execute the remote send and recv command over ssh to migrate the snapshot to the pool backuppool
d. You may need to exchange SSH keys via ```ssh-keygen``` and ```ssh-copy-id``` first
12. On the zpool named datapool on Ubuntu 18.04
a. Execute a zpool list command
b. Enable LZ4 compression on the zpool datapool
c. Execute a zpool list command to display that compression is enabled
13. On the zpool named datapool execute a ```zpool status``` command
a. Execute a scrub of the zpool datapool
b. Create a cron job that executes a zfs scrub on the zpool datapool at 3 am every Sunday morning
14. Using the sample from the text on your Ubuntu 18.04 system add two additional virtual disk
a. Create two partitions on each of these devices
b. Then using the sample code add these two devices as a log and a cache to the zpool datapool
c. Execute a ```zfs status``` command for the zpool named datapool
15. On your Fedora system execute any of the commands listed to print out the disk serial numbers
16. Research:
a. Using [Newegg.com](http://newegg.com "Newegg.com") find the current price per Gigabyte for the following along with listing the throughput of the drive and make a chart of the results.
b. Seagate Barracuda 4 TB
c. Western Digital Blue 1 TB
d. Western Digital Red 10 TB
e. Samsung 970 EVO M.2 500 GB
f. Corsair Force MP300 M.2 960 GB
g. Intel Optane M.2 32 GB - Need to explain what 3D XPoint technology is

#### Footnotes

[^122]: [http://tldp.org/HOWTO/Partition/fdisk_partitioning.html](http://tldp.org/HOWTO/Partition/fdisk_partitioning.html)

[^123]: [https://en.wikipedia.org/wiki/Ext2](https://en.wikipedia.org/wiki/Ext2)

[^124]: [https://en.wikipedia.org/wiki/Journaling_file_system](https://en.wikipedia.org/wiki/Journaling_file_system)

[^125]: [https://en.wikipedia.org/wiki/Ext3](https://en.wikipedia.org/wiki/Ext3)

[^126]: [https://en.wikipedia.org/wiki/Ext4](https://en.wikipedia.org/wiki/Ext4)

[^127]: [https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Performance_Tuning_Guide/s-storage-xfs.html](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Performance_Tuning_Guide/s-storage-xfs.html)

[^128]: [https://en.wikipedia.org/wiki/Btrfs](https://en.wikipedia.org/wiki/Btrfs)

[^129]: [https://en.wikipedia.org/wiki/ZFS](https://en.wikipedia.org/wiki/ZFS)

[^130]: [http://tldp.org/HOWTO/LVM-HOWTO/whatisvolman.html](http://tldp.org/HOWTO/LVM-HOWTO/whatisvolman.html)

[^131]: [http://tldp.org/HOWTO/LVM-HOWTO/vg.html](http://tldp.org/HOWTO/LVM-HOWTO/vg.html)

[^132]: [http://tldp.org/HOWTO/LVM-HOWTO/pv.html](http://tldp.org/HOWTO/LVM-HOWTO/pv.html)

[^133]: [http://tldp.org/HOWTO/LVM-HOWTO/lv.html](http://tldp.org/HOWTO/LVM-HOWTO/lv.html)

[^134]: <a href="https://commons.wikimedia.org/wiki/File:Super_Talent_2.5in_SATA_SSD_SAM64GM25S.jpg">By photo: Qurren (talk)Taken with Canon IXY 10S (Digital IXUS 210)</a> or <a href="https://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0 </a>

[^135]: <a href="https://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0 By Evan-Amos</a> <a href="https://commons.wikimedia.org/wiki/File:Laptop-hard-drive-exposed.jpg">from Wikimedia Commons</a>

[^136]: [https://www.lifewire.com/pci-express-pcie-2625962](https://www.lifewire.com/pci-express-pcie-2625962 "PCi Express")

[^137]: <a href="https://creativecommons.org/licenses/by-sa/4.0">CC BY-SA 4.0 By Anand Lal Shimpi, anandtech.com</a> <a href="https://commons.wikimedia.org/wiki/File:M.2_and_mSATA_SSDs_comparison.jpg">via Wikimedia Commons</a>)

[^138]: [https://www.thegeekdiary.com/how-to-auto-mount-a-filesystem-using-systemd/](https://www.thegeekdiary.com/how-to-auto-mount-a-filesystem-using-systemd/ "Systemd Mount file")

[^139]: [http://tldp.org/HOWTO/LVM-HOWTO/snapshotintro.html](http://tldp.org/HOWTO/LVM-HOWTO/snapshotintro.html "TLDP LVM Snapshots")

[^140]: [https://pthree.org/2012/12/06/zfs-administration-part-iii-the-zfs-intent-log](https://pthree.org/2012/12/06/zfs-administration-part-iii-the-zfs-intent-log "ZFS ZIL LOG")

[^141]: [https://pthree.org/2012/12/07/zfs-administration-part-iv-the-adjustable-replacement-cache/](https://pthree.org/2012/12/07/zfs-administration-part-iv-the-adjustable-replacement-cache/ "L2ARC ZFS")

[^142]: [http://www.c0t0d0s0.org/archives/5329-Some-insight-into-the-read-cache-of-ZFS-or-The-ARC.html](http://www.c0t0d0s0.org/archives/5329-Some-insight-into-the-read-cache-of-ZFS-or-The-ARC.html "Original L2ARC cache data")

[^143]: [https://pthree.org/2012/12/11/zfs-administration-part-vi-scrub-and-resilver/](https://pthree.org/2012/12/11/zfs-administration-part-vi-scrub-and-resilver/ "hdparm")

[^144]: <a href="https://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0 By Redline</a> <a href="https://commons.wikimedia.org/wiki/File:HP_EVA4400-1.jpg">from Wikimedia Commons</a>
