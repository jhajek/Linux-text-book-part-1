# Shell Variables, Meta-Characters, Search and Tools
![*The beauty of Unix Commands*](images/Chapter-Header/Chapter-06/tar-2.png "tar")

## Chapter Objectives

In this chapter we will be continuing our exploration of the commandline.  We will be expanding our exerpience of the original paradigm that Thompson and Ritchie envisioned when designing Unix.

   * Understand the nature of shell meta-characters and how they enhance the shell capabilities
   * Understand the concept of standard in, standard out, and standard error
   * Understand the concept of input/output redirection and piping using *"< > | tee"*
   * Understand how to search the file system for the location of files
   * Understand how to use the grep command for detailed search and replace options using shell meta-characters
   * Understand compression archive tools and their use on the command line 
   
### Chapter Outcomes

  At the conclusion of this chapter you will have a definate understand of the Linux shell and its utilities.  You will know the nature of shell meta-characters and how they can enhance the capabilities of shell commands.  You will be able to use the concepts of standard input, standard output, and standard error to redirect output as you need it.  You will understand the meta-characters used for input redirection and the concept of "|" called piping - that enables single commands to send their standard output as standard input to another command.   We will explore the __find__ and __locate__ commands that are used to find and filter files on the system.   We will use the __grep__ tool for find and replace options and advanced parsing of file content beyonf what __find__ and __locate__ can do.   FInally we will use compression tools and for creating archives and for extracting them. 

## Shell Meta-Characters

  In the last chapter we learned about the Linux shell and it's purpose to help the user interact with the kernel.  We learned that the GUI is just a *sugar* layer sitting on top of the shell.  We also learned a series of essential commands in order to create and maniplulate the contents of our file system.  The next layer to be introduced is something called __shell meta-characters__.  When Ken Thompson Was creating Unix and the first user shell, he quickly realized a need to be able to perform certain tasks that would be repeated often.  For example, the concept of adding a wildcard to an ```ls``` command like this: ```ls -l Do*```.  This command read a directories content and feed it any filenames that match the first two characters "Do" plus any number of other characters, (including 0 charactrers), represented with the star or asterik (*).   The concept of the shell meta-character is intended to replace you having to write a C language program each time to create this functionality.  There are 14 punctuation and non-alphanumberic characters that are standard across Linux shells[^64] - common punction/non alphanumberic characters were adopted to represent the most common repetitive tasks done on the commandline.
      
