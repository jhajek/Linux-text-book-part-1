# Shell Variables, Meta-Characters, Search and Tools
![*The beauty of Unix Commands*](images/Chapter-Header/Chapter-06/tar-2.png "tar")

__Chapter 6 Objectives__

In this chapter we will be continuing our exploration of the commandline.  We will be expanding our exerpience of the original paradigm that Thompson and Ritchie envisioned when designing Unix.

## Chapter Objectives

   * Understand the nature of shell metacharacters and how they enhance the shell capabilities
   * Understand the concept of standard in, standard out, and standard error
   * Understand the concept of input/output redirection and piping using *"< > | tee"*
   * Understand how to search the file system for the location of files
   * Understand how to use the grep command for detailed search and replace options using shell metacharaters
   * Understand compression archive tools and their use on the command line 
   
### Chapter Outcomes

  At the conclusion of this chapter you will have a definate understand of the Linux shell and its utilities.  You will know the nature of shell meta-characters and how they can enhance the capabilities of shell commands.  You will be able to use the concepts of standard input, standard output, and standard error to redirect output as you need it.  You will understand the metacharacters used for input redirection and the concept of "|" called piping - that enables single commands to send their standard output as standard input to another command.   We will explore the __find__ and __locate__ commands that are used to find and filter files on the system.   We will use the __grep__ tool for find and replace options and advanced parsing of file content beyonf what __find__ and __locate__ can do.   FInally we will use compression tools and for creating archives and for extracting them. 

## Shell metacharacters

  In the last chapter we learned about the Linux shell and it's purpose to help the user interact with the kernel.  We learned that the GUI is just a *sugar* layer sitting on top of the shell.  We also learned a series of essential commands in order to create and maniplulate the contents of our file system.  The next layer to be introduced is something called __shell metacharacters__.  When Ken Thompson Was creating Unix and the first user shell, he quickly realized a need to be able to perform certain tasks that would be repeated often.  For example, the concept of adding a wildcard to an ```ls``` command like this: ```ls -l Do*```.  This command read a directories content and feed it any filenames that match the first two characters "Do" plus any number of other characters, (including 0 charactrers), represented with the star or asterik (*).   The concept of the shell meta-character is intended to replace you having to write a C language program each time to create this functionality.  There are 14 punctuation and non-alphanumberic characters that are standard across Linux shells[^64] - common punction/non alphanumberic characters were adopted to represent the most common repetitive tasks done on the commandline.
      
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

: The character question mark is a single character wildcard.  __Usage example:__ 
```bash
ls memo? 
```
```bash
ls vegetalbe-?-report.txt
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

\'

: single tic or single quote.  Any characters or variables surrounded by a single tic will be interpreted literally.  Unlike the previous example this command will only print the literal characters $DT not expand the variable's contents.  __Usage exmaple:__ 
```bash
echo 'Today's date is $DT'
```

\`

: back tic key to left of number 1.  The back tic is used for encasing Linux binary command names.  The back tic tells the system to interpret the command and execute it and return its value to the user for further processing. In the 2 prior examples we stored the content of the date command to a shell variable named DT. __Usage example:__ 
```bash
DT=`date`
```
```bash
CONTENTS=`cat /etc/services`
```

\[\]

: square brackets indicate sets or ranges of characters to be processed.  In a sense it is a mini-for loop for processing files names.  We can present multiple character sets or if we use ```-``` we can present a numeric or alphabetic range of values to be passed to a shell command. __Usage example:__
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

: The carot (shift+6) is a meta-character used in conjunction with the ```[]``` range brackets in order to tell the shell to look for the pattern enclosed in the brackets at the beginning of the line only. __Usage exmaple:__ 
```bash
ls [^tsq]*
```
```bash
ls [^b-d]
```

\!

: Exclamation or usually pronounced as *bang*

\~

: The tilde or tilda (shift+the key to the left of the number 1) is a shortcut representing your user's home directory. ```~-``` 

\<tab>

: Tab key is used for autocomplete. 

\\

: escape sequence


## Std in out err

0 1 2

command &>filename redirects both the stdout and the stderr of command to filename.

command >&2 redirects stdout of command to stderr.


## I/O redirect
 
  < > | tee

## find locate

## grep

## Compression and Archive tools

tar, bzip, xz

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

 FreeBSD

Listen or watch this podcast: [http://twit.tv/show/floss-weekly/104](http://twit.tv/show/floss-weekly/104 "FreeBSD")

  * What is FreeBSD? ~6:00
  * Why did she switch from Linux to BSD? ~6:30
  * Is FreeBSD Linux or Unix?  ~13:00
  * Is FreeBSD a good option for most people as a desktop? ~14:14
  * Using Mac OSX - what OS do you have under the hood? ~16:10
  * What project did Randi take on that no one else wanted? ~19:10
  * What filesystem does FreeBSD support that convinced Randel to move all his websites to FreeBSD? ~24:25
  * Are there any large companies that sponser FreeBSD?  ~ 31:00
  * How could you get involved in helping the FreeBSD community? ~38:15
  * What is Randi's opinion about "getting more women in open-source?"  ~40:00
  * What is Randi saying that is the wrong focus? ~49:00
  * Linux, Ubuntu and Fedora, have regular release cycles and then long term support, what kind of release cycles doed FreeBSD have?  ~50:25
  * Would you like to try/use FreeBSD or PC-BSD?

### Lab

  Lab goes here 
 
#### Footnotes

[^64]: [http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html](http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html "POSIX Shell metacharacters")


