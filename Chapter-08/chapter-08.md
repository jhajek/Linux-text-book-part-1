# Writing Basic Shell Scripts

![*Bash Escape*](images/Chapter-Header/Chapter-08/escape_artist-2.png "Bash Escape")

## Objectives

This portion of the book begins Part II. The first 7 chapters focused more on the *philosophy* and basic tenets of how Unix and Linux were created. The remaining 8 chapters now will focus on the application of what we have learned and focus on using the opensource technology of Linux.  The Objectives of this chapter are as follows:

* Explain how to write and use basic shell scripts
* Explain how to use conditional statements in Bash scripts
* Describe how to declare system environment variables and their scope of existence
* Describe how to use positional parameters as variables into shell scripts
* Explain how to use the scheduling service `cron` for managing shell script automation

## Outcomes

At the conclusion of this chapter you will have furthered your understanding of the vi editor and be able to demonstrate how to use control structures in shell scripts.  You will also learn about command line variables and how they extend the ability of a shell script to accept dynamic input.  You will be able to schedule a shell script to run at a scheduled time by using `cron` service increasing your ability to reduce work by automating repetitive tasks.

## Basic Shell Scripts - Part II

In the previous chapter we were introduced to the simplest of shell scripts.  In this chapter we are going to increase the depth of our knowledge.

### The Bash Shell

Just like any programming language we cannot have complex logic if we don't have control structures.  The two basic ones we want to cover are if statements and for loops.  There are the other traditional control structures but are used less commonly because of the nature of a shell script is a single execution not as a repeated process or system service.

The BASH shell scripting language resembles a traditional programming language. But it is key to remember that it was not designed to be a complete programming language. As you push shell scripts to their limits you begin to see the end of what they are capable of. That is where you see languages like Perl or Python coming in to extend and replace BASH. (Note if you ever find yourself doing serious arithmetic in BASH something is seriously wrong with your design parameters--check again why you are doing this). BASH is a tool to help automate the repetition of commands.

### Shell Script Variables

As we learned previously we can define variables in BASH.  These variables are prefixed with a `$` when referenced.   In the previous chapter in the `.bashrc` file used to modify the system path, we assigned a new value to the `PATH` variable like this:

```bash
PATH=$PATH:/home/user/Documents/apps

echo $PATH; echo $path; $PATH=PATH

UT2=$(uptime)
```

```bash
# This variable assignment command will, why?
UT=$(ls -l file[1-3].txt)
# This variable assignment will succeed
USA="United States of America"
echo $USA
DIR="monthly-reports-winter-quarter-north-america"
ls $DIR
```

Note that there is no space allowed in variable assignments. `PATH=$PATH` is valid, `PATH = $PATH` will be interpreted in a different way by the shell parser.

> __Example Usage:__  Create a shell script with this content below.  Save the file, make it executable, and then execute it.

```bash
#!/usr/bin/bash

# This is a comment - usually by convention variables are in all caps, 
# no spaces, ever!
DT=$(date)
# This command outputs the date in a format of our specifications
MDY=$(date +%m%d%Y)
echo "****************"
echo "today's date is: $DT"
echo "****************"
echo "Making a folder named MMDDYYYY"
mkdir -p /home/joseph/Documents/$MDY
echo "Finished"
```

In this example we see how the value of $MDY is interpreted first and then passed to the argument attached to the `mkdir` command.  Note that the `mkdir` command did not have any backticks around it like the command to assign the output of `date` to the variable `DT`. This is because the Shell sees that `mkdir` is a command and begins to interpret the line followed by options and arguments. If you want to encapsulate the output of one command into a shell variable then you need to enclose them:

```bash
UT2=$(uptime)
```

Any variables that are declared have a scope of this scripts execution. This means that once the script has finished executing any variables are tossed from memory.

#### Array Support in Bash

Arrays are a datatype that can be used to associate data into an ordered collection. Arrays in Bash are untyped (all text). There is no support for ArrayLists, maps, queues, or anything of that nature. Bash arrays are used to store related string data. They came about since Bash version 4.0 (2009).

```bash
# Create a file of names named: names.txt
echo "Joseph" >> names.txt
echo "Evelyn" >> names.txt
echo "Lincoln" >> names.txt

# This will assign the content of each line of names.txt
# to an array named NAMESARRAY
NAMESARRAY=( $(cat names.txt))

echo ${NAMESARRAY[1]}
# this will print out the second element of the array
# which is Lincoln, remember computers and arrays start counting at 0
```