![*User -> Shell -> Kernel -> Shell -> User*](images/Chapter-06/shells/figure2.png "User -> Shell -> Kernel -> Shell -> User")
 
  When the shell parses the three components of a command there is a square that talks about variable replacement.  We sort of skimmed that part in the last chapter but here is what is happening. Here is a list of the major shell meta-characters you need to know.  More information and examples can be found at the [Linux Documentation Project's](http://tldp.org/LDP/abs/html/special-chars.html "TLDP") website.   Remember that everything in Unix is a file, and all files are text based.

\&\& 
                  
: The double ampersand character (shift+7)command allows you to execute two or more commands together in sequence.  Note the && requires each succesive command to return succesfully or else the entire string will stop at the command that failed. __Usage example:__ 
```bash
unzip -d book master.zip && cd book && cat Readme.md
```

\;    

: Unlike the ampersand character the semi-colon __";"__ allows you to chain commands together that will execute in sequence regardless of the previous commands return status. The example command will execute and return two errors tellingyou the file or directory doesn't exist, but the third command will execute showing the data. __Usage example:__ 
```bash 
ls /topsecret; cd /topsecret; date
``` 

\|

:  This character is called the "pipe" because it looks like a vertical bar or a piece of a pipe.  It serves the function of connecting the output of one command to the input of another commmand--not unlike a pipe under your sink.  The character is typed by pressing the shift+the key located directly above the enter key.  In this example here we display the content of the chapter-05.md and *pipe* it to the grep command which filters the file showing us only the lines containing the term *permission*. __Usage example:__ 
```bash 
cat Chapter-05/chapter-05.md | grep permission
```

\*

:  The asterik (shift+8) is the wildcard representative.  It can be used in any shell command when you want to let the computer to the work or when you are not quite sure of a files spelling. __Usage example:__ 
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
ls vegetalbe-?-report.txt
```
```bash
ls ???.txt
```

\$

: Dollar sign allows for reference of shell variables.  __Usage example:__ 
```bash
DIR=/etc/network/interfaces
```
```bash
echo $DIR
```
```bash
DT=`date`; echo $DT
```

\"

: double tic or double quote. Any characters or variables surrounded by double tics will interpret shell variables that inside of the string before passing the contents to a command. This command will print the content of the date command from the previous example along with some text to the screen. __Usage example:__
```bash
echo "Today's date is $DT"
```

```'```

: single tic or single quote.  Any characters or variables surrounded by a single tic will be interpreted literally.  Unlike the previous example this command will only print the literal characters $DT not expand the variable's contents.  __Usage exmaple:__ 
```bash
echo 'Today's date is $DT'
```

```bash
`
```

: back tic key to left of number 1.  The back tic is used for encasing Linux binary command names.  The back tic tells the system to interpret the command and execute it and return its value to the user for further processing. In the 2 prior examples we stored the content of the date command to a shell variable named DT. __Usage example:__ 
```bash
DT=`date`
```
```bash
CONTENTS=`cat /etc/services`
```

```[]```

: Square brackets indicate sets or ranges of characters to be processed.  In a sense it is a mini-for loop for processing files names.  We can present multiple character sets or if we use ```-``` we can present a numeric or alphabetic range of values to be passed to a shell command. __Usage example:__
```bash
ls file[24]
```
```bash
ls file[1-4]
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
```
```bash
echo "Buy milks and eggs!" >> ~/Documents/my-shopping-list.txt
```

\{\}

: Curly braces  expansion braces also for decalring variables with variables in them. Note the difference.  The first command executes the content of ```whoami``` command and returns it.  The second command example from chapter 03 uses ```()``` to execute a sub-shell to get the value of ```uname -r```.  The final example allows you to use brace expansion to create multiple directories at once chapter-01-09.  __Usage example:__
```bash
echo ${username-`whoami`}
```
```bash
sudo apt-get install build-essential dkms linux-headers-$(uname -r)
```
```bash
mkdir chapter-0{1..9}
```

\#

: Pound sign or hash is used to comment out the lines in a shell script. We will cover this in detail in the next chapter.

\^

: The carot (shift+6) is a meta-character used in conjunction with the ```[]``` range brackets in order to tell the shell to negate the range included in the square brackets. ```ls [^r]*``` will find file1-file4, but will not list the files named rfile1-rfile4. __Usage exmaple:__ 
```bash
ls [^r]*
```
```bash
ls [^b-d]
```

\!

: Exclamation or usually pronounced as *bang*.  This is used to negate a test condition.  This will be covered more in the next chapter when we cover bash shell scripts.

\~

: The tilde or tilda (shift+the key to the left of the number 1) is a shortcut representing your user's home directory.  ```~-``` is a combination that references the previous directory you were in. __Usage example:__
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

: Tab key is used for autocomplete on the commandline.  This is a feature of bash, not present in sh, csh, and ksh. 

\\

: By placing a ```\``` in front of any character, the shell will *escape* that characters function.  This is helpful if you want to print out the text of commands without having the shell execute them.
```bash
echo "To assign the content of the date command to a variable type: DT=\`date\`\; echo \$DT"
```

## Standard input, output, and error 

  The original concept behind defining standard input and output devices comes from the idea that Unix grew over the course of 40 years of output and input technology.  Originally there were no keyboards--just teletypes.  Originally there were no screens just ttys to print out on paper.  Then came *glass ttys* and terminals.  Then came Line and Dot Matrix printers.  Standard keyboards via the ISA input bus were invented.  At one time on a busy shared sysetm (remember the central server development paradigm for Unix) a sysadmin would perhaps want to send output of a command or any errors so that they could be debugged on paper.  Not environmentally friendly but sometimes just seeing it in writing solves your issue. Every *device* has a file handle and you can see all the *standards* are located by listing the ```/dev``` directory.      
    
  ![*Standard I/O, ls -l /dev/std\**](images/Chapter-06/standard/standard.png "Standard I/O")
  
  ![*Trail of standard location*](images/Chapter-06/standard/standard-out-location.png "Standard Out Location")

### Standard In

  Standard in would be the way you get text input into the terminal.  This happens to be the keyboard.  Though you can use the reversed angle bracket ```<``` to send stanard in from a file. The example below writes the output of the date command and redirects the output to a file.  The second command will take the content of that same file as standard in--in place of the keyboard and redirect the input from the file to the cat command to display its content.    
  You can send the content of any file to a command with input redirection only if it accepts input from __standard in__ to begin with.
```bash
date > todaysdate.txt
```
```bash
cat < todaysdate.txt
```
```bash
mail < complete-works-of-shakespere.txt
```
  
### Standard Out

  When Unix was developed Ken Thompson took the direction that all devices were files.  In a short sense, the screen, or teletype, or terminal, is nothing more that a file that is located in the /dev directory.  By typing the ```who``` command from the commandline you will see which accounts are logged into the syste.  You will also see the screenshot below.  Try to open another terminal and execute the ```who``` command again.  What do you see now?

  This device allowed Unix and eventually Linux to exchange standard output devices yet not have to modify the output structure of the operating system.  Notice to that the outputs are refered to as ```tty``` which we learned about in chapter 4.  When you execute a command, the output is returned by default to standard out which in this case is the terminal screen.  You can use the ```> and >>``` out redirectors to send the standard output to a file.
  A single ```>``` will create a file if it does not exist, but will also destroy the content of a previous existing file.  A double ```>>``` will append, and is non-destructive.
```bash
date > /tmp/todaysdate
```
```bash
cat log.old >> log.new
```
  
  When you execute this command you will notice no output comes to the screen.   This is because the angle bracket has redirected the output and written it to a file.  

### Standard Error

  When you type a command and ther is an error message, perhaps "file or directory not found:" though that is printed to the screen, that is not part of __standard out__ it is part of __standard error__.  Standard error can be useful for logging.  If you have a command you want to execute but you want to suppress the standard error from showing on the screen, yet log it to a file, you can do so. 

#### Surpressing Standard Out and Error

  Each of the standards can be referenced numberically. The first element is ___standard in__ which has the implied value of __0__ or no value at all.   The next element, __standard out__ has the value of __1__.  The final element, __standard out__ can be referenced by the number __2__.  Note in the script below we are redirecting standard out and error to seperate file which can be used for debugging our shell script later on.  
```bash
sudo apt-get -y update 1>/tmp/01.out 2>/tmp/01.err
sudo apt-get -y install nginx 1>/tmp/02.out 2>/tmp/02.err
service nginx start 1>/tmp/03.out 2>/tmp/03.err
```
  Standard out and standard error and be redirected together in the bash shell with a single ```&```.
  
> __Exercise:__ Use the single angle bracket to redirct the output of a command to a file.  Techncally this command is a "1" followed by an angle bracket ">" but the one is implied and can be left out.  What happens when you try this command: ```ls -l > ./dir-list.txt; cat ./dir-list.txt```

> __Exercise:__ You can surpress the standard error output as well by redirecting it to a file. What happens when you type this? ```ls -l /new-top-secret 2> ./error-report.txt; cat ./error-report.txt```

> __Exercise:__ Both standard out and standard error can be redirected together.  This is useful if you are running a script as a system process or as part of a scheduled task.  What happens when you type these commands? ```ls -l ~; ls -l /new-top-secret &> error-and-out.txt ```

> __Exercise:__  As a final convention anytime you want to *throw away* or completely surpress output you can redirect it to ```/dev/null```.  This directory is called the *bit bucket* or the *black hole* any output directed to it is destroyed irrevocably.  It is useful if you just want a command to execute but not display and output or error messages. This is best used in shell script when looking for the existance of a command binary or file.  You just want the afirmation that the file exists not any output. What happens when you type the ```ls -l > /dev/null``` command.

## History and Usage of Pipes

### Douglas McIlroy

![*Douglas McIlroy*](images/Chapter-06/people/Douglas_McIlroy-2.jpg "Douglas McIlroy")

  Douglas McIlroy was the manager of the Bell Labs Computing Techniques Research Department from 1965 to 1986 where Ken Thompson, Dennis Ritchie, and Brian Kernighan worked under him.  He gave the tacit green light to Unix and encouraged its development.  He even built several Unix commandline binaries such as spell, diff, sort, join, graph, speak, and tr[^66]. Most importantly McIlroy envisioned the concepts of __pipes__ or __pipelines__. This idea allowed for the output of one command to be directed as the input of another command--making a pipeline.  This was in compliance with Thompson's idea of small command binaries doing only one thing.  So by 1973 McIlroy had convinced Thompson to modify and add this feature to Unix.  

> "Pipes were first suggested by [M. Doug McIlroy](https://en.wikipedia.org/wiki/Douglas_McIlroy "Douglas McIlroy"), when he was a department head in the Computing Science Research Center at Bell Labs, the research arm of AT&T (American Telephone and Telegraph Company), the former U.S. telecommunications monopoly. McIlroy had been working on macros since the latter part of the 1950s, and he was a ceaseless advocate of linking macros together as a more efficient alternative to series of discrete commands. A macro is a series of commands (or keyboard and mouse actions) that is performed automatically when a certain command is entered or key(s) pressed. 

> McIlroy's persistence led Ken Thompson, who developed the original UNIX at Bell Labs in 1969, to rewrite portions of his operating system in 1973 to include pipes. This implementation of pipes was not only extremely useful in itself, but it also made possible a central part of the Unix philosophy, the most basic concept of which is modularity (i.e., a whole that is created from independent, replaceable parts that work together efficiently).[^65]" 
 
[2005 audio presentaion by Doug McIlroy about the early history of Unix development](http://www.dlslug.org/past_meetings.html "Interview with Doug McIlroy")

### Additional Commands Used for Manipluating Standard Out

  The best way to envision pipes is to think of them as exactly what they are called--physical pipes in which things travel through.  To maximize your understanding of the concepts of *piping* output we will introduce a series of additional commands to the list of essential command binaries that was introduced in last chapter and show you combined examples.  

who

:  Allows a user to query which accounts are logged into the system at the current time.  __Usage example:__
```bash
who
```

sort

:  Similar to the ```cat``` command, ```sort``` will display the content of a file to standard out with the added feature of sorting the content alphabetically.  Note that what is sorted is just a copy of the output to the screen.  The original file is left uneffected. The ```sort``` and ```uniq``` commands are often used together. __Usage example:__
```bash
echo -e "orange \npeach \ncherry" > fruit.txt; sort fruits.txt  
```
uniq

:  The uniq command is used for reporting or filtering out repeated lines in a file. Though __uniq__ is a full command binary it is mostly used as a filter through which input has been piped [^67]. For example if we had an webserver error log file with this content, we have duplicated lines, we would use ```uniq``` to filter out duplicated lines. The below ```uniq``` command would collapse the first 5 lines into one unique line for output. The -c option will add a count after each unique line and the -d will only show a line if it has two or more occurances. __Usage example:__  
```bash
cat error.log
[Sun Mar 16 16:35:16 2014] [error] [client 64.131.110.29] File does not exist:
[Sun Mar 16 16:35:16 2014] [error] [client 64.131.110.29] File does not exist:
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

: The ```wc``` command stands for and is sometimes pronounces *word count*. It is used for printing out the number of newlines,  words,  and  byte  count for a file or for what is passed by standard in.  You can use ```wc``` as part of a filter to count only specific occurances of a word. The file hosts.deny is a file containing IP addresses of systems attempting to brute force hack a server via SSH.  There IPs have been placed on the hosts.deny list which the system will deny a TCP connection to.  How many have been added?  You can count the lines, words, and bytes by executing the command below or just the number of lines by using the ```-l``` option. __Usage example:__
```bash
wc hosts.deny; tail hosts.deny | wc 
```
```bash
wc -l hosts.deny
```

cut

: The ```cut``` command will allow you to *cut* up your output based on a delimeter, space, dash, comma, and so forth. The command will print selected parts of lines from a file to standard output[^68]. The -d option is the delimeter to *cut* on and the -f is the field number(s) to retrieve. __Usage example:__
```bash
cut -d ' ' -f1,2 /etc/mtab
```
```bash
uname -a | cut -d" " -f1,3,11,12
```

echo 
: This command is used for displaying a line of text.  By using the -e option you can enable escape sequences to be interpreted. The first example will print out a line of text.  The second example uses a for loop to print out a single period and then sleep for 1 second. __Usage example:__
```bash
echo "hello world!:
```
```bash
for i in {0..180}; do echo -ne '.'; sleep 1; done
```

tee

: The ```tee``` command is used to read from standard input and write to standard output. The command below will sort the output of the hosts.deny file and well as save that sorted output to a file name ./sorted.txt. Then that output will be further passed to a ```wc``` command.  Think of the ```tee``` command as like a t-shaped pipe that lets water flow down as well as across. __Usage example:__
```bash
cat hosts.deny | sort | tee ./sorted.txt | wc
```
  
dmesg

: The ```dmesg``` command is a shortcut to display the kernel ring buffer--or in otherwords the kernel's output messages for debugging. __Usage example:__
```bash
dmesg
```

tail

: Capitalizing on the *clever hack* mantra of Richard Stallman, the ```tail``` command produces the same output as the ```cat``` commnad yet does it by showing the last line 10 lines (by default) of a file fist. Note the Unix humor as tail is the opposite of head.  Also a cat has a tail...  __Usage example:__
```bash
tail hosts.deny
```

head

: The ```head``` command is used to show the first 10 lines (by default) of a command.  It is useful for getting a *peek* at what is in a file if you can remember without having to display the entire contents of a file. __Usage example:__
```bash
head hosts.deny
```

tac

: The ```tac``` command is another *clever hack* in that is does the exact same thing as the ```cat``` command except that it does it in reverse (cat backwards). __Usage example:__
```bash
tac hosts.deny
```

### Pipe Usage

Pipes can be used to chain as many commands together as necessary. This is one of the three main design principles of Unix.

> __Exercise:__    In the previous ```cut``` example we see the ```uname``` command which is used to print system information to standard out being piped to the cut command and only certain fields of the information being displayed. Try it.  Type ```uname -a``` and then ```uname -a | cut -d" " -f1,3,11,12```. What is different about the output?

> __Exercise:__ You can also add input redirection to a pipe.  ```tail dmesg > system-output.txt```  This command will take the tail (or last 10 lines) of the dmesg kernel output buffer and redirect them to a text file for later analysis.  We can also pipe data and redirect as well.  ```cat deny.hosts | uniq -c > deny-results.txt```  Multiple commands can be chained together.  Try this command, ``cat deny.hosts | uniq -c | sort -nr``` and then try it again omitting the ```| sort -nr``` what is the difference? 

> __Exercise:__ The chaining process can grow pretty extensive.  The ```ps``` command is used to list system processes that are running and will be covered in detail in a later chapter.  This command will look for every running process that has the system+wildcard name in it, sort it, pipe that output to a tee--which saves that formated output to a file.  Then that sorted text will be passed on as standard in for a cut command to filter out columns via spaces and cut the first column and display this text to standard out.```ps -ef | grep system* | sort | tee ~/processes.txt | cut -d ' ' -f1``` 

> __Exercise:__ A variation on the command above but here there is a second tee command and a final passing to a ```wc``` command that will count the occurences of the```system*``` value. ```ps -ef | grep system* | sort | tee ~/processes.txt | cut -d ' ' -f1  | tee ~/columns.txt | wc```

## Commands for Finding, Locating, and Pattern Matching 

### grep

  The ```grep``` command is a powerful pattern matching and searching tool for the shell.  Originally a feature of the ``ed`` line editor program - it stood for g/re/p--global regualr expression print.  A grep command will search inside of a given text file or directory looking for lines of text that match the pattern you give it.  You can use shell meta-characters from above or literal text strings as the searching parameters.   There are even more advanced search patterns called *regular expression* which is almmost a programming language in itself that allows for complex text queries.  We will not cover *regular expression* in depth in this book but talk about it as it relates to helping us complete our jobs. 

  The grep command [^69] has many options to modify the returned output. Some of the more common ones are listed here [^70]: 
  
 * The -i option causes a case-insensitive search.
 * The -w option matches only whole words.
 * The -l option lists only the files in which matches were found, but not the matching lines.
 * The -r (recursive) option searches files in the current working directory and all subdirectories below it.
 * The -n option lists the matching lines, together with line numbers.
 * The -v (or --invert-match) option filters out matches.
 * The -c (--count) option gives a numerical count of matches, rather than actually listing the matches.
 
> __Exercise:__ Commands in which large amounts of text are going to be displayed can be filtered and then piped to a ```less``` command for viewing.  If you view the hosts.deny file contents you will see it has two columns of text: first column is the service name, the second is the IP address that is banned.  With over 3000+ entries you can use pipes and filters to narrow down the output.  For example let us say that you are looking for every line that has an IP that starts with 216.* and then count those number of occurances? ```cat hosts.deny | grep "sshd: 210" | wc``` 

![*Format of the deny.hosts file*](images/Chapter-06/pipes/hosts-deny.png "Structure of hosts.deny")

> What would happen if you added a ``` | less``` command to the end like this?  ```cat hosts.deny | grep "sshd: 210" | less``` ?

> Can we rewrite the above command to be more efficient?  What if we use the ```cut``` command?  ```cat hosts.deny | cut -d ' ' -f2 | grep ^210 | less```  This will cut out the first column, search for all lines starting with 210 (the ^  in this expression tells grep to look only at the beginning of the line), and then pass the results to the ```less``` command.  

### find and locate commands

  The ```find``` command is used to search for files in a directory hierarchy.  This command has additional parameters that can be used to find files based on time or size criteria.  This is useful searching for files based on when it was created or for finding large files that might be cluttering up the system.   The ```find``` command can also recieve shell-metacharacters as part of the search pattern. All numeric values can be denoted in this fashion:
  
 Character          Value
-----------  -----------------------
    +n        for greater than n,
    -n        for less than n,
     n        for exactly n.
-----------  -----------------------

Some of the common categories you can use for find are: file time parameters, file size paramaters, user ownership parameters, and permission parameters.   

__TIME__

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

__SIZE__

-size n\[cwbkMG\]
              
: File uses n units of space.  The following suffixes can be used:
`b'    for 512-byte blocks (this is the default if no suffix is used)
`c'    for bytes
`w'    for two-byte words
`k'    for Kilobytes (units of 1024 bytes)
`M'    for Megabytes (units of 1048576 bytes)
`G'    for Gigabytes (units of 1073741824 bytes)

__USER__

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

An alternative to using find is the locate command. This command is often quicker and can search the entire file system with ease.  The ```locate``` command is not part of the GNU coretools so it may not be present on your system but usually is.  You can install it by typing ```sudo apt-get install mlocate``` or ```sudo dnf install mlocate```.  locate  reads  one or more databases prepared by updatedb(8) and writes file names matching at least one of the PATTERNs to standard output, one per line [^71].
  



## Compression and Archive tools

### tar

### compression

#### gzip

#### bzip

#### xz

##  Hidden files and single dot operator

./   .ssh

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

__FreeBSD__

Listen or watch this podcast: [http://twit.tv/show/floss-weekly/104](http://twit.tv/show/floss-weekly/104 "FreeBSD")

  * What is FreeBSD? ~6:00
  * Why did she switch from Linux to BSD? ~6:30
  * Is FreeBSD Linux or Unix?  ~13:00
  * Is FreeBSD a good option for most people as a desktop? ~14:14
  * Using Mac OSX - what OS do you have under the hood? ~16:10
  * What project did Randi take on that no one else wanted? ~19:10
  * What filesystem does FreeBSD support that convinced Randel to move all his websites to FreeBSD? ~24:25
  * Are there any large companies that sponser FreeBSD?  ~ 31:00
  * How can you get involved in helping the FreeBSD community? ~38:15
  * What is Randi's opinion about "getting more women in open-source?"  ~40:00
  * What is Randi saying that is the wrong focus? ~49:00
  * Linux, Ubuntu and Fedora, have regular release cycles and then long term support, what kind of release cycles does FreeBSD have?  ~50:25
  * Would you like to try/use FreeBSD or PC-BSD?

### Lab

  Lab goes here 
 
#### Footnotes

[^64]: [http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html](http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html "POSIX Shell meta-characters")

[^65]: [http://www.linfo.org/pipe.html](http://www.linfo.org/pipe.html "History of Unix Pipes")

[^66]: [https://en.wikipedia.org/wiki/Douglas_McIlroy](https://en.wikipedia.org/wiki/Douglas_McIlroy)

[^67]: [http://www.computerhope.com/unix/uuniq.htm](http://www.computerhope.com/unix/uuniq.htm "uniq command")

[^68]: [http://www.tldp.org/LDP/abs/html/textproc.html](http://www.tldp.org/LDP/abs/html/textproc.html "cut command")

[^69]: [http://www.tldp.org/LDP/abs/html/textproc.html](http://www.tldp.org/LDP/abs/html/textproc.html "grep command")

[^70]: [https://www.gnu.org/software/grep/manual/grep.html](https://www.gnu.org/software/grep/manual/grep.html "GNU grep")

[^71]: [http://manpages.ubuntu.com/manpages/utopic/man1/mlocate.1.html](http://manpages.ubuntu.com/manpages/utopic/man1/mlocate.1.html "Locate man page")

