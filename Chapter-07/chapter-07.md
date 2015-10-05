# Introduction to Linux Editors, Introduction to Shell Scripts, and User Profiles  
![*Real programmers...*](images/Chapter-Header/Chapter-07/real_programmers-2.png "vi")

__Chapter 7 Objectives__

  In the chapter we will be continuing our exploration of the Linux Shell.  We will be introducing editors and examining there use in managing our Linux system.  We will also look at understanding user environments and write our initial shell scripts.

*  Understand the difference between stream editors and text editors
*  Understand and learn how to use the vi editor
*  Understand how to write and use basic shell scripts
*  Understand how to use shell scripts to automate tasks
*  Understand how to modify a users profile 

__Outcomes__
 
  At the outcome of this chapter a user will be able to use the vi editor for creating and manipulating text files and shell scripts.  This will give you mastery over the data on your system.  You will be comfortable creating a shell script to automate system administration tasks and you will understand how a user's profile is modified and loaded.  This will open up the remaining chapters where we introduce additional complexity in writing shell scripts and enable greater system administration via shell scripts and using the vi editor.

## History of Unix/Linux Editors

  In the previous chapter we continued learning about essential and additional command binaries that can be executed in the shell.  We learned about meta-characters which help expand our abilities to execute repetative tasks and to simplfy searching and file creation.  The next concept to introduce is __shell scripts__.  Shell scripts are a combination of all of the above features that can be placed into a single text file and run on demand or as a scheduled task.  This allows you to have prepared __shell scripts__ that can be copied from system to sysetm allowing administrators to build up a *tool belt* of scripts that help them get common tasks done.  With that in mind, we come to the concept of the __editor__. In Unix/Linux due to the history and different types of standard in and standard out, there are also different types of editors.  The two categories are __stream__ editors and __screen editors__.  Overtime the distinction has blurred but it is safe to think in these two different categories mostly because each group retains artifacts from its development history.

### Stream Editors

   The reason we call them __stream editors__ is that at their time of development at the dawn of Unix and the dawn of commercial Unix, there modern day 30 inch screen we have, and even X for that matter, didn't exist.  So editing was done not via text editors or word processors, but it was done by editing single lines at a time.  One line would follow another line - hence a *stream*.   The two main families represented in this category are __emacs__ and __vi__.  Each of these has evolved a distinct following.  The __vi editor__ (pronounced *vee-eye*) currently is a Unix Posix standard and the only editor that you will find installed by default on all Unix and Linux distros gaurenteed.  So learning __vi__ gives you the ability create shell scripts on any Unix/Linux system.   In addition both families have a storied history.

