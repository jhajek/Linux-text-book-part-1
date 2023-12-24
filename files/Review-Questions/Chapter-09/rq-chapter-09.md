# Review Questions - Chapter 09

1.  What user account has superuser privilege in Linux?
    a.  `sudo`
    b.  `su`
    c.  `superuser`
    d.  `root`
1.  Which command do you use to temporarily elevate your user's privilege to the superuser (root)?
    a.  `su`
    b.  `sudo`
    c.  `su -`
    d.  `root`
1.  How can you display the content of a file named topsecret.txt that has permissions 600 and is owned by another user?
    a.   You can't do that
    b.   `root cat topsecret.txt`
    c.   `sudo cat topsecret.txt`
    d.   `su cat topsecret.txt`
1.  What license is the sudo application under?
    a.   GPL
    b.   BSD
    c.   Public Domain
    d.   ISC
1.  Which operating system doesn't have an active root account by default?
    a.  Debian
    b.  Ubuntu
    c.  All Debian based distros
    d.  Fedora
1.  What is the name of the file where sudo privileges are kept?
    a.  /etc/sudo
    b.  visudo
    c.  /etc/allow
    d.  /etc/sudoers
1.  What is the name of the command used to modify /etc/sudoers to grant a new user sudo privilege?
    a.  Just use vi to edit it directly
    b.  Logout and log back in as root and do it
    c.  visudo
    d.  sudo visudo
1.  Based on this line in /etc/sudoers - `%meninblack  ALL=(ALL:ALL) ALL` - what does the first value by the % mean?
    a.   Name of a group
    b.   Name of a user
    c.   Name of the user group
    d.   Name of a process
1.  In the /etc/sudoers file - what does this line mean: `RMS ALL=(root) NOPASSWD: ALL`
    a.   The user RMS has sudo permissions and access to all commands
    b.   The user RMS has sudo permissions
    c.   The group RMS has sudo permissions to all commands
    d.   The user RMS has sudo permissions and access to all commands, and requires no password to elevate to the sudo user
1.  When using the su command to switch from a regular user account to the root user account, what do you type to return to the standard user account?
    a.   quit
    b.   exit
    c.   stop
    d.   sudo reboot
1.  What command would you use to edit the file at this location: `/var/www/html/index.html`?
    a.   vi /var/www/html/index.html
    b.   sudo vim /var/www/html/index.html
    c.   vim /var/www/html/index.html
    d.   You need to `chown` the file and change the owner
1.  On a Linux system, which directory are all the traditional system (non-systemd) logs kept in?
    a.   /var/run
    b.   /logs
    c.   /var/adm/log
    d.   /var/log
1.  Under systemd and journald where are the logs kept?
    a.   /var/log
    b.   /var/log/error
    c.   /var/log/journald
    d.   Trick question - as logs are stored in a binary format and retrieved via journalctl
1.  What is the command you use to query the system logs in systemd?
    a.   systemctl
    b.   journald
    c.   journalctl
    d.   showlogs
1.  How would you filter the systemd log based on time? (Which is valid syntax?)
    a.   `journalctl --since=yesterday`
    b.   `journalctl --since=tomorrow`
    c.   `journalctl --yesterday`
    d.   `journalctl --filter=yesterday`
1.  Where is the journald.conf file located?
    a.  /etc/logrotate.conf
    b.  /etc/systemd/journalctl.conf
    c.  /etc/systemd.conf
    d.  /etc/systemd/journald.conf
1.  What command provides a dynamic real-time view of a running system?
    a.   top
    b.   iostat
    c.   ranwhen
    d.   journalctl
1.  Debian based distros have an additional command to abstract the process to add users to the system - what is it?
    a.   useradd
    b.   usermod
    c.   adduser
    d.   add
1.  What command would be used to modify a user account settings and add them to the sudo users group on an Ubuntu distro (user is named controller)?
    a.   `sudo useradd -aG sudo controller`
    b.   `sudo usermod -a sudo controller`
    c.   `sudo usermod -G sudo controller`
    d.   `sudo userdel controller`
1.  Which below are valid useradd commands?  (Choose all that apply)
    a.  `sudo useradd -c "User for spring class" -d "/home/export/controller" -G sudo -s /bin/ksh -m controller`
    b.  `sudo useradd -D controller`
    c.  `sudo useradd controller`
    d.  `sudo useradd -G sudo -s /bin/bash -m controller`
    e. `sudo useradd -c "User for spring class" -G sudo -m controller`
1.  In the sshd configuration, which value would you change to no to disable Password Authentication?
    a.  PassAuth
    b.  Password
    c.  PasswordAuthentication
    d.  Authentication
1.  What is the name of the file located in the `~/.ssh` directory that you can hardcode information per connection?
    a.  conf
    b.  config.txt
    c.  config
    d.  configuration
1.  What is the proper syntax to connect to an ssh server using a private key (identity)
    a.  ssh identityname username@hostname
    b.  ssh identityname hostname
    c.  ssh -i identityname username@hostname
    d.  ssh username@hostname
1.  What is the proper sysntax to copy an indentity (public key) securely to a remote ssh server?
    a.  ssh -i identityname username@hostname
    b.  ssh-copy-id identityname username@hostname
    c.  ssh identityname username@hostname
    d.  ssh-copy-id -i identityname username@hostname
1.  What is the command to generate an ssh keypair of type ed25519?
    a.  ssh-keygen -t ed25519
    b.  ssh-keygen -t rsa
    c.  ssh-keygen
    d.  ssh-keygen -t
1.  What are the three P's of troubleshooting?
    a.  Path, Permission, dePendencies
    b.  Path, Permission, passcodes
    c.  Path, Permission, permutations
    d.  Path, Permission, pam
