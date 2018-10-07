# Writing Basic Shell Scripts
![*Bash Escape*](images/Chapter-Header/Chapter-08/escape_artist-2.png "Bash Escape")

### Objectives

This portion of the book begins Part II. The first 7 chapters focused more on the *philosophy* and basic tenants of how Unix and Linux were created. The remaining 8 chapters now will focus on the application of what we have learned and focus on using the opensource technology of Linux.  The Objectives of this chapter are as follows:

   * Understand how to write and use basic shell scripts
   * Understand how to use conditional statements in Bash scripts
   * Understand how to declare system environment variables and their scope of existence
   * Understand how to use positional parameters as variables into shell scripts
   * Understand how to use the scheduling service ```cron``` for managing shell script automation

### Outcomes

  At the conclusion of this chapter you will have furthered your understanding of the vi editor and be able to demonstrate how to use control structures in shell scripts.  You will also learn about command line variables and how they extend the ability of a shell script to accept dynamic input.  You will be able to schedule a shell script to run at a scheduled time by using ```cron``` service increasing your ability to reduce work by automating repetitive tasks.

## Basic Shell Scripts - Part II

   In the previous chapter we were introduced to the simplest of shell scripts.  In this chapter we are going to increase the depth of our knowledge.

### The Bash Shell

   Just like any programming language we cannot have complex logic if we don't have control structures.  The two basic ones we want to cover are if statements and for loops.  There are the other traditional control structures but are used less commonly because of the nature of a shell script is a single execution not as a repeated process or system service.


   The BASH shell scripting language resembles a traditional programming language.  But it is key to remember that it was not designed to be a complete programming language.  As you push shell scripts to their limits you begin to see the end of what they are capable of.  That is where you see languages like Perl or Python coming in to extend and replace BASH.  (Note if you ever find yourself doing serious arithmetic in BASH something is seriously wrong with your design parameters--check again why you are doing this.) BASH is a tool to help automate the repetition of commands.

### Shell Script Variables

As we learned previously we can define variables in BASH.  These variables are prefixed with a ```$``` when referenced.   In the previous chapter in the ```.bashrc``` file used to modify the system path, we assigned a new value to the ```PATH``` variable like this:
```bash
PATH=$PATH:/home/user/Documents/apps

echo $PATH; echo $path; $PATH=PATH

ut=`uptime`
```

```bash
UT=(`ls -l star[1-3]`)
USA="United States of America"
echo $USA
DIR="monthly-reports-winter-quarter-north-america"
ls $DIR
```

Note that there is no space allowed in variable assignments.  ```PATH=$PATH``` is valid, ```PATH = $PATH``` will be interpreted in a different way by the shell parser.  Variables that are predefined by the system can be found by typing: ```printenv``` and you will see a list of system variables. You can also define your own variables in a shell script--just as you could do on the command line.   Often this is a good idea when you want to assign the output of one command and reuse that value later.  

![*Output of printenv command on Fedora 22*](images/Chapter-08/bash-shell/printenv2.png "printenv")

> __Example Usage:__  Create a shell script with this content below.  Save the file, make it executable, and then execute it.
```bash
#!/bin/bash

# This is a comment - usually by convention variables are in all caps - no spaces, ever!
DT=`date`
# This command outputs the date in a format of our specifications
MDY=`date +%m%d%Y`
echo "****************"
echo "today's date is: $DT"
echo "****************"
echo "Making a folder named MMDDYYYY"
mkdir ~/Documents/$MDY
echo "Finished"
```

In this example we see how the value of $MDY is interpreted first and then passed to the argument attached to the ```mkdir``` command.  Note that the ```mkdir``` command did not have any backticks around it like the command to assign the output of ```date``` to the variable ```DT```.  This is because the Shell sees that ```mkdir``` is a command and begins to interpret the line as such (followed by options and arguments).  If you want to encapsulate the output of one command into a shell variable then you need to enclose them in backticks ```\`\```.

Any variables that are declared have a scope of this scripts execution.  This means that once the script has finished executing any variables are tossed from memory.  If I wanted a variables name and value to life after the completion of my shell script I can always add the __export__ command.  The __export__ command will take the content of this variable and move it from the memory space of the script's execution and move it into the memory space of the launching shell.  This way the variable will live only as long as that terminal session is open--once the window closes those variables disappear from memory because the process that was holding them in a piece of memory is gone too.

> __Example Usage:__  Create a shell script with this content below.  Save the file, make it executable, and then execute it.  Upon completion of that execution, type ```echo $DT``` what value do you see and why?   
```bash
#!/bin/bash