We can make use of some meta-characters that have new special meanings here. First is the *at sign* or `@` which allows us to access all of the elements in an array without having to create a loop. The line below will print out the entire content of the array. The *pound sign* or some people call it a *hash* or *crunch* indicates that we are looking for the length of the array. Note the dollar sign before the element to tell the shell interpreter that this is a variables to be rendered. Also note the array elements are encapsulated in `{ }`--curly braces to prevent the `[ ]` square braces from being interpreted as shell meta-characters.  As usual elements of an array can be accessed by an index. ```echo ${instanceARR[0]}; echo ${instanceARR[1]}; echo ${instanceARR[2]}```. Remember that arrays are __zero indexed__.

```bash
# Using the array from the previous example:
echo ${NAMESARRAY[@]}
LENGTH=${#NAMESARRAY[@]}
echo "ARRAY LENGTH IS $LENGTH"
```

#### Positional Parameters

In the case of the command binary `ls -l /etc` the command takes options and arguments. Shell scripts you create have the same ability to accept and parse input from the commandline. This is for simple variable parameters to be passed into a script. You indicate the position of the parameter passed to the script and reference that value with a `$` and a number.  The first value is `$1`, the second is `$2`, and so on. After `$9` you need to add `{}` around values and should probably add them from the beginning for consistency.

```bash
./delete-directory.sh ~/Documents/text-book Jeremy
```

The content of the shell script is as follows:

```bash
#!/usr/bin/bash

echo "***************************"
echo "The directory to be deleted is: ${1}"
rm -rf ${1}
echo "***************************"
echo "It was deleted by: ${2}"
echo ${2} > /home/joseph/Documents/deletion-log.txt
```

Note that each positional parameter that is passed in to the shell script is simply accessed by a number prefixed by a `$`.  What do you think would be the value of `$0`?  You can similarly access the number of variables that are passed into the command line by using the built-in variable: For example:

```bash
#!/usr/bin/bash
# posparam.sh

echo "This is \$0: ${0}"
echo "This is the length of the number of items passed in \$# (not counting \$0): $#"
echo "This is the entire array of items passed in \$@: $@"
echo "This is the first parameter: ${1}"
echo "This is the fourth parameter: ${4}"
```

Upon giving the shell script above execution permission and then executing the line below, what will the three lines output?

```bash
posparam.sh domo origato Mr. Roboto
```  

#### Positional Parameters Error Checking and Default Values

Positional parameters also have the ability to do built in error checking and default value assignment as well. Let us re-examine a previous sample.

```bash
#!/usr/bin/bash

echo "*********************************************************************"
# If $1 is blank the below syntax acts as an if statement and will exit the 
# program at that line. The ? is the if statement 
echo "The directory to be deleted is: ${1?Error: no file name given!!!}"
rm -rf ${1}
# The -Jeremy is the default value if none is given
echo "It was deleted by: ${2-Jeremy}"
echo ${2} > /home/joseph/Documents/deletion-log.txt
echo "*********************************************************************"
```

Positional parameters can also be redirected into a shell script with the `<` operator. Using this command: `listnames.sh $(< roster.txt)` we can take items listed on each line in a text file and they will become positional parameters automatically via the `<` redirection arrow. Let us take a look at how this works. In the `files > Chapter-08 > examples > listnames.sh` you will see the sample roster.txt and the listnames.sh which will read the names from each line and assign the content to a positional paramter. Note what happens if you run the command `./listnames.sh` without redirecting any arguments from roster.txt

```bash
# This is listnames.sh
# Assume the contents of roster.txt are as follows:
# joseph
# lincoln
# evelyn

echo "The first name is: ${1-No first name given}"
echo "The second name is: ${2-No second name given}"
echo "The third name is: ${3-No third name given}"
echo "The fourth name is: ${4-No fourth name given}"

```

### Control Structures

There are other structures for creating full scale shell scripts that parse user input and create menu like functions. That is beyond the scope of this book.

### IF Statements

The structure of the Bash __IF__ command is as follows:

```bash
if TEST-COMMANDS; then CONSEQUENT-COMMANDS; fi
```

