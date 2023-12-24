1.  What is the name of the firmware that since 2015 has replaced BIOS on essentially all computers?
    a.  BIOS
    b.  POST
    c.  GRUB
    d.  UEFI
1.  What is the name of the GNU software that runs at the start of stage 2?
    a.  BIOS
    b.  LILO
    c.  GRUB
    d.  GLOADER
1.  In what Linux directory are the kernel and initrd image stored?
    a.  /root
    b.  /root/kernel
    c.  /boot
    d.  /boot/vmlinux
1.  What is the name of the pre-kernel gzip file located in `/boot` that helps the kernel load?
    a.  vmlinuz
    b.  initrd
    c.  initram
    d.  init
1.  Where is the file location where the GNU Grub configuration is stored (on Ubuntu) that a user would edit?
    a.  `/boot/grub/grub.cfg`
    b.  `/etc/default/grub`
    c.  `/etc/grub/grub.cfg`
    d.  `/boot/kernel/conf`
1.  In the /etc/default/grub file, which of these options below would you edit to dispaly the splash screen on boot so kernel messages are displayed?
    a.  GRUB_CMDLINE_LINUX_DEFAULT
    b.  GRUB_BACKGROUND
    c.  GRUB_GFXMODE
    d.  GRUB_TIMEOUT
1.  What is the command to make changes to `/etc/default/grub` permanent?
    a.  No special command just edit and save /etc/default/grub
    b.  sudo apt-get update
    c.  sudo update-grub
    d.  sudo updatedb
1.  Under SysVinit - what is the ancestor process that launches first and every other process is started by it?
    a.  root
    b.  sbin
    c.  init
    d.  systemd
1.  Under SysVinit - what runlevel is considered multi-user command-line only?
    a.  1
    b.  m
    c.  3
    d.  5
1.  Which Operating System is still using the Upstart init system?
    a.  Ubuntu
    b.  MX Linux
    c.  Fedora
    d.  ChromeOS
1.  What is the name of the init system that has replaced SysVinit in every single major Linux distribution (not including Devuan and Gentoo Linux.?
    a.  systemX
    b.  systemd
    c.  systemV
    d.  initrd
1.  What is the name of the command you use in systemd to inspect, start, stop, and modify process states?
    a.  systemd
    b.  systemd-init
    c.  service
    d.  systemctl
1.  How would you start the `nginx.service` on an Ubuntu system using systemd?
    a.  `sudo system start nginx`
    b.  `sudo service start nginx`
    c.  `sudo systemctl nginx start`
    d.  `sudo systemctl start nginx`
1.  What would be the command to disable (make the service not start at boot time) the `httpd` service on Fedora using systemd?
    a.  `sudo service httpd stop`
    b.  `sudo systemctl disable apache2.service`
    c.  `sudo systemctl stop httpd.service`
    d.  `sudo systemctl disable httpd.service`
1.  What is the Linux command to inspect processes (not part of systemd)?
    a.  p
    b.  ps
    c.  proc
    d.  meminfo
1.  SysVinit used the concept of PIDs and PPIDs--what did systemd replace these with?
    a.  proc-groups
    b.  sys-groups
    c.  cgroups
    d.  xgroups
1.  The /proc filesystem provides you what?  (choose all that apply)
    a.  Provides you a file based interface to the processes that are running on your system
    b.  It can be regarded as a control and information center for the kernel
    c.  Shows up to the second process usage--updated in real time
    d.  Is a replacement for the top command
1.  What command can be used to list all the pci devices attached to your system?
    a.  ls --pci
    b.  ls -p
    c.  lsusb
    d.  lspci
1.  What is the systemd runlevel target that has a single user only as root, using no password: commonly called single-user or rescue mode?
    a.  runlevel3.target
    b.  runlevel5.target
    c.  runlevel0.target
    d.  runlevel1.target
1.  What is the systemd replacement for cron jobs?
    a.  .service
    b.  .timer
    c.  .mount
    d.  .unit
1.  What is the systemd service used to change the timezone of the system?
    a.  /etc/timezones
    b.  cron
    c.  NTP
    d.  timedatectl
1.  What is the systemd service used to change the name of the system?
    a.  hosts
    b.  hostnamectl
    c.  hostnamed
    d.  timedatectl
