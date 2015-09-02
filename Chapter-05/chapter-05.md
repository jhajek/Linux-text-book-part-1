# Linux Basic Commands, Filesystem Structure, Permissions
![*You are not authorized*](http://imgs.xkcd.com/comics/authorization.png  "File Permissions")

  The main use and power of an operating system to this day is still the Shell.  The shell is a way for a user to directly interface with the operating system.    We will cover more about specific shells and features in Chapter 8.  

__Chapter 5 Objectives__

  *  Understand the function of the Linux Shell and its relation to the Operating System.
  *  Learn how to read the structure of commands on the commandline
  *  Learn the Linux commandline nomenclature
  *  Understand the Linux Standard Base and what makes a distro a Linux distro
  *  Understand the difference between absolute and relative paths
  *  Know basic tools for moving and modifying the contents of the filesystem.
  *  Understand the nomenclature describing file security
  
__Outcomes__

  At the completion of this chapter you will understand how to use the Linux shell for modifying the contents of the operating system.  You will understand the nature of the filesystem and how to navigate it--understadning the system path.  You will know basic commands for manipulating content in the filesystem.  You will be able to read and change file permissions using the appropraite commandline tools.

*Conventions*

   The terms commandline and shell have discrete different meanings but in this chapter and in the local sense the words are often used interchangably.

## Shell

  Show picture of seashells
  
  (insert diagram about shell OS interaction)

Many may say, *"Hey I have a nice point and click GUI why do I need to use the crusty old commandline?"*  That is a valid question.  In reality the GUI is syntactic sugar on top of the Shell. Anything you click on in a GUI in reality is executing a command in the shell.  In certain cases using the shell may have more avaialble features for your command then in the GUI.  The GUI by definition cannot have more capability than the shell.  

In the shell is where we can enter basic commands for navigation and file manipulation.  Some of the basic commands we will cover are as follows:

*  ```cd - used to change directory```
*  ```ls - used to list the content of a directory```
*  ```cp - used to cp the contents of a file, can also be used to copy and rename a file```
*  ```mv - used to rename a file in place```
*  ```mkdir - used to create or make a new directory``` 
*  ```touch - used to create a new blank file or to update the timestamp of an existing file without opening it```
*  ```cat - technically used to concatenate the contents of two files, but will accept nothing as the second paramter thereby just being used to display the content of a file```
*  ```less - used for paging the contents of a large file, also supports scrolling up as well as down```
*  ```date - used for outputting the current date and time in various customizable formats```
*  ```man - the manual command used to find out how to use the detailed structure of a command```
*  ```pwd - used to print out your present working directory--your location in the filesystem tree.```
*  ```file - used to find out what the content type a file is``` 
*  ```wget - command used to retrieve files from the web via the command line```

## Basic Commands

(show screen shot of ls command with ls ls -la ls -la /etc/  man ls

  There is a common nomenclature of commands in Linux.  There is an executable that is part of the system function located in /bin, files such as ls cd touch are all precompiled binaries located on the system.  To enter a command you type the name of the binary, as you use Linux more and more you will begin to memorize the tool names.  Each command can have options or sometimes called flags and then may or may not accept arguments.
  

### Command nomenclature
  
  ```ls -la /etc```
  
  The first two letters __```ls```__ make up the command for listing the contents of a directory.  The command must be followed by a space. Then next letters are preceeded by a __dash__, to tell the shell interpreter that these letters are options.  Options are usually single letter representations of functionality.  The __```-l```__ options tells the ls command to give a long listing of a directory with details and the __"-a"__ tells the shell to print all files in the directory including hidden files.  Options can be combined in most cases into a single string preceeded bya dash.  So __```-la```__ can also be writted as __```-l -a```__.  Additonally there are options that use full english lanugage structure, which are usually preceeded by __two dashes__ and then a more descriptive english phrase.  Ask the students to find one?
   
  The final value of __/etc__ in the command  ```ls -la /etc``` is an argument passed to the ```ls``` command telling the ls command to list the contents of the ___/etc__ directory.  If this value is left empty the shell assumes you mean the ```pwd``` or your current location/.

### Manual (man) command - your best friend

 __Purpose of manual command__
 
 __history of maunal command

        
### File System structure
   
__What is a Filesystem?__ 
  
   A way for the Opertaing system to access and manage files     
   Upside down tree
   Top of the tree / (root)
  
  Add what each of these locations holds - have the students cd into these directories and do ls and file commands
   
   * /etc
   * /bin
   * /sbin
   * /tmp
   * /var
   * /usr
   * /mnt
   
  This filesystem harkons back to Ken Thompson's original Unix design nearly 40 years ago.  This means that this knowledge is wide spread and well known.  The downside is a sense of tradition and nostalgia ha crept in about this filesystem structure has crept in too.
  Red Hat has taken notice of this and while maintainining backwards compatability have started to move forward with changing the nature of the Linux filesystem.  
  For instance --Red Hat  Explain the sym-linking of /usr/sbin and /usr/bin
     
   optional non-standard 
   /opt from Unix
   /media Ubuntu and Red Hat - an obvious place to put mounted USB, CD-ROm and other added devices
   
### POSIX and Linux Standard Base
   
__POSIX__

Need for POSIX standard and what it does, and almost sacredness of Linux supporting POSIX standards

Quote from Poettering about dropping the fantasy UNIX and breaking POSIX to enhance Linux capabilities.

POSIX was created in XYZA

__Linux Standard Base__

Similar to POSIX but additionally unique to Linux in defining what a distro needs to be officially called a Linux distro.  
LSB was created in XYZA

### How to Read Commands and "Speak Linux"

  In working with many excellent people over the years I have found that there is a common Linux language.  When talking to others, you find that for the most part the standard Linux filesystem has been memorized.  As well as the most common Linux tools through repeated usage.  With this in mind you can "speak" a command without mentionig certain aspects--they are implied.  
  
  For instance ```ls -la /etc```
  You would say "el-es el-a eee tee cee"  Note that I didn't mention any dashes or slases.  Why because the context of ```ls``` command tells me that the next characters are options belonging to the ls command.  I assume that you are giving a absolute path because ```/etc``` is under the root and a standard defined Linux directory.  
  
  Let's take a look at this one.  As you remember the cp command takes two arguments: __source__ and __destination__.  
  cp -iv .bash_profile /tmp
  
  
  How would you read and say this command?
  ps -ef | grep systemd
  
  (the | symbol is called a *"pipe"* the key right above the ```enter``` key on most standard US keyboards.) The pipe will be explained in the next chapter - just know that it is used to redirect the output of one command to input of another command.


## Explanation of PATH

When typing Linux commands one may wonder how the system can tell real commands from non-existant one.  The key to this is the commandline parser.  After you type any text on the commandline the entire command is parsed with spaces being the sperators.  The command line is looking for the names of binaries that are kept in its sysetm path, if a name is found then that binary is executed and passed any option or arguments for that binary to further execute.

SO how does the operating system know where to look?   That is something called the __PATH__. The path is a variable that holds the directories where the oerpating sysetm shoudl look to execute a binary.  What is your path?  Go ahead and open a terminal and on the command line type ```echo $PATH``` (caps are required - this is a system variable convention that will be explained in more details in chapter 06.  What is the output of the command?  Does it look similar to this path on Ubuntu 15.04 or Fedora 22

[Fedora 22]

[Ubuntu 15.04]

[Fedora 21]

[Ubuntu 14.04.3]

Your path may look a bit different depending on what packages are installed or removed and even what version of a Linux distro you are using

Everythinig on a Linux system is a file and can be accessed or addressed in two ways.  __Absolute Path__ and __Relative Path__ 

You learned in the section above about the filesystem tree and bit about pathing works.  The ```ls``` command for instance is located in ```/bin/something``, lets take a look at that path in more detail.

Note that this is an absolute path.  Why?  You see  __/__ as the first charecter, (pronounced *root* but usually referred to as *slash*) this is telling you the pathing scheme to get to the binary executable of __ls__.  Since / is the "root" of the filesytem tree all paths have to start there.  From root the next level we learned are the system directories, in this case bin is below root so the address is __/bin__ then the __ls__ binary is contained in the bin directory so the absolute path to the executable is /bin/ls.

Think of your school or work place address.  If I said I live at [10 W Addison Street Chicago Illinois 60101, United States of America](add wrigly field address) that would be my absolute address and very helpful.
 
So use the echo commmand again and list out your system PATH variable.  cd Into some of those directories and see the contents - get to know the absolute path of some of the system executables.

But what if you already lived in the US and in the city of Chicago?  What if you lived on the same street as me, there would be no need to repeat this all the detailed information.  Perhaps I would just say I live at 10 W addison and you would know how to find my house.  This concept is called a __relative path__  For instance if I cd /etc   and do an ls -la I find many subdirectories.  If I am using Fedora 22 and want to enter the system-config directory so I can edit my network card configuration, I can type ```cd /etc/system-config``` or since my pwd is already ```/etc``` I would simplty type ```cd system-config```.  The reason I can do this is remember in the previous section is that the parser sees just the name ```system-config``` and assumes to look in the current directory first.  What would happen if I typed ```cd system-cnfig``` (notice the typo) What output would you expect to see?  

You would see this:
[screen shot of non-existant directory]  

Let's see how this would look with some other commands.

The most common command you use this with is probably the ```ls``` command 

But other commands can use it to.   Let's type this ```touch /tmp/todo-list```  What does it do?  What command would I use to delete it?  What are two ways I could delete this file.

Retrun to your home directory.

Let's create a text file that has the current date and time in it.  type ```date > timestampfile```  (The ```> ``` is a shell meta character that redirects output from the screen to another file. We will learn more about this in chapter 06.)

Now copy that file to the ```/tmp``` directory - what would be the commands?

Now let us make a new directroy under our home directory (remmber the filesystem is an upsidedown tree so you travel down when creating new folders) What command would we use?  ```mkdir notes```.  Now let us copy the file ```timestampfile``` into the notes directroy.  What command would you use? What would the full command and arguments look like?  How would you change directroy and list the content of the notes directory (hint cd and ls)?

In this chapter's lab you will do work with creating and moving files around from the command line.  

*Important note* - if you do not master the concept of Absolute and Relative path then you will struggle with using Linux beyond all but a simplistic level.  Path is one of the key concepts to how the shell works and must be mastered.  It also is often the number one source of problem or file not found errors.  There are actually 3 main issues that describe 99% of the problems you will encounter on a Linux system.  By going through this mental check list you will at least have done the sruface trouble-shooting.  Also from experience I have learned if you ask a season Linux admin to help with a problem they will ask you to run through these steps anyway.

*NOTE if you get lost in the Linux filesystem tree you can always tpye cd $HOME and you will be taken back to your initial home directroy that you are placed in when the terminal starts.*

## File Permissions and Ownership

  Linux has a simple security model.  There are simply three types of permission that every file has: __read__, __write__, __execute__.  These files give a combination of permissions.  With read you can display the content of a file or copy it, but cannot delete or rename it.  For that you need write permission.  If a file is a shell script or an executable binary it needs the execute permission.  How can you tell what permissions a file has?  Type ```ls -la``` and lets see.  We have seen this output before and now we will explain it. 

The first category is a listing of a files permissions:  See the screenshot below.

Notice that there are 3 groupings of the letters __rwx__ looking like this _rw_r__r__ find a way to escape this.  In addition to inducidualy permissions there are three categories of permission.  These three categories are __owner__,__group__,__other__  Each of these groups has its own read write execute permissions.  

Every file includes an owner and a group.  If you notice the next two columns in the output of ```ls -la``` you will see them listed.  The group name and owner name can be the same, we will talk more about that in Chapter X.

Permissions can be read in a short hand numeric fashion as well.  The read value is worth 4, the write value is worth 2, the execute value is worth 1  so a permission of rw_r__r__ can be read as 644.  The permissions for rwxrwxrwx is 777.  Numberic value for this is rw_______ is 600.
  
### Read, Write, Execute

rwx

### Owner, Group, Other (World)



### Tools 

There are a series of commands that can be used to change or augment the owner, group, or permission of a file.  To execute these commands you will need to have administrator privillege.  User accounts and privilleges will be discussed in more detail in Chapter Y.  But for right now we will use the ```sudo``` command in conjunction with these commands.  The ```sudo``` command allows us to temporarily elevate your user privillege from a user level to an admin level in order to modify the attributes of a file.  Just for experience try to execute one of these commands below without the ```sudo``` command.  You will see a permission denied error (number 2 in the 3P's).

  ```chmod```  allows you to change the permissions or mode of a file.  You can use numeric values to change the permissions all at once.  Or you can use short cuts to assign or remove single permissions.  
  The outputs look like this:
  Insert picture of chmod 755 and chmod +x 
  
  Why would you change permissions?  PErhaps to allow all users of a system a shell script that backsup the content of your home directory.  Or to make sure that only users of a certain group can have write access (therefore delete access) to the content of a file.
  
  ```chown``` 
  Pronounced *"chuh-own"*
  This command allows you to change the owner of a file.  The syntax would be ```sudo chown root todolist```  There is also a feature that allows you to change the group and the owner at the same time.  ```sudo chown root:root todolist``` the value following the semi-colon will be the new group owner.  Try it 
  
  touch todolist
  
  ls -la todolist - who is the owner of the file?  Who is the group owner?
  
  Change it so that the file is owned by root and the group owner is root
  
  ```chgrp```
  Pronounced *"Chuh-gerp"*  
  This is the change group command.  It works just like ```chown``` but instead only changes the group ownership.

### ACLs

IF you have ever worked on Windows OS you will notice that they have much deeper access control and permission system the the basic read, write, execute and owner, group, other permissions.  These are called ACL's (pronounced ack-els) __Access Control Lists__.  They are not native to the Linux world as they were not part of the original Unix standard.  Modern versions of RHEL implement there own layer of Windows like ACLs on top of the regular permissions.  There are a few other permission features that can help simulate ACLs.   __Sticky Bits__ are one of them.  Here is what sticky bits do...



## The 3 P's Describing 95% of all Linux Problems

Find how to do definitions in markdown
  * Path 
   + If you get an error message telling you that ```file not found``` or ```path does not exist```  double check your path.  It the absolute path correct?  Is it a relative path problem?  Are you on the wrong level?
  * Permission
   +  This is discussed below, every file has permission on what is allowed to be done with it based on a simple access control of read write and execute.  Maybe you don't have permission to write and therefore can't delete a file. Perhaps the file is owned by someone else and they didn't give you permission.  Check permissions via ls -la
  * dePendencies
     +  The last thing is are all the correct software dependecies installed.  Perhaps you are missing a library or have an incompatible version that is preventing a tool from running?

## Chapter Conclusions and Review

  In this chapter we discovered the basic nature of the Linux Shell and how it allows users to interact with the Kernel.  We learned basic navigational and file create and delete commands.  We learned about the Linux filesystem and the difference between absolute and relative PATH.  FInally we covered file permissions and the tools used to change or modify them. 

### Review Questions

  * Questions go here

### Podcast Questions

Centos - [http://twit.tv/floss/142](http://twit.tv/floss/142 "CentOS")

Answer said questions:

  * ~2:25 Why did Randal's previous employer have large (1000s) Red Hat systems deployed.
  * ~3:40 What is the short story about how Centos came about?
  * ~4:58 Who is the largest commercial Enterprise Linux?
  * ~7:17 Since Centos appears to be pure piracy - how do the two projects relate to each other?  How do they relate from the RedHat point of view?
  * ~8:10 Who from RedHat is not happy with Centos?
  * ~10:25 How do Centos users differ from RedHat's paying customers?
  * ~19:00. How does the RHEL environment work vs Fedora environment? (RedHat Enterprise Linux)
  * ~22:55 Since Centos is using the RHEL code base how long does Centos lag behind the RHEL codebase when a new release is issued?
  * ~24:24 How does Centos make money?
  * ~29:00 How does Centos pay for everything?
  * ~30:00 Who was Lance Davis and what happened with him?
  * ~35:00 - Kiran mentioned 2 million users for Centos - what did they do right compared to other projects (whitebox linux) that didn't make it?
  * ~44:00 Is Centos for Servers only or can you use it on the Desktop?
  * Personal questions - is what Centos doing legal?  Is it ethical?  Why or why not?

### Lab

 * Lab goes here 
   
   