The __IF__ command starts with a test condition or command. It is followed by a `then` condition which will execute if the test command is *true*. The entire __IF__ command is closed by the letters `fi`. Since the scope of BASH is limited compared to a full programming language, __IF__ statements are mostly used to test for conditions or the existence of a condition. These common __TEST COMMANDS__ are available as built in to BASH in order to accomplish just that. These are called *primaries* and are placed between square braces--space is important[^86]. Remember that spaces matter in writing __IF__ statements. Unlike C an Java, the Bash interpreter needs those spaces so it can recognize that there is an __IF__ statement otherwise it gets confused thinking the characters are just a string. Also the `[]` needs to have the space otherwise the commandline parser will interpret the square bracket and the number as a shell meta-characters and not delimiters for the test condition.

```bash
#!/usr/bin/bash
# This is a valid IF statement

if [ -r ~/Documents/final-exam-answers.txt ]
  then
    cat ~/Documents/final-exam-answers.txt
  else
    echo "File is not readable."
fi
```

```bash
#!/usr/bin/bash
# This is NOT a valid IF statement because the spaces are improper

if [-r ~/Documents/final-exam-answers.txt]
then
  cat ~/Documents/final-exam-answers.txt
else
  echo "File is not readable."
fi
```  

: Primary expressions

   Primary              Meaning
------------------ --------------------------------------------------------------
```[ -a FILE ]```   True if FILE exists.
```[ -b FILE ]```   True if FILE exists and is a block-special file.
```[ -c FILE ]```   True if FILE exists and is a character-special file.
```[ -d FILE ]```   True if FILE exists and is a directory.
```[ -e FILE ]```   True if FILE exists.
```[ -f FILE ]```   True if FILE exists and is a regular file.
```[ -g FILE ]```   True if FILE exists and its SGID bit is set.
```[ -h FILE ]```   True if FILE exists and is a symbolic link.
```[ -k FILE ]```   True if FILE exists and its sticky bit is set.
```[ -p FILE ]```   True if FILE exists and is a named pipe (FIFO).
```[ -r FILE ]```   True if FILE exists and is readable.
```[ -s FILE ]```   True if FILE exists and has a size greater than zero.
```[ -t FD ]```     True if file descriptor FD is open and refers to a terminal.
------------------ --------------------------------------------------------------

: Additional Primary expressions

   Primary          Meaning
------------------ -----------------------------------------------------------------------
```[ -u FILE ]```   True if FILE exists and its SUID (set user ID) bit is set.
```[ -w FILE ]```   True if FILE exists and is writable.
```[ -x FILE ]```   True if FILE exists and is executable.
```[ -O FILE ]```   True if FILE exists and is owned by the effective user ID.
```[ -G FILE ]```   True if FILE exists and is owned by the effective group ID.
```[ -L FILE ]```   True if FILE exists and is a symbolic link.
```[ -N FILE ]```   True if FILE exists and has been modified since it was last read.
```[ -S FILE ]```   True if FILE exists and is a socket.
------------------ -----------------------------------------------------------------------

: Primary expressions

   Primary                              Meaning
------------------------------ ---------------------------------------------------------------------
```[ FILE1 -nt FILE2 ]```       Newer than or if FILE1 exists and FILE2 does not.
```[ FILE1 -ot FILE2 ]```       Older than FILE2, or is FILE2 exists and FILE1 does not.
```[ FILE1 -ef FILE2 ]```       True if FILE1 and FILE2 refer to the same device and inode numbers.
```[ -o OPTIONNAME ]```         True if shell option "OPTIONNAME" is enabled.
```[ -z STRING ]```             True of the length if "STRING" is zero.
```[ -n STRING ]```             True if the length of "STRING" is non-zero.
```[ STRING1 == STRING2 ]```    True if the strings are equal.
```[ STRING1 != STRING2 ]```    True if the strings are not equal.
```[ STRING1 < STRING2 ]```     True if "STRING1" sorts before "STRING2"
```[ STRING1 > STRING2 ]```     True if "STRING1" sorts after "STRING2"
```[ ARG1 OP ARG2 ]```          "OP" is one of ```-eq, -ne, -lt, -le, -gt or -ge```.
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
#!/usr/bin/bash

if [ -a ~/Documents ]
    then
      echo "The documents directory exists"
    else
     echo "Directory doesn't exist"
fi
```

```bash
#!/usr/bin/bash
# You might want a script to exit if a certain condition doesn't exist
# You can do that with an exit command

if [ -a ~/documents ]
    then
      echo "The documents directory exists"
    else
     echo "Directory doesn't exist, exiting program!"
     exit 1
fi
```

```bash
#!/usr/bin/bash

if [ -a ~/Documents ]
    then
      echo "The documents directory exists"
    else
     # This will silently log the error to a file
     echo "Directory doesn't exist" &> ~/script.log