# This is a comment - usually by convention variables are in all caps - no spaces, ever!
DT=`date`
# This command outputs the date in a format of our specifications
MDY=`date +%m%d%Y`
echo "****************"
echo "today's date is: $DT"
echo "****************"
echo "Making a folder named MMDDYYYY"
mkdir ~/Documents/$MDY
export DT
echo "Finished"
```

#### Array Support in Bash

  Arrays are a data-type that can be used to associate data in an ordered collection.  Bash arrays function similarly to arrays in C and Java.  Arrays in Bash are untyped (all text).  There is no support for ArrayLists, maps, queues, or anything of that nature.  Arrays are used simply to store related data. You can declare an array by simple using the ```declare -a NAMEOFYOURARRAY``` syntax.  The ```-a``` makes your variable an array.  As of Bash 4.x bash gained support for the ```mapfile``` variable. The new mapfile builtin makes it possible to load an array with the contents of a text file without using a loop or command substitution.  Note that Mac as of OSX 10.11 release with Bash 3.2 as the standard.

This example below creates a Bash array and stores the redirected output (note the ```< <```) of an ```ls -l /etc``` command storing every line of the listing as an element of an array.

```bash
declare -a instanceARR
mapfile -t instanceARR < <(ls -l /etc)
```

How can we access these variables? We can make use of some meta-characters that have new special meanings here.  First is the *at sign* or ```@``` which allows us to access all of the elements in an array without having to create a loop.  The line below will print out the entire content of the array.  The *pound sign* or some people call it a *hash* or *crunch* indicates that we are looking for the length of the array.  Note the dollar sign before the element to tell the shell interpreter that this is a variables to be rendered.  Also note the the array elements are encapsulated in ```{ }```--curly braces to prevent the ```[ ]``` square braces from being interpreted as shell meta-characters.  As usual elements of an array can be accessed by positional parameters.  ```echo Array[0]; echo Array [1]; echo Array[2]```.  Remember that arrays like in C and Java are __0 indexed__.
```bash
echo ${instanceARR[@]}
LENGTH=${#instanceARR[@]}
echo "ARRAY LENGTH IS $LENGTH"
```

#### Positional Parameters

In the case of the command binary ```ls -l /etc``` the command takes options and arguments.  Shell scripts you create have the same ability to accept and parse input from the commandline.  Note that this is different from ```getopts``` which allows you to make a complicated option and argument passing scheme for shell scripts.  This is for simple variable parameters to be passed into a script: For example:
```bash
./delete-directory.sh ~/Documents/text-book Jeremy
```

The content of the shell script is as follows:
```bash
#!/bin/bash

echo "***************************"
echo "The directory to be deleted is: $1"
rm -rf $1
echo "***************************"
echo "It was deleted by: $2"
echo $2 > ~/Documents/deletion-log.txt
```

Note that each positional parameter that is passed in to the shell script is simply accessed by a number prefixed by a ```$```.  What do you think would be the value of ```$0```?  You can similarly access the number of variables that are passed into the command line by using the built-in variable: For example:
```bash
#!/bin/bash
# posparam.sh

echo "This is \$0: $0"
echo "This is the length of the number of items passed in \$# (not counting \$0): $#"
echo "This is the entire array of items passed in \$@: $@"
echo "This is the first parameter: $1"
echo "This is the fourth parameter: $4"
```

Upon giving the shell script above execution permission and then executing the line below, what will the three lines output?

```bash
posparam.sh domo origato Mr. Roboto
```  

### Control Structures

There are other structures for creating full scale shell scripts that parse user input and create menu like functions.  That is beyond the scope of this book.

### IF Statements

The structure of the Bash __IF__ command is as follows:
```bash
if TEST-COMMANDS; then CONSEQUENT-COMMANDS; fi
```

The __IF__ command starts with a test condition or command.  It is followed by a ```then``` condition which will execute if the test command is *true*. The entire __IF__ command is closed by the letters ```fi```.  Since the scope of BASH is limited compared to a full programming language, __IF__ statements are mostly used to test for conditions or the existence of a condition.  These common __TEST COMMANDS__ are available as built in to BASH in order to accomplish just that. These are called *primaries* and are placed between square braces--space is important [^86].  Remember that spaces matter in writing __IF__ statements.  Unlike C an Java, the Bash interpreter needs those spaces so it can recognize that there is an __IF__ statement otherwise it gets confused thinking the characters are just a string.  Also the ```[]``` needs to have the space otherwise the commandline parser will interpret the square bracket and the number as a shell meta-characters and not delimiters for the test condition.

```bash
#!/bin/bash
# This is a valid IF statement

if [ -r ~/Documents/final-exam-answers.txt ]
then
  cat ~/Documents/final-exam-answers.txt
else
  echo "File is not readable."
fi
```

```bash
#!/bin/bash
# This is NOT a valid IF statement because the spaces are improper

if [-r ~/Documents/final-exam-answers.txt]
then
  cat ~/Documents/final-exam-answers.txt
else
  echo "File is not readable."
fi
```  


: Primary expressions

   Primary	            Meaning
------------------ --------------------------------------------------------------
```[ -a FILE ]```	  True if FILE exists.
```[ -b FILE ]```	  True if FILE exists and is a block-special file.
```[ -c FILE ]```   True if FILE exists and is a character-special file.
```[ -d FILE ]```   True if FILE exists and is a directory.
```[ -e FILE ]```   True if FILE exists.
```[ -f FILE ]```   True if FILE exists and is a regular file.
```[ -g FILE ]```   True if FILE exists and its SGID bit is set.
```[ -h FILE ]```   True if FILE exists and is a symbolic link.
```[ -k FILE ]```   True if FILE exists and its sticky bit is set.
```[ -p FILE ]```	  True if FILE exists and is a named pipe (FIFO).
```[ -r FILE ]```	  True if FILE exists and is readable.
```[ -s FILE ]```	  True if FILE exists and has a size greater than zero.
```[ -t FD ]```	    True if file descriptor FD is open and refers to a terminal.
------------------ --------------------------------------------------------------

: Additional Primary expressions

   Primary	         Meaning
------------------ -----------------------------------------------------------------------
```[ -u FILE ]```	  True if FILE exists and its SUID (set user ID) bit is set.
```[ -w FILE ]```	  True if FILE exists and is writable.
```[ -x FILE ]```	  True if FILE exists and is executable.
```[ -O FILE ]```	  True if FILE exists and is owned by the effective user ID.
```[ -G FILE ]```	  True if FILE exists and is owned by the effective group ID.
```[ -L FILE ]```	  True if FILE exists and is a symbolic link.
```[ -N FILE ]```	  True if FILE exists and has been modified since it was last read.
```[ -S FILE ]```	  True if FILE exists and is a socket.
------------------ -----------------------------------------------------------------------

: Primary expressions

   Primary	                            Meaning
------------------------------ ---------------------------------------------------------------------
```[ FILE1 -nt FILE2 ]```	      Newer than or if FILE1 exists and FILE2 does not.
```[ FILE1 -ot FILE2 ]```	      Older than FILE2, or is FILE2 exists and FILE1 does not.
```[ FILE1 -ef FILE2 ]```       True if FILE1 and FILE2 refer to the same device and inode numbers.
```[ -o OPTIONNAME ]```	        True if shell option "OPTIONNAME" is enabled.
```[ -z STRING ]```	            True of the length if "STRING" is zero.
```[ -n STRING ]```       	    True if the length of "STRING" is non-zero.
```[ STRING1 == STRING2 ]```	  True if the strings are equal.
```[ STRING1 != STRING2 ]``` 	  True if the strings are not equal.
```[ STRING1 < STRING2 ]```	    True if "STRING1" sorts before "STRING2"
```[ STRING1 > STRING2 ]```	    True if "STRING1" sorts after "STRING2"
```[ ARG1 OP ARG2 ]```	        "OP" is one of ```-eq, -ne, -lt, -le, -gt or -ge```.
------------------------------ ---------------------------------------------------------------------

 : Boolean Operators

 Boolean               Value
--------------      -------------------------
 ```&&```             Logical AND
 ```||```             Logical OR
 ```-a```             Primary Expression AND
 ```-o```             Primary Expression OR
--------------      -------------------------

#### IF, ELSE, ELIF

If statements in BASH have support for nested IFs, IF ELSE constructs, and even [CASE](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html "Case Statements") statements.  Here is an example of a nested IF statement using Else IFs from the TLDP project. We will not cover the scope of CASE statements in this book - see the previous link for a good tutorial.  Note at this level of complexity it might be better to try to engineer a CASE statement to re-architect what you are trying to do in to smaller steps to reduce complexity.  Complexity is the enemy of the programmer.  
```bash
#!/bin/bash

if [ -a ~/Documents ]
    then
      echo "The documents directory exists"
    else
     echo "Directory doesn't exist"
fi
```
```bash
#!/bin/bash

if [ -a ~/Documents ]
    then
      echo "The documents directory exists"
    else
     # This will fail silently
     echo "Directory doesn't exist" &> ~/Documents/script.log
fi
```
```bash
#!/bin/bash

if [ $# -gt 5 ]
    then
      echo "You need to type only 5 positional parameters - you entered more!"
else
   echo "Good job you typed in 5 parameters"
fi
```

```bash
#!/bin/bash

if [ -a $1 && -x ]
    then
      echo "File exists and is executable"
else
  echo "File does not exist and/or is not executable"
fi
```   

Here is a complex example of nested IF, ELIFs, and ELSE statements.

```bash
#!/bin/bash

# This script lets you present different menus to Tux.  He will only be happy
# when given a fish.  We've also added a dolphin and (presumably) a camel.

if [ "$menu" == "fish" ]; then
  if [ "$animal" == "penguin" ]; then
    echo "Hmmmmmm fish... Tux happy!"
  elif [ "$animal" == "dolphin" ]; then
    echo "Pweetpeettreetppeterdepweet!"
  else
    echo "*prrrrrrrt*"
  fi
else
  if [ "$animal" == "penguin" ]; then
    echo "Tux don't like that.  Tux wants fish!"
    exit 1
  elif [ "$animal" == "dolphin" ]; then
    echo "Pweepwishpeeterdepweet!"
    exit 2
  else
    echo "Will you read this sign?!"
    exit 3
  fi
fi  
```

#### CASE Statement

  Sometimes called a switch statement in C or Java,  a __case statement__ is really just a way to simplify complicated nested IF statements [^89]. []() statements.  Here is an example of a nested IF statement using Else IFs from the TLDP project. We will not cover the scope of CASE statements in this book but I wanted to make you aware of them.

```bash
case "$1" in
        start)
            start
            ;;

        stop)
            stop
            ;;

        status)
            status anacron
            ;;
        restart)
            stop
            start
            ;;
        condrestart)
            if test "x`pidof anacron`" != x; then
                stop
                start
            fi
            ;;

        *)
            echo $"Usage: $0 {start|stop|restart|condrestart|status}"
            exit 1

