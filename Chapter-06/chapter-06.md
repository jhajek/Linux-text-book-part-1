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

  In the last chapter we learned about the Linux shell and it's purpose to help the user interact with the kernel.  We learned that the GUI is just a *sugar* layer sitting on top of the shell.  We learned a series of essential commands in order to create and maniplulate the content of our file system.   Now we are going to extend that knowledge by introducing shell meta-characters.   In creating the shell, Thompson and other later on realized they needed to be able to perform certain features that would be repeated often.  The concept of adding a wildcard to an ```ls``` command like this: ```ls -l Do*```.   In this idea instead of having to write a C language program each time - common punction/non alphanumberic characters were adopted to represent the most common repetitive tasks done on the commandline.
    
![*User -> Shell -> Kernel -> Shell -> User*](images/Chapter-06/shells/figure2.png "User -> Shell -> Kernel -> Shell -> User") 
  When the shell parses the three components of a command there is a square that talks about variable replacement.  We sort of skimmed that part in the last chapter but here is what is happening.  

&&                   
: The ampersand character (shft-7) when doubled is an and command allowing you to string two or more commands together.  Note the && requires each succesive command to return succesfully or else the entire string will stop at the command that failed.
__Usage example:__ ```unzip -d book master.zip && cd book && cat Readme.md```

;
: Unlike the ampersand character the semi-colon __";"__ allows you to chain commands together that will execute in sequence regardless of the previous commands return status. The example command will execute and return two errors tellingyou the file or directory doesn't exist, but the third command will execute showing the data. __Usage example:__ ```ls /topsecret; cd /topsecret; date``` 

|
:  This character is called the "pipe" because it looks like a vertical bar or a piece of a pipe.  It serves the function of connecting the output of one command to the input of another commmand--not unlike a pipe under your sink.  The character is typed by pressing the shift+the key located directly above the enter key.  In this example here we display the content of the chapter-05.md and *pipe* it to the grep command which filters the file showing us only the lines containing the term *shell*. __Usage example:__ ```cat Chapter-05/chapter-05.md | grep shell```

\*
:  The asterik (shift+8) is the wildcard representative.  It can be used in any shell command when you want to let the computer to the work or when you are not quite sure of a files spelling. __Usage example:__

?
: The character question mark is a single character wildcard.

'
: single tic or single quote.  Any characters or variables surrounded by a single tic will be interpreted literally.  
 
"
: double tic or double quote. Any characters or variables surrounded by double tics will interpret shell variables that inside of the string before passing the contents to a command.

`
: back tic key to left of number 1

[]
: square brackers - range can indicate a range values to be passed to a shell command.  

()
: Parentesis

$
: Dollard sign allows for reference of shell variables

<>
: Angle brackets or less than greater than - allow for input and output to be redirected.  Think of them as arrows pointing.

{}
: Curly braces  expansion braces also for decalring variables with variables in them  ${my-name}

#
: Pound sign or hash

^
: Carot

!
: Exclamation or usually pronounced as *bang*

~
: The tilde or tilda (shift+the key to the left of the number 1) is a shortcut representing your user's home directory.  

<tab>
: Tab key is used for autocomplete. 

\
: escape sequence


## Std in out err

0 1 2

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

