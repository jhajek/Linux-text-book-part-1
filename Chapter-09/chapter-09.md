# System Administration

![*This generation's 'Who's on First?'*](images/Chapter-Header/Chapter-09/sandwich-2.png  "Permissions")

## Objectives

* Describe the concept of the `sudo` command and the root user security implications
* Identify basic administration tools 
* Explain the concept of system logs
* Describe how to use basic system tools for system monitoring and reporting
* Identify the "3Ps" method of troubleshooting

## Outcomes

At the completion of this chapter you will have the ability to administer a Linux system.  You will have an understanding of Linux system logs, their standard locations, and their use.  You will have a knowledge of system monitoring tools and how to understand their output.  You will be able to administer user accounts on a Linux system. Finally you will be able to perform trouble shooting procedures on a Linux system.

## Sudo and the Root User Paradigm

On every Unix system dating back to Thompson's Unix, there has always been a single *superuser* account on every system.  This account is usually called the __root user__ or __root__.   The __root user__ must be used with the utmost care, as that account has all the system privilege and authority to carry out any operation, even the `rm -rf /*` command. Root is good for getting things done or overriding users, but is *dangerous.* You should log into that account only sparingly.  Every single admin worth their salt will tell you not to use __root__ in almost any case [^ch9f90].

This concept is *vital* enough that on the Ubuntu distribution there is no __root__ account available. On the BSD distros, Debian, and the Red Hat/Fedora family - there is still a __root__ account, partially because of tradition and partially because of the way system administration always worked. Remember that Unix was developed in the environment of multiple users accessing a large central Unix server. So you always had to have a __root__ account to override any activities of the users and to enforce system policies, such as disk quotas, changing network configurations, or even system wide profiles. As a reminder when you are signed in as, or acting as "root", the shell prompt displays __#__ as the last character in bash and as seen in the image below. You can use the `whoami` command to find out what user account you are logged in as well.