esac  
```  

### FOR Loops

  A FOR loop is used to loop incrementally through a list until the end is met.  In Bash the only data structure that you will use loop through are arrays and lists.  Lists are not a datatype like in C and Java but simply a space delimited list of items.  The syntax of a FOR loop is:
```bash
for arg in [LIST];
do
 # code here
done
```

If the ```do``` portion of the for loop is on the same line as the for loop a single ```;``` is needed between them.

```bash
#!/bin/bash
# Listing the planets.

for planet in Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto
do
  echo $planet  # Each planet on a separate line.
done
```

```bash
#!/bin/bash

declare -a planetARRAY
planetARRAY=( mars earth mercury )
LENGTH=${#planetARRAY[@]}
echo "ARRAY LENGTH IS $LENGTH"

for (( i=0; i<${LENGTH}; i++));
do
  echo ${planetARRAY[$i]}
  sleep 1
done
```

This is also a valid 1 line for loop that prints out a single dot to indicate a meter.

```bash
echo -e "\nFinished launching and sleeping 25 seconds"
for i in {0..25}; do echo -ne '.'; sleep 1;done
echo "\n"
```

## Scheduling Shell Scripts With Cron

Now that we have sufficiently complex shell scripts the idea of automating their execution come into play. The concept of the __cron__ command and the __crontab__ files first came into use in Unix System V release ~1983.  Each user can set their own scheduled tasks by editing the __crontab__ file by typing ```crontab -e```.  The contents of the crontab file are initially blank.  The language of the crontab is that of 5 columns and then a command to be executed. Multiple commands can be executed using ```; or &&``` And multiple different times can be listed in the crontab.  The five (and sometimes a sixth fields) are as follows:

Time Unit              Values
-------------  -----------------------
minute           0 - 59
hour             0 - 23
day of month     1 - 31
month            1 - 12
day of week      0 - 6 (0 is Sunday)
-------------  -----------------------

The cron service scans for your combination of jobs and if a pattern matches the current time then that job executes.  For example:
```bash
* 20 * * * /home/jeremy/backup.sh
```

In this case the script above would execute every night of the week at the 20th hour [^87]. The values of cron can be combined to get specific times and dates.  There is also syntax for executing on every 15 minutes.
```bash
*/15 * * * * ~/Documents/script.sh
```

```bash
0,15,30,45 * * * *  ~/Documents/script.sh
```
Something unique like this will start at 3 minutes after and then execute every 10 minutes (13,23,33,43,53 minutes)

```bash
3/10 * * * * ~/Documents/script.sh
```

```bash
@monthly ~/Documents/backup-data-to-off-site.sh
```

Any command that is executed obeys general shell meta-characters and variables as if you were typing that command directly on the command line.  This also allows for redirection of standard out and standard error as well.

Entry                                Description                          Equivalent to
-------------------- ------------------------------------------------- -----------------------
&#64;yearly            Run once a year at midnight of January 1st           ```0 0 1 1 *```
&#64;monthly           Run once a month, midnight 1st day of the month      ```0 0 1 * *```
&#64;weekly            Run once a week at midnight on Sunday morning        ```0 0 * * 0```
&#64;daily             Run once a day at midnight                           ```0 0 * * *```
&#64;hourly            Run once an hour at the beginning of the hour        ```0 * * * *```
&#64;reboot            Run at startup                                        &#64;reboot
-------------------- ------------------------------------------------- -----------------------

### Where to find more

  [O'Reilly media](http://shop.oreilly.com/home.do "O\'Reilly Media") has many old but good books about Bash, vi, and shell scripting.

* Bash [http://shop.oreilly.com/product/9780596009656.do](http://shop.oreilly.com/product/9780596009656.do "Bash Book")
* Bash Cookbook [http://shop.oreilly.com/product/0636920058304.do](http://shop.oreilly.com/product/0636920058304.do "Bash Cookbook")
* vi and vim [http://shop.oreilly.com/product/9780596529833.do](http://shop.oreilly.com/product/9780596529833.do "vi and vim")

## Awk & Sed

### awk & gawk

AWK is a programming language designed for text processing and typically used as a data extraction and reporting tool. It is a standard feature of most Unix-like operating systems[^91]. This original program was released in 1977, and was a powerful and focused lanugage.  We take things like Perl, Python, and even databases such as MySQL and SQLite. The ```awk``` language was designed to do all these things because at the time text based files was the universal datatype.  The initial program was developed by [Alfred Aho](https://en.wikipedia.org/wiki/Alfred_Aho "Alfred Aho"), [Peter Weinberger](https://en.wikipedia.org/wiki/Peter_J._Weinberger "peter J. Weinberger"), and [Brian Kerhnighan](https://en.wikipedia.org/wiki/Brian_Kernighan "Brian Kernighan") at Bell Labs.  

An AWK program consists of a sequence of optional directives, pattern-action statements, and optional function definitions.

```awk
awk pattern { action statements }
```

```awk
awk [options] <'program'> [file1] [file2][...]
```

Lets compare what ```awk``` can do:

* How would you find which ip caused the most HTTP 404 errors? Take these two files in ```files/Chapter-08/logs``` u_ex150721.log u_ex151002.log.
* How would we capture the top 5 offending IPs? What column number is sc-status?
* How could we look for everything that isn't a 404?
* How would you check for Wordpress filesystem hacks by searching for '/' or '..' or /etc or names like passwd .htacess my.cnf?
  + ```awk '$11~/\.\.\//' u_ex150721.log```
* What is the difference between ```cat hosts.deny``` and ```awk '{print;}' hosts.deny```
* How would you print out all lines of a file that contain a \# as the first character?
  + ```awk '$0~/^#/' hosts.deny```
* How would you print out all lines of a file that do not contain a \# as the first character?
  + ```awk '$0!~/^#/' hosts.deny```

The ```awk``` program works very well, but as the standard text based logs migrate to the binary format of ```journalctl``` what happens? The ```journalctl``` command has a --no-pager option to effectively print out all of the journal.  You can use ```awk``` in conjunction.  How would you scan the journal looking for all log entries related to the sshd daemon? How would you do it in grep and cut?  How would you do it in awk?

```bash
sudo journalctl --no-pager | awk '$5 ~ /^sshd/'
```

Lets take a look at this statement:[^90]

*  \$5 tells awk to look at the fifth "column". 
*  \~ tells awk to do a RegularExpression match \/....\/ is a Regular expression. 
* Within the RE is the string Linux and the special character \^.
* \^ causes the RE to match from the start (as opposed to matching anywhere in the line).
* Seen together: Awk will match a regular expression with "Linux" at the start of the first column.

You can find more information at this IBM tutorial: [Awk by example](https://www.ibm.com/developerworks/library/l-awk1/index.html "Awk by example")

### sed

```sed``` is a stream editor.  A stream editor is used to perform basic text transformations on an input stream (a file or input from a pipeline). While in some ways similar to an editor which permits scripted edits (such as 'ed'), 'sed' works by making only one pass over the input(s), and is consequently more efficient.  But it is the ability of ```sed``` to filter text in a pipeline which particularly distinguishes it from other types
of editors.

```sed
sed script inputfile
```

The ```sed``` command uses regular expressesions between the ```\/..\/```[^92]

* \^ Matches the beginning of the line
* \$ Matches the end of the line
* \. Matches any single character
* \* Will match zero or more occurrences of the previous character
* \[ \] Matches all the characters inside the \[ \]

The command to show all lines that do not start with a '\#' below, how would you make the command print all the lines that do start with a '\#'?

```sed -e '/^#/d' hosts.deny | head```

Looking at this command, using the GNU version of ```sed``` they introduced the -i flag that will make your change and re-write it to the same file.  What is happening in the script below?

```bash
sudo sed -i "s/bantime = 600/bantime = 10000/g" /etc/fail2ban/jail.conf
```

For more information see this IBM tutorial: [sed by example](https://www.ibm.com/developerworks/library/l-awk1/index.html "sed by example")

## Chapter Conclusions and Review

Through this chapter we learned about how to extend and improve our ability to write shell scripts.  We learned about system variables and their scope.  We also learned about positional paramteres and how to pass values into a shell script.  We learned about basic Bash control structures IF and FOR, and finally concluded learning about automating shell script launches using the cron service via cron tab.

### Review Questions

1) True or False The Bash shell scripting language has traditional language constructs like C or Java?

2) What meta-character do you use to access the content of a shell variable?
a.  ```$```
b.  ```#```
c.  ```!```
d.  No character - trick questions

3) When assigning the standard output of a command to a variable what characters do you encase the command in?
a. \`\`
b. ```$```
c. ```""```
d. No characters - trick questions

4) True or False - You can include shell meta-charecters inside of two backticks ```\`\```` - example: ```ANS=`ls -l test[1-5]````