### Emacs

 1976 on the MIT AI Lab (same place Richard Stallman came from).  GNU Emacs was released in 1984 developed by Richard Stallman himself.  1980 James Gosling (father of Java Language) created his own Emacs in the spirit of opensource, but sold his project to a company who re-licensed it with a propriatery license.  Emacs is basically a [Lisp language](https://en.wikipedia.org/wiki/Lisp_\(programming_language\) "Lisp")  interpreter focusing on macros (or key combinations) to make repeatable actions.  Emacs is a very powerful editor (see the cartoon at the beginning of the chapter) and has plugins for email and other functions to exist entirely inside of emacs.  In the course of this book we will not be focusing on emacs but that is not because of anu defficency, I recommend you to try it out at least once.   
 
> In it normal editing mode, GNU Emacs behaves like other text editors and allows the user to insert characters with the corresponding keys and to move the editing point with the arrow keys. Escape key sequences or pressing the control key and/or the meta key, alt key or super keys in conjunction with a regular key produces modified keystrokes that invoke functions from the Emacs Lisp environment. Commands such as save-buffer and save-buffers-kill-emacs combine multiple modified keystrokes [^80].
 
> GNU Emacs is an extensible, customizable text editor—and more. At its core is an interpreter for Emacs Lisp, a dialect of the Lisp programming language with extensions to support text editing. The features of GNU Emacs include[^78] [^79]:

Emacs features include: 

*  Content-sensitive editing modes, including syntax coloring, for a variety of file types including plain text, source code, and HTML.
*  Complete built-in documentation, including a tutorial for new users.
*  Full Unicode support for nearly all human languages and their scripts.
*  Highly customizable, using Emacs Lisp code or a graphical interface.
*  A large number of extensions that add other functionality, including a project planner, mail and news reader, debugger interface, calendar, and more.
  
### The vi Editor

  On the other hand, the family of the __vi editor__ is not as extensive as Emacs beign focused more on extending the original ideas behind Thompson's editor.  The __vi__ editor is written in C language but doesn't expose any of that programatically.  It's history varies widely from that of Emacs because it was not a GNU sponsored proejct.  This book will focus on the __vi editor__ exclusively but not to the detriment of GNU Emacs or GNU Nano.   

The chart below shows the history of the __vi editor__.

  Editor           Year Released              Originator
------------     ------------------------   -------------------------------------
   ed                  1971                   Ken Thompson (original Unix)
   em                  1976                   [George Coulouris](https://en.wikipedia.org/wiki/George_Coulouris_\(computer_scientist\) "George Coulouris")
   ex                  1978                   Bill Joy, Charles Haley, included in BSD 
   vi                  1978                   Bill Joy 
   vim                 1991                   [Bram Moolenaar](https://en.wikipedia.org/wiki/Bram_Moolenaar "Vim") 

Ken Thompson's original shell *ed* is still available for [download and use](http://linuxclues.blogspot.com/2012/09/ed-tutorial-line-editor-unix.html "ed")

em is The em editor was designed for display terminals and was a single-line-at-a-time visual editor

> Eventually it was observed that most ex users were spending all their time in visual mode, and thus in ex 2.0 (released as part of Second Berkeley Software Distribution in May, 1979), Joy created vi as a hard link to ex,[14] such that when invoked as vi, ex would automatically start up in its visual mode. Thus, vi is not the evolution of ex, vi is ex.

### Bill Joy and BSD

![*Bill Joy - creator of vi*](images/Chapter-07/people/384px-Bill_joy-2.png "Bill Joy") 
    
>  *"From the moment I became involved in the creation of new technologies, their ethical dimensions have concerned me, but it was only in the autumn of 1998 that I became anxiously aware of how great are the dangers facing us in the 21st century. I can date the onset of my unease to the day I met Ray Kurzweil, the deservedly famous inventor of the first reading machine for the blind and many other amazing things."*   

  In some ways Bill Joy could be seen as the west coast version of Ken Thompson.  Before Stallman left MIT and started GNU Bill Joy was working hard as a graduate student at Berkeley out in California.  He played a large part in helping to further develop BSD Unix.  Last chapter we mentioned that he created the C shell and he is also the creator of the vi editor.   He left Berkely in 1982 with 3 other grads from Stanford to form Sun Microsystems, which would play a large role in the commercial Unix world and innovated many technologies (Java). Joy stayed on t SUN until 2003.

  In the year 2000 Bill Joy wrote a seminal paper called, "[The Future Doesn't Need Us](http://archive.wired.com/wired/archive/8.04/joy_pr.html "The Future Doesn't Need Us")".  In the paper he was shocked by the speed of the scientific futurist community lead by [Ray Kurzweil](https://en.wikipedia.org/wiki/Ray_Kurzweil "Kurzweil")  and how little they were examinig ethics in the face of technological challenges. Ironically Ray Kurzweil is currently employeed by Google.
   
### vi has a Sharp learning curve 

  Many people will say that the __vi editor__ has a sharp learning curve.  It's learning curve is steep but with use vi becomes fast, elegant, and powerful.  The power of __vi editor__ is in the ability to shift modes, the ability to search and find, execute internal commands, even use grep and regex for complex pattern matching and replacement from within vi.  Keeping your fingers on the keyboard and constantly moving keeps your fingers and mind occupied.  You can think faster than you can write - this evens out the playing field.  This way you are constantly moving.  Keeping your fingers on the keyboard always speeds up your work as well.  Nothing takes more time then to "context" change. Use a mouse.  You will increase in speed and don't abandon it because it is hard.  You will eventually be working on systems that have no GUI at all (FreeBSD) Ubuntu Server RHEL CentOS Fedora Server you will have to use vi.

### vi Cheat Sheet

List about 20 neccesary commands

Input Mode vs Command Mode 

> __Example usage:__

positional commands 
a
A
i
I
o
O

line position commands
w
W
b
B
0
$
H
M
L


modify text
x
X
ndd
nyy
p
\.

Save and quit
```ESC``` ZZ
```ESC``` :w
```ESC``` :q!
```ESC``` :wq
```ESC``` :wq!

set nu
 
will number all your lines 
 


set nonu
 
turn off line numbering 

:5 jump to line 5 
:$ jump to end of file 

```ESC``` u undo
```ESC``` Ctrl + r - redo
```ESC``` Ctrl + g file info
```ESC``` Ctrl + G go to last line of file

## vi/ex Mode
After typing the ```ESC``` key then typing a __:__ colon brings you into *ex* mode.  This is where you can use grep like search and replace directly within __vi__.

/hello 

: will search forwards for the word *hello* and highlight each occurance in the file you are editing in __vi__.

?hello 

: will search the file backwords for the word *hello*.

/[Tt]opsecret.*

:  This is where we can combine shell meta-characters inside of __vi__ for searching.

?print[2-5]

:  This allows for backwards shell meta-character search.

### vi/ex Mode Find and Replace Globally

g/topsecret

:  The letter g tells us this is a global search 

s/topsecret/supersecret

:  The *s* tells us it is a single find and replace -> substitute

g/topsecret/s/supersecret

:  find out

g/topsecret/s//supersecret/g

:  find out

g/topsecret/s//supersecret/gp

:  find out

### Why keybindings are as they are

  The type of terminal and keyboard at the time was XYZ and it happened to have the ESC (escape key) in the place where the TAB key is now.  The convention just stuck with the introdcution and standardization of the IBM keyboard around 1984.

 You editing by typing a command, then call another command to have the screen update to show the result of your command. Vi's “modal editing” is evolved from this
 
Taken from [ADM-3A terminal](https://en.wikipedia.org/wiki/ADM-3A "ADM-3A") keyboard layout [^81]. 
 
![*Orginal ADM-3A Keyboard Layout*](images/Chapter-07/systems/640px-KB_Terminal_ADM3A-svg.png "ADM-3A layout") 

### Relationship of vi and vim

AT&T's UNIX System V (January, 1983) adopting vi but it was not until June, 1987 that Stevie (ST editor for VI enthusiasts), a limited vi clone appeared.[19][20] In early January, 1990, Steve Kirkendall posted a new clone of vi, Elvis, to the Usenet newsgroup comp.os.minix, aiming for a more complete and more faithful clone of vi than Stevie. It quickly attracted considerable interest in a number of enthusiast communities.[21][22] Andrew Tanenbaum quickly asked the community to decide one of these two editors to be the vi clone in Minix;[22] Elvis was chosen, and remains the vi clone for Minix today.

 But at UC Berkeley, Keith Bostic wanted a "bug for bug compatible" replacement for Joy's vi for BSD 4.4 Lite. Using Kirkendall's Elvis (version 1.8) as a starting point, Bostic created nvi, releasing it in Spring of 1994.[23] When FreeBSD and NetBSD resynchronized the 4.4-Lite2 codebase, they too switched over to Bostic's nvi, which they continue to use today.[23]

Over the years since its creation, vi became the de facto standard Unix editor and a nearly undisputed hacker favorite[citation needed] outside of MIT until the rise of Emacs after about 1984. The Single UNIX Specification specifies vi, so every conforming system must have it.

Vim is included with almost every Linux distribution (and is also shipped with every copy of Apple OS X). Vim also has a vi compatibility mode, in which Vim is more compatible with vi than it would be otherwise, although some vi features, such as open mode, are missing in Vim, even in compatibility mode. 

### The King has Left the Building

elvis and vi nvi and vim  Stevie

### Screen Editors

  The second family of editors differs from the first in that they were created after X was fully implemented and are fully screen oriented.  There is a second sub-category of screen editors called GUI editors.

* [JOE](https://en.wikipedia.org/wiki/Joe%27s_Own_Editor "Joe") 1992
* [JED](https://en.wikipedia.org/wiki/JED_\(text_editor\) "JED") 1990 
* [GNU Nano](https://en.wikipedia.org/wiki/GNU_nano "GNU Nano") 1999 

## GUI Text Editors

[gedit](https://wiki.gnome.org/Apps/Gedit "gedit")
[Visual Studio Code](https://code.visualstudio.com/Docs/?dv=linux64 "Visual Studio Code")
[mousepad](https://en.wikipedia.org/wiki/Xfce#Mousepad "Mousepad") Xfce GTK3+ 
[leafpad](http://tarot.freeshell.org/leafpad/ "Leafpad") GTK+
[Sublime](http://www.sublimetext.com/ "Sublime") Multi platform - free to evaluate but need to buy a license.
[Kate](http://kate-editor.org/about-kate/ "Kate KDE") 2001 Part of KDE environment 



http://tldp.org/LDP/abs/html/special-chars.html

cp file22.{txt,backup}
# Copies "file22.txt" to "file22.backup"



## Creating Shell Scripts



### Changing Permissions for Execution



## Scheduling Shell Scripts With Cron Tab



## Understanding .bashrc




## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

 Questions go here

### Podcast Questions

Adam Jacobs - Chef
Please listen to or view this podcast and answer these questions: 
**Warning there is a little foul language in the podcast,** but far less than a standard PG-13 movie =)

http://twit.tv/show/floss-weekly/219

  * ~3:22 What does Chef do?
  * ~7:50 What problem did Adam have with each company he was dealing with in regards to infrastructure?
  * ~9:50 Why was the project named Chef?
  * ~10:44 Sys-admins are natural whats?
  * ~11:30 Why did Chef choose Ruby instead of Perl?
  * ~12:30 Did he just really say, "Up in your grill?"
  * ~13:20 What did Adam learn about teaching people to user Chef from what he learned from beginning to play a guitar?
  * ~15:50 Using Chef what do you end up doing all day?
  * ~18:20-19:20 What is the relationship between Chef and OpsCode?
  * ~21:10 If Chef is OpenSource -- how does OpsCode make money (2 ways)?
  * ~25:30 Who are the big 3 of Configuration Management?
  * ~29:15 What is the 1st rule of automation?
  * ~32:35 What is difference between Kickstart and Chef?
  * ~37:00 What is a Chef Cookbook?
  * ~41:10 How do you describe DevOps/Web Operations?
  * ~44:35  What is the "No butthead rule?"  **note translated from French
  * ~49:00 Why is it delightful for Adam to work at OpsCode?

### Lab

https://gist.github.com/dannguyen/26e5922614dc22053745  write a script in vi that does this analysis

  complete vi tutor example

 
#### Footnotes

[^77]: <a href="https://commons.wikimedia.org/wiki/File:Bill_joy.jpg#/media/File:Bill_joy.jpg">Bill joy</a> by Original uploader was <a title="en:User:SqueakBox" class="extiw" href="//en.wikipedia.org/wiki/User:SqueakBox">SqueakBox</a> at <a class="external text" href="http://en.wikipedia.org">en.wikipedia</a> - Transferred from <a class="external text" href="http://en.wikipedia.org">en.wikipedia</a>; Transfer was stated to be made by <a title="User:Jalo" href="//commons.wikimedia.org/wiki/User:Jalo">User:Jalo</a>.. Licensed under <a title="Creative Commons Attribution 2.0" href="http://creativecommons.org/licenses/by/2.0">CC BY 2.0</a> via <a href="https://commons.wikimedia.org/wiki/">Commons</a>.

[^78]: [http://www.gnu.org/software/emacs/](http://www.gnu.org/software/emacs/ "GNU Emacs")

[^79]: <a href="https://commons.wikimedia.org/wiki/File:Emacs_Dired_buffers.png#/media/File:Emacs_Dired_buffers.png">Emacs Dired buffers</a> by Emacs development team - <a title="User:Ferk (page does not exist)" class="new" href="//commons.wikimedia.org/w/index.php?title=User:Ferk&amp;action=edit&amp;redlink=1">Ferk</a> (user who took this screenshot). Licensed under <a title="Creative Commons Attribution-Share Alike 3.0" href="http://creativecommons.org/licenses/by-sa/3.0/">CC BY-SA 3.0</a> via <a href="https://commons.wikimedia.org/wiki/">Commons</a>.

[^80]:[https://en.wikipedia.org/wiki/GNU_Emacs](https://en.wikipedia.org/wiki/GNU_Emacs "GNU Emacs"

[^81]: "<a href="https://commons.wikimedia.org/wiki/File:KB_Terminal_ADM3A.svg#/media/File:KB_Terminal_ADM3A.svg">KB Terminal ADM3A</a>" by No machine-readable author provided. <a title="User:StuartBrady" href="//commons.wikimedia.org/wiki/User:StuartBrady">StuartBrady</a> assumed (based on copyright claims). - No machine-readable source provided. Own work assumed (based on copyright claims).. Licensed under <a title="Creative Commons Attribution-Share Alike 3.0" href="http://creativecommons.org/licenses/by-sa/3.0/">CC BY-SA 3.0</a> via <a href="https://commons.wikimedia.org/wiki/">Commons</a>.