fi
```

```bash
#!/usr/bin/bash
# Checking the number of parameters and exiting is positional parameter quantity is wrong

if [ $# -lt 1 ]
    then
      echo "You need to type 1 positional parameter - you have not entered the correct amount."
      exit 1
    else
      echo "Good job you typed in 1 parameter"
fi
```

```bash
#!/usr/bin/bash
# Complex decision logic using AND with positional parameters

if [ -a $1 ] && [ -x $1 ]
    then
      echo "File exists and is executable"
else
  echo "File does not exist and/or is not executable"
fi
```

Here is a complex example of nested IF, ELIFs, and ELSE statements.

```bash
#!/usr/bin/bash

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

Sometimes called a switch statement in C or Java, a __case statement__ is really just a way to simplify complicated nested IF statements[^89]. \[\]\(\) statements.  Here is an example of a nested IF statement using Else IFs from the TLDP project. We will not cover the scope of CASE statements in this book but I wanted to make you aware of them.

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

#### While Loops

This while loop will read each line of a text file allow you to operate on each value read. The file, roster.txt is located in the files > Chapter-08 > lab.

```bash
#!/usr/bin/bash
# Assume the names.txt file exists from previous examples

while read LINE
  do echo $LINE; mkdir -v /tmp/$LINE
done < names.txt
```

#### FOR Loops

A FOR loop is used to loop incrementally through a list until the end is met. In Bash the only data structure that you will use loop through are arrays and lists. Lists are not a datatype like in C and Java but simply a space delimited list of items. The syntax of a FOR loop is:

```bash
for i in {1..10};
  do
   # for each loop over elements 1-10
   echo "Your number is: $i"
done
```

If the `do` portion of the for loop is on the same line as the for loop a single `;` is needed between them.

```bash
#!/usr/bin/bash

# Assuming the existence of the names.txt file
# from the previous Bash Array example

for NAME in ${NAMESARRAY[@]};
do
  echo "The names in the file: $NAME"
done
```

```bash
#!/usr/bin/bash
# Or you can list elements out manually

for planet in Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto
do
  echo $planet  # Each planet on a separate line.
done
```

```bash
#!/usr/bin/bash
# This is a traditional C based for loop

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

```bash
#!/usr/bin/bash
# This is a valid 1 line for loop that prints out a single dot indicator

echo -e "\nFinished launching and sleeping 25 seconds"
for i in {0..25}; do echo -ne '.'; sleep 1;done
echo "\n"
```

## Scheduling Shell Scripts With Cron

Now that we have sufficiently complex shell scripts the idea of automating their execution come into play. The concept of the __cron__ command and the __crontab__ files first came into use in Unix System V release ~1983.  Each user can set their own scheduled tasks by editing the __crontab__ file by typing ```crontab -e```.  The contents of the crontab file are initially blank.  The language of the crontab is that of 5 columns and then a command to be executed. Multiple commands can be executed using ```; or &&``` And multiple different times can be listed in the crontab. The five (and sometimes a sixth fields) are as follows:

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

In this case the script above would execute every night of the week at the 20th hour[^87]. The values of cron can be combined to get specific times and dates.  There is also syntax for executing on every 15 minutes.

```bash
*/15 * * * * /home/controller/script.sh
```

```bash
0,15,30,45 * * * *  /home/controller/backup-script.sh
```

This script will run at 3 am on every Sunday

```bash
* 3 * * 0 /home/controller/script.sh
```

```bash
@monthly /home/controller/backup-data-to-off-site.sh
```

Any command that is executed obeys general shell meta-characters and variables as if you were typing that command directly on the command line. This also allows for redirection of standard out and standard error as well.

Some cron implementations support the following non-standard macros[^88]:

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

* [O'Reilly media](http://shop.oreilly.com/home.do "O\'Reilly Media") has many old but good books about Bash, vi, and shell scripting.
  * Bash [http://shop.oreilly.com/product/9780596009656.do](http://shop.oreilly.com/product/9780596009656.do "Bash Book")
  * Bash Cookbook [http://shop.oreilly.com/product/0636920058304.do](http://shop.oreilly.com/product/0636920058304.do "Bash Cookbook")
  * vi and vim [http://shop.oreilly.com/product/9780596529833.do](http://shop.oreilly.com/product/9780596529833.do "vi and vim")

## Text Processing with Awk and Sed

### AWK

AWK is a programming language designed for text processing and typically used as a data extraction and reporting tool. It is a standard feature of most Unix-like operating systems[^91]. This original program was released in 1977, and was a powerful and focused language. We take things like Perl, Python, and even databases such as MySQL and SQLite. The ```awk``` language was designed to do all these things because at the time text based files was the universal datatype. The initial program was developed by [Alfred Aho](https://en.wikipedia.org/wiki/Alfred_Aho "Alfred Aho"), [Peter Weinberger](https://en.wikipedia.org/wiki/Peter_J._Weinberger "Peter J. Weinberger"), and [Brian Kerhnighan](https://en.wikipedia.org/wiki/Brian_Kernighan "Brian Kernighan") at Bell Labs.  

An AWK program consists of a sequence of optional directives, pattern-action statements, and optional function definitions.

```awk
awk pattern { action statements }
```

```awk
awk [options] <'program'> [file1] [file2][...]
```

Lets see what `awk`[^90] can do:

* How would you check for WordPress filesystem hacks by searching for '/' or '..' or /etc or names like passwd .htacess my.cnf?
  * ```awk '$11~/\.\.\//' u_ex150721.log```
* What is the difference between ```cat hosts.deny``` and ```awk '{print;}' hosts.deny```
* How would you print out the last column of a file?
  * ```awk '$NF' <insert_file_name>```
* How would you print out the last 3 columns of a file?
  * ```awk '{print $(NF-2), $(NF-1), $NF}' <insert_file_name>```
* How would you print out all lines of a file that contain a \# as the first character?
  * ```awk '$0~/^#/' hosts.deny```
* How would you print out all lines of a file that do not contain a \# as the first character?
  * ```awk '$0!~/^#/' hosts.deny```

You can find more information at this IBM tutorial: [AWK by example](https://www.ibm.com/developerworks/library/l-awk1/index.html "AWK by example"). The GNU version of AWK is called [gawk](http://www.gnu.org/software/gawk/ "GNU webpage for gawk") and it performs the same commands and options but is licensed under GPLv3+ as AWK was part of the proprietary UNIX tools and license. Linux systems symlink `awk` command to `gawk`.  

### sed

```sed``` is a stream editor.  A stream editor is used to perform basic text transformations on an input stream (a file or input from a pipeline). While in some ways similar to an editor which permits scripted edits (such as 'ed'), 'sed' works by making only one pass over the input(s), and is consequently more efficient.  But it is the ability of ```sed``` to filter text in a pipeline which particularly distinguishes it from other types
of editors.

```sed
sed script inputfile
```

The `sed` command uses regular expressions between the `/../`[^92]

* `^` Matches the beginning of the line
* \$ Matches the end of the line
* \. Matches any single character
* \* Will match zero or more occurrences of the previous character
* The \[ \] Matches all the characters inside the \[ \]

The command to show all lines that do not start with a '\#' below, how would you make the command print all the lines that do start with a '\#'?

`sed -e '/^#/d' hosts.deny | head`

#### sed infile find and replace using -i

Looking at this command, using the GNU version of ```sed``` they introduced the -i flag that will make your change and re-write it to the same file.  What is happening in the script below?

```bash
sudo sed -i "s/bantime      = 1h/bantime      = 10h/g" /etc/fail2ban/jail.conf
sudo sed -i "s/joseph/Joseph/g" names.txt
sudo sed -i "s/database_name_here/wp-database/g" /var/www/html/wordpress
```

The template is that `s` will search a file, the first value in between the `/  /` is the find portion, and the value in the second `/  /` is the replace value. The final `/g` means do it globally across the entire file named.

For more information see this IBM tutorial: [sed by example](https://www.ibm.com/developerworks/library/l-sed1/index.html "sed by example")

## Chapter Conclusions and Review

Through this chapter we learned about how to extend and improve our ability to write shell scripts. We learned about system variables and their scope. We also learned about positional parameters and how to pass values into a shell script. We learned about basic Bash control structures IF and FOR, and finally concluded learning about automating shell script launches using the cron service via cron tab.

### Review Questions

1.  T/F The Bash shell scripting language has traditional language constructs like C or Java.
1.  What meta-character do you use to access the content of a shell variable?
    a.  `$`
    b.  `#`
    c.  `!`
    d.  No character - trick question
1.  When assigning the standard output of a command to a variable which of these are valid methods?
    a.  DT=``` `date` ```
    b.  `DT=$(date)`
    c.  `DT="date"`
    d.  Not possible, trick question
1.  What is the name of the program used for manipulating streams of text inside of a file (used for find and replace)?
    a.  awk
    b.  grep
    c.  egrep
    d.  sed
1.  What would be the correct syntax to find and replace the value 127.0.0.1 with 0.0.0.0 in a the file `50-server.cnf`?
    a.  `sudo sed "s/0.0.0.0/127.0.0.1/g" 50-server.cnf`
    b.  `sudo sed -s "s/0.0.0.0/127.0.0.1/g" 50-server.cnf`
    c.  `sudo sed -i "s/127.0.0.1/0.0.0.0/g" 50-server.cnf`
    d.  `sudo sed -r "s/0.0.0.0/127.0.0.1/g" 50-server.cnf`
1.  Which of these are valid commands in the first line of a shell script?  (Choose any - assume any paths are valid paths to executables.
    a.  `#!/usr/bin/bash`
    b.  `!#/usr/bin/bash`
    c.  `#!/usr/local/usr/bin/bash`
    d.  `#!/bin/bash`
    e.  `#!/bin/sh`
1.  If you stored the output of the command `hostname` into a variable named SYSTEMNAME, what would be the command to print the content to the screen?
    a.   `echo $SYSTEMNAME`
    b.   `echo $systemname`
    c.   `echo SYSTEMNAME`
    d.   `echo systemname`
1.  What is the proper syntax to end an `IF` statement -- what is the very last line?
    a.  `}`
    b.  done
    c.  fi
    d.  exit
1.  What is the correct primary syntax for an `IF` statement, to check if a file exists?
    a.  `if [-e filename]`
    b.   `if [ -e filename ]`
    c.  `if (-e filename)`
    d.  `if [ true filename ]`
1.  Which of these is a valid command to redirect the standard out of a `cat` command to standard in of a shell variable?
    a.  `NAMES = (cat roster.txt)`
    b.   `NAMES << (cat roster.txt)`
    c.  `NAMES=$(cat roster.txt)`
    d.  `NAMES < (cat roster.txt)`
1.  Which is a valid command to find the LENGTH of an array?
    a.  `${#SEARCHARRAY[@]}`
    b.   `${SEARCHARRAY[@]}`
    c.  `${SEARACHARRAY[#]}`
    d.  `${@SEARCHARRAY[#]}`
1.  Based on this shell script and positional parameters, what would the command be to print out the first positional parameter after the command: `./delete-directory.sh ~/Documents/text-book Jeremy`
    a.   `echo $0`
    b.    `echo $1`
    c.   `echo args[1]`
    d.   `echo {$1}`
1.  Based on this shell script and positional parameters, what would the command be to print out the entire content of the positional parameter array? `./delete-directory.sh ~/Documents/text-book Jeremy`
    a.   `echo $#`
    b.    `echo @!`
    c.   `echo $0`
    d.   `echo $@`
1.  Based on this shell script and positional parameters, what would the command be to print out the LENGTH of the positional parameter array? `./delete-directory.sh ~/Documents/text-book Jeremy`
    a.   `echo $#`
    b.    `echo @!`
    c.   `echo $0`
    d.   `echo $@`
1.  In a Bash IF statement, what is the name for the pre-made test conditions?
    a.  Primaries
    b.  Secondary expressions
    c.  Expression
    d.  Primary expressions
1.  All values in a Bash IF statement are of what data type by default?
    a.  INT
    b.  STRING
    c.  NULL
    d.  CHAR
1.  Which of these answers will execute a shell script named /opt/backup.sh at 2 am every day?
    a.  `* * * * * /opt/backup.sh`
    b.  `2 * * * * /opt/backup.sh`
    c.  `* 2 * * * /opt/backup.sh`
    d.  `* * * 2 * /opt/backup.sh`
1.  Which of these answers will execute a shell script named /opt/clean-directory.sh every 15 minutes?
    a.  `3/15 * * * * /opt/clean-directory.sh`
    b.  `*/15 * * * * /opt/clean-directory.sh`
    c.  `* 3/15 * * * /opt/clean-directory.sh`
    d.  `* */15 * * * /opt/clean-directory.sh`
1.  Which of the crontab builtins would you use to execute a cron job 1 time a year on midnight of January 1st? The name of the script is /home/controller/homework-is-finished.sh
    a. `* * * * 1 /home/controller/homework-is-finished.sh`
    b. `1 * * * * /home/controller/homework-is-finished.sh`
    c. `1 1 1 1 1 /home/controller/homework-is-finished.sh`
    d. &#64;`yearly /home/controller/homework-is-finished.sh`
1.  What is the name of the control structure that allows you to incrementally through the contents of an array?
    a.  IF
    b.  CASE
    c.  UNTIL
    d.  FOR
1.  What is the name of the control structure that allows you to loop through a list until there are no more elements?
    a.  IF
    b.  WHILE
    c.  UNTIL
    d.  FOR
1.  What would be the `sed` command to replace the value bantime = 1h with bantime = 10h in the file `/etc/fail2ban/jail.conf`?
    a.  `sudo sed "s/bantime = 1h/bantime = 10h/g" /etc/fail2ban/jail.conf`
    b.  `sudo sed -i "s/bantime = 10h/bantime = 1h/g" /etc/fail2ban/jail.conf`
    c.  `sudo grep -r "bantime = 1h" /etc/fail2ban/jail.conf`
    d.  `sudo sed -i "s/bantime = 1h/bantime = 10h/g" /etc/fail2ban/jail.conf`
1.  What would be the `sed` command to replace the value joseph with Joseph in the file `names.txt`?
    a.  `sudo sed -i "s/joseph/Joseph/g" names.txt`
    b.  `sudo sed -r "s/joseph/Joseph/g" names.txt`
    c.  `sudo sed -n "s/joseph/Joseph/g" names.txt`
    d.  `sudo sed -q "s/joseph/Joseph/g" names.txt`
1.  What would be the `sed` command to replace the value `database_name_here` with `ap-database` in the file `/var/www/html/wordpress/wp-config.php`?
    a.  `sudo sed -i "s/database_name_here/wp-database/g" /var/www/html/wordpress/wp-config.php`
    b.  `sudo sed -i "s/wp-database/database_name_here/g" /var/www/html/wordpress/wp-config.php`
    c.  `sudo sed "s/database_name_here/wp-database/g" /var/www/html/wordpress/wp-config.php`
    d.  `sudo sed -i "s/database_name_here/wp-database/g" /var/www/html/wordpress/`

### Podcast Questions

Watch this short video and answer these three questions relating to the shell script written in the video: [How to write a bash script](https://www.youtube.com/watch?v=F-gskSl4pwQ "youtube video fo how to write a bash script")

* What did Maria write as the first line of Shell script and why did she write it that way?
* In the video, Maria types `NAME=${1?Error: no name given}` in her shell script. Briefly explain what this line means and what happens when `$1` has a value and when $1 doesn't have a value.
* In the video, Maria types `NAME2=${2:-friend}` in her shell script. Briefly explain what this line means and what happens if $2 has a value and when $2 doesn't have a value.

### Lab

#### Lab Objectives

* Explore creating shell scripts
* Explore the use of positional parameters in shell scripts
* Describe the fundamental use of control structures in shell scripts
* Explore task automation using `cron` for shell scripts

#### Lab Outcomes

At the completion of this lab you will further your knowledge of shell scripting and enhance your abilities using Bash shell scripts. Sample code and text files are available in the textbook GitHub repo under `files > Chapter-08 > lab`. You will be writing shell scripts and your deliverable will be the shell scripts that satisfy each files requirements. Copy `names.txt` and `roster.txt` so that they are in the same directories as your shell scripts -- assume path `./`

#### Part 1

1) Create a shell script in your `HOME directory > Documents`, named: `delete-chapter-05.sh` which will delete the output of Chapter-05 lab if present, otherwise print a message saying that "Chapter 05 lab content is not present"

1) Create a shell script in your `HOME directory > Documents` using the deliverables from the Chapter-05 lab. Take all of the commands from Chapter-05 Part-1 and combine them into a single shell script named: `chapter-05-lab.sh` and execute them

1) Create a shell script in your `HOME directory > Documents` using IF statements and primary expressions to *grade* your `chapter-05-lab.sh` script by checking for the precense of the proper directories and files being created and printing out log messages. Name the file: `grade-chapter-05-lab.sh`