5) Which command will list the names of any file that matches these names: file1.txt file2.txt file3.txt file4.txt and send the content of that output to a variable named DIR?
a.  ```DIR='ls -l ./test[1-4].txt'```
b.  ```DIR = \`ls -l ./test[1-4].txt\````
c.  ```$DIR=\`ls -l ./test[1-4].txt\````
d.  ```DIR=\`ls -l ./test[1-4].txt\````

6) Which of these are valid commands in the first line of a shell script?  (Choose any - assume any paths are valid paths to executables)
a. ```#!/bin/bash```
b. ```!#/bin/bash```
c. ```#!/usr/local/bin/bash```
d. ```#/bin/bash```
e. ```#!/bin/ksh```

7) If you stored the output of the command hostname into a variable named sys-hostname, what would be the command to print the content to the screen?
a.  ```echo $HOSTNAME```
b.  ```echo $hostname```
c.  ```echo $SYS-HOSTNAME```
d.  ```echo $sys-hostname```

8) What is the name of the command to print out all the predefined system variables?

9) What is the name of the command that allows you to take stdout of a command and insert the lines of output into an array?
a. arrayfile
b. declare
c. for loop
d. mapfile

10)  Which of these is a valid command to take the output of this find command and assign the contents to an array?  (Assume the array name has already been declared. Choose one)
a. ```mapfile SEARCHARRAY = (find ~ -name mozilla*)```
b. ```mapfile SEARCHARRAY < < (find ~ -name mozilla*)```
c. ```mapfile -t SEARCHARRAY < <(find ~ -name mozilla*)```
d. ```mapfile -t SEARCHARRY < (find ~ -name mozilla*)```

