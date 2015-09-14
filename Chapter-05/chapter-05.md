# Linux Basic Commands, Filesystem Structure, and Permissions
![*You are not authorized*](http://imgs.xkcd.com/comics/authorization.png  "File Permissions")

  The main use and power of a Linux operating system to this day is still the Shell.  The shell is a way for a user to directly interface with the operating system.    We will cover more about specific shells and features in Chapter 8.  

__Chapter 5 Objectives__

  *  Understand the function of the Linux Shell and its relation to the operating system.
  *  Understand how to read the structure of commands on the commandline.
  *  Learn the Linux commandline nomenclature.
  *  Understand the Linux Standard Base and what makes a distro a Linux distro.
  *  Understand the difference between absolute and relative pathing.
  *  Know basic tools for traversing and modifying the contents of the filesystem.
  *  Understand the nomenclature describing file permissions and security
  
__Outcomes__

  At the completion of this chapter you will understand how to use the Linux shell for modifying the contents of the operating system.  You will understand the nature of the filesystem and how to navigate it.  You will be able to demonstrate full awareness of absolute and relative paths and understand the system path.  You will know basic shell commands for manipulating content in the filesystem.  You will be able to read and change file permissions using the appropraite commandline tools.

*Conventions*

   The terms commandline and shell have discrete and different meanings but in this chapter and in the vernacular sense the words are often used interchangably.

## File System Structure
   
__What is a Filesystem?__  A filesystem is a way for the opertaing system to manage and access files.  It is how data is segragated and the mechanism in how you rerieve and write data.  The benefit of a filesytem is you do not need to keep track of the locations in memory of your files, the filesystem will do that for you.  When you double click on a jpg picture in your photo directory, the operating system talks to the filesystem and says, "I want this picture, where is it located?"  The filesystem has an index table and looks up the memory address of the file.  That address is given to the kernel which then passes it to the disk controller for the actual retrieval portion.  The bits are returned to the operating system from the kernel and the image is rendered to the screen.  Specific Linux filesystem and their commands will be covered in chapter 12.  

In Linux the filesyste is designed as an __upside down tree__.  What is at the bottom of a tree?  The root is at the bottom.  In the Linux case the __root__ or also written as __/__ sometimes called *slash*, is at the top of our tree.  Windows operates on a serparate idea of distinct letter drives, C, D, E and that is the root of each drive.  Mac since it is Unix based operates on the same principle as Linux but tries to hide from you by just giving you icons to commonly used places but you can get terminal access to the command line and see this hierarchy too.  The root is located at the top of the file system, you cannot go any higher.  You can only go down from the root.  The root directory contains many folders that vary from Linux distro to Linux distro, but all Linux ditros have to have a common core in order to be called a Linux distro officially.  

![*Ubuntu 15.04 root directory listing*](images/Chapter-05/filesystems/ubuntu-15-04-root-listing.png "Ubuntu 15.04 root directory listing")

![*Fedora 22 root directory listing*](images/Chapter-05/filesystems/fedora-22-root-listing.png "Fedora 22 root directory listing")

Notice that both of the outputs are different even though these are both "stock installs" of two commonly used Linux distros.  Take a look at your own Linux operating system you are using.  Open a terminal and type the command ``` ls /```, what is the output compared to the two images above?  Why is it different?  The answer is complicated.  It goes back to the 40+ years of history of Unix we are carrying with us.  As commercial Unix began to become a reality by 1984, there was a concern, especially from Ricahrd Stallman that his GNU project would get short circuited by UNix vendors changing the Unix implementation as to make GNU software incompatable.  Basically making Unix not Unix.  Stallman spurred on a nacent IEEE standards group to create something called POSIX ( pronounced *pah-zicks*). The Portable Operating System Interface.  "This is a family of standards specified by the IEEE Computer Society for maintaining compatibility between operating systems. POSIX defines the application programming interface (API), along with command line shells and utility interfaces, for software compatibility with variants of Unix and other operating systems." [^49] In this way a Unix vendor could not "run away" with the market and insures a level of interoperatibility between Unix software.  The first official POSIX standard was released in 1988, a few years a head of the creation of Linux (1991).   

### POSIX Standard

The best place I found a short summary of what POSIX is and does was from an answer on Stackoverflow question [http://stackoverflow.com/questions/1780599/i-never-really-understood-what-is-posix](http://stackoverflow.com/questions/1780599/i-never-really-understood-what-is-posix "Attribution") [^48]

__Most important things POSIX 7 defines__

1) [C API](http://pubs.opengroup.org/onlinepubs/9699919799/functions/contents.html "C API")

  * Extends ANSI C with things like: networking, process and thread management, file IO, regular expressions, ...
    + E.g.: write, open, read, ...
  * Those APIs also determine underlying system concepts on which they depend.
  * Many Linux system calls exist to implement a specific POSIX C API function and make Linux compliant, e.g. sys_write, sys_read, ...
  * Major Linux desktop implementation: glibc.

2)  [CLI utilities](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.html "CLI utilities")

  * E.g.: cd, ls, echo, ...
  * Many utilities are direct shell front ends for a corresponding C API function, e.g. mkdir.
  * Major Linux desktop implementation: GNU Coreutils for the small ones, separate GNU projects for the big ones: sed, grep, awk, ... Some CLI utilities are implemented by Bash as built-ins.

3) [Shell language](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18 "Shell language")

  * E.g., ```a=b; echo "$a"```
  * Major Linux desktop implementation: GNU Bash.

