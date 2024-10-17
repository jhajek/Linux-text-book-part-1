# Shell Meta-Characters, Pipes, Search and Tools

![*The beauty of Unix Commands*](images/Chapter-Header/Chapter-06/tar-2.png "tar")

## Objectives

In this chapter we will be continuing our exploration of the commandline.  We will be expanding our experience of the original paradigm that Thompson and Ritchie envisioned when designing Unix.

* Describe how shell meta-characters and how they enhance the shell capabilities
* Explain the concept of standard in, standard out, and standard error
* Explain the concept of input/output redirection and piping
* Describe how to search the file system for files and directories
* Explain how to use the `grep` command for detailed search and replace options using shell meta-characters

## Outcomes

At the conclusion of this chapter you will have a definite understand of the Linux shell and its utilities.  You will know the nature of shell meta-characters and how they can enhance the capabilities of shell commands.  You will be able to use the concepts of standard input, standard output, and standard error to redirect output as you need it.  You will understand the meta-characters used for input redirection and the concept of "|" called piping - that enables single commands to send their standard output as standard input to another command.   We will explore the ```find``` and ```locate``` commands that are used to find and filter files on the system.   We will use the ```grep``` tool for find and replace options and advanced parsing of file content beyond what ```find``` and ```locate``` can do.   Finally we will use compression tools and for creating archives and for extracting them.

## Shell Meta-Characters

In the last chapter we learned about the Linux shell and it's purpose to help the user interact with the kernel.  We learned that the GUI is just a *syntactic sugar* layer sitting on top of the shell.  We also learned a series of essential commands in order to create and manipulate the contents of our file system.  The next layer within the shell to be introduced is something called __shell meta-characters__.

When Ken Thompson was creating Unix and the first user shell, he quickly realized a need to be able to perform certain repetitive tasks.  For example, the concept of using wildcards to do pattern matching. Or to use negation or ranges to look for particular filenames or directories. One of the advantages of making everything in Unix a file is that a file only has one data type, and that is of type __text__. Since everything is text, any file or directory can be searched for or filtered based on text patterns. Enter shell meta-characters which extend the normal capabilities of the shell. 

If you wanted to list the contents of any directory starting with the letters *"Do"*, how would you do it? By adding a wildcard to an `ls` command like this: `ls -l Do*`. This command reads a directory's content and feeds it any filenames that match the first two characters *"Do"* and any number of other characters, (including 0 characters), represented by the star or asterisk (\*). Shell meta-characters replace having to write a C program to recreate this same functionality. There are 18 characters that are standard across the bash shell[^64]--common punctuation/non alphanumeric characters that were adopted to represent these common repetitive text modification tasks done in the shell.

![*User -> Shell -> Kernel -> Shell -> User*](images/Chapter-06/shells/figure2.png "User -> Shell -> Kernel -> Shell -> User")