11)  Which below is a valid command to find the LENGTH of an array?
a. ```${#SEARCHARRAY[@]}```
b. ```${SEARCHARRAY[@]}```
c. ```${SEARACHARRAY[#]}```
d. ```${@SEARCHARRAY[#]}```

12)Based on this shell script and positional parameters, what would the command be to print out the first positional parameter after the script name? ```./delete-directory.sh ~/Documents/text-book Jeremy```
a.  ```echo $0```
b.  ```echo $1```
c.  ```echo args[1]```
d.  ```echo {$1}```

13) Based on this shell script and positional parameters, what would the command be to print out the entire content of the positional parameter array? ```./delete-directory.sh ~/Documents/text-book Jeremy```
a.  ```echo $#```
b.  ```echo @!```
c.  ```echo $0```
d.  ```echo $@```

14) Based on this shell script and positional parameters, what would the command be to print out the LENGTH of the positional parameter array? ```./delete-directory.sh ~/Documents/text-book Jeremy```
a.  ```echo $#```
b.  ```echo @!```
c.  ```echo $0```
d.  ```echo $@```

15) In a Bash IF statement, what is the name for the pre-made test conditions?
a. Primaries
b. Secondary expressions
c. Expression
d. Primary expressions

16) All values in a Bash IF statement are of what data type by default?
a. INT
b. STRING
c. NULL
d. CHAR

