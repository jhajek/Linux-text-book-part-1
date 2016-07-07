# History of Unix and Linux

![*At the end of class if your instructor has done their job, you will find this cartoon funny.  If you already understand this cartoon you get an "A".*](images/Chapter-Header/Chapter-02/open_source.png "A GNU Dawn")

## The Foundation of Unix and Linux

> [*"If you still don't like it, that's OK: that's why I'm boss. I simply know better than you do."* Linus Torvalds](http://groups.google.com/groups?selm=4sv02t%24j8g%40linux.cs.Helsinki.FI "Quote from Linus Torvalds")

As you browse this book, let me ask you a question; are you using a Linux or Unix based device?  It might seem like a strange question but you would be surprised.  Are you using an Android based phone or tablet?  Android is Linux.  Are you using OSX or macOS? The Mac operating system is BSD based under the hood.  Some pieces of this book may seem frustrating at first, after all the roots of Linux and Unix go back 30-40 years in some cases.  Understanding these concepts and what these creators were thinking will help you master the Linux environment.

__Chapter 2 Objectives__

  * Understand how and why the Unix Operating System was created 
  * Understand the contributions of Ken Thompson and Dennis Ritchie to Unix
  * Understand the contributions of Richard Stallman to Unix, Linux, GNU, and FLOSS
  * Understand the contributions of Linus Torvalds to the creation of Linux
  * Understand and explain how the AT&T and BSD lawsuit enabled the proliferation of Linux 
  * Be able to describe and differentiate the five phases of Unix maturity
  * Understand the nature of modern commercial distributions of Linux and Unix operating systems
  * Understand the principles and key differences of *"free/libre software"* and *"opensource software"*

__Outcomes__
 
 At the completion of this chapter a student will understand and be able to explain the history of the environment in which Unix and Linux were created. You will be able to relate key names; *Thompson, Ritchie, Stallman, McIlroy and Torvalds* to their respective technological contributions to free and opensource software.  You will be able to understand what a distribution is and how free and opensource software relates to proprietary software.

*Convention Note*

  In this chapter the terms Linux and Unix are generally interchangable from a conceptual standpoint. For a large part of this book the conventions are the same - their history is intertwined. Though this book focuses on Linux we would be depriving you of the spectrum of free and opensource software we left Unix and BSD out. If you are curious the name is pronounced *"Lin-ucks;"* [link to audio pronunciation,](https://upload.wikimedia.org/wikipedia/commons/0/03/Linus-linux.ogg "Pronunciation of Linux") and Unix; *"Yoo-nix."*

## Where it Began and Why it Matters Now 
 
  Unix and Linux have a unique relationship.  Similar to a square and a rectangle. Whereas a square is a rectangle but a rectangle is not a square, Linux is Unix in spirit, but Unix is not Linux.  Let's look at this in detail. The first main difference between Unix and Linux is that *"Unix"* is an entire operating system. Linux is just a kernel. An operating system can be boiled down into three main parts:   

1. __The Kernel__  [^1]
         
 ![*Kernel_Layout.svg*](images/Chapter-02/Kernel/Kernel_Layout.svg.png "Kernel Layout")
    
  Any computer operating system must contain a kernel.  In the same way all plants require a seed or a kernel to grow from.  This is a small piece of code that forms the core of your operating system.  You the user will not interact with the kernel, but devices you use, like a keyboard, mouse, touchscreen, or a WiFi network card will do so when you take any action on the system.  How do the devices talk to the kernel?  They *speak* to the kernel via *device drivers*.  As the picture describes above, the user interacts with the operating system.  The oeprating system, via drivers, interacts with the kernel.  The kernel is the hardware abstraction layer that handles all interfaces from the operating system to the hardware.  Without the concept of device drivers and a kernel, each manufacturer's computer would have to be custom made and therefore incompatible with each other.  The kernel handles other complex tasks such as memory management, task scheduling, input/output, and allocation of resources.     
  
  Take the Windows operating system for instance in which you have just one version, 7, 8, 10, etc. etc.  How many of you have an AMD processor?  Have an Intel processor?  What about kind of network card or motherboard brand? You may not even know off the top of your head.  There is no need to know because of the kernel takes care of hardware communication for you.   
  
2. __User Interface and User Tools__
 
  All operating systems need a way for a user to interface with the kernel.  This is where the *"shell"* and *"user applications"* (sometimes called user-land) come into play.  The shell is a way for the user to send commands to the operating system--which executes these commands through the kernel.  Unix originally didn't have a graphical user interface but it always had a shell, which we will cover more about in chapter 5.  Even after CRT monitors became prevalent the GUI command line shell still was the standard interface.  X Windows is the standard windowing toolkit thatallows for GUIs, *Graphical User Interfaces* to exist across Linux and Unix and will be covered more in chapter 5.     

  User tools include all tooling or commands needed to function in an operating system: copy, delete, move, make directory, kill a process, open a text editor to modify a file, issue a compile command to the C compiler, redirect output from the screen to a file, etc, etc.  
  
  User applications like a web browsers and email clients are seen as user created tooling that is an amalgamation of many smaller tools to accomplish a larger task. With out these user tools and user interface, your computer would be essentially useless with no way to interact with it.

3. __Programming Language and Compiler Tools__

  In the modern computing world we are used to installing programs via pre-compiled binaries or just clicking on an *exe* or *dmg* files for installing programs.  But before an executable file is possible that code needs to be coded and compiled.  In Unix and Linux the kernel is built using the C language.  Most of the world's software is built using the C language.  You need a C compiler to build the kernel, operating system, system applications, user tools, and any additional tools you create. Without a C compiler you cannot build or make anything.  Today most code is pre-compiled for you and you can use other languages besides C to build applications, but in the early days of Unix and Linux a C Compiler were critical to have as you were building the kernel, operating system, and all tooling from scratch.  
 
#### Linux is the same as Unix but... 
 
  Linux on the other hand, is technically not a full operating system like Unix.  It is actually just a kernel, missing items 2 and 3 from the above list. Despite this, you will hear people refer to it as an operating system.  Depending on your audience you need to know both facets.  The Linux kernel plus someone else's *User Interface and User Tools* plus a *Programming Language* and *Compiler Tools* makes up a Linux distribution or simply called for short a *Linux distro*. 

#### Who Uses Unix and Linux Today?  
  
  * [Facebook](http://royal.pingdom.com/2010/06/18/the-software-behind-facebook/ "Facebook architecture")
  * [Oracle](https://en.wikipedia.org/wiki/Oracle_Linux "Unbreakable Oracle Linux")
  * [Google](http://highscalability.com/google-architecture "You Tube Architecture" ) 
  * [Amazon](http://highscalability.com/blog/2007/9/18/amazon-architecture.html "Amazon Architecture")
  * [NYSE -New York Stock Exchange](https://en.wikipedia.org/wiki/New_York_Stock_Exchange "NYSE architecture")
  * [CME - Chicago Mercantile Exchange](https://en.wikipedia.org/wiki/Chicago_Mercantile_Exchange "CME architecture")
  * [Netflix](http://highscalability.com/blog/2015/11/9/a-360-degree-view-of-the-entire-netflix-stack.html "Netflix arch")
  * [WhatsApp](http://highscalability.com/blog/2014/2/26/the-whatsapp-architecture-facebook-bought-for-19-billion.html "whatsApp Architecture")
  * [Microsoft](https://en.wikipedia.org/wiki/History_of_Linux#Competition_from_Microsoft "2009 submitted 12,00 Lines of Code to the Linux Kernel") 
  * [Pretty much every top website except stackoverflow.com](http://highscalability.com/all-time-favorites/ "Architectures")
 
  The question is not who uses Linux and Unix but the question should be when did you last use it?  How did it get this way?  Where did it come from?  Ignore this part at your own peril. You will never understand Linux unless you understand UNIX at its core philosophies. 

### Thompson, Ritchie, and Bell Labs

  Many people supported and worked on what would become known as the Unix operating system but two names have received most of the credit for the creation, promotion, and use of Unix.  *__Know these names.__*
  
#### Ken Thompson and Dennis Ritchie 

![*Ken Thompson and Dennis Ritchie*](images/Chapter-02/People/Ken-Thompson/Ken_n_dennis.jpg "Ken and Dennis")

  Without Thompson and Ritchie[^2], there would be no Unix and most likely no Linux today.  Until recently both were employeed as Distinguished Engineers at Google.  Dennis Ritchie passed away in 2011 (same year as Steve Jobs). Ken Thompson is still working and recently help produce the [Go programming language](http://golang.org/ "Golang") while at Google.

  To begin this story we need to go back to 1968.  At the time, the combined might of all the brightest minds of General Electric, MIT, ARPA, and Bell Labs came together to try to build a multi-user operating system called *MULTICS*.  Now today those aren't names that come to mind when you think of computer companies.  Yet in 1968/1969 General Electric and the government (ARPA) were the large funders and suppliers of computing (The PC market we know of today doesn't come into existence until 1984!).

  Bell Labs at the time was basically the *"idea shop"* of the United States--where the best and brightest went to invent everything we take for granted today. Bell Labs was spun off by AT&T and became Lucent Technologies, which became Alcatel-Lucent and now is soon to be part of Nokia. One could argue that Google and Facebook have taken its place  where the brightest minds go to invent new things in America.  No wonder that Dennis Ritchie, Ken Thompson, Brian Kernighan and even James Gosling (creator of the Java programming language) are and were employees at Google.

  Like all projects that try to do too much, MULTICS stalled in gridlock between the different companies and the demands of the government.  This left one crafty engineers with much free time and (for those days) a true rarity - unused computers; PDP-7s to be exact.  Ken Thompson had an insiders view of the innovative things MULTICS was trying to accomplish and why the inner workings of the MULTICS project went wrong. Thompson also had a job to do as a Bell Labs researcher.  On his own time and down time, he began to use these PDP-7s and program his own multi-user operating system, but with a different twist.  It was designed by him, and solved daily work and coding problems he had.  This operating system and its tools was a project to help him get his own work done more efficiently.   

In 1969-70, the *"Unix"* concept had never been attempted.  Thompson had no idea that his pet work project was going to become part of a computing revolution.  Whereas MULTICS and other computer systems were designed by committees and based on marketable features--due to the nature of the up front financial investment, Unix was simple and easy to build because it solved only a small set of problems--which turned out to be the same problems every engineer had.  The overall reason that Unix took hold was that it was designed by engineers to solve other problems that engineers were having--enabling them to get work done.  This was pure genius and this is how Ken Thompson's mind worked.  

Unix differences from existing commercial Operating Systems

  * Written by Ken Thompson on his spare time
  * No company owned it or committee designed it for commercial purposes
  * Built by engineers 
  * Solved problems that engineers had
  * Had a consistent design philosophy
  * Designed to be portable and work on many hardware vendor platforms

Thompson's Unix success was also a byproduct of its main design philosophy:

  *  Everything is a file 
    + This means that everything can be read from or written to: all the way from devices to text files
    +  Yes, there are compiled binaries but you generally are not reading and writing directly to them
  *  Unix is portable
    + Tools and OS code can be recompiled for different environments because everything is written in C. 
  * I/O is redirectable between small executables 
    + Small tools that do one and only one thing well
    + Output of one command becomes the input of another command.
    + Complicated applications are built by chaining many outputs of small executables together with *pipes* -> "|"
    
  The best demonstration of these tennants was during a coding challenge issued by [Jon Bently](https://en.wikipedia.org/wiki/Jon_Bentley_\(computer_scientist\ "Jon Bently") in 1986 to:
> *Read a file of text, determine the n most frequently used words, and print out a sorted list of those words along with their frequencies.* 

  There were two main submissions to the problem.  [Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth "Donald Knuth") a preminant computer scientist, called the "father of analysis algorithms" tackled the problem by originating a ingenious new programming language, lengthy documentation, and code to solve the problem.  Comparatively, [Doug McIlroy](https://en.wikipedia.org/wiki/Douglas_McIlroy "Doug McIlroy"), who was Thompson and Rithcie's manager, wrote a six line Unix shell script to do the same work Knuth did in his massive work. We will talk more about Doug McIlroy and his controbutions to Unix in chapter 6. Here is his answer:

```bash
tr -cs A-Za-z '\n' |
tr A-Z a-z |
sort |
uniq -c |
sort -rn |
sed ${1}q
```

#### PDP-7 

![*PDP-7 restored and running*](images/Chapter-02/PDP-7/320px-Pdp7-oslo-2005.jpg "Restored PDP-7")

 Between 1970 and 1974 Unix grew from a pet project into a real product and one of its crowning achievements--its portability across hardware came to life.  Unix was originally written in assembly language for the PDP-7. It needed to be as low level code as possible because disk storage space was a *HUGE* problem in those days.  The code was good and highly optimized, but the problem with writing in low level assembly means that the code is optimized to only run on a PDP-7 system in this instance.  Not on a PDP-11 or a DEC VAX, or an IBM 360, etc, etc.  So what you gain in efficiency you lose in portability.  What good would it have been if Unix could only be used on a PDP-7[^3]? It would have stayed a Bell Labs pet project and become an obscure entry on a Wikipedia page today.
 
 While Thompson was building Unix to solve his own workloads, his fellow engineers at Bell Labs got wind of what he was doing and asked to have access to his system.  These new people contributed additional functionality to solve their work problems.  Enter Dennis Ritchie, who championed Ken Thompson's Unix in Bell Labs.  Ritchie was a computer language creator and saw the utility of Thompson's Unix, but realized it was trapped by its use of PDP-7 assembler language.  Today we take for granted high level programming languages like C, C++, Python, and Java.  In the early 1970's none of these languages existed.  Ritchie's initial work at Bell Labs was on a high level programming language that could would allow a user to write one piece of code and compile it on different computer architectures. In 1970 this was generally not possible and a radical idea. His initial work was on a [language called "B"](https://en.wikipedia.org/wiki/B_\(programming_language\) "B Language") which was derived from a language called BCPL.  B was designed to execute applications and operating system specific tasks but didn't handle numeric data (a feature designed to save precious hard drive space). B was also missing other features you would expect in a modern programming languages.  
 
 The next logical step was that Thompson and Ritchie went to work extending "B" with all the features they would need to make an operating system fully function and portable.  They called this language surprisingly, "C" -- the same "C" language you know today.  C was different from assembler in that is resembled assembler code syntax but a high enough level of abstraction that the "C" code was an independent language.  With the advent of C - Unix was rewritten in this language.  With the creation of C compilers for different hardware, Unix could now be built and be recompiled on different architectures, PDP-7, PDP-11, DEC VAX, DEC Alpha, IBM 360, SUN SPARC, eventually Intel and x86, etc, etc.  

### Assembler and C Language Comparison

[Hello World in x86 Intel Assembly for Linux](http://en.literateprograms.org/Hello_World_%28Assembly_Intel_x86_Linux%29 "x86 Linux Intel Assembly")

```nasm
section .data
msg	db	"Hello World!",0x0a

len	equ	$-msg

section .text
	global _start

_start:

  mov	ebx,0x01
	mov	ecx,msg
	mov	edx,len
	mov	eax,0x04
	int	0x80

	mov	ebx,0x00
	mov	eax,0x01
	int	0x80
```

[Hello World in x86_64 Intel Assembly for Linux](https://gist.github.com/adrianratnapala/1321776 "Linux assembly")

```nasm
hello:
	.string	"Hello world!\n"
	.globl	_start
  
_start:
        # write(1, hello, 13)
        mov     $1, %rdi
        mov     $hello, %rsi
        mov     $13, %rdx
        mov     $1, %rax 
        syscall

        # _exit(0)
        xor     %rdi, %rdi
        mov     $60, %rax
        syscall
```

[C Language equivalent of above code](https://en.wikipedia.org/wiki/List_of_Hello_world_program_examples#C "C Hello World")

```c
#include <stdio.h>

int main(void)
{
    printf("Hello, world!\n");
}
``` 
 
Since Ritchie created "C" to solve all the problems Unix had -- it became the defacto language of Unix and from that point on pretty much all operating systems are designed in "C" after Thompson and Ritchie showed that you could use a high level language to make Unix portable across many platforms.  Recently a project to restore the original UNIX assembly code from a tape and documents recovered from 1972 has begun and is [hosted on Google code](https://code.google.com/p/unix-jun72/source/browse/trunk/src/cmd/init.s "Initial Unix Code").

#### Brian Kernighan 

![*Brian Kernighan in 2012 at Bell Labs*](images/Chapter-02/People/Brian-Kernighan/320px-Brian_Kernighan_in_2012_at_Bell_Labs_2-2.jpg "Brian Kernighan in 2012 at Bell Labs")
  
  Thompson didn't have a name for his project initially, another related figure, Brian Kernighan[^4], can be credited with giving it the name UNIX.  This was a play on words--MULTI vs UNI in the name. Kernighan also helped write the original C language textbook along with Dennis Ritchie (Published in 1978, called K&R C which some of you might have used when in school).
  
![*K&R C*](images/Chapter-02/People/Brian-Kernighan/The_C_Programming_Language_First_Edition_Cover.svg.png "K&R C book cover")

## First Phase of Unix Maturity -- OS Implimentation 

By 1974/75 internal use of Unix at Bell Labs is high amongst engineers.  Word is starting to spread about it as Bell Labs engineers move on and into academia. Other Bell Labs divisions and universities got wind of this and begin to request Unix install *"tapes"* for their own use.  *Tapes* meant giant mounted magnetic tape reels that contained all the operating system code.  By law AT&T was prohibited from getting into the computer business so they took a hands-off approach to Unix at the time.  AT&T left it curiously as Thompson and Ritchie's pet project.  Many Universities at this time--wanting to teach computing and operating systems began to request copies of Unix to teach in their Operating Systems classes.  This was attractive to universities because Unix was a fully operational and working system but the main draw was that the source code was freely given away by Ken Thompson.  You sent him a letter, paid for shipping, and you got a reel within a week or so.  Thompson had no concept of "ownership" and freely shared his project with anyone who was interested.  This was evidance of free and opensource software even before the term was coined a decade later. 

In 1975 Ken Thompson took a sabbatical from Bell Labs and went back to his Alma Mater, Berkeley, in California.  Installing the Version 6 Unix Release.  The students at Berkeley loved Unix and started adding their own features to improve it to solve their own problems.  One student in 1978, Bill Joy, added vi and the C Shell (two things still in use today in modern Linux and Unix) and people started referring to the changes made to the Unix at Berkely as BSD Unix (Berkeley System Distribution Unix.)  

By 1980, with many copies of Thompson's Unix now in circulation and nearly a decade of work there started to be fragmentation of the original Unix and many universities adding on their own customizations. At this time the Berkeley System Distribution of Unix was beginning to vary widely in functionality and quality from commercial AT&T UNIX. Since the code was technically proprietary under AT&T's ownership there was no way to contribute code back to AT&T and this led to fragmentation.  Another interesting problem AT&T had was that by the end of the 70's all those students who had learned Unix in college went to work in corporations and began to request Unix to be used as their corporate hardware platforms at work. Unix was the only operating system of its kind that could do this.  Now AT&T had a financial motive to commercialize Unix.  By 1982 AT&T released Unix System III, followed by System V in 1983, as a commercial product for sale to commercial companies, while creating a multi-hundred dollar academic licensed fee for universities.  By the dawn of the 1980s the first phase of UNix maturity was complete, the operating system, its code, and its design philosphies were well proven and in wide use accross commercial enterprises and in universities. Into the 1980s the focus of Unix takes a dramatic shift to users and application creation.

## Phase Two of Unix Maturity -- Unix Users and Application Development 

  The next phase of Unix history revolves around the important work done by developers to create applications and standards around the Unix operating system to increase productivity and accesibility.  There are many people who contributed to this phase but among the names we will discuss there is none more important than Richard Stallman, also known as RMS.  

### Richard Stallman and GNU 

![*Richard Stallman*](images/Chapter-02/People/Richard-Stallman/Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG "Richard Stallman")

Richard Stallman[^5] was a researcher at MIT in the early 1980's.  He was part of what you would call today a *"hacker culture"* that was constantly researching and developing new tools and applications.  They were explorers eager to solve problems.  As Richard Stallman progressed in his studies at MIT he began to encounter events that he saw as counter intuitive to the hacker culture that had been created at MIT Artificial Intelligence lab by 1984.  THis lab had a strong culture of sharing software and ideas amongst its students, faculty, and employees.  By 1984 a number of small events began to erode this free environment.  One such issue was the introduction of account passwords for every computer user.  We take passwords for granted these days, but in the early 1980s they weren't standard issue and the implementation of them seemed draconian to users who had freely used them before. Another event which bothered Richard Stallman was the removal of the capability to modify a network printer's firmware to send an email in case of a paper jam.  

This was a large problem as the networked printer was 2 floors up from the lab and involved quite a walk. THe original printer allowed access to their firmware code and Richard Stallman improved it and added a feature to send emails when a paper jam occurred.  The next version of the printer prevented the users from inspecting the firmware and changin or modifying the code--hence locking the lab into a proprietary device.  Worse--there was no mechanism for the lab to contribute its improvement to the printer back to the company. Stallman disagreed with these concepts as they hindered the ability of the users to inspect the code and improve it to serve their needs. By 1983 Stallman began to argue that the users of the software's freedom were being trampled upon. To make matters worse, by 1984 AT&T began to withhold the source code of Unix and restricted the access of those in the academic world to be able to use the AT&T source code. Users were now beholden to the closed nature of the products they were using--even if they had paid for the software.  Stallman saw this as a moral injustice and set about making it his life's work to rectify this issue.

### The GNU Manifesto

  A plan began to hatch in Stallman's mind by late 83/84.  Since Unix was the popular operating system at the time Stallman began to make an open declaration against proprietary code, he would create a manifesto. This manifesto would reverse engineer all the functionality, capability, and tooling of Unix __BUT__ without the proprietary and restrictive licenses of commercial Unix operating systems.  There by giving the world access to a *free* (as in freedom) operating system.  He would call it __GNU__  (guh-noo) or *GNU's Not Unix*.  Everything done under the GNU project would have the source code *free* for analysis, study, modification, and redistribution. Stallman always intended *free software* to fight perceived injustices relating to softwere.  The term *free software* has nothing to do with cost or money. Through the manifesto, Stallman wanted to let people know his project was Unix-like in functionality and nomenclature but not commercially licensed Unix governed by AT&T licensing.

  He felt strongly enough to announce the GNU project publicly in the fall of 1983, and to quit his job working in the MIT lab in 1984 to avoid conflict of interests in pursuit of this work.  The [GNU Manifesto](http://www.gnu.org/gnu/manifesto.html "GNU Manifesto") was officially published on October 3rd, 1985 and issued a general call to free software arms. Here is the opening paragraph from the manifesto:
 
> __Why I Must Write GNU__

> *"I consider that the Golden Rule requires that if I like a program I must share it with other people who like it. Software sellers want to divide the users and conquer them, making each user agree not to share with others. I refuse to break solidarity with other users in this way. I cannot in good conscience sign a nondisclosure agreement or a software license agreement. For years I worked within the Artificial Intelligence Lab to resist such tendencies and other inhospitalities, but eventually they had gone too far: I could not remain in an institution where such things are done for me against my will."*
 
> *"So that I can continue to use computers without dishonor, I have decided to put together a sufficient body of free software so that I will be able to get along without any software that is not free. I have resigned from the AI Lab to deny MIT any legal excuse to prevent me from giving GNU away."*

 It is easy to write a manifesto but hard to lead a revolution they say. Stallman was one of those rare minds that could do both; a brilliant programmer who had the will and the raw skills and capability to build an entire operating system from scratch and he would get almost all the way there.

### Free Software Foundation and the GPL

 In late 1985 the [FSF](http://www.fsf.org/ "FSF") -- *Free Software Foundation*, was formed to be the holder of all the intellectual property of the GNU project with the motto:
 
 > “Our mission 
 
  to preserve, protect and promote the freedom to use, study, copy, modify, and redistribute computer software, and to defend the rights of Free Software users.”
 
#### GCC, BASH, and GNU Tools 

  In 1984 RMS started his work of creating a free Unix-like operating system.  Since Unix was built upon the C programming language, the first thing needed to build a kernel, a shell, or any tooling was a *C compiler*.  This project was called GCC (GNU C Compiler) which was a *"free"* version of the proprietary Unix AT&T "cc" program (C Compiler).  
  
  After GCC was finshed, Stallman could begin to build other tools with this *free* C compiler.  He needed an extensible text editor to edit files and with which to run GCC to build software. A few years prior, in 1981, James Gosling had created the Gosling Emacs editor; [gmacs](https://en.wikipedia.org/wiki/Gosling_Emacs "Gosling Stallman and Emacs").  We will learn more about editors in chapter 7. This name should be familiar because James Gosling would later go on to create the Java programming language while at Sun in 1994.  Stallman almost single-handedly rewrote all of Gosling's code to produce a *"free"* version of gmacs which he called GNU __Emacs__.  This program is over 30 years old and still in use and active development to this day. 
  
  The next step the GNU project took was to begin reverse engineering all the basic Unix tools and commands needed to accomplish tasks: such as [ls, grep, awk, mv, make and cp.](https://en.wikipedia.org/wiki/GNU_Project "Commands")   Eventually an entire "zoo" of projects was created and are available at [GNU's website](https://www.gnu.org "GNU Website"). [Other GNU tools](http://www.gnu.org/manual/blurbs.html) were added by contributors and volunteers over the years.  BY 1991 the GNU Bash shell was completed.  A shell is the way the user interacts with the operating system to issue command.  This was the last major tool that needed completing to have an entire function *free* Unix-like operating system.
  
  The GNU project did remarkably well in quality and quantity of *free* programs considering there were created mostly by volunteers with little funding and no corporate backing. They had pretty much reverse engineered, and in some cases improved, all the components of Unix by 1991 (8 years of work). The last thing the project was  missing was the most critical piece... they didn't have a kernel for their operating system.  Turns out that writing a kernel is much harder than it looks.  
 
#### GNU HURD -- The Kernel That Wasn't to Be

  Along with all the other GNU tooling work started in 1985, a project was started called [GNU Hurd](http://www.gnu.org/software/hurd/ "GNU Hurd"). This was to be the kernel for the GNU operating system. The name GNU Hurd is also another clever recursive hack, as the name GNU has a double meaning.  There is a [large goat like animal called a gnu](https://en.wikipedia.org/wiki/Wildebeest "GNU"), which lives in herds that roam the plains of Africa.  The name HURD came from the similarities of a herd of animals and the design of the GNU Kernel would be a "herd" of small micro-processes communicating together, like a herd of gnus (the animal).  It seems that GNU developers really love cleaver hacks.  It it something that you have to get used to in opensource as the spirit of bad puns and clever hacks has carried on to this day.
  
  Hurd made some false starts in its initial micro-kernel development phase causing multiple versions to be created and scrapped.  What they were trying to do was really innovative but really complicated and difficult to make work reliably. In retrospect HURD was never finished.  By 1998 The GNU project had all but stopped active development and promotion of GNU HURD as the kernel for its *free* operating system.  The GNU project realized that the Linux Kernel had accomplished what GNU had working on for 13 years in a mere 4 years. 
  
  GNU HURD still exists and is in a usable alpha stage. It is [downloadable today](http://www.gnu.org/software/hurd/ "GNU HURD Download") by joining it with the Debian Linux distribution applications--all GPL approved mind you. 

  The GNU project instead recommends using the Linux kernel instead and joining the GNU tools with it to form GNU/Linux.  In some ways this is the realization of Stallman's dream of a *free* operating system and yet some ways this was his biggest disappointment that Linus Torvalds and not the GNU project finished the kernel.  By 1991 a new name comes onto the scence, Linus Torvalds and the Linux kernel come along and make the next leap in the *free* and opensource operating system world by introducing the Linux kernel. 

### Free and Opensource State in the 1990s 

#### Professor Andrew Tanenbaum and Minix

  Before we talk about the Linux kernel, we need to talk about the state of other free adn opensource operating systems at this time.  One main one comes to mind: the Minix operating system.  With the closing off of the AT&T Unix source code in 1984 to academics and researchers in the university - they were left without source code to show as examples in classes.  
  
  ![*Professor Andrew S. Tanenbaum*](images/Chapter-02/People/Andrew-Tanenbaum/AndrewTanenbaum2-2.png "Professor Andrew S. Tanenbaum")
  
  [Professor Tanenbaum](http://www.cs.vu.nl/~ast/ "Tanebaum's website") [^6] was teaching at Vrije Universiteit in Amsterdam - and began to write and implement his own *free* Unix-like operating system initially for teaching and research purposes.  It was 12,000 lines of C code and system call compatible with commercial Unix.  The name [Minix](http://www.minix3.org/ "Minix 3 website") was a combination of "minimal" and "Unix."  Minix 1.0 and 1.5 were released in 1987 and 1991 respectively. Minix 1.0 and 1.5 were freely available to anyone as the source code came in the appendix to a [textbook about operating systems](https://en.wikibooks.org/wiki/Minix_3 "Minix") written by Tanenbaum in 1987.  Minix was designed to run on older x86 Intel processors (286 and 386 systems) and in version Minix 1.5 a port was included for Sun Sparc processors.  These were common desktop stations in use at the university at that time.  Any enterprising student could find and old 286 PC or old Sun Sparc Station to run Minix on. The source code for Minix 3 is currently available in a [Git repository](http://git.minix3.org/index.cgi "Minix Git") and is still being developed and researched.  In 1991 many people believed that Minix could have been a viable alternative to commercial Unix and become the still missing GNU Hurd kernel.  But the Minix creator, Professor Tanenbaum, was not interested in moving into compertition: the code was nowhere near as mature as the Unix code base, which by 1991 had been in existence for almost 20 years!  Minix appeared on the radar but was not the missing piece to the GNU puzzle.   
    
### Linus Torvalds and Linux

![*Linus Torvalds*](images/Chapter-02/People/Linus-Torvalds/320px-LinuxCon_Europe_Linus_Torvalds_03.jpg "LinuxCon Europe Linus Torvalds 03")

  In 1991, Linus Torvalds was a graduate student at the University of Helsinki in Finland.  As a student Torvalds was using Unix for his courses on the university's [Sun SparcStations](https://en.wikipedia.org/wiki/SPARCstation "SparcStations").  He was not pleased with Sun's Unix, called SunOS, but felt it was the best of the commercial Unix available.  His real dream was to run his own Unix-like operating system on his own personal PC.  He had recently purchased an Intel x386 processor based desktop PC.  Linus tried using Minix, but was put off by its minimalist approach and realized it had some good design concepts but was not a complete Unix replacement.  In a fashion not unlike Ken Thompson, Torvalds set out in the early part of 1991 to see if he could build his own kernel for his own operating system for his own use and purpose that was Unix-like but wasn't Minix.  
 
  This was very impressive feat for a single person. Torvalds himself acknowledged that if GNU Hurd had been ready for production or if at this time AT&T hadn't been suing BSD, he would have re-used their kernel work and not built his own. By August 25th of 1991 the initial release of the Linux kernel was posted online[^7].  The quote from the beginning of the chapter was the basis of the initial post to the Minix Usenet Newsgroup(A newsgroup was a bulletin board-like precursor to the actual Internet - like Google Groups in a sense--today you would use Twitter). His initial work was not quite a full-fledged system but really just a small kernel, with a port of the GNU Bash shell, and a port of the GNU C Compiler (GCC)Many things were missing, support for other processors, audio, printers, etc etc but it was like a crack in a damn - something was about to burst forth in the operating system world.
  
  By September of 1991 Linux kernel version 0.01 had been posted to the University of Helsinki FTP servers for public download.  The initial kernel included this [release note](https://www.kernel.org/pub/linux/kernel/Historic/old-versions/RELNOTES-0.01 "Linux Initial release notes") by Linus:
  
  > Sadly, a kernel by itself gets you nowhere. To get a working system you need a shell, compilers, a library etc. These are separate parts and may be under a stricter (or even looser) copyright. Most of the tools used with Linux are GNU software and are under the GNU copyleft. These tools aren't in the distribution - ask me (or GNU) for more info.
  
  By February of 1992 Linux 0.12 kernel had been released.  As more users began to download and use Linux, Linus decided to give the project a proper license for its use.  Having seen Richard Stallman speak at the University of Helsinki a few years prior, Linus was inspired and decided to release the Linux Kernel under the GPLv2 license.  This was the smartest thing anyone could have done and no one could have foresaw the great economc value the Linux kernel and GNU tools licensed under the GPL has generated for many companies.  This combination allowed Google to start and grow to its tremendous size.  This combination allowed Amazon to start up and grow to its tremendous size. 
  
  The reason why Linux is so popular is because of this fledgling kernel that worked enough for people to use, hack on, build upon, and improve now had a governance structure with the GPL that could accept code contributions and be available for commercial work as well.  Being GPL the Linux kernel was instantly compatible with all of the entire GNU project's tools base.  You instantly had the kernel that GNU was missing and the Linux kernel had all the tools and applications it needed to be usable.     
   
  People began downloading and compiling the Linux kernel, adding the GNU tools, and making fully capable Unix-like operating systems for personal use soon after commercial use.  Linus' brilliance comes not from ingenuity but comes from good engineering principals like knowing when not to go down dead-end development trails.  Torvalds' work was not perfect but was good enough that others could take it and start to use it and improve upon it.  From 1992 to 2001 the Linux kernel grew rapidly in size and features and spawned commercial companies to sell and support Linux Distributions. Stallman's dream of a complete free and opensource operating system was being realized.  
    
  This should have been cause for great celebration amongst the Linux and GNU communities.  The FSF saw this as a victory for GNU and began calling the system GNU/Linux, assuming that without the GNU tools, the Linux kernel would be useless.  The FSF assumed credit in this case.  But Linus Torvalds didn't see it that way.  He just referreed to the system as Linux.  He just ignored the FSF's requests and people referred to what should have been GNU/Linux as just Linux, leaving the GNU part out even though all of their tooling is what made Linux possible.  In a sense that is Linus' unique personality. On the other hand, Richard Stallman will not conduct any interview unless their is an agreement to only use the term GNU/Linux not Linux. Some would argue that this is Stallman's ego, but he insists he only wants credit where credit is due. This issue is still a matter of contention for the FSF today. 


#### Linux Kernel Attributes Compared to Unix OS Attributes

Creation Method      

  * Linus Torvald as a graduate student at a university
  * Thompson and Ritchie developed as Bell Labs Engineers to solve computer problems

Release Cycle

  * Linux releases a new kernel in short windows and maintains a LTS, Long Term Support Kernel version too
    + Linux distributions have to plan around this and choose which kernel to use.
  * Unix/BSD maintain a complete operating system and release everything together in a 1 to 2 year cycle

License

 *  The Linux kernel is licensed and protected under the GPLv2 and allows induviduals and corporations alike to contribute back to the Linux kernel, but source code must be open and freely available.
 *  Each BSD project is licensed under a permissiver license which allows for derivative works to be made without requiring that the source code be given back to the main project.  BSD distros do take outside contributions.
    + Commercial Unix does not take outside contributions

Tooling

  * Any Linux based operating system need to make use of a set of coretools -- usually the GNU coretools to be able to function
  * BSD/Unix may use some GNU coretools but has their own versions internally built in with the distro 

#### Linus' Personality
  
  Some people think Linus' personality is a shtick or a comedy act he puts on.  But whatever it is he is very straight forward in dealing with people, and will not spare anyone a harsh public rebuking if he thinks they made a sloppy mistake.  He justifies this as kernel work is hard and you need to be prepared to take difficult criticism if you are going to survive here. Some consider Linus really mean and even aggressively mean spirited to those with whom he has disagreements.  When approached about this, Linus states that he only cares about the kernel and no one else matters to him.  These links below provide some points and counter points about Linus.  
  
*  [Torvalds' right to offend](http://www.wired.com/2013/07/linus-torvalds-right-to-offend/ "rights")
*  [Torvalds doesn't care](http://arstechnica.com/business/2015/01/linus-torvalds-on-why-he-isnt-nice-i-dont-care-about-you/ "Doesn't care")
*  [Linus' response to previous article](http://arstechnica.com/business/2015/01/linus-torvalds-responds-to-ars-about-diversity-niceness-in-open-source/ "Response")

### AT&T and BSD Lawsuit 

  The nacent Linux project saw a rush of growth and developer contribution from August of 1991 to February of 1992. But where did all these developers come from?  At this time we need to go back to Berkeley University and check in on the BSD project, (Berkeley System Distribution).  In the late 80s and up to the early 1990s BSD Unix development had been flourishing at Berkeley.  Some would attribute this to great minds and an open environement, some would attribute it to lots of government funding.  Either way the product produced therte began to eclipse the commercial AT&T Unix in features and quality.  BSD began to significantly and irreconcialably differ from AT&T Unix. 
  
  AT&T seeing this decided in the early 1992 to take the BSD project to court.  Since BSD technically came from AT&T Unix back in 1976, when Ken Thompson took his sabattical at Berkely and brought the then pet project AT&T Unix with him. AT&T found that some of the BSD code was actually AT&T copywritten code and property. In early 1992 AT&T was granted a court ordered development injunction against the BSD project while in court, preventing work from being done on BSD Unix.  This was the perfect time for Linux kernel development to flourish, protected by the GPL, there were no licensing or copyright issues to worry about. BSD developers in droves flocked to the Linux project. By the time the lawsuit was finished in late 1993/1994 it was too late.  All that had happened was that BSD no longer use the term Unix to describe itself an they had to rewrite a handful of programs to remove the AT&T code.  AT&T had succeded in planting the seed for the growth of the entire Linux industry with this action. The Linux rocket had left the launch pad and was never coming back. 

  After the BSD and AT&T lawsuit was settled the BSD code base split into three and then four main distribution families--each with their own focus but all common enough to share code between them. Also they are free of any contention with commercially licensed Unix and usable for enterprise work. Unlike Linux, BSD lacks a major corporate sponsored distribution, like Ubuntu or Red hat.  All are maintained by volunteer organizations. 

  *  FreeBSD
    + DragonFlyBSD
  *  OpenBSD
  *  NetBSD

## Third Phase of Unix Maturity - Free and Opensource Software Enter the Enterprise 

### Free Software vs. Opensource Software

By the end of the 90s a curious thing was happening; Microsoft had a near total domination of the desktop PC operating system market and was being investigated by the US Department of Justice for anti-competetive practices. Apple had just brought Steve Jobs back as CEO and was beginning to take steps towards recovering from a decade of mediocre performance.  The internet as an item we recognize today was just beginning to take root in homes accross America through dialup services like [AOL](https://en.wikipedia.org/wiki/AOL "AOL"), [Compuserve](https://en.wikipedia.org/wiki/CompuServe "Compuserve"), and [Prodigy](https://en.wikipedia.org/wiki/Prodigy_\(online_service\) "Prodigy"). At the same time, the quality of free and opensource software was increasing.  The internet was being powered by webservers and databases.  Opensource tools such as Apache Webserver and MySQL database beame the *killer apps* to use on Linux or BSD to run these applications.

The term opensource software is prevasive today but in 1998, it didn't exist.  The term *free software* had existed since 1985, but because of the ambiguity of the English word *free* it became associated with zero-cost free and not freedom free.  The term *free* can also give the potential idea of cheap or shoddy work--compared to professional propriatery work and the enterprise would not touch it.  

The term *opensource* was not a movement away from the principles of *free software* but a chance to show the enterprise that the opensource development model was sustainable and could produce superior products.  In order to better understand the difference we need to meet some of the key players. Enter Eric S. Raymond.

#### Eric S. Raymond 

![*Eric S. Raymond*](images/Chapter-02/People/Eric-Raymond/256px-Eric_S_Raymond_portrait.jpg "Eric S. Raymond")

Eric S. Raymond[^8] had long been a free software developer and part of the hacker community. Raymond's most famous contribution to opensource is writing a seminal paper that was later reprinted in book form called, [__"The Cathedral and the Bazaar"__](http://www.catb.org/~esr/writings/cathedral-bazaar/introduction/ "The Cathedral and the Bazaar")  

  His main point was that by business-as-usual practices Linux should have been a massive failure and a poorly implemented experiment.  But instead it was an unprecedented success because of the opensource development method.  His article examined why this is the case comparing the cathedral like design of Emacs and GCC--open but not publically available during development versus Linux bazaar style development of everything publicly open and availalbe at all time via the internet.  
  
  His conclusion was that the open source code and open design methodology of treating your user as a valued resource was vital to an opensource projects success.  Based on this Raymond and [Bruce Perens](https://en.wikipedia.org/wiki/Bruce_Perens "Bruce Perens") founded the [Open Source Initiative (OSI)](http://opensource.org/ "OSI") and were part of the group that in 1998 coing the term "opensource". Their goal was to continue to promote free software but instead of focusing on the moral issue of software freedom, they focused on the design principals as producing superior software.  A quote from Raymond puts his opinion bluntly;
 
 > *As head of the Open Source Initiative, he (Raymond) argued that advocates should focus on the potential for better products. "The "very seductive" moral and ethical rhetoric of Richard Stallman and the Free Software Foundation fails, he said, "not because his principles are wrong, but because that kind of language ... simply does not persuade anybody".* 
 > [Eric S. Raymond](https://en.wikipedia.org/wiki/Eric_S._Raymond#Open_source "Quote")

  The "Cathedral and the Bazaar" was influential in helping the Netscape Corporation opensource their Netscape Web Browser code before the company was sold to AOL, under the name of the Mozilla project.  This code gave rise to what would eventually become the Firefox web browser in 2002--thanks to Raymond's writings.  
  
  The OSI was willing to make freedom compromises in order to make larger productivity gains with opensource software. The FSF will not compromise. Richard Stallman fired back in his article ["Open Source Misses the Point"](http://www.gnu.org/philosophy/open-source-misses-the-point.html "Open Source Misses the Point") The terms do overlap, but Free Software and opensource but ultimately have two divergent meanings.  
  
  There has been some compromise in the naming __FLOSS__--[*Free Libre and Open Source Software*](https://en.wikipedia.org/wiki/Free_software_movement "FLOSS"), but the FSF rejects any licensing that allows a user to restrict the users right of "freedom."  One way to conceptualize the difference is would be to look at the concept of [DRM software](https://en.wikipedia.org/wiki/Digital_rights_management "DRM"), which is basically the copy protection schemes on DVDs.  The OSI group would not be opposed to push for open source DRM software.  But the FSF would be opposed to the entire concept of DRM--which is a tool they believe restricts a user's freedom to play their DVD anywhere and in any way. 

 You can read Raymond's two seminal books on Unix and opensource philosophy online as they are free and opensource: 

  * [The Art of Unix Usability](http://www.catb.org/~esr/writings/taouu/html/ "Book link")
  * [The Cathedral and the Bazaar](http://www.catb.org/~esr/writings/cathedral-bazaar/ "CatB")

## Fourth Phase of Unix Maturity - The Rise of Commercial Linux 

  As the 1990s came to a close we began to see established companies adopting and using opensource projects in enterprise, such as MySQL for database and GCC as a C/C++ compiler.  Especially we begin to see companies trying to make commercial distributions of Linux by adding the GNU coretools and a GUI interface.  Of all the Linux companies that started at that time, Red Hat Linux is one of the few remaining and by far the most successful.  Most of all of the Linux distributions started pre-2003 no longer exist.  To illustrate this, as of August 10th 2015, Red Hat Linux has a market cap of [~14 billion dollars.](http://ycharts.com/companies/RHT/market_cap "Red Hat Market Cap")  

### The Rise of Commercial Linux and Modern Linux Distributions

  As corporations became more involved in Linux kernel development, the value proposition of Linux began to grow as well.  The combination of the Linux kernel and the GNU tools, plus GUI tools became known a Linux distribution, also known as a *distro* - which anyone could freely make.  Each distribution flavors, derivatives, or spins as well. 
  
  Today we have almost 20 years of Linux Kernel work and distribution work. Essentially Linux distributions hail from two distinct families: Debian and Red Hat.   There are many other quality distributions of Linux that I don't want to leave out or paint in a bad light.  For the purposes of this book I will focus on the two main distributions.  You can find almost all known Linux distributions at [http://distrowatch.com](http://distrowatch.com/ "Distro Watch")
  
   *  [Slackware](http://www.slackware.com/info/ "Slackware")
   *  [Gentoo Linux](https://www.gentoo.org/get-started/about/ "Gentoo Linux")
   *  [SUSE Linux](https://en.wikipedia.org/wiki/SUSE_Linux_distributions "SUSE Linux")
   *  [Kali Linux](https://www.kali.org/ "Kali Linux") - Hacking tool based Debian distro
   *  [antiX Linux](http://antix.mepis.org/index.php?title=Main_Page "antiX") - lightweight Debian derivative focused on old machines.
   *  [Arch Linux](https://www.archlinux.org/ "Arch Linux")
   *  [Tails Linux](https://tails.boum.org/ "Tails Linux") - Online security focused Debian based distro
   *  and many more at [http://www.distrowatch.com](http://www.distrowatch.com "Distro Watch") 
  
### The Debian-based Family

![*Ian Murdock - founder of The Debian Project*](images/Chapter-02/People/Ian-Murdock/256px-IanMurdock.jpg "Ian Murdock")  
  
>*"I founded Debian in 1993. Debian was one of the first Linux distributions and also one of the most successful and influential open source projects ever launched. Debian pioneered a number of ideas commonplace today, including employing an open community that allowed (and encouraged!) anyone to contribute (much like how Wikipedia would later operate). And, with its integrated software repositories anyone could contribute to, Debian arguably had the industry’s first (albeit primitive) “App Store”. Today, more than 1,000 people are involved in Debian development, and there are millions of Debian users worldwide."* - [http://ianmurdock.com](http://ianmurdock.com) 

Unfortunately on December 31st, 2015, Ian Murdock succumbed to mental illness and took his own brilliant life. Bruce Perens eulogized him in this post: [https://perens.com/blog/2015/12/31/ian-murdock-dead/](https://perens.com/blog/2015/12/31/ian-murdock-dead/ "Ian Murdock").

The Debian family contains 4 major sub-families: [^9]

#### Debian

![*Debian*](images/Chapter-02/Linux-logos/Debian/109px-Debian-OpenLogo.svg.png "Debian Logo")

The Debian distribution (pronounced *"dehb-ian"* officially but sometimes the stress is put on the first syllable and you will hear *"dee-be-an"*) was founded in 1993 By Ian Murdock and is unique for being one of the only non-commercially backed Linux distros still in existence.  The current release is Debian 8.5 codenamed Jessie, as of June 2016.  The Debian project and its history can be found at [http://debian.org](https://www.debian.org/intro/about) and at the [history of Debian](https://www.debian.org/doc/manuals/project-history). There are [currently 122 major Debian based distros](http://distrowatch.com/search.php?ostype=All&category=All&origin=All&basedon=Debian&notbasedon=None&desktop=All&architecture=All&status=Active "Debian based distros") in existance according to distrowatch.com.
 
 These are the main points of Debian distro and the key I believe to their long term success and usage across the Linux landscape:
   
   * Initial release schedule was yearly but as Debian project has grown now is two year release schedule
   * Releases are named after characters from the Toy Story movie.
   * It is the only major distribution not backed by a corporation.  
   * All volunteer project and organization -- project leader is elected on a rotating basis
   * Dedicated to protecting software rights and freedoms of users
   * First major distribution to come with a [Software contract](https://www.debian.org/social_contract "Contract") - of what the project will guarantee to the user.
   * Debian supports free and opensource software as superior to closed source but will allow for closed source software/drivers to be installed by the user. 
   * Supported at various times 11 different processor types giving it a wide install base. 
 
#### Ubuntu 

![*Ubuntu Linux*](images/Chapter-02/Linux-logos/Ubuntu/128px-Ubuntu_logo_copyleft_1.svg.png "Ubuntu Linux")
 
   Ubuntu Linux is a unique distribution [^10].  It is entirely based on Debian.  It is Debian repackaged with a focus on applications "just working."  Around 2004, [Mark Shuttleworth](https://en.wikipedia.org/wiki/Mark_Shuttleworth), the founder of Ubuntu, was unnerved that Windows had such a domination of the PC market.  He had been a Debian developer, but felt that the partial lack of a corporate sponsor in some ways hindered Debian from catching the market share from Windows.  He set out to make a Debian based distro called Ubuntu.  This is a Zulu word for *"community"* as Shuttleworth wanted Linux to be people friendly and work really well out of the box--like Windows.  
   
   By 2004 Red Hat, who had owned the desktop Linux market realized that there was little money to be made in that market so they abandoned it deciding to focus on the enterprise market.  This left a void that Ubuntu rushed to fill and they did it well. By 2005, Mark Shuttleworth who had started the Thwate SSL security company which was bought out by Verisign, took his money and invested 10 million dollars in the Ubuntu Foundation to subsidize the creation and maintenance of Ubuntu Linux.  
   
![*Mark Shuttleworth*](images/Chapter-02/People/Mark-Shuttleworth/128px-Mark_Shuttleworth_by_Martin_Schmitt.jpg "Mark Shuttleworth")
   
   What made Ubuntu so successful was that they forked the opensource work of rock-solid Debian but built on top of it adding in closed source code and user centered features where necessary in order to make the best experience.  They had business in mind and have indeed captured the desktop Linux market.  But one problem is they haven't found a way to make much money off of their excellent product.  Ubuntu has a 10 million dollar parachute in the form of the Ubuntu Foundation which was seeded by Mark Shuttleworth [^11]. Shuttleworth formed a commercial company called [Canonical](http://www.canonical.com/ "Cannonical") that was formed to handle commercial support and hires the developers who work on Ubuntu.  
   
   Ubuntu pioneered the idea of rolling releases - releasing every 6 months compared to Microsoft doing 3 to 5 years.  Each distribution is released in late April and late October so there are two distributions per year.  Ubuntu also introduced the concept of an LTS, Long Term Support - this means that certain releases will have security patches, fixes, and software backported to it for 5 years, allowing you to base an enterprise business off of this product and have the stability you need.  These LTS releases happen every even year and in the April distribution.  So Ubuntu 10.04, 12.04, 14.04, 16.04, and so forth. (the first number being the year.)
  
#### Linux Mint 
 
![*Linux Mint*](images/Chapter-02/Linux-logos/LinuxMint/256px-Linux_Mint_logo_and_wordmark.svg.png "Linux Mint")
       
   Linux Mint started also in 2006 as a fork of the Ubuntu project but with a different desktop interface [^12].  Linux Mint focused foremost on the user and desktop experience out of the box adding multimedia codecs for playback of audio and video directly to the install (see Flash).  Linux Mint is even more user experience focused than Ubuntu and is one of the most popular Ubuntu based distros.  Linux Mint can be considered a sub-family because although it is Ubuntu based, Mint makes usability choices that are the opposite of what Ubuntu chooses. There by leading to a different operating system.

#### Devuan 

![*Devuan Linux*](images/Chapter-02/Linux-logos/Devuan/Devuan-logo.png "Devuan")

  [Devuan Linux Project](http://www.devuan.org "Devuan") (Pronounced *Dev-one*) is a fork of the entire Debian project - not just a Debian based distro.  This is a result of a "Debian Civil War" with half of the Debian developers leaving in the Debian project in the beginning of 2015 to begin this distribution from scratch.  It is a direct fork with fundamental changes to the core operating system.  Other distros change application look and feel but to change the core operating system is a monumental task.  The state of the OS is in late Alpha or early beta as of August 2015 with VM images available for download.  We will talk about this more in detail under the topic "Linux Civil War" later in this chapter. 

#### Other Debian Based Distros

Some of the other notable Debian/Ubuntu based distros are as follows:
   
   *  [Xubuntu](http://xubuntu.org "Xubuntu")
   *  [Lubuntu](http://lubuntu.net "Lubuntu") 
   *  [Kubuntu](http://www.kubuntu.org/ "Kubuntu") Ubuntu remixed with the KDE desktop Environment
   *  [SteamOS](http://store.steampowered.com/steamos "SteamOS") Steam online gaming company's official Linux distro
   *  [Kylin Linux](http://distrowatch.com/ubuntukylin "Kylin Linux") Ubuntu Distro designed for Mandarin Chinese as opposed to English.
   *  [Raspian](http://www.raspbian.org/ "Raspian") This is a Debian based distro that is standard recommended for the Raspberry Pi.
   *  [gNewSense](http://gnewsense.org "gNewSense") GNU/Linux FSF distro, entirely GPL compliant software.
   *  [trisquel](https://trisquel.info "Tri-skel") FSF and Richard Stallman use this one, entirely GPL compliant.

### Red Hat Family
    
Red Hat Linux was formed shortly after the Debian project launched in 1995 Marc Ewing and Bob Young.  Red Hat source code is currently shared across three main distributions: Fedora, RHEL (Red Hat Enterprise Linux), and CentOS. You can read more about Red Hat from their website:
   
  *  [About Red Hat](http://www.redhat.com/en/about/company)
  *  [Red Hat History](http://www.redhat.com/infographics/corporate/data/ "Red Hat History")
  
#### Fedora Project

![*Fedora Project*](images/Chapter-02/Linux-logos/Fedora/768px-Logo_Fedora_full.svg-96dpi.png "Fedora Project")
 
   The [Fedora Project](https://en.wikipedia.org/wiki/Fedora_Project "Fedora Project") was started in 2003 when the Red Hat Desktop Linux product was merged with the company/community based spin off Fedora Core Linux [^13].  The [Fedora Project's](https://getfedora.org/ "Get Fedora") focus was rapid development and rapid release.  They would release two distributions almost yearly, with package and update support only extending back to the previous version cutting off support to viable but from Red Hat's point of view outdated software.  Remember their focus was rapid iteration of the project to quickly test new technologies.  
   
   For example Fedora 24 was released on 06/21/15, Fedora 23 was released on 11/03/15, Fedora 22 was released on 05/26/2015, Fedora 21 was released 12/09/2014, and Fedora 20 was released 12/17/2013.  Fedora 20-22 are no longer supported anymore - even though they released within the last two years! Why is the Fedora Project so fast and so merciless on not supporting older versions?  This distribution was meant for desktop users and developers who don't mind updating rapidly.  The reason for this iteration is that the Fedora Project is really just a testing ground for technology that will eventually go into Red Hat's enterprise project, referred to as RHEL. 
   
   Currently there are [25 Fedora based distros](http://distrowatch.com/search.php?ostype=All&category=All&origin=All&basedon=Fedora&notbasedon=None&desktop=All&architecture=All&package=All&status=Active) or Fedora calls them *"spins"* -- this term is unique to Fedora.
  
#### Red Hat Enterprise Linux--RHEL

![*RHEL*](images/Chapter-02/Linux-logos/RHEL/320px-RedHat.svg.png "RHEL")
  
   Red Hat began to see the opportunity to create a Linux distro targeting enterprises and make money using opensource at the time.  A big market that was practically cornered by two companies were Java based applications and database servers - MySQL and Oracle.  These markets had been the domain of Sun and its Unix based Solaris Operating System for years, as well as Microsoft running Oracle on Windows.  RHEL could enter that market, running the same applications, and do it on cheaper Intel x86 based boxes.  With Oracle announcing it would port its products to RHEL, this platform became to the go to choice as the alternative against Microsoft and helped put Sun and Solaris basically out of business.  The acronym __RHEL__ stands for Red Hat Enterprise Linux.  

  The key to RHEL's success in the enterprise is its long term stability.  Much like the version of Windows Servers it competes with - the application platform is expected to run for 5+ years.  An enterprise grade server product cannot be changing every six months like the Fedora project.  Red Hat instead takes "snapshots" from Fedora and freezes them in time.  As of today (fall 2015) the current version of RHEL is 7.1 which is a freeze of the technology from Fedora 19, which was released July of 2013.  This way the developers get to know the platform and software versions that will be maintained and supported long term. How successful is this strategy? By 2012 they became the first Linux based company to make a billion dollars in a physical year.  But this success brought about a serious opensource question, if you have a successful product like RHEL, since you are using GPL based opensource code--you have to opensource your code--that means anyone else can redistribute your code freely, in theory eating your lunch.     
 
#### CentOS
  
![*CentOS*](images/Chapter-02/Linux-logos/CentOS/CentOS_Logotype.png "CentOS logo")
    
  By 2004 many people began to see the utility and success of Red Hat Linux, and being opensource they began to fork the code and make their own distributions.  CentOS is one of them [^14].  By 2010 they emerged as one of the two remaining RHEL derivatives.  Their developers, like Debian, are entirely volunteer based and not backed by a company.  Their motive was to take the solidness of RHEL and just update a few features and add more modern software packages sooner then the 5 year RHEL cycle.   Initially Red Hat didn't support CentOS--taking them to court numerous times, as CentOS had not removed all of Red Hat's trademarked logos in all the code.  Eventually all of Red Hat's copyrighted material was removed and CentOS has a legal copy of RHEL to redistribute and use.  This made Red Hat angry as they were loosing sales to enterprises using CentOS instead of RHEL.  By 2014, Red Hat and Centos came to terms to work together--with Red Hat offering to sell support contracts to CentOS users.  Is CentOS doing anything illegal?  Not according to the GPL and the spirit of opensource, but it does bring up the financial issue again.
   
#### Oracle Linux
      
  Did you think that Oracle Linux would allow their logo to be displayed under an open license? Not to be out done.  Oracle who saw that many of their customers were paying Red Hat for operating systems licenses, buying support contracts, and then running their database on top of it wanted a piece of the action.  Oracle now owns Java--which is the primary tool used to interface with all the Oracle and its supporting products.  Oracle made a fork of RHEL's opensource code and placed their logos, Oracle specific tools, and made their own software tweaks in this fork and called it Oracle Linux.
  
 [Oracle Linux](https://en.wikipedia.org/wiki/Oracle_Linux) was born in 2007 and is a fully GPL compliant OS.  Oracle claims that their *"Unbreakable Enterprise Kernel"* is fully compatible with RHEL, and that Oracle middleware and third-party RHEL-certified applications can install and run unchanged. One may ask, isn't this illegal? Is Oracle breaking the law?  Not according to the GPL - they are fully entitled to do this and thus compete with Red Hat selling support contracts on Red Hat's created software--this is the nature of the GPL license.   
    
### Unix and the BSD Family Distros
  
  While Linux was exploding in the mid 1990's the AT&T lawsuit against BSD had been settled and work could resume of the BSD forks of Unix.  Unfortunately the BSD code splintered into 4 main distros pulling the already thin developer group that hadn't shifted to Linux development, even thinner. Although these are not Linux distributions they are worth mentioning since they share the same space and operate under similar opensource licenses.
  
![*FreeBSD*](images/Chapter-02/Linux-logos/FreeBSD/128px-Freebsd_logo.svg.png "FreeBSD")
   
   * Released in November 1994
   * Essentially the inheritor of the BSD code base
   * Largest BSD implementation.
   * Legally prohibited from using the term *"Unix"* as outcome of AT&T lawsuit.
     
#### PC-BSD

   *  FreeBSD based distro with a focus on user interface and experience. 
   *  Provides friendly installers and package managers for users 
   *  Created new Lightweight desktop environment called [Lumina](http://lumina-desktop.org/)

#### Ghost BSD

   *  FreeBSD based distro with a focus on user interface and experience. 
   *  Provides friendly installers and package managers for users
   *  Tries to match the usability of Mac or Windows with the foundation and principals of FreeBSD

#### DragonFly BSD 

![*DragonFly BSD*](http://www.dragonflybsd.org/images/small_logo.png)
   
   * Fork of FreeBSD in April of 2005 by Matthew Dillon.
   * Focused on unique techniques in handling multiprocessing in the FreeBSD kernel
   * Introduced a new filesystem called [HAMMER](https://en.wikipedia.org/wiki/HAMMER "HAMMER FS") and HAMMER2

#### OpenBSD
   
 ![*OpenBSD*](images/Chapter-02/Linux-logos/OpenBSD/128px-OpenBSD_Logo_-_Cartoon_Puffy_with_textual_logo_below.svg.png "OpenBSD") 

   * Theo de Raadt was banned/left from the NetBSD project in 1994.
     + He complained that they were developing too slow and not focusing on security.
   * Started a fork of NetBSD at the end of 1995   
   * OpenSSH, OpenNTPD, OpenSMTPD, LibreSSL, OpenBGPD, and [others](http://www.openbsd.org/innovations.html "BSD Innovaations") comes out of this project.
     + [Microsoft recently became the first "gold sponsor" of the project](http://undeadly.org/cgi?action=article&sid=20150708134520)
     + Recognizing the standard of SSH (secure shell) they are moving to port and integrate SSH nativly to Windows. 
   * Project is focused on radical implementations of security and safe coding practices--leveraging itself as the most secure OS.

#### NetBSD

![*NetBSD*](images/Chapter-02/Linux-logos/NetBSD/128px-NetBSD.svg.png "NetBSD") 
   
   * Released October of 1994 as another version of the BSD code after the lawsuit.
   * Focuses on portability to run this OS on nearly every platform you can think of.
   
#### Minix 3 
   
   * [__Minix 3__](https://en.wikipedia.org/wiki/MINIX_3 "Minix 3") released October of 2005 
   * Since then the OS went from a teaching tool to a product being used commercially.
   * Began using NetBSD user space applications to give it a GUI and make it a viable commercial product. 

### Solaris Based Unix Distros
        
#### OpenSolaris 
     
![*OpenSolaris*](images/Chapter-02/Linux-logos/OpenSolaris/128px-OpenSolaris_Logo-2.svg.png "Open Solaris")

   * In 2006 Sun had experimented with creating and opensource user based distro from their Unix based Solaris OS [^16]
   * They hired Ian Murdock (the guy who started Debian) to oversee this project
   * Project was called OpenSolaris but was killed when Oracle purchased Sun in 2010
   * [Explanation of how OpenSolaris forked](http://www.slideshare.net/bcantrill/fork-yeah-the-rise-and-development-of-illumos "Fork")
 
#### OpenIndiana 
   
![*Open Indiana*](images/Chapter-02/Linux-logos/OpenSolaris/128px-OpenIndiana_logo_large-2.svg.png "Open Indiana")
       
   *  All the OpenSolaris developers left Oracle soon after the purchase and continued the OpenSolaris spirit with this project [^15]
   *  Eventually all the technologies that had been forked were moved into a project called Illumios - which was not a distro but a reference implementation.
      
#### SmartOS   
   
  *  [SmartOS](https://smartos.org/ "SmartOS") released by Joyent and full of ex-Sun engineers who worked on Solaris. [^17]  
      + Combines the best of the BSD/Solaris products but runs the best of Linux based desktop applications and software--especially the KVM Virtualization Platform
        
### The Impending Linux Civil War?

![*Lennart Poettering*](images/Chapter-02/People/Lennart-Poettering/640px-Lennart_poettering-2.jpg "Lennart Poettering")

  Not since Linux Torvalds has a man been so loved or reviled in the Linux community.  Lennart is a name you need to know as well [^18].  He is currently a developer for Red Hat, but has also developed [PulseAudio](https://en.wikipedia.org/wiki/PulseAudio "pulse") and [Avahi](https://en.wikipedia.org/wiki/Avahi_(software) "Avahi")--network discovery demon.  His current project is systemd.  Systemd is a replacement for the traditional SysVinit program that started all of the Operating Systems process upon boot.  
  
  Poettering has angered many people by breaking certain Unix traditions and conventions in the name of speed and features.  The Unix philosophy of having little programs do one thing well goes right out the window. Poettering argues that philosophy is a byproduct of an era where computing was slow and disk space was precious.  If Linux wants to be taken serious like Mac and Windows, these changes are not only necessary but actually closer to the core Unix philosophy then what is currently in place.  Lennart Poettering along with [Kay Sievers](https://en.wikipedia.org/wiki/Kay_Sievers "Sievers") are leading the systemd charge as the lead developers.  Through out this book we will investigate their technology, and while impressive, needs to be examined in closer detail.  
  
  The other major point of contention is with all the changes in systemd to the boot process, many other pieces of software need to change as well.  Linux has always been about choice but the GNOME desktop developers have chosen to hard link/integrate with systemd. Meaning that if your operating system uses systemd instead of SysVinit - then you are basically forced to use GNOME3 as a Desktop environemnt as it has become a dependency of systemd.
  
  This leads to an interesting point.  All major distros have moved to systemd.  Debian was the last hold out and they actually had a civil war and split over this issue.  Half of the developers left and went to form a distro called [Devuan](http://www.devuan.org "devuan")--which is focusing on removing all the systemd and udev dependencies and putting choice back in the user's hand.
  
  Systemd has many nice and needed features.  Leonart is updating pieces of Linux that haven't been touched in ages. He even wrote a [21 part defense](http://0pointer.de/blog/projects/systemd-for-admins-1.html "21") of systemd on his website. I will talk more on the technical aspects of systemd in the chapter 11.
     
  The fears of Linux users are that systemd will grab dependencies and eventually force Linux users into a small sub-section of systemd supported software only choices. Some of the conspiracy theorists believe that since Red Hat could not coerce Linus Torvalds under their wing, that they will just innovate around him. In a sense create a vendor lock in.  Could this be a [*"embrace, extend, and extinguish"*](https://en.wikipedia.org/wiki/Embrace,_extend_and_extinguish "Embrace, extend, and extinguish") tactic that Oracle and Microsoft were once so famous for conducting on rival technologies?  What makes this all the more intriguing is that Lennart works for Red Hat.  Would Red Hat mind if this systemd technology improved the Linux experience at the cost of choice of software and freedom available to the user?  That is a good question.  This also begs the question - can Linux survive as an independent and open software project or does it need a commercial company backing it?  Or could this be seen as Red Hat's grab for the entire Linux market?  It is too early to tell but keep a watch on what happens with systemd.

## Chapter Conclusion and Summary

  Wow - we covered a lot of history -- but it is important to the understand the current state of Linux usage.
  [Learn more about opensource licensing](http://www.openlogic.com/resources/enterprise-blog/archive/open-source-license-interpretation-made-easy)

   [Additional Reading on the Unix history side](http://www.oreilly.com/openbook/opensources/book/kirkmck.html "History of Unix")

### Review Questions

Get into groups and answer/discuss these questions

1. Based on the movie's tone and time - why would you think there was a definite anti-Microsoft tone at the time of the movies making (~2002)?

1. What influence did Bill Gates' 1976 *"Open Letter to Hobbyists"* have later on for the Free Software/Opensource movement, if any?

1. Would Richard Stallman enter into a discussion on which is a better product: Microsoft Word or LibreOffice Writer? Why or why not?

1. Would Eric S. Raymond enter into a discussion on which is a better product: Microsoft Word or LibreOffice Writer? Why or why not?

1. Why did Bruce Perens help write the Open Source Definition / Debian Social Contract Standard?

1. What were the two commercial Linux companies featured in the movie?

1. What is Red Hat Linux's stock price today?

1. What is VA Linux's stock price today?

1. How does Richard Stallman react at the end of the movie of the success of the Linux kernel to the exclusion of the GNU tools?  

1. What is the main argument between *"Free Software"* and *"Open Source"*?

### Podcast Questions

Listen to the FLOSS podcast number 73 with [Tim O'Reilly - http://twit.tv/floss/73](http://twit.tv/floss/73) 

 *  Who is Tim Orielly? ~3:00-5:00
 *  What is Oscon? ~6:45
 *  Who coined the term web 2.0? ~13:34
 *  What did we learn from the IBM PC? ~18:30
 *  What is web 2.0? ~19:30
 *  Open Source vs Open Data - what does Tim Orielly think is the ultimate destination for computing? ~23:00
 *  Where is the money made in open source - software or data? ~ 34:00
 *  What prediction did Tim Oreilly make in this podcast (2009) that is now coming true? ~51:32
 *  [radar.oreilly.com](http://radar.oreilly.com) What is the lag time from articles on this site to the main stream media? ~55:00

### Lab

This activity can be induvidual or group based.

1. There was a documentary movie called [Revolution OS - https://www.youtube.com/watch?v=jw8K460vx1c](https://www.youtube.com/watch?v=jw8K460vx1c) made in 2001. Answer the questions listed under "Review Questions" above.

2. Install [Oracle VirtualBox](http://www.virtualbox.org "VirtualBox homepage") on your own laptop or if a lab computer is provided.  Note if you are already using desktop Linux or have access to a system with Linux on it, this step is optional, but VirtualBox runs on Linux as well.

#### Footnotes

[^1]: [By Bobbo (Own work) via Wikimedia Commons](https://commons.wikimedia.org/wiki/File%3AKernel_Layout.svg)

    [CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0) or GFDL (http://www.gnu.org/copyleft/fdl.html)](https://commons.wikimedia.org/wiki/File%3AKernel_Layout.svg)

[^2]: [See page for author Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File%3AKen_n_dennis.jpg)

[^3]: [By en:User:Toresbe via Wikimedia Commons](https://commons.wikimedia.org/wiki/File%3APdp7-oslo-2005.jpeg)

    [CC SA 1.0 (http://creativecommons.org/licenses/sa/1.0/)](https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pdp7-oslo-2005.jpeg/512px-Pdp7-oslo-2005.jpeg)
     
[^4]: [By Ben Lowe via Wikimedia Commons](https://www.flickr.com/photos/blowe/7984191331/ "Brian Kernighan in 2012 at Bell Labs 1") 

    [CC BY 2.0 (http://creativecommons.org/licenses/by/2.0)](  https://commons.wikimedia.org/wiki/File%3ABrian_Kernighan_in_2012_at_Bell_Labs_1.jpg)
    
[^5]: [By Dkoukoul (Own work) , via Wikimedia Commons](https://commons.wikimedia.org/wiki/File%3ARichard_Stallman_at_CommonsFest_Athens_2015_2.JPG "Richard Stallman at CommonsFest Athens 2015 2") 
    [CC BY-SA 4.0 (http://creativecommons.org/licenses/by-sa/4.0)](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG/320px-Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG "Richard Stallman at CommonsFest Athens 2015 2")

[^6]: By derivative work: Okoura (talk)AndrewTanenbaum.JPG: GerardM (AndrewTanenbaum.JPG) 
    <a href="http://creativecommons.org/licenses/by/2.5">CC BY 2.5</a>, 
    <a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a> or 
    <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a>, 
    <a href="https://commons.wikimedia.org/wiki/File%3AAndrewTanenbaum2.png">via Wikimedia Commons</a>

[^7]:   By Krd (Own work) <a href="http://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0</a> 
    or <a href="http://creativecommons.org/licenses/by-sa/4.0">CC BY-SA 4.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3ALinuxCon_Europe_Linus_Torvalds_03.jpg">via Wikimedia Commons</a>
    
[^8]: By Erc_S_Raymond_and_company.jpg: jerone2derivative work: Bilby (Erc_S_Raymond_and_company.jpg) 
    <a href="http://creativecommons.org/licenses/by-sa/2.0">CC BY-SA 2.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AEric_S_Raymond_portrait.jpg">via Wikimedia Commons</a>

[^9]: By Ilya Schurov , Computerra Weekly (originally posted to Flickr as 9722_00_23_14) 
    <a href="http://creativecommons.org/licenses/by-sa/2.0">CC BY-SA 2.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AIanMurdock.jpg">via Wikimedia Commons</a>  
    
[^10]: By Macguy314 (Own work) 
    <a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a> or <a href="http://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AUbuntu_logo_copyleft_1.svg">via Wikimedia Commons</a>

[^11]: By Martin Schmitt (cropped by Mary Gardiner) (http://www.flickr.com/photos/foobarbaz/141522112/) 
    <a href="http://creativecommons.org/licenses/by/2.0">CC BY 2.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AMark_Shuttleworth_by_Martin_Schmitt.jpg">via Wikimedia Commons</a>   
   
 [^12]: By Clement Lefebvre <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>
      <a href="https://commons.wikimedia.org/wiki/File%3ALinux_Mint_logo_and_wordmark.svg">via Wikimedia Commons</a>
 
 [^13]: See page for author [Public domain]
     <a href="https://commons.wikimedia.org/wiki/File%3AFedora_logo_and_wordmark.svg">via Wikimedia Commons</a>
     
 [^14]: By CentOS Project (http://wiki.centos.org/ArtWork/Logo/Type) 
     <a href="http://www.gnu.org/licenses/gpl.html">GPL</a> or Public domain, <a href="https://commons.wikimedia.org/wiki/File%3ACentOS_Logotype.png">via Wikimedia Commons</a>    
     
[^15]: By openindiana.org [Public domain]
     <a href="https://commons.wikimedia.org/wiki/File%3AOpenIndiana_logo_large.svg">via Wikimedia Commons</a> 
 
 
[^16]: By Sun Microsystems (OpenSolaris) <a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a> 
    or <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AOpenSolaris_Logo.svg">via Wikimedia Commons</a>
 
 
[^17]: By Joylent (uploaded by (Lamro@enwiki) [Public domain]
    <a href="https://commons.wikimedia.org/wiki/File%3AJoyent-logo.png">via Wikimedia Commons</a> 

          
[^18]: By Kushal Das (Own work) <a href="http://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0</a>
     <a href="https://commons.wikimedia.org/wiki/File%3ALennart_poettering.jpg">via Wikimedia Commons</a>   
     
     