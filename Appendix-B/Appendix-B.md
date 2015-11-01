# Appendix B
![*Git commit messages--after developing this book I understand this completely*](images/Chapter-Header/Appendix-B/git_commit-2.png "Git Commit")

This section contains the answers to the chapter review questions

## Chapter 01

NA

## Chapter 02

TBA

## Chapter 03

Hardware and Linux Installation
Chapter 03

1. What is the term for the industry standard file format that is used to install a Linux distro?
a. ISO

2. What is currently the most common Linux install media type?
c. USB

3. What is the name of the most common tool used to create bootable Linux install media?
c. UNetbootin

4. What is the technology that is inserted between ring 1 and ring 0 that enables virtualization?
A: hypervisor

5. The operating system that the hypervisor resides on is called the _________ system?
A: host

6. Hosted or desktop virtualization is called what type of hypervisor?
A: Type II

7. Bare Metal or Native Virtualization is called what type of hypervisor?
A: Type I

8. Each Linux installation distro provides a mechanism to compare what you downloaded with what you expected to download, what is that called?
b. check sum

9. What is the name of the driver package you can install in VirtualBox in order to enable features such as shared clipboard, larger screen resolution, and mouse pointer integration?
d. VirtualBox Guest Additions 

10. What is the name for a Linux installation that runs in memory?
b. Live ISO 


## Chapter 04
Linux Desktop and GUI 
Chapter 04 review questions