17) Which of these answers will execute a shell script named ~/backup.sh at 2 am every night of the week?
a. ```* * * * * ~/backup.sh```
b. ```2 * * * * ~/backup.sh```
c. ```* 2 * * * ~/backup.sh```
d. ```* * * 2 * ~/backup.sh```

18) Which of these answers will execute a shell script named ~/clean-directory.sh every 15 minutes?
a. ```3/15 * * * * ~/clean-directory.sh```
b. ```*/15 * * * * ~/clean-directory.sh```
c. ```* 3/15 * * * ~/clean-directory.sh```
d. ```* */15 * * * ~/clean-directory.sh```

19) Which of the crontab builtins would you use to execute a cron job 1 time a year on midnight of January 1st?  The name of the script is ~/give-free-cash-to-students.sh
a. ```* * * * 1 ~/give-free-cash-to-students.sh```
b. ```1 * * * * ~/give-free-cash-to-students.sh```
c. ```1 1 1 1 1 ~/give-free-cash-to-students.sh```
d. &#64;```yearly ~/give-free-cash-to-students.sh```

20) What is the name of the control structure that allows you to incrementally through the contents of an array?
a. IF
b. CASE
c. UNTIL
d. FOR

### Podcast Questions

__Jenkins__

[https://twit.tv/shows/floss-weekly/episodes/443](https://twit.tv/shows/floss-weekly/episodes/443 "jenkins on floss weekly podcast")

Kohsuke Kawaguchi

* ~3:30 What is Jenkins and what does it do?
* ~7:54 What problem are people solving when using Jenkins?
* ~9:25 What are Jenkins plugins and why do they exist? 
* ~10:33 How did Jenkins get started?
* ~13:30 What was happening to Sun in 2004/2005?
* ~14:37 Why did the project name change from Hudson to Jenkins?
* ~20:30 What licesnse does Jenkins use and why?
* ~21:09 What language is Jenkins built on?
* ~22:00 What is Koshuke's company name and who does he compare his company too?
* ~29:25 What is the approximate size of the developer community?
* ~34:55 What has changed in Jenkins since 2011?
* ~40:00 What are some of the benefits of using a opensource softare with alarge comminity of users?
* ~42:30 What does CloudBees provide for Jenkins customers?
* ~45:20 Who has control over the Jenkins project - the Jenkins developer community or CloudBees?

### Lab

__Objectives__

This lab will allow you to create shell scripts.  Use positional parameters, control structures, and write cron jobs.

__Outcomes__

At the completion of this lab you will further your knowledge of shell scripting and enhance your abilities using Bash shell scripts.

__Notes__ 

In the Github repo provided to you please create a folder in your ITMO-556 directory named Chapter-08.  In this directory you will create a file called ReadMe.md and all of the answers, screenshots, and code will be contained in this document.  Submit to Blackboard just your Github URL.

1) What would be the command to create an array in Bash named itemARRAY?