4) [Environment variables](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html#tag_08 "Environment Variables")

  * E.g.: HOME, PATH.

5) [Program exit status](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08 "Program Exit Status")

  * ANSI C says 0 or EXIT_SUCCESS for success, EXIT_FAILURE for failure, and leaves the rest implementation defined.
  * POSIX adds:
    + 126: command found but not executable.
    + 127: command not found.
    + 128: terminated by a signal.
  * But POSIX does not seem to specify the 128 + [SINGAL_ID rule used by Bash](http://unix.stackexchange.com/questions/99112/default-exit-code-when-process-is-terminated)

6) [Regular expression](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09 "Regular Expressions")

  * There are two types: BRE (Basic) and ERE (Extended). Basic is deprecated and only kept to not break APIs.
  * Those are implemented by C API functions, and used throughout CLI utilities, e.g. grep accepts BREs by default, and EREs with -E.
    + E.g.: ```echo 'a.1' | grep -E 'a.[[:digit:]]'```

7) [Directory struture](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap10.html#tag_10 "Directory Structure")

  * E.g.: ```/dev/null, /tmp```
  * The [Linux FHS](http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch01.html "FHS" greatly extends POSIX.

8) [Filenames](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_267 "Filenames")
  * ```/``` is the path separator
  * ```NUL``` cannot be used
  * ```.``` is ```cwd```, ```..``` is  ```parent directory```
  * minimum filename length that must be accepted is 14, 256 for full paths
  * portable filenames should only contain: a-zA-Z0-9._-
  * [See also: what is posix compliance for filesystem?](http://stackoverflow.com/questions/18550253/what-is-posix-compliance-for-filesystem)

9) [Command line utility convention](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html "Utility Convention")

  * Not mandatory, used by POSIX, but almost nowhere else, notably not in GNU. But true, it is too restrictive, e.g. single letter flags only.
  * A few widely used conventions:
    + ```-``` means stdin where a file is expected
    + ```--``` terminates flags
  * See also: [Are there standards for Linux command line switches and arguments?](http://stackoverflow.com/questions/8957222/are-there-standards-for-linux-command-line-switches-and-arguments)

Who conforms to POSIX?

Many systems follow POSIX closely, but few are actually certified by the Open Group which maintains the standard. Notable certified ones include:

  * AIX (IBM)
  * HP-UX (HP)
  * Solaris (Oracle)
  * OSX (Apple)
  
Most Linux distros are very compliant, but not certified because they don't want to pay the compliance check.

### Linux Standard Base

  Seeing the iterative issues that Unix went through, in order to encourage adoption the LSB, [Linux Stanadrd Base](https://en.wikipedia.org/wiki/Linux_Standard_Base "LSB"), was formed so that application vendors could certify their product would work accross Linux and that a central Linux identity could be set for all distros to comply with.  The LSB extends POSIX to include items specific to Linux.  The LSB specifies for example: standard libraries, a number of commands and utilities that extend the POSIX standard, the layout of the file system hierarchy, run levels, the printing system, including spoolers such as CUPS and tools like Foomatic and several extensions to the X Window System [^50]. The initial standard body came together and was published in January of 1991. 
  
  Most importantly the LSB sought to create an ABI, [Application Binary Interface](https://en.wikipedia.org/wiki/Application_binary_interface "ABI").  This is different than an API, which just assumes that there will be standard libraries available.  The ABI gives assurance that code compiled using a standard C compiler with the ABI compatability turned on will generate a binary file that will run on all LSB compliant Linux systems.  This is similar to a Windows exe package I create will run on all Windows platforms from XP all the way to 10.  Linux wanted to gaurentee that so that major vendors of software would not have to maintain multiple different versions, but could build 1 version and maintain ABI compatability.
  The Linux Standard Base chose RPM (Red Hat Package Manager)[^51] as way to distribute packages but did not specify how they would be installed, leaving this up to the induvisual distro.  This caused Debian based distros-to create an conversion layer package manager called *Alien* which will convert translate the RPM standard so it can be installed using the native *apt* package manger of Debian based distros.

#### Linux Filesystem Hierarchy

In addition to the API and ABI of the Linux standard base, the most important thing we were given was the LFH, Linux Filesystem Hierarchy.  This is a list of directories that exist under root that are standard across all Linux distros.  These you have to memorize, their name and their function.  All these will be present in any Linux distro you use.  The following directories, or symbolic links to directories, are required in /.  [^47]

Directory           Function
---------- ---------------------------------------------------
bin        Essential command binaries 
boot       Static files of the boot loader 
dev        Device files 
etc        Host-specific system configuration 
lib        Essential shared libraries and kernel modules 
media      Mount point for removable media 
mnt        Mount point for mounting a filesystem temporarily 
opt        Add-on application software packages 
run        Data relevant to running processes 
sbin       Essential system binaries 
srv        Data for services provided by this system 
tmp        Temporary files 
usr        Secondary hierarchy 
var        Variable data 
---------- ---------------------------------------------------

 This filesystem harkons back to Ken Thompson's original Unix design nearly 30+ years ago.  This means that this knowledge is wide spread and well known.  The downside is a sense of tradition and nostalgia ha crept in about this filesystem structure has crept in too. Note that Red Hat based distros have made a move to change this, seeing as it is a very Unix based list and includes many directories that could be combined. Also there is little strict resaoning to where a file or folder should go leaving it up to the system to have to architect a bunch of links to make sure that all programs can find it.  Red Hat maintains this directory hierarchy but symlinks most of them to /usr.  [^52]  It is not just a move just to be different but also a move to unify development.  Making applications built for Unix easier to port over to Red Hat based distros.  There are many companies still using comercial Unix, especially people using SolarisOS looking to get away from Oracle, and this is a way they can transition everything to Linux without having to rewrite all the paths of their binaries.

> Improved compatibility with other Unixes/Linuxes in behavior: After the /usr merge all binaries become available in both /bin and /usr/bin, resp. both /sbin and /usr/sbin (simply because /bin becomes a symlink to /usr/bin, resp. /sbin to /usr/sbin). That means scripts/programs written for other Unixes or other Linuxes and ported to your distribution will no longer need fixing for the file system paths of the binaries called, which is otherwise a major source of frustration. /usr/bin and /bin (resp. /usr/sbin and /sbin) become entirely equivalent. [^52]

  * ```/bin → /usr/bin```
  * ```/sbin → /usr/sbin```
  * ```/lib → /usr/lib```
  * ```/lib64 → /usr/lib64``` 

![*Ubuntu 15.04 root full directory listing*](images/Chapter-05/filesystems/ubuntu-15-04-root-full-listing.png "Ubuntu 15.04 root directory listing")

![*Fedora 22 root full directory listing*](images/Chapter-05/filesystems/fedora-22-root-full-listing.png "Fedora 22 root directory listing")
  
Leonart Poettering has some things to say about POSIX and LSB:  

>  "POSIX is really an encapsulation of some choices that various Unix systems made along the way, rather than a body of text that got standardized and then implemented. According to Poettering, Linux should use its position as "market leader" (in the market of free Unix-like operating systems) and try out some new things. If developers don't force themselves into the constraints of the POSIX API, they could develop some really innovative software, like systemd shows. When these new developments happen to turn out really interesting, other operating systems could eventually adopt them as well." [^53]
    
>  "Not having to care about portability has two big advantages: we can make maximum use of what the modern Linux kernel offers these days without headaches -- Linux is one of the most powerful kernels in existence, but many of its features have not been used by the previous solutions. And secondly, it greatly simplifies our code and makes it shorter: since we never need to abstract OS interfaces the amount of glue code is minimal, and hence what we gain is a smaller chance to create bugs, a smaller chance of confusing the reader of the code (hence better maintainability) and a smaller footprint." [^54]    
    
> "In fact, the way I see things the Linux API has been taking the role of the POSIX API and Linux is the focal point of all Free Software development. Due to that I can only recommend developers to try to hack with only Linux in mind and experience the freedom and the opportunities this offers you. So, get yourself a copy of The Linux Programming Interface, ignore everything it says about POSIX compatibility and hack away your amazing Linux software. It's quite relieving!" [^54]

## The Linux Shell

 ![*Shells*](https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Shell_Island_1985.jpg/282px-Shell_Island_1985.jpg "Sea Shells") 
  
  No not these shells... [^45]
  
### History of the Shell 
  
![*Basic structure of what a shell does*](images/Chapter-05/shells/figure1.png "Shell Diagram") 

![*Shell/OS interaction diagram*](images/Chapter-05/shells/figure2.png "Shell Interaction Diagram")

As always the history of anyhting un Unix/Linux goes back to Ken Thompson[^46].  

## Linux Shell Commands

Many may say, *"Hey I have a nice point and click GUI why do I need to use the crusty old commandline?"*  That is a valid question.  In reality the GUI not separate from the shell.  It is syntactic sugar on top of the Shell. Anything you click on in a GUI in reality is executing a command in the shell anyway.  In most cases using the shell may have more avaialble features for your command then in the GUI.  The GUI by definition cannot have more capability than the shell.  

### Basic Shell Commands 

In the shell is where we can enter basic commands for navigation and manipulation of text files.  Some of the basic commands we will cover are as follows:

-------------------- ------- ------- ------ ------ -------- ------- ----- 
meta-commands          cd      ls     pwd    file    date
file-related           cp      mv     mkdir  touch   wget    rmdir   rm 
file-ownership        chmod   chown   chgrp 
display-related        cat     less   more    tac    head    tail
display-augmentation   grep    awk    sed      
help commands          man    info    find   which  locate
-------------------- ------- ------- ------ ------ -------- ------- ----- 

  In the course of your career you need to memorize at least these commands by name and what they do.  THey have been broken down into 5 helpful categories.  They are essential to the use of any Linux operating system.  

cd

: This command is used to help you change the directory location.  The shell can only be pointed at one file location at a time.  In a GUI you are used to *"clickling"* on folders to navigate up and down the filesystem hierchy.  What you are actually doing when you click is issuing __cd__ commands to the kernel which is returning instructions of what the GUI should now render.  __Usage examples:__ 
```bash 
cd /tmp 
```

ls

: This command is used to list the content of the current directory you are in.  __Usage examples:__ 
```bash
ls /etc 
```

cp 
 
: This command is used to cp the contents of a file, can also be used to copy and rename a file.  __Usage examples:__ 
```bash
cp *.txt /home/user/Documents
```

mv
 
: This command is used to rename or move a file in-place, though the actions are technically the same.  By renaming a file you are essentially moving its contents to a new file in-place. __Usage examples:__ 
```bash
mv ./secret-passwords.txt ./new-secret-passwords.txt
```
 
mkdir 
 
: This command is used to create or make a new directory. __Usage examples:__ 
```bash
mkdir ~/legally-downloaded-music
```
 
touch
 
: This command is used to create a new blank file or to update the timestamp of an existing file without opening it.   __Usage examples:__ 
```bash
touch todolist.txt
``` 
 
cat
 
: This command is used to display the content of a file to the screen.  Technically created to concatenate two files but will accept "nothing" as one input and concatenate nothing plus a filename content and output it to the screen.  There are lengthy articles discussing if this is the [correct method or a superaltive way](http://stackoverflow.com/questions/11710552/useless-use-of-cat "UUoC").  We will use it through out the textbook becausae of readability and common usage acceptance.  __Usage examples:__  
```bash 
cat /etc/apache2/sites-available/000-default
```
 
less
 
: This command is a *hack* on the __more__ command which allows for scrolling the text of a file using the enter key or page down, and space bar or arrow down key for single line scroll.  The __more__ command only went down, niot up.  Hence the more powerful command __less__ which pages and line scrolls up and down a document.  Less is more. __Usage examples:__ 
```bash
less /var/log/apache2/error.log
```
 
date 
 
: This command displays the common date and time format. It has full formatting customization so you can display date and time exactly as you need to.  __Usage examples:__ 
```bash
date '+%m%d%y' 
```
 
file 
 
: This command has been in Unix since at least 1973 records show.  Its use is to help you identify what type of file something is.  It will out put the type of file if it is text, a directory, a binary, or something else.  __Usage examples:__ 
```bash
file self-destruct
``` 

pwd 
 
: This command tells you your __present working directory__ on the Linux filesystem tree.  __Usage examples:__ 
```bash
pwd
```
 
wget 
 
: This command is used to retrieve files over the internet via an HTTP GET request.  If you are using the commandline you cannot "click" on a link but when you click on a link you are sending an HTTP GET request in reality.  This gives you control without having to leave the commandline.  The sample below will you download the markdown files used to build this textbook.  __Usage examples:__  
```bash
wget https://github.com/jhajek/Linux-text-book-part-1/archive/master.zip
```

man
 
: This is the command you use when you can't remember how to use other commands.  just type the word man and then any other command name and you will automatically drop into a __less__ session which will explain the use and history of that command.  This is a very helpful tool as no one can memorize every single command.  From here on out in the class when you ask a question, the instructor's first answer will be, *"Check the man page."* As you progress in your Linux journey the __man__ command will be your best friend--use it wisely young Jedi.  __Usage examples:__ 
```bash
man wget
```

__(show screen shot of ls command with ls ls -la ls -la /etc/  man ls__

  There is a common nomenclature of commands in Linux.  There is an executable that is part of the system function located in /bin, files such as ls cd touch are all precompiled binaries located on the system.  To enter a command you type the name of the binary, as you use Linux more and more you will begin to memorize the tool names.  Each command can have options or sometimes called flags and then may or may not accept arguments.
  
### Command nomenclature
  
```bash
ls -la /etc
```
  
  The first two letters __```ls```__ make up the command for listing the contents of a directory.  The command must be followed by a space. Then next letters are preceeded by a __dash__, to tell the shell interpreter that these letters are options.  Options are usually single letter representations of functionality.  The __```-l```__ options tells the ls command to give a long listing of a directory with details and the __"-a"__ tells the shell to print all files in the directory including hidden files.  Options can be combined in most cases into a single string preceeded bya dash.  So __```-la```__ can also be writted as __```-l -a```__.  Additonally there are options that use full english lanugage structure, which are usually preceeded by __two dashes__ and then a more descriptive english phrase.  Ask the students to find one?
   
  The final value of ```__/etc__``` in the command  ```ls -la /etc``` is an argument passed to the ```ls``` command telling the ls command to list the contents of the ___/etc__ directory.  If this value is left empty the shell assumes you mean the ```pwd``` or your current location/.
        
### How to Read Commands and "Speak Linux"

  In working with many excellent people over the years I have found that there is a common Linux language.  When talking to others, you find that for the most part the standard Linux filesystem has been memorized.  As well as the most common Linux tools through repeated usage.  With this in mind you can "speak" a command without mentionig certain aspects--they are implied.  
  
  For instance: 
  ```bash
  ls -la /etc
  ```
  You would say "*el-es el-a eee tee cee*".  Note that I didn't mention any dashes or slases.  Why? Because the context of ```ls``` command tells me that the next characters listed are options belonging to the ```ls``` command.  I assume that you are giving a absolute path because ```/etc``` is under the root and a standard defined Linux directory.  
  
  Let's take a look at this one.  As you remember the cp command takes two arguments: __source__ and __destination__.  
  ```bash
  cp -iv .bash_profile /tmp
  ```
  
  How would you read and say this command?
  ```bash
  ps -ef | grep systemd
  ```
  
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

Final deliverable is to place all of the above screenshots, 23 total) into a single zip file named: __lastname-firstname-chapter-05-lab.zip__   

#### Footnotes   

[^45]: By Manfred Heyde (Own work) <a href="http://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0</a> or <a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a>, <a href="https://commons.wikimedia.org/wiki/File%3AShell_Island_1985.jpg">via Wikimedia Commons</a>

[^46]: [https://www.ibm.com/developerworks/library/l-linux-shells/](https://www.ibm.com/developerworks/library/l-linux-shells/ "History of shells")

[^47]: [http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s02.html](http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s02.html "FHS standard")

[^48]: The answer was written by StackOverflow user [Siro-Santilli](http://stackoverflow.com/users/895245/ciro-santilli-%e5%85%ad%e5%9b%9b%e4%ba%8b%e4%bb%b6-%e6%b3%95%e8%bd%ae%e5%8a%9f-%e7%ba%b3%e7%b1%b3%e6%af%94%e4%ba%9a-%e5%a8%81%e8%a7%86) 
    The question was asked by StackOverflow user [Claws](http://stackoverflow.com/users/193653/claws)
    and is licensed under CC BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/ ).
    Question URL: http://stackoverflow.com/questions/1780599/i-never-really-understood-what-is-posix

[^49]: [http://www.opengroup.org/austin/papers/posix_faq.html](http://www.opengroup.org/austin/papers/posix_faq.html)

[^50]: [https://en.wikipedia.org/wiki/Linux_Standard_Base](https://en.wikipedia.org/wiki/Linux_Standard_Base "LSB")

[^51]: [http://refspecs.linux-foundation.org/LSB_3.1.0/LSB-Core-generic/LSB-Core-generic/swinstall.html](http://refspecs.linux-foundation.org/LSB_3.1.0/LSB-Core-generic/LSB-Core-generic/swinstall.html)

[^52]: [http://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/](http://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/)

[^53]: [http://lwn.net/Articles/430598/](http://lwn.net/Articles/430598/)

[^54]: [https://archive.fosdem.org/2011/interview/lennart-poettering](https://archive.fosdem.org/2011/interview/lennart-poettering)