In the above diagram, the box labeled *Expansion*, is where the shell *expands* any meta-characters into text that can be interpreted by the shell. The following is a list of the major shell meta-characters you need to know.  More information and examples can be found at the [Linux Documentation Project's](http://tldp.org/LDP/abs/html/special-chars.html "TLDP") website.

\&\&

: The double ampersand character (shift+7) command allows you to execute two or more commands together in sequence.  Note the && requires each successive command to return successfully or else the entire string will stop at the command that failed. __Usage example:__
```bash
unzip -d book master.zip && cd book && cat Readme.md
```

\;    

: Unlike the ampersand character the semi-colon __";"__ allows you to chain commands together that will execute in sequence regardless of the previous commands return status. The example command will execute and return two errors telling you the file or directory doesn't exist, but the third command will execute showing the data. __Usage example:__
```bash
ls /topsecret; cd /topsecret; date
```

\|

:  This character is called the "pipe" because it looks like a vertical bar or a piece of a pipe.  It serves the function of connecting the output of one command to the input of another command--not unlike a pipe under your sink.  The character is typed by pressing the shift+the key located directly above the enter key.  In this example here we display the content of the chapter-05.md and *pipe* it to the grep command which filters the file showing us only the lines containing the term *permission*. __Usage example:__
```bash
cat Chapter-05/chapter-05.md | grep permission
```

\*

:  The asterisk (shift+8) is the wildcard representative.  It can be used in any shell command when you want to let the computer to the work or when you are not quite sure of a files spelling. __Usage example:__
```bash
ls *.md
```
```bash
cat Linux-*.pdf
```
```bash
rm -rf ./*
```

\?

: The character question mark is a single character wildcard. Multiple question marks can be combined but are single wildcards. ```???.txt``` will list all files with three characters and the .txt extension.  __Usage example:__
```bash
ls memo?
```
```bash
ls vegetable-?-report.txt
```
```bash
ls ???.txt
```

```'```

: single tic or single quote.  Any characters or variables surrounded by a single tic will be interpreted literally.  Unlike the previous example this command will only print the literal characters $DT not expand the variable's contents.  The first item below will not work, why? You will see a >> on the next line which is a continuation.  The shell interpreter is confused and matches the first two \'\' but the second is not closed.
See the next example below.
  __Usage example:__
```bash
echo 'Today's date is $DT'
echo 'Today the date is: $DT'
```

\"

: double tic or double quote. Any characters or variables surrounded by double tics will interpret shell variables that inside of the string before passing the contents to a command. This command will print the content of the date command from the previous example along with some text to the screen. You can include single and double tics in a single command but make sure they are matched.  __Usage example:__
```bash
echo "Today's date is $DT"
```

```[]```

: Square brackets indicate sets or ranges of characters to be processed.  In a sense it is a mini-for loop for processing files names.  We can present multiple character sets or if we use a ```-``` we can present a numeric or alphabetic range of values to be passed to a shell command. __Usage example:__
```bash
ls file[24]
```
```bash
rm file[1-4]
```
```bash
ls file[!a-z]
```

\(\)

: Parenthesis are used to start a sub-shell.  The parent shell doesn't have memory access to this sub-shell. We will cover this more in detail in the next chapter. __Usage example:__
```bash
(a=hello; echo $a)
```

\< \> \>\>

: Angle brackets or less than greater than - allow for input and output to be redirected.  Think of them as arrows pointing. Single arrow is destructive meaning if the filename exists the previous contents will be destroyed and the file recreated.  Double arrow is an append operation and will append the content to the end of the filename given as an argument. The arrows can be combined with the ```&``` to help suppress output and that will be described in the next section in detail.  Note how the normal output to the screen is being redirected to these files by the arrow operators. __Usage example:__
```bash
date > /tmp/todaysdate.txt
date >> /tmp/todaysdate.txt
```
```bash
echo "Buy milks and eggs!" >> ~/Documents/my-shopping-list.txt
```

\{\}

: Curly braces are expansion braces for declaring variables with variables in them. Note the difference. The first command example allows you to use brace expansion to create multiple directories at once chapter-01-09.  __Usage example:__

```bash
mkdir chapter-0{1..9}
rm dir chapter-0{1..9}
```

\#

: Pound sign or hash is used to comment out the lines in a shell script. We will cover this in detail in the next chapter.

\^

: The caret (shift+6) is a meta-character used in conjunction with the `[]` range brackets in order to tell the shell to negate the range included in the square brackets. `ls [^r]*` will find `file1, file2, file3, and file4`, but will not list the files named `rfile1-rfile4`. __Usage example:__
```bash
ls [^r]*
```
```bash
ls [^b-d]
```

\!

: Exclamation or pronounced as *bang*.  This is used to negate a test condition.  This will be covered more in the next chapter when we cover shell scripts.

\~

: The tilde (shift+the key to the left of the number 1) is a shortcut representing your user's home directory.  ```~-``` is a combination that references the previous directory you were in. __Usage example:__
```bash
cd ~
```
```bash
cd ~/Documents
```
```bash
cd ~-
```

\<tab>

: Tab key is used for autocomplete on the commandline.  This is a feature of bash, not present in `sh`, `csh`, and `ksh`.

\\

: By placing a ```\``` in front of any character, the shell will *escape* that characters function.  This is helpful if you want to print out the text of commands without having the shell execute them.
```bash
echo "Assign date command output to a variable type: DT=`date`; echo \$DT"
echo "This is a variation of the above command: DT2=$(date); echo \$DT2"
```

\$

:  The dollar sign (shift+4) is used to reference shell variables.  You can declare a local variable by assigning a value with the equal sign-just like you can in C or Java.  But in this case space matters (no spaces) and you only use the ```$``` sign the reference that variable.  There are a number of preset system environment variables that the os sets for you and you can make your own as well. The command ```printenv``` will display all of the system environment variables.  By convention shell variables are usually declared all capital letters.  Note that shell variables only "live" for the time that the terminal window in which they were declared is open.  

```bash
echo $PATH
```

```bash
# Both commands are the same, but the $() is preferred
DT=`date`; echo $DT
DT=$(date); echo $DT
```

```bash
JAVA_HOME="/usr/bin/java"; echo $JAVA_HOME
```

There is a final meta-character called the backtick or formally the grave accent. The backtick key is to left of number 1.  The backtick is used for encasing Linux binary command names.  The backtick tells the system to interpret the command and execute it and return its value to the user for further processing. In the 2 prior examples we stored the content of the date command to a shell variable named DT. __Usage example:__

```bash
DT=`date`
# second method to execute the above
DT2=$(date)
```

```bash
CONTENTS=`cat /etc/services`
```

## Standard input, output, and error

The original concept behind defining standard input and output devices came from the idea that Unix grew over the course of 40 years of output and input technology.  Originally there were no keyboards--just teletypes.  Originally there were no screens just ttys to print out on paper.  Then came *glass ttys* and terminals.  Then came Line and Dot Matrix printers.  Standard keyboards via the ISA input bus were invented.  At one time on a busy shared system (remember the central server development paradigm for Unix) a sysadmin would perhaps want to send output of a command or any errors so that they could be debugged to paper.  Not environmentally friendly but sometimes just seeing it in writing solves your issue. Every *device* has a file handle and you can see all the *standards* are located by listing the ```/dev``` directory.      

![*Standard I/O, ls -l /dev/std\**](images/Chapter-06/standard/standard.png "Standard I/O")

![*Trail of standard location*](images/Chapter-06/standard/standard-out-location.png "Standard Out Location")

### Standard In

The __standard in__ is the default method of getting text input into the terminal.  Currently this happens to be the keyboard.  The __standard in__ from the keyboard can be overridden by using the reversed angle bracket `<` to read __standard in__ from a file. You can send the content of any file to a command with input redirection only if it accepts input from __standard in__ to begin with. Why might you want to send __standard in__ from anywhere other then the keyboard?  Here are a couple of examples.

```bash
wc < state-of-the-union-address.txt
```

```bash
./display-env.sh $(< arguments.txt)
```

### Standard Out

When Unix was developed the design decision was made that all devices were files.  In short, the screen, or teletype, or terminal, is nothing more than a file that is located in the `/dev` directory. By having a __standard out__ device this allowed Unix/Linux to exchange standard output devices and not have to modify the output structure of the operating system.  Notice too that the outputs are referred to as `tty` which we learned about in chapter 4.  When you execute a command, the output is returned by default to __standard out__ which in this case is the terminal screen.  You can use the `> and >>` out redirectors to send the standard output to a file. Be careful, a single `>` will create a file if it does not exist, but will also destroy the content of a previous existing file.  A double `>>` will always append, and is non-destructive. When you execute this command you will notice no output comes to the screen.   This is because the angle bracket has redirected the output and written it to a file.
```bash
date > /tmp/todaysdate
```
```bash
cat log.old >> log.new
```

### Standard Error

When you type a command that does not execute successfully it returns an error message to the __standard out__. Perhaps the message is *"file or directory not found:"* that is printed to the screen.  But that error is not part of the __standard out__, it is part of __standard error__.  Standard error can be useful for logging and debugging purposes.  If you have a command you want to execute but you want to suppress the __standard error__ from showing on the screen, yet log it to a file, you can do so.

#### Suppressing Standard Out and Error

Each of the standards can be referenced numerically. The first element is ___standard in__ which has the implied value of __0__ or no value at all.   The next element, __standard out__ has the value of __1__.  The final element, __standard error__ can be referenced by the number __2__.  Note in the script below we are redirecting standard out and error to separate file which can be used for debugging our shell script later on.    Standard out and standard error and be redirected together in the bash shell with a single ```&``` in front of an angle bracket.  

```bash
sudo apt update 1>/tmp/01.out 2>/tmp/01.err
sudo apt -y install nginx 1>/tmp/02.out 2>/tmp/02.err
sudo systemctl nginx start 1>/tmp/03.out 2>/tmp/03.err
```

> __Exercise:__ Use the single angle bracket to redirect the output of a command to a file.  Technically this command is a "1" followed by an angle bracket ">" but the one is implied and can be left out.  What happens when you try this command: ```ls -l > ./dir-list.txt; cat ./dir-list.txt```

> __Exercise:__ You can suppress the standard error output as well by redirecting it to a file. What happens when you type this? ```ls -l /new-top-secret 2> ./error-report.txt; cat ./error-report.txt```

> __Exercise:__ Both standard out and standard error can be redirected together.  This is useful if you are running a script as a system process or as part of a scheduled task.  What happens when you type these commands? ```ls -l ~; ls -l /new-top-secret &> error-and-out.txt```

> __Exercise:__  As a final convention anytime you want to *throw away* or completely suppress output you can redirect it to ```/dev/null```.  This directory is called the *bit bucket* or the *black hole* any output directed to it is destroyed irrevocably.  It is useful if you just want a command to execute but not display and output or error messages. This is best used in shell script when looking for the existence of a command binary or file. You just want the confirmation that the file exists not any output. What happens when you type the ```ls -l /topsecrect 2> /dev/null``` command?

## History and Usage of Pipes

### Douglas McIlroy

![*Douglas McIlroy*](images/Chapter-06/people/Douglas_McIlroy-2.jpg "Douglas McIlroy")

Douglas McIlroy was the manager of the Bell Labs Computing Techniques Research Department from 1965 to 1986 where Ken Thompson, Dennis Ritchie, and Brian Kernighan worked under his direction.  He gave support to Unix and encouraged its development.  He even built several Unix commandline binaries such as `spell`, `diff`, `sort`, `join`, `graph`, `speak`, and `tr`[^66]. Most importantly McIlroy envisioned the concepts of __pipes__ or __pipelines__. This idea allowed for the output of one command to be directed as the input of another command--making a pipeline.  This was in compliance with Thompson's idea of small command binaries doing only one thing. So by 1973 McIlroy had convinced Thompson to modify and add this feature to Unix.  

> "Pipes were first suggested by [M. Doug McIlroy](https://en.wikipedia.org/wiki/Douglas_McIlroy "Douglas McIlroy"), when he was a department head in the Computing Science Research Center at Bell Labs, the research arm of AT&T (American Telephone and Telegraph Company), the former U.S. telecommunications monopoly. McIlroy had been working on macros since the latter part of the 1950s, and he was a ceaseless advocate of linking macros together as a more efficient alternative to series of discrete commands. A macro is a series of commands (or keyboard and mouse actions) that is performed automatically when a certain command is entered or key(s) pressed."

> "McIlroy's persistence led Ken Thompson, who developed the original UNIX at Bell Labs in 1969, to rewrite portions of his operating system in 1973 to include pipes. This implementation of pipes was not only extremely useful in itself, but it also made possible a central part of the Unix philosophy, the most basic concept of which is modularity (i.e., a whole that is created from independent, replaceable parts that work together efficiently)[^65]."

[2005 audio presentation by Doug McIlroy about the early history of Unix development](http://www.dlslug.org/past_meetings.html "Interview with Doug McIlroy")

### Additional Commands Used for Manipulating Standard Out

The best way to envision pipes is to think of them as exactly what they are called--physical pipes in which water travels through.  To maximize your understanding of the concept of *piping* output we will introduce a series of additional command binaries to the list of essential command binaries that was introduced in last chapter and show you combined examples.  

who

:  Allows a user to query which accounts are logged into the system at the current time.  __Usage example:__
```bash
who
```

sort

:  Similar to the ```cat``` command, ```sort``` will display the content of a file to standard out with the added feature of sorting the content alphabetically. Note that what is sorted is just a copy of the output to the screen. The original file is left unaffected. The ```sort``` and ```uniq``` commands are often used together. The \\n character provides a newline or carriage return __Usage example:__
```bash
echo -e "orange\npeach\ncherry" > fruits.txt; sort fruits.txt  
```

uniq

:  The uniq command is used for reporting or filtering out repeated lines in a file. Though __uniq__ is a full command binary it is mostly used as a filter through which input has been piped [^67]. For example if we had an webserver error log file with the content below, we would use ```uniq``` to filter out duplicated lines. The ```uniq``` command would collapse the first 5 lines into one unique line for output. The -c option will add a count after each unique line and the -d will only show a line if it has two or more occurrences. __Usage example:__  
```bash
cat error.log
[Sun Mar 16 16:35:16 2014] [error] [client 64.131.110.29] File does not exist:
[Sun Mar 16 16:35:16 2014] [error] [client 64.131.110.29] File does not exist:
[Sun Mar 16 16:35:16 2014] [error] [client 64.131.110.29] File does not exist:
[Sun Mar 16 16:35:30 2014] [error] [client 157.55.33.126] File does not exist:
[Sun Mar 16 17:49:05 2014] [error] [client 216.152.249.242] File does not exist:
[Sun Mar 16 18:05:54 2014] [error] [client 75.148.238.204] Invalid method
```
```bash
uniq error.log
```

wc

: The ```wc``` command stands for and is sometimes pronounces *word count*. It is used for printing out the number of newlines, words, and  byte count for a file or for standard in. You can use ```wc``` as part of a filter to count only specific occurences of a word. The file hosts.deny is a file containing IP addresses of systems attempting to brute force hack a server via SSH. The banned IPs have been placed in the hosts.deny file for which the system will deny a TCP connection from any address listed in that file. How many have been added?  You can count the lines, words, and bytes by executing the command below or just the number of lines by using the ```-l``` option. __Usage example:__
```bash
wc hosts.deny; tail hosts.deny | wc
```
```bash
wc -l hosts.deny
```

cut

: The ```cut``` command will allow you to *cut* up your output based on a delimiter: space, dash, comma, and so forth. The command will print selected parts of lines from a file to standard output[^68]. The -d option is the delimiter to *cut* on and the -f is the field or column number(s) to retrieve. __Usage example:__
```bash
cut -d' ' -f1,2 ./sample-data/stations-fixed-width.txt
```
```bash
uname -a | cut -d" " -f1,3,11,12
```

echo
: This command is used for displaying a line of text.  By using the -e option you can enable escape sequences to be interpreted. The first example will print out a line of text. The second example uses a for loop to print out a single period and then sleep for 1 second. __Usage example:__
```bash
echo "hello world!"
```
```bash
for i in {0..10}; do echo -ne '.'; sleep 1; done
```

tee

: The ```tee``` command is used to read from standard input and write to standard output. The command below will sort the output of the hosts.deny file and well as save that sorted output to a file name ./sorted.txt. Then that output will be further passed to a ```wc``` command.  Think of the ```tee``` command as like a t-shaped pipe that lets water flow down as well as across. __Usage example:__
```bash
cut -d' ' -f2 ./hosts.deny | sort | tee ./sorted.txt | wc
```

dmesg

: The ```dmesg``` command is a shortcut to display the kernel ring buffer--or in other words the kernel's output messages for debugging. __Usage example:__
```bash
dmesg
```

tail

: Capitalizing on the *clever hack* mantra of Richard Stallman, the ```tail``` command produces the same output as the ```cat``` command yet does it so by showing the last line 10 lines (by default) of a file fist. Note the Unix humor as tail is the opposite of head.  Also a cat has a tail...  __Usage example:__
```bash
tail hosts.deny
```
```bash
tail -n 35 hosts.deny
```

head

: The ```head``` command is used to show the first 10 lines (by default) of a command.  It is useful for getting a *peek* at what is in a file if you can remember without having to display the entire contents of a file. __Usage example:__
```bash
head error.log
```
```bash
head -n 25 error.log
```

tac

: The ```tac``` command is another *clever hack* in that is does the exact same thing as the ```cat``` command except that it does it in reverse (cat backwards). __Usage example:__
```bash
tac error.log
```
```bash
tac error.log | less
```

jq

: The `jq` command isn't part of the default GNU tools, and needs to be installed via a package manager. It is specfically and only geared to work with [JSON](https://www.json.org/json-en.html "webpage for JSON org"). It is a text-based way to transport and parse object and attribute related data. __Usage example:__
```bash
sudo apt install jq
jq -r .'Reservations[].Instances[].InstanceIds' ./aws-launch-results.json
```

### Pipe Usage

Pipes can be used to chain as many commands together as necessary. This is one of the three main design principles of Unix.

> __Exercise:__  In the previous ```cut``` example we see the ```uname``` command which is used to print system information to standard out being piped to the cut command and only certain fields of the information being displayed. Lets try it. Type ```uname -a``` and then ```uname -a | cut -d" " -f1,3,11,12```. What is different in the output?

> __Exercise:__ You can also add input redirection to a pipe: ```dmesg | tail > current-log.txt```. This command will take the tail (or last 10 lines) of the dmesg kernel output buffer and redirect them to a text file for later analysis. We can also pipe data and redirect as well.  ```cat deny.hosts | uniq -c > deny-results.txt```  Multiple commands can be chained together. Try this command, ```cat deny.hosts | uniq -c | sort -nr``` and then try it again omitting the ```| sort -nr``` what is the difference?

> __Exercise:__ The chaining process can grow pretty extensive. The ```ps``` command is used to list system processes that are running and will be covered in detail in a later chapter. This command will look for every running process that has the system+wildcard name in it, sort it, pipe that output to a tee--which saves that formatted output to a file.  Then that sorted text will be passed on as standard in for a cut command to filter out columns via spaces and cut the first column and display this text to standard out.
```ps -ef | grep system* | sort | tee ~/processes.txt | cut -d' ' -f1```

> __Exercise:__ A variation on the command above but here there is a second tee command and a final passing to a ```wc``` command that will count the occurrences of the ```system*``` value. ```ps -ef | grep system* | sort | tee ~/processes.txt | cut -d' ' -f1  | tee ~/columns.txt | wc```

## Commands for Finding, Locating, and Pattern Matching

### grep

The ```grep``` command is a powerful pattern matching and searching tool for the shell. Originally a feature of the ``ed`` line editor program - it stood for g/re/p--global regular expression print. A grep command will search inside of a given text file or directory looking for lines of text that match the pattern you give it.  You can use shell meta-characters from above or literal text strings as the searching parameters. There are even more advanced search patterns called *regular expression* which is almost a programming language in itself that allows for complex text queries.

The grep command[^69] has many options to modify the returned output. Some of the more common ones are listed here[^70]:

* The -i option causes a case-insensitive search.
* The -w option matches only whole words.
* The -l option lists only the files in which matches were found, but not the matching lines.
* The -r (recursive) option searches files in the current working directory and all subdirectories below it.
* The -n option lists the matching lines, together with line numbers.
* The -v (or --invert-match) option filters out matches.
* The -c (--count) option gives a numerical count of matches, rather than actually listing the matches.

> __Exercise:__ Commands in which large amounts of text are going to be displayed can be filtered and then piped to a ```less``` command for viewing.  If you view the hosts.deny file contents you will see it has two columns of text: first column is the service name, the second is the IP address that is banned.  With over 3000+ entries you can use pipes and filters to narrow down the output.  For example let us say that you are looking for every line that has an IP that starts with 216.* and then count those number of occurrences? ```cat hosts.deny | grep "sshd: 210" | wc```

![*Format of the hosts.deny file*](images/Chapter-06/pipes/hosts-deny.png "Structure of hosts.deny")

> What would happen if you added a ```| less``` command to the end like this?  ```cat hosts.deny | grep "sshd: 210" | less``` ?

> Can we rewrite the above command to be more efficient?  What if we use the ```cut``` command?  `cat hosts.deny | cut -d' ' -f2 | grep ^210 | less`  This will cut out the first column, search for all lines starting with 210. The `^` in this expression tells `grep` to look only at the beginning of the line and then pass the results to the `less` command.

> Using `grep` can you display all the lines that contain *InstanceId* in the file `aws-launch-results.json`?

> Using `grep` can you display all the lines that contain *1949* in the file `records.txt`

Grep can also be used as an initial command -- saving the trouble of calling a `cat` command. Both of these commands are valid, the second one is preferred.

```bash
# This will display the full file content to the screen -- adding some overhead
# in memory requirements to print all the data out then grep it
cat stations-fixed-width.txt | grep TROMSO
# This will skip the printing step and commence with the searching and printing
# of all the weather stations that have TROMSO in the name
grep "TROMSO" stations-fixed-width.txt
```

This is just the beginning of `grep` as we will expand upon its powerful usage along with shell meta-characters and text editors in the next chapters.


### find and locate commands

The `find` command is used to search for files in a directory hierarchy. This command has additional parameters that can be used to find files based on time or size criteria. This is useful searching for files based on when it was created or for finding large files that might be cluttering up the system. The `find` command can also receive shell meta-characters as part of the search pattern. All numeric values can be denoted in this fashion:

 Character          Value
-----------  -----------------------
    +n        for greater than n
    -n        for less than n
     n        for exactly n
-----------  -----------------------

Some of the common categories you can use for find are: file time parameters, file size parameters, user ownership parameters, and permission parameters.

#### TIME

-amin n

: File was last accessed n minutes ago.

-anewer file

: File was last accessed more recently than file was modified.  If file is a symbolic link and the -H option or the -L option is in effect, the access time of the file it points to is always used.

-atime n

: File was last accessed n*24 hours ago.  When find figures out how many 24-hour periods ago the file was last accessed, any fractional part is ignored, so to match -atime +1, a file has to have been accessed at least two days ago.

-cmin n

: File's status was last changed n minutes ago.

-cnewer file

: File's status was last changed more recently than file was modified.  If file is a symbolic link and the -H option or the  -L  option  is  in effect, the status-change time of the file it points to is always used.

-ctime n

: File's  status  was  last  changed n*24 hours ago.  See the comments for -atime to understand how rounding affects the interpretation of file status change times.

#### SIZE

-size n\[cwbkMG\]

: File uses n units of space.  The following suffixes can be used:

* b    for 512-byte blocks (this is the default if no suffix is used)
* c    for bytes
* w    for two-byte words
* k    for Kilobytes (units of 1024 bytes)
* M    for Megabytes (units of 1048576 bytes)
* G    for Gigabytes (units of 1073741824 bytes)

#### USER

-user uname

: File is owned by user uname (numeric user ID allowed).

-perm 000

: File is owned by user uname (numeric user ID allowed).

> __Exercise:__ find . -perm 664

> __Exercise:__ find ~ -mtime 0

> __Exercise:__ find ~ -size +100M  

> __Exercise:__ find ./ -size +1M

> __Exercise:__ find ./ -name "*.log"

> __Exercise:__ find ./ -size +1M

#### Locate

An alternative to using ```find``` is the ```locate``` command. This command is often quicker and can search the entire file system with ease.  The ```locate``` command is not part of the GNU coretools so it may not be present on your Linux distro by default. You can install GNU locate: ```sudo apt-get install mlocate``` or ```sudo dnf install mlocate```. The ```locate``` command reads one or more databases prepared by ```updatedb``` and writes file names matching at least one of the PATTERNs to standard output, one per line [^71]. What the ```locate``` command does is make a database of all files on the system, thereby making lookups faster. You need to run the `sudo updatedb` command to update the index (done every time on reboot).  

> __Example usage:__ ```sudo updatedb; locate *.png; locate chapter-05.md```

> __Example usage:__ Compare the output and amount of time this command takes: ```sudo find / -name chapter-05.md``` and ```locate chapter-05.md```. The `locate` command is quicker to the answer because databases are good at looking things up.  

## Hidden files and single dot operator

In the previous chapter we talked about the single-dot operator--which is a short cut for *right here* or your present working directory.  If the single-dot proceeds a file or directory name that file or directory becomes hidden.  Not completely invisible but by using the ``ls`` or ```ls -l``` commands you will not see these files.  You need to add the -a option to see all hidden directories.  Usually hidden directories are reserved for important user configuration files or system files.  It is a convention not a rule, but as you have seen so far, tradition is rule in Unix.

> __Example usage:__ Compare the output of these two commands: ```ls -l ~``` and ```ls -la ~```--what new files or directories appear?

> __Example usage:__ You can create a hidden file by prefixing a filename or directory with a single dot: ```touch .top-secret.txt``` or ```mkdir ~/.topper-secret```

## Chapter Conclusions and Review

In this chapter we covered and explored the power-tools of the commandline.  We learned about shell meta-characters and how they enhance the usability of the commandline.  We examined additional command binaries used for manipulation and modification of output to the screen.  We learned about the standard input, output, and error devices and how input can be redirected to them via the arrow operators.  Finally we coved find, locate, and grep tools for searching in files and for files.  This chapter is preparing us to combine of these features into a shell script.

### Review Questions

Shell Meta-Characters, Pipes, Search, and Tools

Chapter 06 review questions

1.  What is the name for characters that have special meanings in the Linux shell?
    a.  special chars
    b.  marked characters
    c.  shell characters
    d.  shell meta-characters
1.  Assume your pwd is ~.  If you wanted to list every directory that started with the letters "Do" what would be the command?
    a.  ls -l
    b.  ls -la [Dd]o
    c.  ls -l Do
    d.  ls -l Do*
1.  In figure 6.2 in Chapter 06, which of the 3 blue boxes is the step where shell meta-characters are transformed into text?
    a.  Lexical analysis and parse
    b.  Execution
    c.  Builtins
    d.  Expansion
1.  Which meta-character allows you to string commands together regardless of the successful execution of the previous command?
    a.  &&
    b.  ;
    c.  \+
    d.  ||
1.  Which meta-character allows you to string commands together but will exit if the first command fails?
    a.  &&
    b.  ;
    c.  \+
    d.  ||
1.  Which meta-character is the wildcard for 0 or more matches?
    a.  ?
    b.  \*\*
    c.  &
    d.  \*
1.  Which meta-character is the single character wildcard?
    a.  ?
    b.  '
    c.  &
    d.  \*
1.  Square braces [] indicate sets or ______ of characters to be processed
    a.  numbers
    b.  letters
    c.  characters
    d.  ranges
1.  If you wanted to use brace expansion and create a series of nine files named: file1 - file9, all at once--what command would you use?
    a.  touch file[1-9]
    b.  touch file(1-9)
    c.  touch file{1..9}
    d.  touch file[1..9]
1.  If you wanted to assign the value of /etc/alternatives/java to a shell variable named JAVA_HOME--what would be the proper syntax?
    a.  JAVA_HOME = /etc/alternatives/java
    b.  /etc/alternatives/java = JAVA_HOME
    c.  JAVA_HOME=/etc/alternatives/java
    d.  $JAVA_HOME=/etc/alternatives/java
1.  What would be the proper syntax to display the content of a variable named JAVA_HOME in the shell?
    a.  echo JAVA_HOME
    b.  cat JAVA_HOME
    c.  print JAVA_HOME
    d.  echo $JAVA_HOME
1.  There are 3 standard I/O devices in a Linux system, standard in, standard out, and ________
    a.  standard air
    b.  standard io
    c.  standard x
    d.  standard error
1.  Standard In is what device by default?
    a.  mouse
    b.  screen
    c.  tty
    d.  mouse and keyboard
1.  Standard Out is what device by default?
    a.   mouse
    b.   screen
    c.   X
    d.   keyboard
1.  What meta-character can you use to redirect standard out to a file? (Choose all that apply.)
    a.  \>
    b.  \>\>
    c.  \<
    d.  \>\>\>
1.  What meta-character is used to redirect the standard output of one command as the standard input of another command?
    a.  ->
    b.  &&
    c.  ||
    d.  \|
1.  Which command is used to search within files using textual filter patterns?
    a.  find
    b.  locate
    c.  slocate
    d.  grep
1.  Which command can be used to count lines that are in a text file?
    a.  count
    b.  wc
    c.  lines
    d.  uniq
1.  Which command can be used to find unique line occurrences in a text file? 
    a.  sort
    b.  uniq
    c.  wc
    d.  who
1.  Which command can be used to sort the content of a text file?
    a.  sort
    b.  uniq
    c.  wc
    d.  who
1.  Which command would assign the output of the date command to a variable named DT?
    a.  DT = date
    b.  DT=date
    c.  DT=$(date)
    d.  DT = $(date)
1.  What would be the correct command to redirect the standard out and standard error of a command to files?
    a.  `sudo apt install nginx 1>/tmp/02.out 2>/tmp/02.err`
    b.  `sudo apt install nginx 0>/tmp/02.out 1>/tmp/02.err`
    c.  `sudo apt install nginx >/tmp/02.out >/tmp/02.err`
    d.  `sudo apt install nginx &>/tmp/02.out &>/tmp/02.err`
1.  What is the command that will print the last 10 lines of a text file?
    a.  head
    b.  tail
    c.  tac
    d.  cat
1.  What is the command that will print the first 10 lines of a text file?
    a.  head
    b.  tail
    c.  tac
    d.  cat
1.  What is the command to display the content of a text file backwards (last line first)?
    a.  head
    b.  tail
    c.  tac
    d.  cat

### Podcast Questions

Watch this video with Professor Brian Kernighan [History of grep](https://www.youtube.com/watch?v=NTfOnGZUZDk&t=1s) and answer the following questions.

* ~0:11 What does the grep program do?
* ~1:11 What was the first computer that Unix ran on?
* ~1:40 Why did the original Unix software tend to be "simple and straight forward?"
* ~2:01 What was the first Unix text editor called?
* ~2:30 When designing text editors in the early 70's what didn't they have that we have now?
* ~4:09 What does the "ed" command `1,$p` accomplish?
* ~4:35 What is a Regular Expression?
* ~5:26 What does a star or asterisk (shift+8) mean in Shell meta-characters?
* ~7:30 Who wrote the grep command and how long did it take?
* ~7:42 What is the explanation of what the grep command does?
* ~8:04 What does the character `g` mean in regular expressions?
* ~8:33 Why is the program named `grep`?
* ~9:00 Describe the assignment the Professor Kernighan gave to his students

### Lab

#### Lab Objectives

The objectives of this lab will be:

* Implement shell meta-characters, pipes, search, and commandline tools 
* Engage in file creation, traversal, modification, and manipuation
* Deploy the concepts of Unix pipes in your shell scripts

#### Lab Outcomes

At the outcome of this lab will you will be able to successfully implement meta-characters for file creation, traversal, modification, and manipulation. You will successfully have deployed the concept of pipes and redirection as well.  Resist the temptation to use the GUI file manager and a web browser. 

#### Lab Notes

You can use either an Ubuntu or a Fedora based OS, all you need is a Linux Terminal and to clone the Textbook Github repo into your `Documents` folder.

1. What is the command to clone a copy of the textbook code into your Documents folder (if you have already done this in Lab 5 no need to repeat this step, just answer the question). 
1. Issue the command to `cd` into the `Linux-Text-Book-Part-I` directory. Type the command that will list every file in this directory that ends with `.sh`
1. Type the command to do a *long listing* of Chapters-02, 04, 06, and 08 only
1. Type the command that will copy the file `Chapter-02/chapter-02.md` into the your home directory, then list the content of your home directory. Use the meta-characters needed to execute the proceeding commands only if the previous command is true and place all these commands into one single line
1. In your home directory, using the meta-character, create these two series of files: homework10.txt - homework15.txt and account10.txt - account15.txt. Create each series using a single command
1. In your home directory, using the meta-character, issue a command to list only the homework10.txt - homework15.txt files
1. In your home directory, using the meta-character, create the directories named: debian10, debian11, and debian12 with a single command
1. In your home directory, using the meta-character, delete the directories named debian10, debian11, and debian12 with a single command
1. In your home directory redirect the output of the `date` command into a file named: **today.txt**
1. In your home directory append the output of the `date +%m%d%Y` command to the file **today.txt** and display the content - you should see two formatted date entries
1. In your home directory, in a single command using **pipes** append the `date +%m%d%Y` and the last ten lines of the error log to the file today.txt
1. Create a shell variable named `UT`, assign the contents of the command `uptime` to `UT` and print a string to the screen with its value and with a string stating, "The system has been up for: " and then the value of UT.
1. Using an Ubuntu Desktop system, execute the following commands: ```sudo apt-get update 1>/tmp/01.out 2>/tmp/01.err``` ```sudo apt-get -y install nginx 1>/tmp/02.out 2>/tmp/02.err``` and ```sudo systemctl start nginx 1>/tmp/03.out 2>/tmp/03.err```. Issue the command to list the contents of the `/tmp` directory.
1. What would be the command to modify the previous questions code to redirect both standard out and standard error to a single file.
1. Issue the command: `sudo apt install nginx123` redirecting the standard out and standard error to a single file, what is the output of standard error?
1. Type the command ```ls -l /topsecret``` and redirect both standard out and standard error to a file named: `/tmp/out-and-error.txt`
1. You will find a file named `hosts.deny` located in the directory `files` > `Chapter-06` of the download of the textbook. It contains a list of IP addresses - what command would you use to count ONLY the number of lines in the file?
1. Using the `error.log` file located in the directory `files` > `Chapter-06` - what command would you use to count only unique lines and to display their count and only if there is more than 1 occurrence?
1. What command would let you display the content of the `hosts.deny` file, cut out the the second column and sort it?
1. What command would let you search the file `error.log` for the lines that contain the term **robots.txt**?
1. What command would let you count the number of lines that have the term "robots.txt" in the file error.log?
1. Using the hosts.deny file, what command would you type to display the last 10 lines of the file, cut out the field with the IP address and sort them in ascending order?
1. Use the `grep` tool to search the file `error.log` for the line "Invalid method in request" and print to the screen the lines found.
1. Using tools discussed in this chapter and based on the contents of the file **error.log**, type the commands needed to find the following information: How many unique IPs did the error messages come from?  
1. Home many unique URLs based errors (last column), and list all of the unique type of errors (second to last column).
1. Using the ```find``` command and starting from the \~ directory what would be the command to find all files with the name .md?
1. Using the `find` command and starting from your home directory, what would be the command to find all the files that have been modified in the previous hour?

#### Deliverable

Create a directory named: `chapter-06` under the `labs` folder.  Create a file named: `chapter-06.sh` in that directory containing the answers to each of the lab questions listed above. For answers that require two or more commands, chain them together on a single line using the `;` or `&&` metacharacters. Submit the URL to the chapter-06.sh file to Canvas.

#### Footnotes

[^64]: [http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html](http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html "POSIX Shell meta-characters")

[^65]: [http://www.linfo.org/pipe.html](http://www.linfo.org/pipe.html "History of Unix Pipes")

[^66]: [https://en.wikipedia.org/wiki/Douglas_McIlroy](https://en.wikipedia.org/wiki/Douglas_McIlroy)

[^67]: [http://www.computerhope.com/unix/uuniq.htm](http://www.computerhope.com/unix/uuniq.htm "uniq command")

[^68]: [http://www.tldp.org/LDP/abs/html/textproc.html](http://www.tldp.org/LDP/abs/html/textproc.html "cut command")

[^69]: [http://www.tldp.org/LDP/abs/html/textproc.html](http://www.tldp.org/LDP/abs/html/textproc.html "grep command")

[^70]: [https://www.gnu.org/software/grep/manual/grep.html](https://www.gnu.org/software/grep/manual/grep.html "GNU grep")

[^71]: [http://manpages.ubuntu.com/manpages/utopic/man1/mlocate.1.html](http://manpages.ubuntu.com/manpages/utopic/man1/mlocate.1.html "Locate man page")

[^72]: [https://en.wikipedia.org/wiki/Compress](https://en.wikipedia.org/wiki/Compress "Compress")

[^73]: [https://en.wikipedia.org/wiki/Gzip](https://en.wikipedia.org/wiki/Gzip "gzip")

[^74]: [https://en.wikipedia.org/wiki/Bzip2](https://en.wikipedia.org/wiki/Bzip2 "bzip2")