1) Write a shell script that declares an array in Bash named dirarr. Using the mapfile command - redirect the output of the ls -l ~ command into the array previously named and echo out the 3rd and 4th elements of that array.
  
1) Write a for loop to iterate through that array and print every element of the line out on the screen.  (Make sure you detect the length of the array and use a $LENGTH variable as your sentinel condition.
  
1) Write the syntax to make a cronjob execute 5 minutes past every hour everyday to execute the shellscript you previously made to store the content of ls -l ~ into an array named dirarr.
  
1)  From the clones textbook code,  locate the file install-java8.sh located in the **files/Chapter-08/lab** directory.  Modify the script to include IF statements to check for the existance of the path ```/datapool1``` and to print an error message if the path does not exist.
  
1) Modify install-java8.sh again--this time take a positional parameter and put that in place of the directory name ```/datapoo1``` (this will allow you to customize the install location of the shell script).  
  
1) Modify the install-java8.sh from the previous question to count the number of positional parameters and if less than 1 or more than 1 stop execution of the script.
  
1) Create a directory in ```~``` named ```topsecret```.  In that directory create a file named xfile.txt.  Write a shell script to check if that file has executable permission by passing the filename as a positional paramter.  If TRUE print a message.  If FALSE print an error message that the positional parameter name of the file is not executable.
  