#### Part 2

1) Create a shell script that will take 3 positional parameters, append each parameter to a file named roster.txt (each of the parameters will be a name), named `l8ex1.sh`

1) Create a shell script to cat the content of the roster.txt file into an array named: ROSTERARRAY and echo the 2nd element of the array, named `l8ex2.sh`

1) Create a shell script that redirects the content of roster.txt into an array, uses a forloop to cycle through the array's contents, and then uses the command to make a directory for each name listed in the array in your home directory, echo a message telling the user the path of the directory just created. Final command of the script is to list the content of the home directory to show the success of the script, named `l8ex3.sh`

1) Modify the shell script from the previous question to include an `if` statement that checks for the existence of a directory. If the directory exists, echo a message: "Directory $NAME exists". Then add an else clause that if the directory does not exist, create it and echo a message that the new directory and its path have been created, named `l8ex4.sh`

1) Write a WHILE loop that will read the content of the file names.txt, (located in the files > Chapter-08 > lab folder) and create a directory based on the value on the line in the `/tmp` directory (one per users). Include an if statement to detect if the directory already exists, if it does exist, write the duplicate name out to a text file named: `duplicates.txt` located in the `/tmp` directory, named `l8ex5.sh`

1) Create a directory in ```~``` named ```topsecret```.  In that directory create a file named `xfile.txt`.  Write a shell script to check if that file has executable permission by passing the filename as a positional parameter.  If TRUE print a message.  If FALSE print an error message that the positional parameter name of the file is not executable, named `l8ex6.sh`
  
