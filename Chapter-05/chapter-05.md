# The Linux Filesystem, Path, Shell, and File Permissions

![*The Shells*](images/Chapter-Header/Chapter-05/seashell2.png "Linux Shells")

## Objectives

* Describe the structure of the Linux Filesystem
* Explain the difference between absolute and relative paths
* Identify the function of the Linux Shell and its relation to the operating system
* Identify the fundamental shell commands for traversing the filesystem
* Describe the Linux commandline nomenclature
* Explain file permissions and file security nomenclature

## Outcomes

At the completion of this chapter you will understand how to use the Linux shell for modifying the contents of the operating system.  You will understand the nature of the filesystem and how to navigate it.  You will be able to demonstrate full awareness of absolute and relative paths and understand the system path.  You will know basic shell commands for manipulating content in the filesystem.  

### Chapter Conventions

The terms `commandline`, `terminal`, and `shell` have been used interchangeably so far to convey the method for a user to issue commands to the kernel.  In this chapter we will explore the discrete differences between the terminal and the shell, with the term commandline or CLI being a generic word referring to anything where system commands are entered in text.

The terms `files`, `folders`, and `directories` can be used interchangeably in regards to this chapter's contents.  Remember from Chapter 2, everything in Unix is a *file*, meaning that a folder which is also a directory is also a file from the operating systems point of view. You will also notice a tag __Exercise:__ in blockquotes throughout the chapter with little exercises that will let you follow along as you read.  

## The Filesystem

A filesystem is a way for the operating system to manage and access files.  It is how data is segregated and the mechanism the operating system uses to retrieve and write data.  The benefit of a filesystem is it will keep track of the locations in memory of your files.  When you double click on a jpg picture in your photo directory, the operating system talks to the filesystem and says, "I want this picture, where is it located?"  The filesystem has an index table of all files location in memory and looks up the address of the file.  That address is given to the kernel which then passes it to the disk controller for the data retrieval portion.  The bits are effectively returned to the operating system from the kernel and the image is rendered to the screen.  

The Linux filesystem was designed as an __upside down tree__ by Ken Thompson.  What is at the bottom of a tree? The __root__ is at the bottom.  This is an important concept to remember in Linux.  In Linux the __root__ or written as __"/"__ (pronounced *slash*), is at the top of our upside down tree.  From the __root__ you navigate down the file hierarchy using the `cd` commandline tool. You cannot go any higher in the tree than __root__, you can only go down.  When you type the command `ls /` you see a directory listing of the contents of the root directory. As you can see below the root directory contains sub-folders, and those sub-folders can have many more sub-folders.  This first level below the __root__ has a common core of directories across each Linux distro. Let us take a closer look at Ubuntu and Fedora root folder file hierarchy.

![*Ubuntu root directory listing*](images/Chapter-05/filesystems/ubuntu-root-listing.png "Ubuntu root directory listing")

![*Fedora root directory listing*](images/Chapter-05/filesystems/fedora-root-listing.png "Fedora root directory listing")

> __Exercise:__ Notice that both of the screenshots above are different even though these are both "stock installs" of two commonly used Linux distros.  Take a look at your own Linux operating system you are using and try running the same command.  Use the GNOME Activities button to search for the phrase __terminal__ and launch it by clicking on the terminal icon. Then type the command ```ls /``` in the terminal. What is the output you see compared to the two images above?  Try it on some other distros and compare the output.

How does this compare to other operating systems? Windows operates on a separate idea of distinct letter drives, C, D, and E for example, each mapping to a discrete disk drives and that is the __root__ of each drive.  Unix was created before it was even technologically possible to have multiple disk drives.  Mac OSX is a different case since it is BSD based, it operates on the same principle as Linux but tries to hide it from you by just giving you icons and finders. You can get terminal access to the commandline and see Mac's Unix heritage too.  

### POSIX Standard

Why are the two filesystem hierarchies different?  The answer goes back to the dawn of commercial Unix in the early 1980s.  By 1985 there was a growing concern, especially from Richard Stallman, that the GNU project would suffer a Coup d'état by Unix vendors who would subtly change the way Unix interfaced with software and make GNU software incompatible and therefore impractical for use. Richard Stallman spurred on a nascent IEEE standards group to create __POSIX__ (pronounced *pah-zicks*), the __Portable Operating System Interface__.  

> "This is a family of standards specified by the IEEE Computer Society for maintaining compatibility between operating systems. POSIX defines the application programming interface (API), along with command line shells and utility interfaces, for software compatibility with variants of Unix and other operating systems.[^49]"  