1) Write a shell script to check in the ~/topsecret directory to see if a given file name exists.  If TRUE print a message else print an error message with the given file name being passed.
  
1) Write a shell script to check if a given PATH is a file or a directory.  If TRUE print a message, else print an error message using the given file name.
  
1) Write a shell script that take 4 positional parameters.  In the shell script print out $0, $#, and $@ with an explanation of what these variables contain.
  
1) Repeat the previous cron command but this time redirect the standard out and standard error to a file named ~/Documents/my.log
  
1) Using awk and other tools, how would you find which ip caused the most HTTP 404 errors? Take a screenshot of the command and the output.  Use these two files in ```files/Chapter-08/logs```: u_ex150721.log, u_ex151002.log.

1) Using awk and other tools, how would you capture the top 5 offending IPs? Take a screenshot of the command and the output. Use these two files in ```files/Chapter-08/logs```: u_ex150721.log, u_ex151002.log.

1) Using sed, type the command to find the line **bind-address** located in the mariadb database server config file (you might need to install mariadb-server).  The file locations are: Fedora 28 ```/etc/my.cnf.d/mariadb-server.cnf``` and Ubuntu 16 and 18 ```/etc/mysql/mariadb.conf.d/50-server.cnf```.  Comment out the value, change the IP value to 0.0.0.0, and write the change back to the original file.  Take a screenshot of the command.

#### Footnotes

[^86]: [http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html)

[^87]: [https://en.wikipedia.org/wiki/Cron#Examples](https://en.wikipedia.org/wiki/Cron#Examples)

[^88]: [https://en.wikipedia.org/wiki/Cron#Nonstandard_predefined_scheduling_definitions](https://en.wikipedia.org/wiki/Cron#Nonstandard_predefined_scheduling_definitions)

[^89]: [http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html "Case Statements")

[^90]: [https://unix.stackexchange.com/questions/72734/awk-print-line-only-if-the-first-field-start-with-string-as-linux1](https://unix.stackexchange.com/questions/72734/awk-print-line-only-if-the-first-field-start-with-string-as-linux1 "awk and print line only if the first field start with string as Linux1")

[^91]: [https://en.wikipedia.org/wiki/AWK](https://en.wikipedia.org/wiki/AWK "AWK")

[^92]: [https://www.ibm.com/developerworks/library/l-sed1/index.html](https://www.ibm.com/developerworks/library/l-sed1/index.html "sed")
