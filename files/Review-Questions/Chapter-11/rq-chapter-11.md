# Review Questions - Chapter 11
1.  Which drive type replaced Mechanical drives?
    a.  hdd
    b.  Western Difital
    c.  sata
    d.  SSD
1.  What do the letters ssd stand for?
    a.  Serial server disk
    b.  Solid State disk
    c.  Sata State disk
    d.  Serial Sata disk
1.  What is the protocol for hard disks that replaced SATA?
    a.  Super SSD
    b.  IDE
    c.  PCIe
    d.  NVMe
1.  What is the name of the system bus that NVMe drives transfer data over?
    a.  SATA
    b.  PCI
    c.  PCIe
    d.  IDE
1.  What is the `fdisk` program?
    a.  a dialog-driven program for the creation and manipulation of partition tables.
    b.  a filesystem creation tool
    c.  a tool for formatting floppy disks
    d.  a tool for removing disks from a system
1.  What is the default VirtualBox disk type?
    a.  VDI
    b.  HDD
    c.  COW
    d.  VDD
1.  After attaching a new virtual disk, what is the next step assuming that you are using a single disk, ext4, an no LVM?
    a.  partitioning
    b.  make a filesystem
    c.  mount a filesystem
    d.  add an extent
1.  Which command will print out currently all the block devices, their device name, and their partitions in a nice tree based format?
    a.  lspci
    b.  lsblk
    c.  lsusb
    d.  lstree
1.  `fdisk` is part of what package?
    a.  utils
    b.  GNU
    c.  utils-linux
    d.  utils-unix
1.  What would be the name of the second SATA disk attached to your system?
    a.  sda
    b.  sdb
    c.  sdc
    d.  sdd
1.  What is the name of the first native Linux filesystem released in 1992?
    a.  ext2
    b.  minix
    c.  ext4
    d.  ext
1.  What is the name of the current default Linux Filesystem?
    a.  ext
    b.  btrfs
    c.  ext3
    d.  ext4
1.  Ext4 breaks up data into __________, which is the smallest sized piece of data that can be read or written?
    a.  sectors
    b.  tracks
    c.  blocks
    d.  clusters
1.  What is the name of the filesystem created at Oracle as a competitor to ZFS, that is also a next generation filesystem?
    a.  UFS
    b.  ZFS
    c.  BTRFS
    d.  GFS
1.  What is the name of the maintainer of the ext4 filesystem?
    a.  Brian Kernighan
    b.  Theodore Ts'o
    c.  Andrew Tanenbaum
    d.  Google
1.  What is the name of the filesystem that the ext4 maintainer, Theodore Ts'o, is recommending to replace ext4?
    a.  XFS
    b.  Btrfs
    c.  ZFS
    d.  HAMMER
1.  What is the name of the filesystem that Red Hat adopted on their RHEL platform to replace ext4 and support better performance on large filesystems?
    a.  ZFS
    b.  XFS
    c.  Btrfs
    d.  HAMMER
1.  What is the name of the combined filesystem and logical volume manager designed by Sun Microsystems?
    a.  XFS
    b.  SunFS
    c.  ZFS
    d.  Btrfs
1.  Which is the correct command for making an ext4 filesystem on a partition /dev/sdb1?
    a.  `sudo mkfs.ext4 /dev/sdb`
    b.  `sudo mkfs.ext4 /dev/sdb1`
    c.  `sudo mkfs /dev/sdb1`
    d.  `sudo makefs`
1.  Which is the correct command to mount an ext4 filesystem, /dev/sdb1 on a mount point /mnt/data-drive-2?
    a.  `sudo mnt /dev/sdb1 /mnt/data-drive-2`
    b.  `sudo mnt -t ext4 /dev/sdb1 /mnt/data-drive-2`
    c.  `sudo mount -t ext4 /dev/sdb1 /mnt/data-drive-2`
    d.  `sudo mount /dev/sdb1 /mnt/data-drive-2`
1.  Which file contains the mountpoints that will be mounted automatically at boot?
    a.  /etc/mtab
    b.  /etc/default/grub.conf
    c.  /etc/fstab
    d.  /etc/tab
1.  What is the command used to create a LVM physical volume?
    a.  `pvcreate`
    b.  `pvck`
    c.  `pvadd`
    d.  `pvscan`
1.  The ZFS filesystem differs from the ext4 filesystem because ZFS does what?
    a.  Data Integrity, Filesystem and Logical Volume Management
    b.  Filesystem and Logical Volume Management
    c.  Disk Compression
    d.  Data Integrity
1.  What is the command used to create a LVM volume group?
    a.  `vgcreate`
    b.  `vgck`
    c.  `vgdisplay`
    d.  `vgmknodes`
1.  What is the command used to create a LVM logical volume?
    a.  `vgcreate`
    b.  `lvck`
    c.  `lvdisplay`
    d.  `lvcreate`