1.	 What was the original and most popular Unix “Smart Terminal?” 
b.	VT-100
2.	What is the three letter abbreviation still in use today in modern Linux to refer to “terminal 
devices?”
b.	TTY
3.	Why is the GNOME terminal and Windows cmd.exe terminal emulator screens 80 by 25 by 
default?
c.	The developers of these technologies were seeking to emulate the popular VT-100 and 
VT-0220 terminals they used prior.
4.	What is the key combo sequence you can hit to switch to a new virtual terminal in Linux?
b.	Alt + Ctrl + F1 - F7
5.	What is the name of the original Unix based GUI that came out of MIT in ~1984?
b.	X
6.	True or False – X was originally not opensourced by MIT in 1984
a.	False
7.	What is the official name in the Ubuntu Unity desktop environment for the launcher icon? (The 
Icon in the upper left hand corner that looks like circle with 3 dots?.
a.	Dash Icon
8.	What is the name of the successor GUI compositor to X being created by the X.org foundation?
c.	Wayland Project
9.	What is the name of Ubuntu’s own GUI compositor replacement for X? (Just the name.
a.	Mir
10.	There are 5 types of Linux window managers: Compositing, Minimalistic, Tiling, and Other.  
What is the name of the missing category?
a.	Stacking
11.	There are 4 major Linux desktop environments in use today: which grouping is correct?
d.	KDE, GNOME, Xfce, LXDE
12.	What is the name of the windowing toolkit that KDE uses? (Two letters.
a.	Qt
13.	What is the name of the windowing toolkit that GNOME uses? (just 3 letters, no plus sign.
a.	GTK+
14.	What is the name of the founder of the GNOME project? 
a.	Miguel de Icaza
15.	When the GNOME 3 desktop environment was released in early 2012, many people were 
unhappy that many changes were made.  There were 3 major projects started to either preserve 
GNOME 2 or to modify GNOME 3 significantly – what are the names of those projects?
c.	Unity, Mate, Cinnamon
16.	When released in 2006, what was the main development goal of the LXDE desktop environment?
c.	Energy saving and extremely fast
17.	Which of these statements are true in regards to Linux desktop environments? (choose all that 
apply.
a.	Desktop environments have a File Manager
b.	Desktop Environments have start or action buttons and task and notification bars
c.	Desktop environments have a changeable but consistent look-and-feel
d.	Desktop environments have system configuration tools and user applications built in
18.	What is the default desktop environment for Fedora 22? (Name and versions.
a.	GNOME 3
19.	What is the name of the button on the upper left hand corner of the GNOME 3 desktop in 
Fedora 22 that you use to “launch applications?”
a.	Activities
20.	What is the name of the default Ubuntu desktop environment?
a.	Unity

## Chapter 05

The Linux Filesystem, Path, Shell, and File Permissions
Chapter 05 review questions

1.	 What is the numeric value of a file with the permissions rwxr--r--?
d.	744
2.	What is the numeric value of a file with the permissions rw-----?
c.	600
3.	What is the numeric value of a file with the permission rwx-r-xr-x?
b.	755
4.	What is the name of the command you use to list the contents of a directory?
d.	ls
5.	What is the name of the command you use to display the content of a file to the screen?
d.	cat
6.	What is the name of the command you use to display the content of a file to the screen that 
allows you to page up and down?
b.	less
7.	Every shell command has three components:
b.	Command, options, arguments
8.	What does the user use to issue commands to the kernel?
d.	Shell
9.	What is the name of the GNU shell that is standard across all Linux Distros
d.	bash
10.	Based on the ls command, what is the option to do a long listing?
d.	ls –l
11.	What is the command you can use to find out additional usage information about a shell 
command?
b.	man
12.	Which of these directories is not part of the LSB LFH?
c.	temp
13.	The Linux Filesystem is an upside down what?
c.	tree
14.	What is the name of the top of the Linux Filesystem?
a.	/
15.	Everything (directories, files, devices. in Unix/Linux is a what?
a.	file 
16.	What is the name of the Unix system standard developed in ~1985 that defines at a minimum 
what a certified Unix based system must support?
c.	POSIX
17.	What is the directory where all configuration files are stored in Linux?
c.	etc
18.	What is the directory where all system binaries are stored?
a.	bin
19.	What is the directory that holds all of the user’s home directories? (no slash, just the name.
a.	home
20.	True or False - Leonart Poettering supports POSIX
a.	False
	
## Chapter 06

Shell Meta-Characters, Pipes, Search, and Tools
Chapter 06 review questions

1.  What is the name for characters that have special meanings in the Linux shell?
d. shell meta-characters

2. Assume your pwd is ~. If you wanted to list every directory only that started with the letters "Do" what would be the command?
d. ls -l Do*

3. In figure 95 in Chapter 06 which of the 3 blue boxes is the step where shell meta-characters are transformed into text?
d. Expansion

4. Which meta-character allows you to string commands together regardless of the successful execution of the previous command?
b. \;

5. Which meta-character allows you to string commands together but will exit if one of the commands fails?
a. &&

6. Which meta-character is the wildcard (0 or more matches.?
d. \*

7. Which meta-character is the single character wildcard?
a. \?

8. Square braces [] indicate sets or ______ of characters to be processed
d. ranges

9. If you wanted to use brace expansion and create a series of nine files named: file1, file2, file3, etc etc all at once--what command would you use?  (type the full command using touch .
a. touch file{1..9}

10. If you wanted to assign the value of /etc/alternatives/java to a shell variable named JAVA_HOME--what would be the proper syntax?
c. JAVA_HOME=/etc/alternatives/java

11. What would be the proper syntax to display the content of a variable named JAVA_HOME in the shell?
d. echo $JAVA_HOME

12. There are 3 standard I/O devices in a Linux system, standard in, standard out, and ________
d. standard error

13. Standard In is what device by default?
d. keyboard

14. Standard Out is what device be default?
b.  screen

15. What meta-character can you use to redirect standard out to a file? (Choose all that apply.
a. \>
b. \>\>

16. What meta-character is used to redirect the standard output of one command as the standard input of another command?
d. | 

17. Which command is a shortcut to display the kernel's output messages?
d. dmesg

18. Which command is used to search within files using textual filter patterns?
d. grep

19. When you combine a tar (tape archive. and an additional compression method--what is the name for the resulting file?
d. tarball

20. What is the name of the GNU compression tool project released in 1992?
d. gzip

## Chapter 07

Introduction to Linux Editors, Introduction to Shell Scripts, and User Profiles 

Chapter 07 review questions

1.  What are the two main representatives of stream editors  
d. vi and Emacs

2. Which family of editors came first?
d. Stream Editors

3. Emacs at it's core is what?
c. An interpreter for Emacs Lisp

4. Who created the vi editor?
c. Bill Joy

5. Which of the following sequences of the history of vi is correct? 
b. ed -> em -> ex -> vi -> vim

6.  What are the three modes in vi?  (separate each answer via a comma)
a.  command, insert, ex

7.  What is the key you use in vi to transition between COMMAND MODE and INSERT mode? (Just three letters)
a. ESC

8.  What command sequence (key) in vi will add text to the right of the current cursor position?  (just the letter)
a. a

9.  What command sequence (key) in vi will move you to the beginning of the next word? (just the letter)
a. w

10. What command sequence in vi will delete a single line based on the current cursor position? (just the letters)
a. dd

11. What command sequence in vi will delete 10 lines from the current cursor position? (just the numbers and letters)
a. 10dd

12. Which command in ex mode (vi) will save the current file you are working on and exit the vi editor? (include the :)
a. :wq

13.  In the log file u_ex150911_.log what would be the ex command to search forward for occurrences of xmlrpc.php? (include the forward slash) 
a. /xmlrpc.php

14.  Assuming your pwd is Linux-text-book-part-I and you have loaded Chapter-02.chapter-02.md into vi, what would be the ex mode command to replace all occurrences of linux with Linux?
a. s/linux/Linux/g

15.  Assuming your pwd is Linux-text-book-part-I and you have loaded Chapter-02.chapter-02.md into vi, what would be the ex mode command to replace all occurrences of Linux with GNU/Linux? (remember to escape the /)
a. s/Linux/GNU\/Linux/g

16.  Assuming the your pwd is Linux-text-book-part-I and you have loaded Chapter-02.chapter-02.md into vi, what would be the ex mode command to remove all occurrences of the word Windows?
a. s/Windows//g

17. Assuming a file name topsecret.sh has a permission of 644 - what is the shortcut to give the owner of the file permission to execute the script?
a. chmod u+x topsecret.sh

18. Assuming a file named moretopsecret.sh has a permission of 757 - w2hat is the shortcut to remove all permissions from the other (everyone else) group (0)? 
a. chmod go-rwx moretopsecret.sh

19. What is the correct sequence of profile inheritance?
a. /etc/profile -> ~/.bash_profile or ~/.bash_login or ~/.profile -> ~/.bashrc

20.  What is the command to display the contents of the PATH system variable on the command line?
b. echo $PATH

## Chapter 08

1) True or False The Bash shell scripting language has traditional language constructs like C or Java?
True

2) What meta-character do you use to access the content of a shell variable?
a.  ```$```

3) When assigning the standard output of a command to a variable what characters do you encase the command in?
a. \`\`

4) True or False - You can include shell meta-charecters inside of two backticks ```\`\```` - example: ```ANS=`ls -l test[1-5]````
True

5) Which command will list the names of any file that matches these names: file1.txt file2.txt file3.txt file4.txt and send the content of that output to a variable named DIR?
d.  ```DIR=\`ls -l ./test[1-4].txt\````

6) Which of these are valid commands in the first line of a shell script?  (Choose any - assume any paths are valid paths to executables) 
a. ```#!/bin/bash```
c. ```#!/usr/local/bin/bash```
e. ```#!/bin/ksh```

7) If you stored the output of the command hostname into a variable named sys-hostname, what would be the command to print the content to the screen?
d.  ```echo $sys-hostname```

8) What is the name of the command to print out all the predefined system variables?

9) What is the name of the command that allows you to take stdout of a command and insert the lines of output into an array?
d. mapfile

10)  Which of these is a valid command to take the output of this find command and assign the contents to an array?  (Assume the array name has already been declared. Choose one) 
c. ```mapfile -t SEARCHARRAY < <(find ~ -name mozilla*)```

11)  Which below is a valid command to find the LENGTH of an array?
a. ```${#SEARCHARRAY[@]}```

12)Based on this shell script and positional parameters, what would the command be to print out the first positional parameter after the script name? ```./delete-directory.sh ~/Documents/text-book Jeremy``` 
b.  ```echo $1```

13) Based on this shell script and positional parameters, what would the command be to print out the entire content of the positional parameter array? ```./delete-directory.sh ~/Documents/text-book Jeremy```
d.  ```echo $@```

14) Based on this shell script and positional parameters, what would the command be to print out the LENGTH of the positional parameter array? ```./delete-directory.sh ~/Documents/text-book Jeremy```
a.  ```echo $#```

15) In a Bash IF statement, what is the name for the pre-made test conditions?
d. Primary expressions

16) All values in a Bash IF statement are of what data type by default?
b. STRING

17) Which of these answers will execute a shell script named ~/backup.sh at 2 am every night of the week?
b. ```2 * * * * ~/backup.sh```

18) Which of these answers will execute a shell script named ~/clean-directory.sh every 15 minutes?
b. ```*/15 * * * * ~/clean-directory.sh```


19) Which of the crontab builtins would you use to execute a cron job 1 time a year on midnight of January 1st?  The name of the script is ~/give-free-cash-to-students.sh
d. &#64;```yearly ~/give-free-cash-to-students.sh```

20) What is the name of the control structure that allows you to incrementally through the contents of an array? 
d. FOR

## Chapter 09

TBA

## Chapter 10

TBA

## Chapter 11

TBA

## Chapter 12

TBA

## Chapter 13

TBA

## Chapter 14

TBA

## Chapter 15

TBA