In this way a single or a small consortium of Unix vendors could not "run away" with the market. POSIX ensures a level of interoperability between software across Unix distros that have declared POSIX compliance.  The first official POSIX standard was released in 1988, a few years ahead of the creation of Linux (1991).  The current version is [POSIX.1-2008](http://pubs.opengroup.org/onlinepubs/9699919799/ "POSIX 7").  It is also referred to by its Open Group Base Specification Issue number, which is 7 or POSIX 7.

It is great to have a standard but what exactly does POSIX do?  Even in that question the answer varies widely, since Unix was already in use at the time for over 15+ years before a standard was in place.  This required the standard to back-define some issues and cave on other issues. POSIX defines at a minimum what a certified Unix based system must support feature and API wise, no more, no less.  It does not restrict extra non-POSIX features from being included.  In reality there is no POSIX Unix version like there is GPL compliant GNU/Linux distros. Most Linux distros are very POSIX compliant by nature, but very few systems are certified POSIX compatible.  For example, POSIX doesn't define a default filesystem other than requiring /, /tmp, and /dev be present.

### The Linux Standard Base

Seeing the good that POSIX standardization brought to the Unix world, a similar industry group formed the [Linux Standard Base](https://en.wikipedia.org/wiki/Linux_Standard_Base "LSB"), or LSB.  The LSB was put together for two main purposes. First it was hoped that application vendors (Oracle, Postgress, Sun, JBoss, IBM, etc, etc) would certify their products to work across different Linux distros that are LSB certified.  Vendors pay a significant amount of money to Microsoft to get drivers certified across versions of Windows for instance.  Second was for creating a central Linux identity and reference guide for distros to comply with.  The LSB started by extending POSIX and included new items unique to Linux.  *"The LSB specifies for example: standard libraries, system commands and utilities that extend the POSIX standard, the layout of the file system hierarchy, run levels, the printing system (including spoolers such as CUPS) and tools like Foomatic, and several extensions to the X Window System."* [^50] This initial standard body came together and was published in January of 2001.

Most importantly the LSB sought to create an __ABI__, [Application Binary Interface](https://en.wikipedia.org/wiki/Application_binary_interface "ABI").  This is different than an API, which assumes that there will be the same standard libraries to code against on every Linux distro.  The ABI gives assurance that code __compiled__ using a C compiler with the ABI compatibility feature turned on will generate a binary file that will run on all LSB compliant Linux systems.  This is similar to a Windows .exe package you create. It runs on all Windows platforms from XP all the way to Windows 10, those operating systems are ABI compliant.  The LSB wanted to guarantee this so that major vendors of software would not have to maintain multiple software versions, just maintain one version with ABI compatibility, thus preventing a barrier Linux enterprise adoption.

The dream of a unified Linux standard never really occurred. __No one implements LSB the way it was intended__. This post from the Debian LSB mailing list marked July 3rd 2015 says it all:  

> "*The crux of the issue is, I think, whether this whole game is worth the work: I am yet to hear about software distribution happening through LSB packages. There are only _8_ applications by 6 companies on the LSB certified applications list, of which only one is against LSB >= 4.  Amongst the distributions, RHEL 7.0 is LSB4.1, and Oracle 6, RHEL 6.0 and Ubuntu 9.04 are LSB 4 [^59].*"

### United Linux of 2002 and the Enterprise Linux Association of 2023

As we saw in the fifth phase of Unix/Linux maturity, as Linux companies became viable businesses at the turn of the century, there was a fear that a single company could do what Microsoft had done and corner the market and force all other Linux distributions to be incompatable. So in 2002, United Linux was formed. It was a group united to making a single compatible Linux distro that would compete against Red Hat Linux. It consisted of [SUSE](https://www.suse.com/ "webpage for SUSE Linux"), then owned by [Novell](https://en.wikipedia.org/wiki/Novell "wiki for Novell"), Oracle, and Caldera Linux, which was renamed [SCO Group](https://en.wikipedia.org/wiki/SCO_Group "wiki for SCO group"). The effort collapsed in 2004, when the SCO Group turned around and claimed it owned the Unix Trademarks and that Novell/SUSE, along with IBM, were infringing on their patents. It took a decade, but the courts eventually dismissed SCO Groups claim, but United Linux was dead.

Ironically, a second effort at what might be called the "New United Linux" is being formed by the [ELA - Enterprise Linux Association](https://www.suse.com/news/OpenELA-for-a-Collaborative-and-Open-Future/ "webpage for the ELA announcemnt"). This group is comprised of SUSE, Oracle, and CIQ and is trying to make a standard Enterprise Linux to compete with Red Hat, forked from the Red Hat Enterprise linux code base.

### Lennart Poettering's thoughts on POSIX

Lennart Poettering, the Red Hat engineer and leader of the systemd init system has some things to say about POSIX and his being a Red Hat employee seems to mirror Red Hat's position on the history of the Linux Filesystem.

> "POSIX is really an encapsulation of some choices that various Unix systems made along the way, rather than a body of text that got standardized and then implemented. According to Poettering, Linux should use its position as "market leader" (in the market of free Unix-like operating systems) and try out some new things. If developers don't force themselves into the constraints of the POSIX API, they could develop some really innovative software, like systemd shows. When these new developments happen to turn out really interesting, other operating systems could eventually adopt them as well." [^53]

> "Not having to care about portability has two big advantages: we can make maximum use of what the modern Linux kernel offers these days without headaches -- Linux is one of the most powerful kernels in existence, but many of its features have not been used by the previous solutions. And secondly, it greatly simplifies our code and makes it shorter: since we never need to abstract OS interfaces the amount of glue code is minimal, and hence what we gain is a smaller chance to create bugs, a smaller chance of confusing the reader of the code (hence better maintainability) and a smaller footprint." [^54]

> "In fact, the way I see things the Linux API has been taking the role of the POSIX API and Linux is the focal point of all Free Software development. Due to that I can only recommend developers to try to hack with only Linux in mind and experience the freedom and the opportunities this offers you. So, get yourself a copy of The Linux Programming Interface, ignore everything it says about POSIX compatibility and hack away your amazing Linux software. It's quite relieving!" [^54]

#### Linux Filesystem Standard Hierarchy

The one useful thing that came out of the LSB is the __Filesystem Hierarchy Standard__, or *FHS* [^47][^61].  This is a voluntary standard maintained by the [Linux Foundation](https://wiki.linuxfoundation.org/lsb/fhs-30 "Linux Foundation") that includes a standard hierarchy of directories and optional directories that exists under the __root__ in a standard Linux distro.  You should *memorize* each directory name and its general function [^63].  

Directory           Function
----------  ---------------------------------------------------------------------------------------------
__bin__         Essential command binaries
__boot__        Static files of the boot loader that copy the kernel into memory on boot
__dev__         Device file handles
__etc__         System configuration files, pronounced *"et-cee"* or *"ee-tee-cee"*
__lib__         Essential shared libraries and kernel modules
__media__       Mount point for removable media
__mnt__         Mount point for mounting a filesystem temporarily, pronounced *"mount"*
opt         Add-on application software packages
run         Data relevant to running processes
__sbin__        System binaries added by each operating system for management  
srv         Data for services provided by this system
__tmp__         Temporary files - some distros clear this directory upon reboot (pronounced *"temp"*)
__usr__         Secondary hierarchy - contains X, KDE or GNOME, plus documentation
__var__         Variable data - used for storing databases, webserver files, and application logs
*proc*        Virtual filesystem created at runtime providing process and kernel information as files
----------  ---------------------------------------------------------------------------------------------

![*Linux Filesystem Hierarchy Standard - items not bold from above will not be included*](images/Chapter-05/filesystems/chapter-05-filesystem-hierarchy-diagram.png "Hierarchy")

There are 3 additional directories that are non-standard but appear on most Linux distros [^62].  You can see a screenshot below.

Directory       Function
----------  ---------------------------------------------------------------------------------------------
__home__        Users' home directories, containing saved files, personal settings, place that you own.
__root__        Home directory for the root user - not to be confused with /
__lib64__       Alternate home for 64 bit libraries
----------  ---------------------------------------------------------------------------------------------

![*Ubuntu root full directory listing*](images/Chapter-05/filesystems/ubuntu-root-listing-long.png "Ubuntu root directory listing")

![*Fedora root full directory listing*](images/Chapter-05/filesystems/fedora-30.png "Fedora root directory listing")

#### Red Hat vs POSIX and LSB

The traditional file system layout goes back to the original design of Unix 50+ years ago. This means that this structure is wide spread and well known. Modern Linux realized that some of the directories defined are completely arbitrary, such as /bin, /sbin, /lib, and /lib64. There are historic reasons for these being discrete directories and also repeated under the /usr directory.

To move things back in line with the original Unix design, Red Hat led the charge in the FSH to merge /bin, /sbin, /lib, and /lib64 to be under /usr[^52] and update the FSH. The discrete directories are left in place as symlinks for backwards compatability. Red Hat also says this makes Linux applications more inline with Unix and Solaris, therefore making it easier for customers and companies using Unix and Solaris to port over their software or migrate to Red Hat based distros. By using the command `ls -l /` you can see the light blue colored soft links to the actual directories.

## Path

Remember that our filesystem is an upside down tree?  That means we can traverse up and down the tree to arrive at file locations.  We now have a way of addressing every single file, folder, and directory on the filesystem.  We call this the __path__.  This path can be referred to in two ways: __absolute path__ and __relative path__.  There are also certain locations in the path that have well known names, such as __root__ and a user's __home directory__.  

### Absolute Path and Relative Path

What is the difference? Think of your school or home address.  If I told you I live at [324 W 35th Street Chicago Illinois 60616, United States of America](https://en.wikipedia.org/wiki/Comiskey_Park "Comiskey Park") that would be my __absolute__ address and very helpful, right?

But what if you already lived in the US and in the city of Chicago?  What if you lived on the same street as the address listed above, there would be no need to repeat all the detailed information.  Perhaps I would just say I live at *"325 West"* and you would know where to go.  This concept is called __relative path__. Let us see this concept in action.  Later in this chapter we will cover shell commands in detail but for now we will introduce a few basic ones.

* `cd` - used to change directory and move up and down the filesystem tree.
* `pwd` - used to check what your present location is on the filesystem tree.
* `ls` - used to list the content of the directory where you are located on the filesystem tree.

When the terminal window opens you are automatically deposited at a specific location on the filesystem tree.  You are placed in your __HOME__ directory.  In this case the absolute path to that location is ```/home/jeremy``` (my username being jeremy in this example.)  You can always come back to this directory by using the shortcut of ```~``` like this:  ```cd ~```. Let us open a terminal window and try this ourselves.

> __Exercise:__ Figure out what your pwd (present working directory) is.  You would do this by simply typing ```pwd``` on the commandline. Try it and what is the output?

> __Exercise:__ The next thing we should do is a listing of the contents in our current directory.  We do this by issuing an ```ls``` command.  Try it, what do you see?

> __Exercise:__ Let's learn how to use the ```cd``` command, which allows us to change our current directory location.  Let's change our location into the Documents folder, which is under our current pwd.  Do so by typing ```cd Documents```.  Once we have changed the directory, type ```pwd``` and then ```ls``` command.  What do you see?

> __Exercise:__ Let's learn about the ```cd``` command to change our directory location. Type ```cd /etc/network``` if you are on Ubuntu and ```cd /etc/sysconfig/network-scripts``` if you are on Fedora or CentOS.  Type the ```ls``` commands--what do you see?  Also are these path absolute or relative?

The way to determine is that an absolute path will always start with __/__ as the first character. Much like the address example this is telling you the directories absolute location in relation to the __root__.  On Ubuntu for instance, the network directory can be found by traversing the tree from ```/``` down to a system directory called ```etc``` and then to a sub-directory located in etc called ```network```.  In this case, ```network``` is a sub-directory of etc and contains all the files related to configuring your network card settings.  

A relative path assumes the pwd portion of the absolute path.  From the exercise example above we notice a few things about relative paths.  __First__ our pwd when we open a shell is our home directory.  In my case /home/jeremy. If we see the hierarchy the directory Documents is under the jeremy directory.  the ```cd``` command takes us down one directory by default.  How can we "cd" into that directory?  By simply typing ```cd Documents```.  This is a __relative path__. Why?  Notice that there is no __/__ in front of the directory name.  This tells the cd command that you are assuming that the system should start looking for the directory name we passed in the directory we currently are.  Could we have typed ```cd /home/jeremy/Documents```?  Yes we could have, but the first two parts of the absolute path were irrelevant to us because we were already in that location.

How would we navigate back up the tree?  What if we want to return to our home directory? There are a few options, assuming that our pwd is ```/home/jeremy/Documents``` which of these would be the best choice?

----------------------  ----------------------------
```cd /home/jeremy```    absolute or relative path?
```cd ~```               absolute or relative path?
```cd ../```             absolute or relative path?  
----------------------  ----------------------------

The first two options are absolute paths, the third option is a relative path with something new.  Here we are introduced to the __double-dot__ operator.  The __double-dot__ and __single-dot__ (sometimes just called *dot*) are the way you can reference locations up the tree or in your current directory (same level).  The command ```cd ../``` is a shortcut to take you __up__ one level in the filesystem tree.  Double-dots can be chained together to traverse up multiple directories all at once.  

> __Exercise:__ If your pwd is `/home/jeremy/Documents` (replace "jeremy" with whatever your username is) and you want to change directory to /home.  What command would you use?  What happens when you type `cd ../../` on the commandline?  What is your pwd now?

> __Exercise:__ Assume your pwd is `/home/jeremy/Documents` and you want to change directory to `/home/jeremy/Downloads` what would be the command to do so in one single command?

You could do this:

1. ```cd ../``
1. and then ```cd Downloads``` which would get the job done.
1. In one single command: ```cd ../Downloads```
1. This command will be interpreted as: ```../``` means go up one directory
1. The next directory name ```Downloads``` means go down one directory.  

![*Path demonstration*](images/Chapter-05/path/path-commands.png "Path Commands")

What happens if you try to cd into a directory that doesn't exist?

![*File or Directory not found*](images/Chapter-05/path/file-not-found.png "File not found")

> __Exercise:__ You can use the ```touch``` command to create an empty file called todo-list.txt in the /tmp directory. Try this command assuming your pwd is your Home directory. From the commandline type: ```touch /tmp/todo-list.txt```.  Now type: ```ls```, do you see the file todo-list.txt?  Why or why not? How would you list (ls) the contents of the /tmp directory if your pwd is /home/jeremy/Documents?

## The Linux Shell

### Shell, Terminal, and Commandline  

If you remember from chapter 4 that the word *"terminal"* came from the actual DEC VT-100 physical terminals that were in use in the late 70's and early 80's for use in interfacing to Unix systems.  A terminal is a way to display text in 80 by 25 line screens of text.  The __shell__ is the actual application that runs on the terminal to display that screen of text and allow the user to interact with the Kernel via commands.   There are many types of shells that have different features.  Shells give the user the ability to create scripts for executing multiple commands, command completion, command history, command aliases, and more.  You open a terminal and in a terminal session you use a shell.  You can have multiple terminal sessions and use different shells on each one if you prefer.   In total the combination of using a terminal to access a shell can be called using the *commandline*.  The diagram below shows how the commands you type in the terminal are processed by the shell, given to the kernel and then output is returned to the user.

![*Shell/OS interaction diagram*](images/Chapter-05/shells/figure2.png "Shell Interaction Diagram")

### Linux Shell Commands

Many may say, *"Hey I have a nice point and click GUI why do I need to use the crusty old commandline?"*  That is a valid question.  In reality the GUI is not separate from the shell.  It is a *"visual sugar"* built on top of the Shell. Anything you click on in a GUI in reality is in reality __executing a command through the shell__.  In most cases using the Shell has more features for your command than in the GUI.  The GUI by definition cannot have more capability than the shell.  

### Basic Shell Commands

The Shell is where we enter commands for navigation, manipulation, and creation of text files.  Some of the basic commands covered in chapter 5 and 6 are in the table below.  In the course of your career you need to memorize at least these commands by name and what they do.

-------------------- ------- ------- ------ ------ -------- ------- -----
meta-commands          cd      ls     pwd    file    date
file-related           cp      mv     mkdir  touch   wget    rmdir   rm
file-ownership        chmod   chown   chgrp
display-related        cat     less   more    tac    head    tail
display-augmentation   grep    awk    sed
help commands          man    info    find   which  locate
-------------------- ------- ------- ------ ------ -------- ------- -----

cd

: This command is used to help you change the directory location.  The shell can only be pointed at one file location at a time.  In a GUI you are used to *"clicking"* on folders to navigate up and down the filesystem hierarchy.  What you are actually doing when you click is issuing __cd__ commands to the kernel which is returning instructions of what the GUI should now render.

```bash
cd /tmp
```

ls

: This command is used to list the content of the current directory you are in.

```bash
ls /etc
```

cp

: This command is used to cp the contents of a file, can also be used to copy and rename a file.

```bash
cp *.txt /home/user/Documents
```

mv

: This command is used to rename or move a file in-place, though the actions are technically the same.  By renaming a file you are essentially moving its contents to a new file in-place.

```bash
mv ./secret-passwords.txt ./new-secret-passwords.txt
```

mkdir

: This command is used to create or make a new directory. Pronounced *"make-dur"*

```bash
mkdir ~/legally-downloaded-music
```

touch

: This command is used to create a new blank file or to update the timestamp of an existing file without opening it.

```bash
touch todolist.txt
```

cat

: This command is used to display the content of a file to the screen.  Technically created to concatenate two files but will accept "nothing" as one input and concatenate nothing plus a filename content and output that to the screen.  There are lengthy articles discussing if this is the [correct method or a superlative way](http://stackoverflow.com/questions/11710552/useless-use-of-cat "UUoC").  We will use it through out the textbook because of readability and common usage acceptance.

```bash
cat /etc/apache2/sites-available/000-default
```

tac

: This command is used to display the entire content of a file but backwards.  The last line of the file will be printed first

```bash
tac /etc/passwd
# The contents of tac can be piped to a less command to allow paging:  
# hit the letter 'q' to exit the less command
tac /etc/passwd | less
```

less

: This command is a *hack* on the __more__ command which allows for scrolling the text of a file using the enter key or page down, and space bar or arrow down key for single line scroll.  The __more__ command only went down, not up.  Hence the more powerful command __less__ which pages and line scrolls up and down a document.  Less is more.

```bash
less /var/log/apache2/error.log
```

date

: This command displays the common date and time format. It has full formatting customization so you can display date and time exactly as you need to.

```bash
date '+%m%d%y'
```

file

: This command has been in Unix since at least 1973 records show.  Its use is to help you identify what type of file something is.  It will out put the type of file if it is text, a directory, a binary, or something else.

```bash
file self-destruct
```

pwd

: This command tells you your __present working directory__ on the Linux filesystem tree.

```bash
pwd
```

wget

: This command is used to retrieve files over the internet via an HTTP GET request.  If you are using the commandline you cannot "click" on a link but when you click on a link you are sending an HTTP GET request in reality.  This gives you control without having to leave the commandline.  The sample below will you download the markdown files used to build this textbook.

```bash
wget https://github.com/jhajek/Linux-text-book-part-1/archive/master.zip
```

unzip

: This command is used to extract a compressed file of type zip.  There is a GNU version of this named gzip that extracts gzip files.

```bash
unzip music.zip
```

tail

: This command is used to display the last 10 lines of a file.  The number 10 can be overridden by using the `-n` flag to display an arbitrary number of lines.

```bash
tail /etc/passwd
```

```bash
tail -n 25 /etc/passwd
```

man

: This is the command you use when you can't remember how to use other commands.  just type the word man and then any other command name and you will automatically drop into a __less__ session which will explain the use and history of that command.  This is a very helpful tool as no one can memorize every single command.  From here on out in the class when you ask a question, the instructor's first answer will be, *"Check the man page."* As you progress in your Linux journey the __man__ command will be your best friend--use it wisely young Jedi.

```bash
man wget
```

> __Exercises:__ Let's create a text file that has the current date and time in it.  Type ```date > timestampfile```  (The ```>``` is a shell meta character that redirects output from the screen to another file. We will learn more about this in chapter 6.)

> __Exercise:__ Now copy that file to the ```/tmp``` directory--what would be the commands? Now let us make a new directory under our home directory called notes (remember the filesystem is an upside down tree)

> __Exercise:__ What command would we use?  ```mkdir notes```.  Now let us copy the file ```timestampfile``` into the notes directory. What command would you use? What would the full command and arguments look like?  How would you change directory and list the content of the notes directory (hint cd and ls)? *Note* if you get lost in the Linux filesystem tree you can always type cd ~ (tilde) and you will be taken back to your user home directory.

### Command Nomenclature

Commands contain three parts in this order:

* command or binary name (required)
* options (may or may not be required)
* arguments (may or may not be required)

Let's take this command for instance:

```bash
ls -la /etc
```

The first two letters of the command listed above `ls` make up the command for listing the contents of a directory.  The command must be followed by a space. The next  letters are proceeded by a __dash__ to tell the shell interpreter that these letters are __options__.  Options are usually single letter representations of functionality.  The `-l` options tells the __ls__ command to give a long listing of a directory with details and the __"-a"__ option tells the shell to print all files in the directory, including hidden files.  Options can be combined in most cases into a single string proceeded by a dash.  So `-la` can also be written as `-l -a`.  Additionally there are options that use full English language words instead of single letters proceeded by __two dashes__.  You can use the ```man``` command followed by the name of the command in question to see all of it's usage options.  

The final value of __```/etc```__ in the command  ```ls -la /etc``` is an argument passed to the ```ls``` command telling the __ls__ command to list the contents of the __/etc__ directory.  If this value is left empty the shell assumes you mean the ```pwd``` or your current location in the filesystem.

![*Listing of the /home/controller directory*](images/Chapter-05/commands/ls-home.png "ls /home/controller")

![*Long and hidden Listing of the /home/controller directory*](images/Chapter-05/commands/ls-la-home.png "ls -la /home/controller")

### How to Read Shell Commands and "Speak Linux"

In working with many excellent people over the years I have also found that there is a common Linux spoken language.  When talking to others, you find that for the most part the standard Linux filesystem has been memorized.  As well as the most common Linux tools through repeated usage.  With this in mind you can "speak" a command without mentioning certain aspects--they are implied.  

Let's take a simple command to list the contents of the /etc directory with a long listing and showing all, including hidden filed for instance.  How would you verbalize the command to your co-worker?

```bash
ls -la /etc
```

You would say "*el-es el-aaa eee tee cee*".  *Note* I didn't mention any dashes or slashes.  Why? Because the context of the ```ls``` command tells me that the next characters listed are options belonging to the ```ls``` command.  The shell assumes that you are giving an absolute path because of the slash proceeding ```/etc```.  

> __Exercise:__  How would you read and say this command?

```bash
rm -rf /tmp/topsecret
```

> __Exercise:__ How would you read and say this command?

```bash
mkdir -p /mnt/datadrive
```

> __Exercise:__ How would you read and say this command?

```bash
ls -la /etc/network/interfaces
```

### History of the Shell

On modern Linux there is one standard shell in place on pretty much all major Linux distros, the [GNU Bash Shell](http://www.gnu.org/software/bash/ "Bash Shell"). It was created in parallel with the rise of Linux--the two are practically tied together.  But to understand how we got to the modern Bash Shell we have to go back to the beginning. As always the history of anything on Unix/Linux goes back to Ken Thompson [^46].  By 1972 there was a single shell in Unix in use, referred to by others as the [Thompson Shell](https://en.wikipedia.org/wiki/Thompson_shell "Thompson Shell").  This shell was written by Ken Thompson and was written for Ken Thompson solving the technical problems he had back in 1972.  By 1979 computer processing power and the nature of computing tasks were light years away from where they had been when Thompson started his shell. *"The shell's design was intentionally minimalistic; even the if and goto statements, essential for control of program flow, were implemented as separate commands [^55]."* A new shell was needed.

Two almost simultaneous efforts on different sides of the country were happening to replace the Thompson shell.  Remember that Unix had split into BSD Unix out at Berkeley California and AT&T Unix which was the commercial Unix back east.  The BSD group was developing the C shell (csh) under Bill Joy.  AT&T researcher Steven Bourne was developing the Bourne Shell (sh).

![*Timeline history of Unix/Linux Shells*](images/Chapter-05/shells/figure1.png "Timeline history")

#### C Shell

The __C Shell__ was written primarily by [Bill Joy](https://en.wikipedia.org/wiki/Bill_Joy "Bill Joy") while working on the BSD Unix distro in 1978/79.  Joy concluded that since Unix was written in the C language and most programs at the time were written using C, it didn't make sense to change the language one was using in their shell to something other than C. So Joy implemented the shell concept Thompson had started with vastly improved features and using the C language based syntax.  By 1984 there was an improved C Shell called the tcsh that fixed the deficiencies of the original C Shell and added features.  This was only available on some BSD variants at the time.  

Criticism of C Shell: "*Although Stephen Bourne himself acknowledged that csh was superior to his shell for interactive use, it has never been as popular for scripting. Initially, and through the 1980s, csh could not be guaranteed to be present on all Unix systems, but sh could, which made it a better choice for any scripts that might have to run on other machines. By the mid-1990s, csh was widely available, but the use of csh for scripting faced new criticism by the POSIX committee, which specified that there should only be one preferred shell, the Korn Shell, for both interactive and scripting purposes. The C shell also faced criticism from others over the C shell's alleged defects in syntax, missing features, and poor implementation.* [^56]"

#### Bourne Shell

Steven Bourne was a researcher at AT&T Bell labs implemented his own shell to replace the Thompson Shell in 1977.  The Bourne Shell was distributed in standard Unix from Version 7, SystemIII, SVR2, SVR3, SVR4 [^57].

* Built-in test command – System III shell (1981)
* ```#``` as comment character – System III shell (1981)
* Colon in parameter substitutions ```"${parameter:=word}"``` – System III shell (1981)
* Functions and the return builtin – SVR2 shell (1984)
* Built-ins unset, echo, type – SVR2 shell (1984)
* Source code de-ALGOL68-ized – SVR2 shell (1984)
* Modern "$@" – SVR3 shell (1986)
* Built-in getopts – SVR3 shell (1986)
* Cleaned up parameter handling allows recursively callable functions – SVR3 shell (1986)
* 8-bit clean – SVR3 shell (1986)
* Job control – SVR4 shell (1989)
* Multi-byte support – SVR4 shell (1989)

#### Korn Shell

By the start of the 1980s you had two shells, Bourne Shell and the C Shell.  Both had strengths and weaknesses as detailed above.  There is an American expression, "The grass is always greener on the other side of the fence." The C shell users wanted features from the Bourne Shell and vis-a-versa.  Another researcher at Bell Labs, named David Korn, began the process of starting a new shell that was backwards compatible with the Bourne Shell but added the newer features of the C Shell.  This was called the [Korn Shell](http://kornshell.com/ "ksh") (ksh) and released in 1983.  The Bourne Shell was standard on all AT&T Unix so any new shell had to guarantee backwards compatibility otherwise that shell was never going to receive adoption.  The improvements the Korn Shell made were apparent and it was soon included on AT&T Commercial Unix as the standard shell.  In 1991/1992 the POSIX standard adopted KSH as the standard shell that any Unix system claiming POSIX compliance was required to have.  By 2005 the Korn Shell was opensourced under a free license but it was too late.  

#### GNU Bash Shell

The ksh was a suitable replacement for the Bourne Shell and C Shell, but from the Free Software Foundation's view there was one main problem.  All of these shells were under proprietary AT&T licenses.  This led Richard Stallman and the FSF to fund development seeing that having a free software licensed shell was central to their dream of a completely free operating system.  Work was begun in 1989 and completed in 1991.  The shell was named the Bash Shell.  It was a clever hack on the Bourne Shell name.  Bash was a superset of the Bourne Shell and feeling as though they were "freeing" the Bourne Shell from its past life of closed software, they named it the "*Bourne Again Shell*"--Bash.  Bash is the GNU Project's shell. It is intended to conform to the IEEE POSIX P1003.2/ISO 9945.2 Shell and Tools standard. It offers functional improvements over sh for both programming and interactive use. In addition, most sh scripts can be run by Bash without modification [^58].

The improvements offered by bash over sh, csh, and ksh include:

* Command line editing
* Unlimited size command history
* Job Control
* Shell Functions and Aliases
* Indexed arrays of unlimited size
* Integer arithmetic in any base from two to sixty-four

#### Open Source sh Replacements

Unlike Bash which provided a *"free"* `sh` compatible shell for the GNU system, there was much code written in `sh` but no opensource version available. In 1989 Kenneth Almquist released the Almquist Shell (ash) which was an updated and opensourc version of the Bourne shell. In 1995/96 Debian maintainers released another improved version of Ash Shell called the Debian Ash Shell (dash) and this is the standard replacement for the traditional `/bin/sh`.

## File Permissions and Ownership

Since everything in Linux is file, there is a simple file-based security model. There are three types of permission per file: __read__, __write__, __execute__. These files give a combination of permissions. With __read permission__ you can display the content of a file or copy it, but cannot delete or rename it. For that you need __write permission__. If a file is a shell script or an executable binary you will need __execute permission__ for it to run. How can you tell what permissions a file has?  Type `ls -l` see the output. We have seen this output before and now we will explain it.

```bash
$ ls -l
total 936
drwxr-xr-x 3 student student   4096 Sep  8 21:24 aws
-rw-rw-r-- 1 student student 946176 Sep  9 14:34 awscliv2.zip
-rw------- 1 student student   1675 Sep  9 14:49 laptoppc-ubuntu-vm2.priv
-rw-r--r-- 1 root    root       409 Aug 24  2019 vagrant.pub
```

The first column is a listing of the permissions for a file. Notice that there are actually 3 groupings of the letters __rwx__ combined into one long string like this:  ```rw-r--r--```.  In addition to individual permissions there are three categories of permission.  These three categories are __owner__, __group__, __other__  Each of these groups has its own read, write, and execute permissions.  

Every file includes an owner and a group.  If you notice the next two columns in the output of ```ls -l``` you will see them listed.  The group name and owner name can be the same, we will talk more about that in Chapter 9. Permissions can be read in a short hand numeric fashion as well.  The read value is worth 4, the write value is worth 2, the execute value is worth 1  so a permission of ```rw-r--r--``` can be read as 644.  The permissions for rwxrwxrwx is 777.  Numeric value for this is ```rw-------``` is 600. Permissions are calculated with binary.

### Owner, Group, Other (World)

In addition to the rwx permissions, each file has three groupings of permissions associated with it.  The first triad of rwx is the file's __owner__ permission--meaning what the person who owns the file can do to it.  These permissions are usually more liberal because you trust yourself.

The second triad of rwx permissions is __group__ permissions.  Each user is assigned to a group upon account creation and additional groups can be created as needed.  You can give group permissions that cascade to all users in a group.

The final triad of rwx permissions is considered __other__ or sometimes called unofficially __world__.  This covers the permissions for a user who is not the owner nor in the group that owns the file. Usually this column is conservatively "read-only."

### Reading and Changing File Permissions

| Owner| Group | Other |
|-----|-----|-----|
| 7   | 6   | 5   |
| 421 | 42- | 4-1 |
| rwx | rw- | r-x |

There is one character either a "-" or a "d" generally proceeding the file permissions, and this tells "d" for directory and "-" for a file.  There are additional file type characters that I will list here, only the first three we will be dealing with directly in this book [^60].  

File type                 Symbol
------------------       --------
__file__                    -
__directory__               d
__symbolic link__           l
named pipe                  p
devices                   b or c
sockets                     s
------------------       --------

## Chapter Conclusion and Review

In this chapter we covered the basic nature of the Linux Shell and how it allows users to interact with the Kernel.  We learned basic navigational and file creation and delete commands.  We learned about the Linux filesystem and the difference between absolute and relative path and a number of the basic shell commands. Finally we covered file permissions.

### Review Questions

1.  What is the numeric value of a file with the permissions rwxr--r--?
    a.  777
    b.  700
    c.  766
    d.  744
1.  What is the numeric value of a file with the permissions rw-----?
    a.  700
    b.  400
    c.  600
    d.  007
1.  What is the numeric value of a file with the permission rwxr-xr-x?
    a.  711
    b.  755
    c.  644
    d.  227
1.  What is the name of the command you use to list the contents of a directory?
    a.  `lst`
    b.  `less`
    c.  `cat`
    d.  `ls`
1.  What is the name of the command you use to display the content of a file to the screen?
    a.  `dg`
    b.  `tac`
    c.  `ls`
    d.  `cat`
1.  What is the name of the command you use to display the content of a file to the screen that allows you to page up and down?
    a.  `more`
    b.  `less`
    c.  `ls`
    d.  `page`
1.  Every shell command has three components:
    a.  Command, arguments, flags
    b.  Command, options, arguments
    c.  Commands, arguments, options
    d.  Commands, flags, options
1.  What does the user use to issue commands to the kernel?
    a.  Terminal
    b.  Commandline
    c.  Magic
    d.  Shell
1.  What is the name of the GNU shell that is standard across all Linux Distros
    a.  ksh
    b.  sh
    c.  csh
    d.  bash
1.  Based on the ls command, what is the option to do a long listing?
    a.  `ls --all`
    b.  `ls -n`
    c.  `list`
    d.  `ls –l`
1.  What is the command you can use to find out additional usage information about a shell command?
    a.  about
    b.  man
    c.  F1
    d.  /?
1.  Which of these directories is not part of the LSB LFH?
    a.  bin
    b.  media
    c.  temp
    d.  opt
1.  The Linux Filesystem is an upside down what?
    a.  root
    b.  object
    c.  tree
    d.  mess
1.  What is the character name of the top of the Linux Filesystem tree?
    a.  `/`
    b.  `./`
    c.  `../`
    d.  slashdot
1.  Everything (directories, files, devices) in Unix/Linux is a what?
    a. state
    b. idea
    c. node
    d. file
1.  What is the name of the Unix system standard developed in ~1985 that defines at a minimum what a certified Unix based system must support?
    a.  Xenix
    b.  LSB
    c.  POSIX
    d.  Linux
1.  What is the absolute path of a user's home directory, assuming the user is named controller?
    a.  /home/user/controller
    b.  /home
    c.  /user/controller
    d.  /home/controller
1.  What is the command line short cut to represent the home directory?
    a.  `~-`
    b.  `$`
    c.  `#`
    d.  `~`
1.  In the Linux Filesystem Hierarchy which directory usually holds system configuration files?
    a. `/usr`
    b. `/etc`
    c. `/conf`
    d. `/opt`
1.  In the Linux Filesystem Hierarchy which directory usually holds essential command binaries?
    a. `/bin`
    b. `/etc`
    c. `/conf`
    d. `/opt`
1.  In the Linux Filesystem Hierarchy which directory usually holds a mount point for mounting a filesystem?
    a. `/opt`
    b. `/etc`
    c. `/conf`
    d. `/mnt`
1.  What is term used to describe this system path: `/usr/sbin/`?
    a. relative
    b. hybrid
    c. normal
    d. absolute
1.  What is term used to describe this system path: `../`?
    a. relative
    b. hybrid
    c. normal
    d. absolute

### Podcast Questions

[Command Line Heroes: Bash](https://www.redhat.com/en/command-line-heroes/season-3/heroes-in-a-bash-shell "Command Line Heroes: bash")

* ~0:20 Who is the creator of the Bash Shell?
* ~0:43 Which organization did the creator of the Bash Shell write the shell for?
* ~2:05 How does the podcast host define a shell script?
* ~2:23 Shell scripts are the key to what?
* ~3:28 When did Ken Thompson release his shell and what was it missing?
* ~3:45 What year did shell scripting come into existence?
* ~4:27 What was the shell that became the AT&T UNIX standard shell?
* ~5:53 The Bourne Shell was licensed and owned by whom?
* ~7:59 Why was Brian Fox the perfect person to develop the Bash Shell?
* ~9:30 How long did it take to create the Bash shell and what was difficult about this?
* ~12:02 What did Brian accidentally do to the Bash Shell code?
* ~14:48 What was the other shell released one month before Bash?
* ~15:19 When was GNU Bash released?
* ~18:40 What was the released/intended purpose of GNU Bash?
* ~19:25 What words and terms are now in use in everyday English?
* ~20:46 Was Steven Bourne "cool" with the Bash Shell?
* ~22:52 What prepares you to be more of a long-term thinker?

### Lab

The objectives of this lab are to use the shell commands we learned in this chapter and understand their proper usage and form. The outcome will help your ability to successfully use the Linux Shell for navigation, file creation, and file modification. Resist the temptation to use the GUI file manager and a web browser. All actions will be done through the shell unless noted.  

**Note:** All work should be done on either Ubuntu desktop or Fedora desktop unless noted and using the Terminal.

#### Part 1

Here we will be creating a number of directories and files in order to navigate our filesystem. Each step can be satisfied with a short line of text or a screenshot.

1) Open a terminal, `cd` to the **Documents** directory. Issue the `pwd` command to find your present working directory (or current location).
1) In the **Documents** directory, use the `mkdir` command to create a directory named: **class-notes**
1) `cd` into the `class-notes` directory. Issue the command to show your present working directory. 
1) Create the a directory named `distros` in the `class-notes` directory. Once created take a screen shot of the output of the `ls` command in the distros directory
1) Under the `distros` directory create a directory named: `BSD`
1) Under the `distros` directory create a directory named: `Debian`
1) Under the `distros` directory create a directory named: `redhat`
1) In the directory `BSD` use the command to create a file: Create three files names: oracle-linux.txt, openbsd.txt, and netbsd.txt
1) In the directory `Debian` use the command to create a file: Create three three names: ubuntu.txt, freebsd.txt, and xubuntu.txt
1) In the directory `redhat` use the command to create a file: Create three files names: fedora.txt, rhel.txt, and debian.txt
1) `cd` to the `distro` directory and create a file named: `omnios.txt`
1) In the text files created you will notice that a few of them are out of place, such as `debian.txt` is in the `redhat` folder. Issue the command to move the text files to the correct locations and show a directory listing before and after the move command.  (*Hint*: ls mv ls)
1) Use the `mv` command to rename the `redhat` directory to have an uppercase "R"
1) Use the `rm` command to delete the oracle-linux.txt file
1) Use the `mkdir` command to create a directory in the `distros` directory named: **illumos** and move the omnios.txt file into the **illumos** directory
1) What would be the command to `cd` from your current location to the relative path of `./distros/BSD` directory using a relative path?
1) What would be the command to change directory from your current location to the `Redhat` directory using a relative path?
1) What would be the command to change directory to your **HOME** directory using the relative path?
1) What would be the command to change directory from your **HOME** directory to the `debian` directory using a relative path? 
1) What would be the command, using an **absolute** path to change from your current directory to the `/etc/ssh/` directory?