1) Write a shell script to check in the `~/topsecret` directory to see if a given file name exists (passed in by positional parameters).  If TRUE print a message else print an error message with the given file name being passed, named `l8ex7.sh`
    
1) Using `awk` and other tools, how would you find which ip caused the most HTTP 404 errors? Take a screenshot of the command and the output.  Use these two files in ```files/Chapter-08/logs```: u_ex150721.log, u_ex151002.log, named `l8ex8.sh`

1) Using `awk` and other tools, how would you capture the top 5 offending IPs? Use these two files in ```files/Chapter-08/logs```: u_ex150721.log, u_ex151002.log, write a shell script named `l8ex9.sh`

1) Using `sed`, write a shell script to find the line **bind-address** located in the mariadb database server config file (you might need to install mariadb-server). The file locations are: Fedora ```/etc/my.cnf.d/mariadb-server.cnf``` and Ubuntu ```/etc/mysql/mariadb.conf.d/50-server.cnf```. Comment out the value, change the IP value to 0.0.0.0, and write the change back to the original file, named `l8ex10.sh`

#### Part 3

The goal of this shell script is to add IF statement logic to prevent errors in our code in case of duplicates in relation to account creations on a server. Create the shell script in your in your `HOME directory > Documents` and name it `l8ex12.sh`.