![*Root User has the # sign as its shell*](images/Chapter-09/root/root.png "Root User Shell")

In order to change the user you are logged in as, without logging out, you use the `su` command. Known as *superuser* or *switch user*. By typing `su root` on the command line in Fedora Linux, you will be presented with a password prompt to enter the password you created during the install process for the root account. You still need to type `exit` to logout from the user you switched too. The sudo command on the other hand, only elevates you for a default period of 15 minutes and then returns you to your standard user account. It is good habit to type `sudo` in front of any command that needs elevated privileges.

### sudo  

As a great philosopher once said, *"With great power comes great responsibility."* Seeing as __root__ has unintentionally dangerous uses a temporary system was devised to blunt the power of the __root__ account. The __sudo__ command was created by researchers at SUNY/Buffalo in New York in 1980 to allow users to run specific commands as a different user, in this case as root while not remaining or needing to sign in as root.

From 1986 to 1991, development of `sudo` moved to CU-Boulder in Colorado and gained the cu-sudo prefix. In 1991, the code was relicensed under the GPLv2. In 1996 Todd C. Miller (one of the early maintainers) took the project under his wing moving a version of sudo to his own servers, to differentiate from cu-sudo. By 1999 the code base was moved to the ISC license--[Internet Systems Consortium](https://www.isc.org/ "ISC"), the same license the bind-dns server is under, it is the preferred license of the OpenBSD project and is a GPL compatible free license. Todd C. Miller is paid by Dell to maintain `sudo` as part of his day job. The sudo project homepage is located at [http://www.sudo.ws](http://www.sudo.ws). [A brief history of sudo](http://www.sudo.ws/history.html "Brief history of sudo") [^ch9f91]. The tool is often mispronounced "*su - doh*". But actual pronunciation is "*su - doo*". You can learn more about sudo implementation and security in a video by Michael Lucas entitled, [Sudo: You're doing it wrong](https://www.youtube.com/watch?v=o0purspHg-o "Sudo you are doing it wrong").

#### Ubuntu

Ubuntu is a bit different from the other Linux and Unix distros in regards to sudo.  They firmly believe not to have a root account as a point of differentiation. They rely on `sudo` in place of root. The first user you create (like in Windows and Mac) is automatically added to the __sudo__ usergroup and has sudo privilege. Then any command you need *superuser* privileges you can simply ellevate to that privilege by typing the word `sudo` in front on any command. Upon successful entry of your own password you will be elevated up to full system authority. Some refer to this as *god mode* but I think using that term is a bit presumptuous as you do have absolute power over the system but `sudo` doesn't let you create the world in seven days.  

![*Ubuntu /etc/sudoers*](images/Chapter-09/root/etc-sudoers-2.png)

Let's look at the contents in more detail. To edit the `/etc/sudoers` file you do not directly edit the file, but through a special tool called `visudo`. The `visudo` command edits the sudoers file in a safe fashion. The command `visudo` locks the sudoers file against multiple simultaneous edits, provides basic sanity checks, and checks for parse errors. If the sudoers file is currently being edited you will receive a message to try again later [^ch9f92]. You can invoke `visudo` from anywhere on the system.

The first line is where you set the system path a user receives when they become a sudo user.  
 ```Defaults  secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"```  

> __Example Usage:__  Using either Fedora or Ubuntu as your user account from the commandline type `echo $PATH` now type `sudo sh` and then `echo $PATH` notice what happens to the prompt? Are the paths different? Why?  Type `exit` to exit back to the normal user.

The next line of interest is:

```bash
# User privilege specification
root    ALL=(ALL:ALL) ALL
```

This line allows you to add specific users and then list specific commands that they have *superuser* access too.

```bash
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL
```

The next line allows you to add groupnames to receive sudo access.  Any user account that is a member of this group, in Ubuntu's case *sudo* can gain *superuser* permissions

```bash
# Members of the admin group may gain root privileges
# Ubuntu prior to version 14.04 used the admin group
# this is left for backwards compatability
%admin  ALL=(ALL:ALL) ALL
```

#### Explanation of sudoers Entries

What does the values `%sudo ALL=(ALL:ALL) ALL` mean? This particular command gives every user in the admin group access to execute every command the system. It essentially turns the root account superuser privileges over temporarily to the user account or group that has that privilege.

The first column is either a user account (no %) or preceded by a % sign meaning a user group. The second column (or the first ALL) is the hostname of the systems that can allow elevation to *superuser*. Now if this is your only system the value can be left at ALL. But if you are preparing enterprise-wide /etc/sudoers configurations then you may want to specify *superuser* access only on particular systems. The third column (second ALL) is the user that you will turn into when you use the *sudo* command. By default it is __root__ but you may want it to be another specific user. The fourth column after the : (third all) is the comma separated list of commands that user can execute. The fifth column (fourth ALL) is optional but it is an access control feature allowing only members of [certain groups to sudo](https://www.unixtutorial.org/how-to-use-visudo/ "how to use visudo").

  User/Group             Hosts                    Target User                      Commands
--------------- -----------------------------    ------------------   -----------------------------------------
   bkupuser              dbserver1                      ALL               /usr/bin/mysqldump /usr/bin/gzip
  %bkupadmins            ALL                         dbadmin                             ALL
   %cia                  ALL                           ALL                               ALL
--------------- -----------------------------    ------------------   -----------------------------------------

After the useraccount you can add an additional parameter to remove the password requirement. This is dangerous because it means anyone who has local access to the system can now become a *superuser* account just by switching users. It is best to leave this task for remote automated users or narrow down the powers to a single specific job.

> __Example Usage:__  The two commands below give the user `bkupuser` the ability to become sudo without requiring a password and only the power to execute the database backup tool. 

```bash
%bkupusers ALL=(root) NOPASSWD: /usr/bin/mysqldump
vagrant  ALL=(ALL) NOPASSWD:ALL
```

#### /etc/sudoers.d

You would add additional entries into a special file named `/etc/sudoers.d/extensions`. The `.d` convention is on all Unix and Linux systems and means that the original file `/etc/sudoers` should read any file in the directory `/etc/sudoers.d/` and append those values to the original `/etc/sudoers` file. This keeps the original clean, allows the operating system to update it with worrying about conflicting changes, and allows you to automate the creation of additional sudoers rules.

#### Fedora and other Linux

All other Linux distributions have a __root__ account user made at install time. Some minimal distributions or in FreeBSD case may only allow you to create a __root__ user at install time and make additional users your job to create. In Fedora you can log into an GNOME session using the root account, there might be warnings from the operating system, as it is not expecting you to be logged in as __root__. The __root__ user has its own home directory located at `/root`. Even if you are going to use the __root__ account it is still advised to log in as a regular user and then use the `sudo` or `su` commands to elevate and then exit those privileges.

Fedora and other Linux/Unix/Mac use different groups for sudo and *superuser* access. That group is called *wheel*.  If you look at the `/etc/sudoers` output below from Fedora system you see the groups and file content is slightly different.

![*Fedora /etc/sudoers*](images/Chapter-09/root/fedora-22-etc-sudoers.png "Fedora sudoers")

#### sudo usage examples and conclusion

> __Example Usage:__ After installing the apache webserver (httpd) on Fedora - the html files are served out of the default directory `/var/www/html`. Now if you cd to that `/var/www/` what do you notice about group and other ownership of `html`? How would you write a newfile `support.html` file in that directory?

> __Example Usage:__ To install a service: `sudo dnf install httpd`, then you need to start the service (on Ubuntu they autostart for you, Fedora family they don't autostart), `sudo systemctl start httpd`.

That is sudo in a nutshell, be careful and happy sudo-ing.  To learn more about the heavy details of sudo you can watch [this presentation http://blather.michaelwlucas.com/archives/2266](http://blather.michaelwlucas.com/archives/2266 "sudo") from Michael Lewis.

## Logging and Monitoring

![*Logging*](images/Chapter-09/logs/640px-PONDEROSA_PINE_LOGS_STACKED_AT_PINE_INDUSTRY_MILL_-_NARA_-_542596.jpg "Logs") [^93]  

One of the most central functions of an operating system is logging. Without logging facilities it would be difficult to keep track of what the system is doing. The technical term for this is __introspection__. In the course of your Linux career you will find the logging system to be of immense help.  Not only can it be used to debug problems and find errors or security issues, but also to monitor and measure that changes made to the operating system are working to prevent issues. From here on out when there is an application problem in Linux - your first trouble shooting step should be to go to the logs.  

### /var/log/\*

The default logging directory on all Linux systems is located in `/var/log`. This is the place where the kernel, the operating system, and any default installed services will place its logs. For 30+ years this was the convention and all common knowledge. But with the recent adoption of systemd on all major Linux platforms, the logging facility that was once simple text, has now been moved into the `journald` and into a binary format. Note with the systemd, the logging convention has been changed to a binary format and placed under the `journalctl` command which we will cover in chapter 11.

When you install additional packages, those packages too will add a directory for its own logs. Note in the picture below there is a log called `httpd` that is created when you install the https (apache2 webserver package) to track the webserver error.log and access.log files. You will notice in these screenshots that there is a log entry for VBoxGuestAdditions--telling you that you are using VirtualBox.

![*Fedora contents of /var/log/\**](images/Chapter-09/logs/var-log.png "var log")

![*Ubuntu contents of /var/log\**](images/Chapter-09/logs/ubuntu-var-log.png "var log")

### syslog

The operating system needs a convention on how all the logs are transferred and stored. That method was called syslog. Until 1980 there were various logging methods and schemes. The one that caught on was called `syslog` and was actually part of an email program, Sendmail, initially. Syslog permits the consolidation of logging data from different types of systems in a central file location. Syslog logs can also be transmitted remotely and aggregated on a central system. Originally the protocol used UDP to reduce network traffic, but now mandates the protocol to use TCP and even TLS. Syslog listens on port 514 and has no authentication mechanism, deferring to the user to allow or block access via the firewall or other network access control. Fedora removed syslog as standard back in Fedora 20 and moved to `journalctl`[^94].

\newpage

#### Error Levels

Syslog has adopted default levels to describe the severity of a log that is recorded. Standard syslog error levels [^104].  

Value    Severity        Keyword   		Description     			 	            Examples
----- ---------------- ---------- ---------------------------  ----------------------------------
  0 	  Emergency       emerg      System is unusable  			     This level should not be used
															     by applications.																
  1        Alert         alert     Should be corrected 			     Loss of the primary
								                   immediately 					         ISP connection
  2       Critical       crit      Critical conditions           A failure in the system's
															                                   primary application.
	3        Error         err       Error conditions              An application has exceeded its
																                                 file storage limit and attempts
																                                 to write are failing.
  4       Warning        warning   May indicate an error         A non-root file system has
								                   will occur if action is       only 2GB remaining.
								                   not taken.  
  5        Notice        notice    Events that are unusual,
								                   but not error conditions.
  6      Informational   info      Normal operational messages   An application has started,
								                   that require no action.       paused or ended successful.
  7        Debug         debug     Information useful to
                  								 developers for debugging
							                     the application.
----- ---------------- ---------- ---------------------------  ----------------------------------

### Rsyslog

By the year 2004 the clear need for a syslog compatible but feature rich replacement was needed. Rsyslog was developed by [Rainer Gerhards](http://www.gerhards.net/rainer "Rainer Gerhards") and in his words, __"Rsyslog is a GPL-ed, enhanced syslogd. Among others, it offers support for reliable syslog over TCP, writing to MySQL databases and fully configurable output formats (including great timestamps)."__  It was an improvement on syslog. It made syslog extensible and eventually replaced syslog by default. Most Linux distributions dropped the original syslog application and replaced it with Rsyslog by 2008 [^95].

### journald and systemd

Not to be outdone - `systemd` has replaced syslog with `journald`.  And this has happened in every system that has adopted `systemd` - Debian 8, Fedora 22, Ubuntu 15.04/15.10, CentOS 7.  You can read the initial `journald` announcement and [justification paper here](https://docs.google.com/document/pub?id=1IC9yOXj7j6cdLLxWEBAGRL6wl97tFxgjLUEHIX3MSTs&pli=1 "Justification Paper") [^96].

In Lennart Poeterring's own words, *"If you are wondering what the journal is, here's an explanation in a few words to get you up to speed: the journal is a component of systemd, that captures Syslog messages, Kernel log messages, initial RAM disk and early boot messages as well as messages written to STDOUT/STDERR of all services, indexes them and makes this available to the user. It can be used in parallel, or in place of a traditional syslog daemon, such as rsyslog or syslog-ng."* [^97]

*"One of the impetuses behind the systemd journal is to centralize the management of logs regardless of where the messages are originating. Since much of the boot process and service management is handled by the systemd process, it makes sense to standardize the way that logs are collected and accessed. The journald daemon collects data from all available sources and stores them in a binary format for easy and dynamic manipulation.[^98]"*

Syslog runs along side of journald The traditional ways of using syslog had been modified by journald.

* `cat /var/log/syslog` will now become `sudo journalctl`
* `tail -f /var/log/syslog` will now become `sudo journalctl -f`
* `grep sshd /var/log/syslog` will now become `sudo journalctl -u sshd`

To use the journal daemon (journald) all its elements are accessed through the `journalctl` command.  All previously sparse logs are now contained in a single binary append only log format. The advantage of that is that the output can be programmatically parsed and queried like a database.

> __Example Usage:__ These examples have been taken from the [systemd website](http://www.freedesktop.org/software/systemd/man/journalctl.html "jounralctl examples"):[^99]

```bash
journalctl
```

> Without arguments, all collected logs are shown unfiltered:

```bash
journalctl -x -u nginx.service
```

> Shows errors that the current service (-u) is showing:

```bash
journalctl -u sshd.service -u nginx.service
```

> If two matches refer to the same field, all entries matching either expression are shown:

```bash
journalctl -k -b -1
```

> Show all kernel logs from previous boot:

```bash
journalctl -f -u apache2.service
```

> Show a live log display from a system service apache2.service:

```bash
journalctl -b
```

> This will show you only the logs of the current boot:

```bash
journalctl -b -p err
```

> List all messages of priority levels ERROR and worse, from the current boot:

```bash
journalctl --since=yesterday -u nginx.service
```

> Filtering based on time and service

```bash
journalctl --since=2012-10-15 --until="2011-10-16 23:59:59"
```

> Filter based on time range - note how difficult this would be with using grep, sort, and awk because everything is text. But since journald can be thought of a similar to a SQL database, then these types of queries are possible.

```bash
journalctl -u ssh.service
```

> See log entries created only by the SSH service



### Log rotation

The concept of log rotation existed under syslog and rsyslog when logs were simple text files, but no longer exists under journald.  This was accomplished by the `/etc/logrotate.conf`.   Applications may still write to a discrete syslog (or may not), but all logs are then copied by journald, which systemd made the central repository for logs.

When viewing an older syslog style text log you can use the `tail -f` command and it will auto-update if there is new content automatically. This command can be very helpful if you are watching a log for some particular output - can you find the journald equivalent: `journalctl --follow --since=-1day`.

You can find the systemd journald log rotation and collection specifics [here](http://www.freedesktop.org/software/systemd/man/journald.conf.html "journald.conf"): [^101].

`/etc/systemd/journald.conf`

Below are the default settings - even though they are commented out they are set there to give a template for a system admin to modify.

Entries can be service specific and kept in subdirectories `/etc/systemd/journald.conf.d/*.conf` any configurations in these directories take precedence over the main journald.conf file.

Storage

: Controls where to store journal data. One of "volatile", "persistent", "auto" and "none". If "volatile", journal log data will be stored only in memory, i.e. below the /run/log/journal hierarchy (which is created if needed). If "persistent", data will be stored preferably on disk, i.e. below the /var/log/journal hierarchy (which is created if needed), with a fallback to /run/log/journal (which is created if needed), during early boot and if the disk is not writable. "auto" is similar to "persistent" but the directory /var/log/journal is not created if needed, so that its existence controls where log data goes. "none" turns off all storage, all log data received will be dropped. Forwarding to other targets, such as the console, the kernel log buffer, or a syslog socket will still work however. Defaults to "auto".

SplitMode

: Controls whether to split up journal files per user. One of "uid", "login" and "none". If "uid", all users will get each their own journal files regardless of whether they possess a login session or not, however system users will log into the system journal. If "login", actually logged-in users will get each their own journal files, but users without login session and system users will log into the system journal. If "none", journal files are not split up by user and all messages are instead stored in the single system journal. Note that splitting up journal files by user is only available for journals stored persistently. If journals are stored on volatile storage (see above), only a single journal file for all user IDs is kept. Defaults to "uid".

MaxLevelStore, MaxLevelSyslog, MaxLevelKMsg, MaxLevelConsole, MaxLevelWall

: Controls the maximum log level of messages that are stored on disk, forwarded to syslog, kmsg, the console or wall (if that is enabled, see above). As argument, takes one of "emerg", "alert", "crit", "err", "warning", "notice", "info", "debug", or integer values in the range of 0..7 (corresponding to the same levels). Messages equal or below the log level specified are stored/forwarded, messages above are dropped. Defaults to "debug" for MaxLevelStore= and MaxLevelSyslog=, to ensure that the all messages are written to disk and forwarded to syslog. Defaults to "notice" for MaxLevelKMsg=, "info" for MaxLevelConsole=, and "emerg" for MaxLevelWall=.

SystemMaxFileSize and RuntimeMaxFileSize

: Control how large individual journal files may grow at maximum. This influences the granularity in which disk space is made available through rotation, i.e. deletion of historic data. Defaults to one eighth of the values configured with SystemMaxUse= and RuntimeMaxUse=, so that usually seven rotated journal files are kept as history.

Specify values in bytes or use K, M, G, T, P, E as units for the specified sizes (equal to 1024, 1024²,... bytes). Note that size limits are enforced synchronously when journal files are extended, and no explicit rotation step triggered by time is needed.

SystemMaxFiles and RuntimeMaxFiles

: Control how many individual journal files to keep at maximum. Note that only archived files are deleted to reduce the number of files until this limit is reached; active files will stay around. This means that in effect there might still be more journal files around in total than this limit after a vacuuming operation is complete. This setting defaults to 100.

## System Monitoring

The first step in system administration is monitoring. Just like viewing logs, also knowing what is currently going on resource wise can be very helpful. The first command we want to look at to help us understand what is occurring on our system is a command called `top`. This stands for *table of processes*. Top produces a list of running processes selected by user-specific criteria[^100]. The traditional Unix version was written by William LeFebvre and originally copyrighted in 1984. Since 1991 there has been a Linux based GPL top command which is part of the [procps-ng suite of tools](https://gitlab.com/procps-ng/procps)[^102].

### top

The top program provides a dynamic real-time view of a running system. It can display system summary information as well as a list of tasks currently being managed by the Linux kernel. When the screen comes up there is a lot of data present and at first it might not be clear what you are looking at. 

![*Fedora top screenshot*](images/Chapter-09/monitoring/top/top.png "top")

The image below displays the system average loads over longer rolling periods: 1 minute, 5 minutes, and 15 minute rolling average.

![*top avg*](images/Chapter-09/monitoring/top/top-avg.png "Top average")

This section tells you the number of processes, how much memory and swap is in use and how much is free. It also tells you the breakdown between users and system on who is using the CPU percentage wise.

![*top usage*](images/Chapter-09/monitoring/top/top-usage.png "Top usage")

Finally this section shows the name and individual breakdown of the processes and how much resources they are using.  We will cover this in more detail in chapter 11.  

![*top processes*](images/Chapter-09/monitoring/top/top-processes.png "Top process")

The `top` command also has the ability to sort and modify its output while running.  

   Key                  Action in Top
-----------  --------------------------------------------------------------------------------
'd' or 's'     Plus a positive number you can change the reporting cycle.
   'u'         Plus a user's name will filter only those processes they own
   'k'         Sorts by \%CPU usage.  
   'I'         Sorts by CPU time usage
   'm'         Same as above but more granular
   'n'         Percentage of memory that a task is using.
'w' STATE      D=uninterruptible sleep, R=running, S=sleeping, T=traced or stopped, Z=zombie
  'q'          This will quit the `top` application
-----------  --------------------------------------------------------------------------------

### htop

The htop command is an extension to the Linux top command. It is written in C using the ncurses library for text-based GUIs so it has mouse support. It also has metered output-and uses all the same interactive commands as `top`. The homepage for the project can be found at [http://hisham.hm/htop](http://hisham.hm/htop/ "htop")[^103]. The `htop` command needs to be installed via apt-get or yum/dnf.

![*htop*](images/Chapter-09/monitoring/top/htop.png "htop")

### systemd-cgtop

You were probably wondering if systemd had its own system monitoring tool. And you would be correct to think so.  It's name is systemd-cgtop and the command is native to any system running systemd. The usage patterns can be found at [http://www.freedesktop.org/software/systemd/man/systemd-cgtop.html](http://www.freedesktop.org/software/systemd/man/systemd-cgtop.html "systemd-cgtop") The nature of the output is the same as top but the information is being queried from systemd and not from the `/proc` filesystem. You run the command `systemd-cgtop` from the commandline with preset flags like top or you run it in interactive mode. In interactive mode you would type `%` percent to toggle between CPU time as time or percentage. You would type p, t, c, m, i to sort by path, number of tasks, CPU load, memory usage, or IO load. The letter *q* is to quit. There are other configuration options displayed by typing `man systemd-cgtop`.

### btop

You can install [btop](https://github.com/aristocratos/btop "webpage for btop") for a smoother looking text-based system resource usage output for processor, memory, disks, network and processes. 

### Network Monitoring Tools

These tools are used like the *top commands but monitor network interfaces and their traffic. All can be run on a server based system, textbased and no GUI required.

* [bmon](https://en.wikipedia.org/wiki/Bmon "wikipage for Bmon")
* [iftop](https://en.wikipedia.org/wiki/Iftop "wikipage for iftop")
* [nethogs](https://github.com/raboof/nethogs "webpage for nethogs")
* [tshark](https://en.wikipedia.org/wiki/Wireshark#Features "wikipage for tshark")

### Additional Monitoring Tools

There are many additional standard Linux tools as well as many GitHub projects being launched all the time to solve specific monitoring problems.  Below is a list of some of the utilities that comes with Linux `top` under the procps and procps-ng packages.  

   Command                              Function
--------------  -------------------------------------------------------------
  `free`          Report the amount of free and used memory in the system
  `load`          Graphical representation of system load average
 `uptime`         Display how long the system has been running
 `vmstat`                  Report virtual memory statistics
   `w`                Report logged in users and what they are doing
  `watch`        Execute a program periodically, showing output fullscreen
  `df`           This will tell you the percentage of disk usage
--------------  -------------------------------------------------------------

#### Load Generators

The opposite side of system monitoring is sometime you want to generate a load to see how your system responds.  On modern system that are multi-core with fast memory. There is a tool called `stress` you can install it via The Ubuntu and Fedora software stores or form the commandline using apt-get and yum/dnf.  It is also available for the Mac via the Homebrew package manager. The command `stress --cpu 2 --timeout 60`  will cause two processors to max out for 60 seconds.  You would then be able to see this using an of the above top based commands.  There are some other ways to generate loads in bash as well located here: [http://stackoverflow.com/questions/7908953/how-to-measure-cpu-usage/12993326#12993326](http://stackoverflow.com/questions/7908953/how-to-measure-cpu-usage/12993326#12993326 "Bash load generator ideas")

#### mpstat and iostat

In addition to memory, CPU, and process information. You can other commands to measure system I/O. The `iostat` command, which in Linux is part of the sysstat package--displays kernel I/O statistics on terminal, device and cpu operations. The `mpstat` command will give you a per-processor readout. A common word for this is I/O measurement or throughput. These reports can then be used to change system configurations to better balance the input/output load between physical disks.

![*iostat*](images/Chapter-09/monitoring/io/iostat.png "iostat")

#### Procmon

[Process Monitor (Procmon)](https://github.com/microsoft/ProcMon-for-Linux "Download site for Procmon") is a Linux reimagining of the classic Procmon tool from the Sysinternals suite of tools for Windows. Procmon provides a convenient and efficient way for Linux developers to trace the syscall activity on the system.

#### iotop

Display a dynamic view of system I/O. This can be installed from your package manager.

## User Administration

There are a series of commands that can be used to change or augment the owner, group, or permission of a file. To execute these commands you will need to have administrator privilege. The nature of the user commands allow you to do three operations. The commands are: `useradd`, `userdel`, and `usermod`.

### useradd

The useradd command allows you to add a new user to the system. There are many options to override system account creation defaults.

```bash
sudo useradd -c "This is a user for ITMO-356-01 Fall 2023" -d /home/controller \
-G sudo -s /usr/bin/bash -m controller
```

: useradd command options

  Option         Function
-------------   ----------------------------------------------------
`-c`              Add a comment
`-d`              User's home directory
`-e`              Date in which a user account expires
`-g`              Add user to a specific primary group
`-G`              Add user to additional supplementary groups
`-m`              Create user's home directory if it doesn't exist
`-s`              Assign the user's shell
-------------   ----------------------------------------------------

There are system defaults that can save time by using only the `useradd` command.

```bash
# You can see the defaults settings with the -D options
useradd -D
# Adds an account and taked the system defaults
useradd name-of-account-to-add
```

In Debian distributions there is an abstraction layer called `adduser` and `addgroup` which are interfaces to the useradd and groupadd commands. It is just a perl script that passes the values you enter in the menu to the useradd command. On all other non-Debian distros `adduser` is a symlink to `useradd` command. The `adduser` command prompts you for information to fill out all the values and is recommended on Debian based systems, but if writing a shell script this is not portable to a non-Debian based distro.

![*useradd*](images/Chapter-09/user-administration/default/etc-default.png "etc-default")

### userdel and usermod

The same as above, the `userdel` command allows you to delete a user. The `usermod` command allows you to modify a setting for a user without having to delete and re-create a user. The most common scenario is changing the users supplementary groups so that they can be in the sudo, wheel, or admin group. By default the system creates a usergroup with the same name as the usergroup and marks that as your users primary group. In this command `-a` means append and `-G` means append to the groups list. For example: `sudo usermod -aG sudo <username>`  is a handy command to remember.

### addgroup and groupadd

In the same way as a user is created and there is a Debian based shortcut, there is a similar command to create a new group. You would want to do this if you needed to create a group that was not in existence. The syntax is simply `sudo addgroup name-of-group` and that is it. The opposite command exists as well groupdel and delgroup, with the syntax of `sudo delgroup name-of-group`.

You can list all the groups that exist on your system by executing the `groups` command. If executed without any arguments it will show the current users group membership. If you follow it up with a username it will return the group memberships of that user. You can display the list of all the groups that exist on a system by typing `cat /etc/group` on the commandline.

### The groups command

Sometimes you need to find detailed information about a user and which groups they are a member of.  You can quickly inspect your current user by typing the command `groups` you will see print out a list of groups.

### /etc/passwd

When a new user is created, the information passed into the `adduser` or `useradd` command is stored in the `/etc/passwd` file (yes it is missing the 'or'). This file originally stored user passwords which had been encrypted, but the file had read access and it was realized that it was a security flaw to allow access in this way. The actual encrypted passwords were moved to a file called `/etc/shadow` and linked via the character *x* in the `/etc/passwd` file. You can see this in the image below. Also notice from the snippet that there are many many usernames that have been created but only two of them are by your hand.  That is because the system upon install creates many additional users that have single or even legacy purposes that the user will not touch. At the very end of the screenshot below you see users on a system.

```
controller:x:1000:1000:controller,,,:/home/controller:/bin/bash
fwupd-refresh:x:128:136:fwupd-refresh user,,,:/run/systemd:/usr/sbin/nologin
vboxadd:x:999:1::/var/run/vboxadd:/bin/false
joseph:x:1001:1001::/home/joseph:/bin/sh
lincoln:x:1002:1002:Student for ITMO 556:/home/lincoln:/bin/bash
sshd:x:129:65534::/run/sshd:/usr/sbin/nologin
```

The syntax is as follows: Username:password:user-id:group-id:comment-field:home-directory:default-shell.    You can see the encrypted and salted password hash if you have root or sudo privileges by typing `sudo cat /etc/shadow` on the command line.

### systemd-homed

Systemd is looking to the future and will be fading out support for the Unix `/etc/passwd` user control and brining in a new systemctl named [systemd-homed](https://systemd.io/HOME_DIRECTORY/ "webpage for systemd-homed"). As of 2023, systemd-homed is not deployed by any major Linux distros.

> *systemd-homed.service(8) manages home directories of regular (“human”) users. Each directory it manages encapsulates both the data store and the user record of the user, so that it comprehensively describes the user account, and is thus naturally portable between systems without any further, external metadata. This document describes the format used by these home directories, in the context of the storage mechanism used.*

### chmod

Pronounced *"chuh-mod"*. This command allows you to change the permissions or mode of a file. You can use numeric values to change the permissions all at once. Why would you want to change permissions? You need to give write or execute permission to a file. Or to make sure that only users of a certain group can have write access (therefore delete access) to the content of a file.  Or to give a shell script execute permission so it can be run by other.

![*Same file with write and execute permission enabled*](images/Chapter-09/user-administration/standard-permission-chmod.png "Standard Permissions")

### chown

Pronounced *"chuh-own"*. This command allows you to change the owner of a file.  The syntax would be `sudo chown root todolist`  There is also a shorthand feature that allows you to change the group and the owner at the same time.  `sudo chown root:root todolist` the value following the semi-colon will be the new group owner.  Resist the temptation to go nuclear--if you are getting a permissions denied on a command figure out why it is being denied--instead of chown-ing everything as this could create subtler problems down the line for system processes expecting a certain pattern of ownership.

> __Exercise:__  based on the previous todo-list.txt created in `/tmp`, issue an `ls -l` command - who is the owner of the file?  Who is the group owner? Change it so that the file is owned by root and the group owner is root (remember to use `sudo`.)

### chgrp

Pronounced *"Chuh-gerp"*. This is the change group command. It works just like `chown` but instead only changes the group ownership.

#### ACLs

If you have ever worked on Windows OS you will notice that they have much deeper access control and permission system the the basic read, write, execute and owner, group, other permissions. These are called ACL's (pronounced "*ack-els*") __Access Control Lists__. They are not native to the Linux world as they were not part of the original Unix standard. Modern versions of RHEL implement there own layer of Windows like ACLs on top of the regular permissions. The difficulties of ACL's in Linux is that they are exclusive to RHEL and not portable to other Linux or Unix systems.

### The 3 P's of Troubleshooting Linux Problems

All my troubleshooting experience in Linux boils down to three things. I have named them the 3P's (yes I know that they all don't start with *P*).  If you have an error message or cannot execute a command--run down these three troubleshooting steps:

* Path
  * If you get an error message telling you that `file not found` or `path does not exist`--double check your path.  Is the absolute path correct? Is it a relative path problem?  Are you on the wrong level of the tree?
* Permission
  * Every file has permission on what is allowed to be done with it based on a simple access control of read write and execute.  Maybe you don't have permission to write and therefore can't delete a file. Perhaps the file is owned by someone else and they didn't give you permission.  Check permissions via ls -la or see if you need sudo.
* dePendencies
  * Are all the correct software dependencies installed? Perhaps you are missing a library or have an incompatible version that is preventing a tool from running? 
  * If you try to run the commmand `btop` or `links 127.0.0.1` and you don't have these packages installed, you will receive error messages. 
  * If you don't have the `gcc` compiler installed you won't be able to compile and build the VirtualBox Guest Additions, which will be a dependency error.
* All else fails and you still have a problem, see if it is a full moon outside.

## Secure Shell

What happens when you need to remotely access a system and it needs to be secure? The need for security or encryption of data sent over a network was not apparent. But as the ability to access data grew and the need to remotely access systems across untrusted networks became a reality the `rsh` remote shell was no longer viable. SSH or Secure Shell became a reality in 1999, appearing first in OpenBSD 2.6, introduced by the security focused OpenBSD project and quickly adopted universally across Unix, Linux, Mac, and Windows. In fact [Microsoft was the first ever gold-level sponsor of the OpenBSD project](https://undeadly.org/cgi?action=article&sid=20150708134520 "Microsoft was the first ever gold-level sponsor of the OpenBSD project").

By default the SSH *client* is installed on all Linux, Unix, MacOS, and Windows 10+ systems. You can access SSH from the command line to check if it is installed via typing: `ssh -V`. You can install the OpenSSH server typing `sudo apt install openssh-server` or `sudo dnf install openssh-server`.

```
controller@controller-VirtualBox:~$ ssh -V
OpenSSH_8.9p1 Ubuntu-3ubuntu0.4, OpenSSL 3.0.2 15 Mar 2022

[controller@fedora ~]$ ssh -V
OpenSSH_9.0p1, OpenSSL 3.0.9 30 May 2023
```

### Public Key Cryptography

SSH works because of [Public Key Cryptography](https://en.wikipedia.org/wiki/RSA_(cryptosystem) "webpage for RSA"). A data encryption scheme and a standard created and widely adopted by the RSA company. Without going to deep into RSA encryption, this set of public and private keys allows you to securely transmit information across an untrusted network. How does it work?

Each person generates a __keypair__, a public key and a private key. Both halves of the key make up the single key used for authentication. These keys are exactly what they sound like. The public key is something that is revealed openly, but without the unique private key the "lock" cannot be opened. Think of the __public key__ as the lock on your front door. Conceivably anyone can come up to that lock and try to insert a key. Unless they have the particular key, the lock won't open. The __private key__ is then something to be guarded with your life as anyone who has that key can log into any system where it has permission.

How do you then exchange data? First you generate a keypair. There is the [default RSA standard or a newer  algorithm](https://security.stackexchange.com/questions/90077/ssh-key-ed25519-vs-rsa "webpage RSA vs ed25519") using [eliptical curce cryptography](https://en.wikipedia.org/wiki/Elliptic-curve_cryptography "webpage elitical curve cryptography"), the Twisted Edwards Pair 25519. By default ed25519 has a more secure key size, but the RSA keys can be made comparably secure with an override of the defauly options. 

* `ssh-keygen -t rsa -b 4096`
* `ssh-keygen -t ed25519`

```
$ ssh-keygen -t rsa -b 4096
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/vagrant/.ssh/id_rsa
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:XxObpGsM3QhN04YCnbHDekkg6eKwhp41ojVGdmIhg2w vagrant@bookworm
The key's randomart image is:
+---[RSA 4096]----+
|o   ..oo.ooo     |
|+E. .. o++..o    |
|.o o    *...o    |
|. * o  o = = +   |
|.B +  . S + *    |
|oo=o   . + o .   |
|+o+..     =      |
|.o       .       |
|                 |
+----[SHA256]-----+
```

#### SSH Security

While having SSH give us secure remote tunnels, it does lead to a potential problem.  It means exposing an open port to the external network.   This can and should be mitigated by things such as VPNs and mandating use of RSA keys only.  But there are many systems that are exposed.  This is a serious security vulnerability as hackers are actively scanning the entire IPv4 space looking for SSH systems and they will simply try to brute force the username and password.

One of the tools to alleviate this is called [fail2ban](https://www.fail2ban.org/wiki/index.php/Main_Page "Fail2ban website").  This is a brute force login denial tool.  This tool will scan the connection (or auth) logs looking for failed connection. Fail2ban can use the default syslog location as well as `journalctl` logs. Fail2ban will count the number of occurrences and the distinct IP and after a user defined threshold of failure will ban any network connection from the offending IP. This can be a time based back-off or can be a permanent ban, configured by the user in the configuration file. Fail2ban can also ban failed MySQL database connections as well if you have an exposed database server. You can install fail2ban: `sudo apt install fail2ban` then enable it and start the service, `sudo systemctl enable fail2ban` and then `sudo systemctl start fail2ban`.

#### OpenSSL

OpenSSL is an Opensource Library used for cryptographic key generation by OpenSSH. In 2016, it suffered an exploit, named [heartbleed](http://heartbleed.com "Heartbleed.com")[^ch9f106] due to the critical library maintaining old code from defunct systems and only having one part-time developer. Take note that although Google built its entire business using OpenSSH and OpenSSL, they contributed almost nothing to its development. After the exploit the projects were adopted by the Linux Foundation [Core Infrastructure Initiative](https://www.coreinfrastructure.org/ "website for CII")[^ch9f107] and recently transferred to the [Open Source Security Foundation](https://openssf.org/ "website for Open Source Security Foundation").

The heartbleed OpenSSL bug has its own website to explain the details of it, located at [http://heartbleed.com](http://heartbleed.com "Heartbleed.com"). Links to "Security Now" Technical Podcast explaining HeartBleed

* [https://twit.tv/shows/security-now/episodes/450 - Part 1](https://twit.tv/shows/security-now/episodes/450 "heartbleed podcast part 1")
* [https://twit.tv/shows/security-now/episodes/451 - Part 2](https://twit.tv/shows/security-now/episodes/451 "heartbleed podcast part 2")

#### LibreSSL

Not to be outdone, the OpenBSD group immediately after HeartBleed, made a fork of the OpenSSL project code and called it [LibreSSL](https://www.libressl.org/ "LibreSSL") and began to strip out as much uneeded code as possible and to write new code.  This library became the default cryptographic library on OpenBSD and was ported to Linux.  Though it is new and has a smaller attack surface, so many products (for better or worse) are using OpenSSL that they have not or cannot switch libraries. Microsoft adopted LibreSSL for use in their native SSH client and server in Windows 10 as well.

> "LibreSSL is a version of the TLS/crypto stack forked from OpenSSL in 2014, with goals of modernizing the codebase, improving security, and applying best practice development processes.

Primary development occurs inside the OpenBSD source tree with the usual care the project is known for. On a regular basis the code is re-packaged for portable use by other operating systems (Linux, FreeBSD, Windows, etc)[^ch9f105]."  

### SFTP

Secure FTP uses the traditional FTP program but over a secure SSH tunnel. This allows you keep using existing file transfer methodologies but in a secure manner.  FTP (file transfer protocol) is an unencrypted way to transfer files to and from a server. Its usage is discouraged as the protocol was developed at a time when security was not a consideration.  All data, including passwords are transmitted in clear text.  SFTP solves that issue of allowing you to use FTP but over an established SSH connection--there by using an SSH tunnel to provide encryption for the transmitted packets.  Some would argue the rise in using version control such as Git makes SFTP/FTP redundant.  

`sftp [-i identity_file] username@hostname`

### SCP

Secure cp (copy) Allows for using the `cp` command to a remote system via SSH, as SFTP should be used for moving multiple files, this command is good for moving a single file quickly via the command line.

`scp [-i identity_file] localfilename username@hostname:filename`

### Rsync

From the rsync man page:

Rsync is a fast and extraordinarily versatile file copying tool. It can copy locally, to/from another host over any remote shell, or to/from a remote rsync daemon. It offers a large number of options that control every aspect of its behavior and permit very flexible specification of the set of files to be copied. It is famous for its delta-transfer algorithm, which reduces the amount of data sent over the network by sending only the differences between the source files and the existing files in the destination. Rsync is widely used for backups and mirroring and as an improved copy command for everyday use.

`rsync dir1/* dir2`

### ssh-copy-id

After generating an SSH keypair with the command `ssh-keygen`, you now have the two keys located in you `~/.ssh` directory. The file with the .pub extension is the public key, the other is the private key. __Guard the private key with your life!__  

There is a command that will let you securely exchange RSA keys with a server. This requires you first to have an account on the server (host) you are connecting to so that you can place your identity securely onto that remote server.

```bash
ssh-copy-id username@hostname

# Optional command if you want to transfer the identity other than the default id_rsa
ssh-copy-id -i identityname username@hostname

```  

### SSH config file

The ssh command has a provision for a file named `config` located in the `~/.ssh` directory.  This is where you can hardcode short cut information per connection.  Items such as:

* Turning off strict host key checking
* predefining hostname
* defining a non-default connection port
* predefining a password (not recommended)
* defining a non-default RSA private key

The format of the file is as such:

```bash
Host github.com
  User jhajek
  Hostname github.com
  IdentityFile /home/user/.ssh/id_ed25519
```

The full range of options for the config file can be found in this Digital Ocean Tutorial located at [https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client](https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client "Digital Ocean Tutorial for ssh config file")

### SSH Service Daemons and Security

SSH has two configuration files that control its abilities. Located at `/etc/ssh/ssh_config` and `/etc/ssh/sshd_config`. The first file contains user information about what options your client will present and use when connecting to a remote SSH server.  

In the `ssh_config` file you can modify these lines to increase the security of the encryption ciphers you use.  By default OpenSSH defaults back to an older and weaker set of encryption ciphers such as:

```Ciphers aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,aes128-cbc,3des-cbc```

You would uncomment the line and the entries with a more robust list.  You would want to make sure that the coresponsiding SSH server in the `sshd_config` file had the same ciphers set other wise negotiation could fail and no connection would take place[^ch9f109].

```bash

# This is one line with no line breaks
# I made it into two lines so it would display properly.
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,
aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
```

#### SSH Server Security Setting to Change

In the configuration file `/etc/ssh/sshd_config` the default settings are generally very permissive. Here are some suggestions of items to change right away to tighten up your OpenSSH Server. 

* Disable password authentication to a remote server and only use Public key authentication.
  * Uncomment the line `#PasswordAuthentication yes` and change it to `PasswordAuthentication no`[^ch9f108].  
* By default Fedora and BSD based operating sysems allow the Root account to connect via SSH using a password.
  * This is inherantly dangerous, Ubuntu uses the value prohibit-password which would allow RSA but not password based auth. 
  * Uncomment and change this setting from  `PermitRootLogin yes` to `PermitRootLogin no`[^ch9f110].
* Now tell systemd that you have changed a config file
  * `sudo systemctl daemon-reload`.
  * Restart the SSH service: `sudo systemctl restart sshd`

### WireGuard - Linux kernel native VPN

A [VPN](https://en.wikipedia.org/wiki/Virtual_private_network "VPN Wikipedia page")  is a virtual private network.  It uses RSA encryption to extend a private network across the public network.  An example would be an employee connecting from home over the public network to a companies private network.  To do this you would need a VPN.

[WireGuard](https://www.wireguard.com/ "WireGuard Linux Kernel VPN") is a Free and Opensource VPN software.  It's modullarly built and since March of 2020, has been included natively in the Linux Kernel.  This increases speed and flexibilty compared to other VPN solutions.  It was written by Jason A. Donenfeld and is published under the GNU General Public License (GPL) version 2, which makes it compatible with the Linux Kernel as well as being compiled for [MacOS, Windows, Android, iOS, FreeBSD, and OpenBSD](https://ianix.com/wireguard/wireguard-deployment.html "Wireguard deployment web page").  Of note, launched on July 15th, Mozilla launched a VPN service, called [Mozilla VPN](https://en.wikipedia.org/wiki/Mozilla_VPN "Mozilla VPN web page") that runs the wireguard code.

## Chapter Conclusions and Review

Through this chapter we learned about the su, sudo, and root user account paradigms. We learned when to use them and how they were designed. We learned about the nature of traditional logging (non-systemd) and how they are stored. We learned about a newer logging format in the journald service from systemd. Finally we learned about system monitoring tools for visual display of system resources being used. Finally we learned about the 3Ps of Linux troubleshooting.

### Review Questions

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
1.  What is the name of the directory where a user can add customizations the `/etc/sudoers` file to grant a new user sudo privilege?
    a.  Just use vi to edit `/etc/sudoers` directly
    b.  `/etc/sudoers`
    c.  `/etc/sudoers.d/`
    d.  `/etc.d/sudoers`
1.  Based on this line in `/etc/sudoers` - `%meninblack  ALL=(ALL:ALL) ALL` - what does the first value `%` mean?
    a.   Name of a group
    b.   Name of a user
    c.   Name of the user group
    d.   Name of the superuser
1.  In the `/etc/sudoers` file - what does this line mean: `RMS ALL=(root) NOPASSWD: ALL`
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
1.  What command would be used to modify a user account's settings and add them to the sudo users group on an Ubuntu distro (user is named controller)?
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
1.  In the sshd configuration, which value would you change to **no** to disable Password Authentication?
    a.  PassAuth
    b.  Password
    c.  PasswordAuthentication
    d.  Authentication
1.  What is the name of the file located in the `~/.ssh` directory that you can hardcode information per SSH connection?
    a.  conf
    b.  config.txt
    c.  config
    d.  configuration
1.  What is the proper syntax to connect to an ssh server using a private key (identity)
    a.  ssh identityname username@hostname
    b.  ssh identityname hostname
    c.  ssh -i identityname username@hostname
    d.  ssh username@hostname
1.  What is the proper syntax to copy an identity (public key) securely to a remote ssh server?
    a.  ssh -i identityname username@hostname
    b.  ssh-copy-id identityname username@hostname
    c.  ssh identityname username@hostname
    d.  ssh-copy-id -x identityname username@hostname
1.  What is the command to generate an ssh keypair of type ed25519?
    a.  ssh-keygen -t ed25519
    b.  ssh-keygen -t rsa
    c.  ssh-keygen
    d.  ssh-keygen -t
1.  What are the three P's of troubleshooting?
    a.  Path, Permission, Planning
    b.  Path, Permission, Passcodes
    c.  Path, Permission, Permutations
    d.  Path, Permission, dePendencies

### Podcast Questions

Watch this presentation, [How Secure Shell (SSH) works](https://www.youtube.com/watch?v=ORcvSkgdA58 "youtube how ssh works") and answer the questions listed.

* ~0:12 What does SSH stand for and when did it first appear?
* ~0:30 What was the security problem with the predecessors of SSH?
* ~1:19 Who wrote the first version of SSH and why?
* ~1:50 What is the first thing that happens when a machine makes a connection via SSH to another machine?
* ~2:45 How does the SSH protocol encrypt the payload and how does padding impact the encryption
* ~3:41 How do the server and the client in an SSH connection know which encryption algorithm to use?
* ~6:18 When connecting to an SSH server using the -v option, explain the output printed to the screen?

### Lab

#### Lab Objectives

The objective of this lab are as follows:

* Understand when and how to use the sudo command
* Understand how to edit the /etc/sudoers file
* Understand how to use the journald and journalctl logging mechanism in systemd
* Understand how to add and manage user accounts
* Understand how to modify, use, and secure the SSH service

#### Lab Outcomes

At the outcome of this lab you will be able to successfully understand how to apply the sudo/root user paradigm. You will understand the binary logging mechanism of journald. You will be able to add, delete, and modify user accounts. Finally, you will be able to succesfully setup and establish remote connections.

Assumptions:

* Assignments can be done using Ubuntu or Fedora desktop unless stated
* If a command asks you to work on a user that doesn't exist, it is assumed that you have to create it
* The `mysqldump` application requires the `mysql-client` package to be installed: [http://superuser.com/questions/165582/installation-mysqldump](http://superuser.com/questions/165582/installation-mysqldump "webpage for mysqldump")

1) Write a shell script that issues the command to add a user named "controller" to your system, using the system default values and display the content of the `/etc/passwd` file to show that the user has been created

1) Write a shell script that issues the command to add a group named *itmo356* to your system. Then use the command to modify the user and append this additional group to the user controller you just created.  Issue the command that shows all of the groups a user is a member of.

1) Write a shell script that issues the command to modify the user **controller** to add them to a *superuser* group (sudo on Ubuntu or wheel on Fedora based)

1) Write a shell script that issues the command to add the user named **nsa**, display the content of the `/etc/passwd` file, and then delete the user account, display the content of the `/etc/passwd` to show that the user has been deleted

1) Issue the commands to edit the `/etc/sudoers.d/extensions` file and add an entry to give the **user** "mysql-backup" sudo privilege.

1) Issue the commands to edit the `/etc/sudoers.d/extensions` file and give the **group** "mysql-admins" sudo privilege.

1) Issue the commands to edit the `/etc/sudoers.d/extensions` file and give the **user** "mysql-admin" sudo privilege to only use the mysql database backup command named `mysqldump`

1) Issue the commands to edit the `/etc/sudoers.d/extensions` file to give the user "mysql-admin" sudo privilege to only execute the `mysql` command and not require a password.

1) Issue the command to list all log messages of priority levels ERROR and worse, from the current boot.

1) Issue the command to install `mysql-server` (database) from the command line using either `dnf` or `apt-get`.

1) Issue the command to list all the occurrences in the logs generated by `mysql-server` using journalctl.

1) Install the Nginx webserver in a virtual machine. In your Virtual Machine open a webbrowser and navigate to http://127.0.0.1. Then type in the address bar http://127.0.0.1/cats (this site will 404 -- not be found). Then issue the command to display the content of the Nginx access.log showing both connection you just made, from the log file

1) In your home directory, create a file named: `todo-list.txt`. Then create a group named: accounting. What command would you use to change the group ownership of the file `todo-list.txt` to be owned by the "accounting" group?  

1) Issue the command you would type to generate a RSA key pair, if you created it previously you can overwrite the previous key.

### Part Two

This portion of the lab requires some pre-reqs and setup.

1) The next questions require some setup:
   i. You need two virtual machines for this part: One Ubuntu based and one Fedora based
   i. You will need to modify the Network settings to add a **Host-Only Network Interface** in VirtualBox to get a an IP address only accessible on your computer
   i. Install **openssh-server** on Ubuntu (Server) via apt and Fedora via dnf
   i. On Fedora only, you will need to issue two additional commands to start the ssh server: `sudo systemctl enable sshd` and `sudo systemctl start sshd`

1) Git Clone the repository [https://github.com/jtesta/ssh-audit](https://github.com/jtesta/ssh-audit "SSH audit tool") to both the client and server system, in your home directory. Run the ssh-audit tool on the Fedora and Ubuntu, list the weak ciphers installed by default, use 127.0.0.1 as the host IP

1) Modify the client and servers using the example in the text to increase cipher strength, run the ssh-audit tool again and report any weak ciphers or security anomalies -- you will need to stop the service and start it again to make the changes active

1) Issue the command to connect remotely to the Fedora server via ssh using username and password, create a text file named: website.app - then exit the remote session. On the Fedora system show that the file: website.app, has been created

1) Issue the command to transfer an SSH ed25519 key pair to from your system designated as a client, Fedora, to the Ubuntu SSH server

1) Issue the command to connect remotely to the Fedora server via ssh using username and the identifyFile (RSA key), create a text file named: new-website.app - then exit the remote session. On the Fedora system show that the file: website.app, has been created

#### Footnotes

[^ch9f90]: [http://www.tldp.org/LDP/lame/LAME/linux-admin-made-easy/root-account.html]( http://www.tldp.org/LDP/lame/LAME/linux-admin-made-easy/root-account.html "tldp root")

[^ch9f91]: [http://www.sudo.ws/history.html](http://www.sudo.ws/history.html "sudo")

[^ch9f92]: [http://manpages.ubuntu.com/manpages/dapper/man8/visudo.8.html](http://manpages.ubuntu.com/manpages/dapper/man8/visudo.8.html "visudo")

[^93]: "<a href="https://commons.wikimedia.org/wiki/File:PONDEROSA_PINE_LOGS_STACKED_AT_PINE_INDUSTRY_MILL_-_NARA_-_542596.jpg#/media/File:PONDEROSA_PINE_LOGS_STACKED_AT_PINE_INDUSTRY_MILL_-_NARA_-_542596.jpg">PONDEROSA PINE LOGS STACKED AT PINE INDUSTRY MILL - NARA - 542596</a>" by <span class="fn value"> Daniels, Gene, photographer, Photographer (<a class="external text" href="//research.archives.gov/person/8463941" rel="nofollow">NARA record: 8463941</a>) </span> - <a title="en:U.S. National Archives and Records Administration" class="extiw" href="//en.wikipedia.org/wiki/U.S._National_Archives_and_Records_Administration">U.S. National Archives and Records Administration</a>. Licensed under Public Domain via <a href="//commons.wikimedia.org/wiki/">Wikimedia Commons</a>.

[^94]: [https://fedoraproject.org/wiki/Changes/NoDefaultSyslog](https://fedoraproject.org/wiki/Changes/NoDefaultSyslog)

[^95]: [http://www.rsyslog.com/doc/history.html](http://www.rsyslog.com/doc/history.html)

[^96]: [https://docs.google.com/document/pub?id=1IC9yOXj7j6cdLLxWEBAGRL6wl97tFxgjLUEHIX3MSTs&pli=1](https://docs.google.com/document/pub?id=1IC9yOXj7j6cdLLxWEBAGRL6wl97tFxgjLUEHIX3MSTs&pli=1)

[^97]: [http://0pointer.de/blog/projects/journalctl.html](http://0pointer.de/blog/projects/journalctl.html)

[^98]: [https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)

[^99]: [http://www.freedesktop.org/software/systemd/man/journalctl.html](http://www.freedesktop.org/software/systemd/man/journalctl.html)

[^100]: [https://en.wikipedia.org/wiki/Top_(software)](https://en.wikipedia.org/wiki/Top_\(software\))

[^101]: [http://www.freedesktop.org/software/systemd/man/journald.conf.html](http://www.freedesktop.org/software/systemd/man/journald.conf.html)

[^102]: [http://www.rogerbinns.com/blog/linux-top-origins.html](http://www.rogerbinns.com/blog/linux-top-origins.html)

[^103]: [http://hisham.hm/htop/](http://hisham.hm/htop/)

[^104]: [https://en.wikipedia.org/wiki/Syslog](https://en.wikipedia.org/wiki/Syslog)

[^ch9f105]: [https://www.libressl.org/](https://www.libressl.org/ "Libressl")

[^ch9f106]: [http://heartbleed.com](http://heartbleed.com "heartbleed")

[^ch9f107]: [https://www.linuxfoundation.org/press-release/2014/04/amazon-web-services-cisco-dell-facebook-fujitsu-google-ibm-intel-microsoft-netapp-rackspace-vmware-and-the-linux-foundation-form-new-initiative-to-support-critical-open-source-projects/](https://www.linuxfoundation.org/press-release/2014/04/amazon-web-services-cisco-dell-facebook-fujitsu-google-ibm-intel-microsoft-netapp-rackspace-vmware-and-the-linux-foundation-form-new-initiative-to-support-critical-open-source-projects/ "Linux foundation adopts OpenSSL as core infrastructure")

[^ch9f108]: [https://askubuntu.com/questions/2271/how-to-harden-an-ssh-server/2279](https://askubuntu.com/questions/2271/how-to-harden-an-ssh-server/2279 "harden SSH server")

[^ch9f109]: [https://unix.stackexchange.com/questions/333728/ssh-how-to-disable-weak-ciphers](https://unix.stackexchange.com/questions/333728/ssh-how-to-disable-weak-ciphers "SSH how to disable weak ciphers")

[^ch9f110]: [https://askubuntu.com/questions/449364/what-does-without-password-mean-in-sshd-config-file](https://askubuntu.com/questions/449364/what-does-without-password-mean-in-sshd-config-file "SSH what does without password mean in sshd conf")