#### Part 2

1) Use the `man` command to figure out how to display the format of the `date` command as month, day, year combined to look like: 10152021
1) Using the file on Ubuntu: `/var/log/syslog` or Fedora `/var/log/dnf.log`:  Type the command to display the last 10 lines of this file
1) Using the file on Ubuntu: `/var/log/syslog` or Fedora `/var/log/dnf.log`:  Type the command to display the first 10 lines of this file
1) Using the file on Ubuntu: `/var/log/syslog` or Fedora `/var/log/dnf.log`:  Using the `man` command on the previous question, find how to display the last 25 lines of this file
1) Using the file on Ubuntu: `/var/log/syslog` or Fedora `/var/log/dnf.log`:  Type the command to display the entire contents of this file backwards (last line to first)
1) Using the file on Ubuntu: `/var/log/syslog` or Fedora `/var/log/dnf.log`:  Use one of the commands to allow for paging through one of these commands (hit 'q' to quit the paging command)
1) Change directory to the Documents folder under your **HOME** directory and issue the command to Git clone the textbook source code. Issue the command: `git clone https://github.com/jhajek/Linux-text-book-part-1.git`. (*Hint:* You may have to use your distro package manager to install the `git` tool)
1) Issue the `cd` command to change directory into Linux-text-book-part-1 and then issue the command to display what type of file `./title/metadata.yaml` is.
1) Issue that same command to display what type of file `Appendix-A` is.
1) Using in the book source code, under files > chapter-05 > sample-script: copy the file `sample-command` to your home directory. Use the command to the give the script execute permission `+x`.  Issue the command: `ls -l sample-command` to show the permissions of just the `sample-command` file
1) Move the file `sample-command` to the location `/usr/local/bin` (**Note:** you will need to add the `sudo` command in front to give yourself root privileges to move a file to this location)
1) From the command line (any location) execute the command: `sample-command`, and if succesful you will receive a message of success
1) Execute the `ssh-keygen` command on the command line (from any location) and accept all the default values (just hit enter for now, we will cover RSA in depth later in the text). This command generates two files that are part of an RSA keypair, located in `~/.ssh`
1) `cd` into the directory `~/.ssh` and type the command to show the long listing of the directory.
1) From the textbook sample code > Files > Chapter-05 > sample-scripts > copy the file `date-time-script.sh` to your home directory.  `cd` to your home directory and execute the shell script you just copied (which will print out the current datetime) with the command: `./date-time-script.sh`.  You get an error message stating **permission is denied**: Explain why?
1) Type the command to grant execute permission for `./date-time-script.sh`
1) From the cloned textbook sample code under the directory `files` > `Chapter-05` > `sample-textfiles`, issue the command to display the content of the distro-list.txt to the screen
1) Issue the command using a relative path to copy the file `distro-list.txt` to the `distros` directory you made under the `class-notes` folder
1) Issue the command to show the listing of the `distros` directory and show that the file was copied
1) In the cloned class textbook directory, `Linux-text-book-part-1`, issue the command to delete the `Mobi` directory and its contents, under `output`
1) Issue the command make a copy of the entire directory `Linux-text-book-part-1` and all sub-directories to a directory named `textbook-copy` located in your **HOME** directory.
1) Issue the command to delete the directory `Linux-text-book-part-1` and its sub-directories in one command (recursively).