* Write a shell script using a while script to read in the content of roster.txt into a variable named $LINE
  * For each user check for the existence of a home directory
  * If the directory doesn't exists, use the this command to create a user account on your system
    * `sudo useradd -c "Account for $NAME" -s /usr/bin/bash -d /home/$NAME -m $NAME`
    * Write a log message telling us which account was created, redirecting output for standard error and standard out and with a timestamp
      * Name the log `l8ex11.log`
    * Add an `echo` to the screen telling which account has just been created
    * else skip the account creation 
  * Run the command to create a directory named `.ssh` owned by the user `$NAME` in their home directory
    * Use -O to check for file existence and ownership
  * Run the command to create an ssh key using an IF statement checking for the existence of the keys in the .ssh directory
      * `sudo ssh-keygen -t ed25519 -f /home/$NAME/.ssh/id_ed25519_$NAME -N ""`
      * Take note of the home directory and use the `chown` command to change the ownership of the keys in the .ssh directory to the user just created
      * Write a log message telling us that keys were created for a user, redirecting output for standard error and standard out and with a time stamp
        * Append to the log `l8ex11.log`
      * Add an `echo` to the screen telling which keys have just been created

#### Footnotes

[^86]: [http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html)

[^87]: [https://en.wikipedia.org/wiki/Cron#Examples](https://en.wikipedia.org/wiki/Cron#Examples)

[^88]: [https://en.wikipedia.org/wiki/Cron#Nonstandard_predefined_scheduling_definitions](https://en.wikipedia.org/wiki/Cron#Nonstandard_predefined_scheduling_definitions)

[^89]: [http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html "Case Statements")

[^90]: [https://unix.stackexchange.com/questions/72734/awk-print-line-only-if-the-first-field-start-with-string-as-linux1](https://unix.stackexchange.com/questions/72734/awk-print-line-only-if-the-first-field-start-with-string-as-linux1 "awk and print line only if the first field start with string as Linux1")

[^91]: [https://en.wikipedia.org/wiki/AWK](https://en.wikipedia.org/wiki/AWK "AWK")

[^92]: [https://www.ibm.com/developerworks/library/l-sed1/index.html](https://www.ibm.com/developerworks/library/l-sed1/index.html "sed")