#### Footnotes

[^46]: [https://www.ibm.com/developerworks/library/l-linux-shells/](https://www.ibm.com/developerworks/library/l-linux-shells/ "History of shells")

[^47]: [http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s02.html](http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s02.html "FHS standard")

[^49]: [http://www.opengroup.org/austin/papers/posix_faq.html](http://www.opengroup.org/austin/papers/posix_faq.html)

[^50]: [https://en.wikipedia.org/wiki/Linux_Standard_Base](https://en.wikipedia.org/wiki/Linux_Standard_Base "LSB")

[^52]: [http://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/](http://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/)

[^53]: [http://lwn.net/Articles/430598/](http://lwn.net/Articles/430598/)

[^54]: [https://archive.fosdem.org/2011/interview/lennart-poettering](https://archive.fosdem.org/2011/interview/lennart-poettering)

[^55]: [https://en.wikipedia.org/wiki/Thompson_shell#cite_note-Mashey1976-10-13-1](https://en.wikipedia.org/wiki/Thompson_shell#cite_note-Mashey1976-10-13-1)

[^56]: [https://en.wikipedia.org/wiki/C_shell#Criticism](https://en.wikipedia.org/wiki/C_shell#Criticism)

[^57]: [https://en.wikipedia.org/wiki/Bourne_shell#Features_introduced_after_1979](https://en.wikipedia.org/wiki/Bourne_shell#Features_introduced_after_1979)

[^58]: [http://www.gnu.org/software/bash/](http://www.gnu.org/software/bash/)

[^59]: [https://lists.debian.org/debian-lsb/2015/07/msg00000.html](https://lists.debian.org/debian-lsb/2015/07/msg00000.html)

[^60]: [https://en.wikipedia.org/wiki/Unix_file_types](https://en.wikipedia.org/wiki/Unix_file_types "Unix File Types")

[^61]: [http://www.linuxfoundation.org/collaborate/workgroups/lsb/fhs-30](http://www.linuxfoundation.org/collaborate/workgroups/lsb/fhs-30 "FHS")

[^62]: [http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s02.html](http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s02.html "FHS Spec")

[^63]: [http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s03.html](http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s03.html)
