## Chapter 1 - History of Unix and Linux

![*At the end of class you will find this cartoon funny*](http://imgs.xkcd.com/comics/open_source.png "Understanding the Technology and Philosophy of Linux Part I")

### 1.1.0 - The foundation of Unix and Linux

Why are you learning about Linux?  It is a term that seems to be on everyone's lips.  There is a good chance that you even have Linux running in your pocket and don't even know it! (Hint Android Operating System is based off of Linux).  So this chapter begins the start of your mastery of Linux.  In addtition to teaching you technology, this book aims to teach you about the history and philosophy of Linux so you can understand where it came from and where it is going.  Some pieces of this book will seem frustratingm, after all the roots of the design decisions of what we are dealing with are 40 years old in some cases.  Helping to understand what kind of technology was available and what these creators were thinking will help you master the concepts of Linux.

__Objectives__

  * Understand how Unix Operating System was created 
  * Understand the contributions of Ken Thompson and Dennis Ritchie to Unix
  * Understand the contributions of Richard Stallman to Unix, Linux, GNU, and FOSS
  * Understand the contributions of Linus Torvalds to the creation of Linux
  * Understand the nature of modern commercial implementations of Linux
  * Understand the principles of the Linux Community and what the *"free"* in *"Software Freedmom"* means

__Outcomes__
 
 At the completion of this chapter a student will understand and be able to discuss the environment in which Unix and Linux were created. They will be able to relate key names; Thompson, Ritchie, Stallman, Torvalds to their technilogical contributions.  They will be able to understand what Linux and Unix are and how they relate to FOSS and commercial softare.

### 1.2.0 - Where it began and why it matters now 

Conventions

  You will notice that I have been using the terms Unix and Linux interchangably.  For a large part the conventions are the same - their history is intertwined. Though this book focuses on Linux and we would be depriving you of the full truth if we left Unix out.  For this first chapter then we need to understand their related history.  There are differences and their are similarities.  
  
  When we say *"Unix"* we are referring to an entire operating system.  This includes all the many components of an operating system you would expect.  

  __Kernel__
 
  <a title="By Bobbo (Own work) [CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0) or GFDL (http://www.gnu.org/copyleft/fdl.html)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3AKernel_Layout.svg"><img width="256" alt="Kernel Layout" src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Kernel_Layout.svg/256px-Kernel_Layout.svg.png"/></a>
    
  Unix includes a kernel - a hardware abstraction layer that handles all the interfaces from the operating system to the hardware.  The kernel is the portion of the Operating system that allows you to write once and interface with hardware through drivers.  Otherwise you would have to compile the operating system everytime and include the hardware drivers for your hardware.  Take Windows for instance - you have just one version for all of the hardware out there.  Intel Chips, AMD processors, Marvell, Broadcom, and many others.  But there is no need to buy a version of Windows specific to that hardware - software drivers are inserted into the kernel and allow Windows, Mac, or Linux to simply communicate with the hardware.  
  
__Graphical User Interface__
  
  Unix originally didn't have a user interface.  All data was typed in and then a paper tape printed out the "screen output" but it wasn't on a screen but paper tape.  The original interface once CRT monitors (ahh the green and if you were lucky the amber ones...) became prevelant was through the shell.  This allowed you to type commands direclty on a screen and see the results back--no paper involved.  Finally the [X Windows System](https://en.wikipedia.org/wiki/X_Window_System) came along giving you the familiar desktop windows you are most likely used to, allowing for mouse and keyboard input.  More on that in chapter 2. (put link here)  Their are full desktops like KDE and GNOME (meant to copy features of Mac and Windows) as well.  

__Compilation Tools__

  Perhaps we are used to just clicking on .exe or .dmg files and off our installation of Chrome or Firefox goes.  But in the Unix world you compilied your software manually.  So in order to be productive you needed a C language compiler among other building and making tools.   The first UNIX compiler was *cc* later on becoming replaced by [GCC](http://www.gnu.org/software/gcc/ "GNU gcc").
  

__Linux is the same as Unix but...__
  Linux on the otherhand is technically not a full operating system like Unix.  It is actually just a kernel, and is missing all the other tools listed above.  Although you will hear people refer to it as an operating sysetm.  Depending on your audience you need to know both facts.  The Linux kernel plus someone elses GUI and Compliations tools and software makes up a linux distribution or simply Linux distro. Every company and person can equally contribute to the Linux kernel and add whatever they like on top of it.  Linux was built out of the Unix world, keeping all the same conventions and ideas from Unix but starting in a different place.  I think a good analogy would be the American Colonies in 1776 - they thought of themselves as Europeans, they came out of Europe but yet were starting new in America.   

__Take away point__
  
  Who uses Linux today?  
  
  * Facebook
  * Google
  * Amazon
  * RedHat
  * NYSE
  * CME
  * Android
  * [Microsoft](http://www.informationweek.com/enterprise/microsoft-contributes-to-linux-kernel----and-its-not-april-1/d/d-id/1081481) 
  
  The question is not who uses Linux but the question should be when did you last use it?  How did it get this way?  Where did it come from?  For that we need to go back 40+ years to fully understand this shared Unix/Linux history.  Ignore this part at your own peril, you will never understand Linux unless you understand UNIX at its core philosophies.  Here we go.

#### 1.2.1 - Thompson, Ritchie, and Bell Labs

  Many people supported and worked on Unix but two names have received most of the credit for the creation, promotion, and use of Unix.  
  
__Ken Thompson__

<a title="See page for author [Public domain], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3AKen_n_dennis.jpg"><img width="256" alt="Ken n dennis" src="https://upload.wikimedia.org/wikipedia/commons/3/36/Ken_n_dennis.jpg"/></a>
    
__Dennis Ritchie__
    
 <a title="By Dennis_Ritchie_(right)_Receiving_Japan_Prize.jpeg: Denise Panyik-Dale derivative work: YMS [CC BY 2.0 (http://creativecommons.org/licenses/by/2.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3ADennis_Ritchie_2011.jpg"><img width="256" alt="Dennis Ritchie 2011" src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Dennis_Ritchie_2011.jpg/256px-Dennis_Ritchie_2011.jpg"/></a>

  Without Thompson and Ritchie, there would be no Unix and most likely no Linux today.  Until recently both were hired as Distinguished Engineers at Google.  Dennis Ritchie passed away in 2011. Ken Thompson is still working and recently help produce the [Go programming language](https://en.wikipedia.org/wiki/Go_(programming_language) from Google. 

*I think the Linux phenomenon is quite delightful, because it draws so strongly on the basis that Unix provided. Linux seems to be among the healthiest of the direct Unix derivatives, though there are also the various BSD systems as well as the more official offerings from the workstation and mainframe manufacturers.* - [Dennis Ritchie](https://en.wikipedia.org/wiki/Dennis_Ritchie "Ritchie Quote on Linux")

We need to go back to 1968.  The Unix project got it start in something called MULTICS, which was an attempt to build a multi user operating system.  At the time, this combined all the brightest minds of General Electric, Honeywell, and Bell Labs.  Now today those aren't names you think of when you think of computers.  Yet in 1968/1969 these were the big players in the computing market (The PC market we know of today doesn't come until 1983!) 

Bell Labs was basically the *"idea shop"* of the entire country - where the best and brightest went to invent everything we take for granted today. IT still technically exists as part of AT&T and also became what is Lucent -> Alcatel-Lucent -> and now just bought out by Nokia. You would think that Google and Facebook have taken its place a the place where the brightest minds go to invent new things.  Ironically that Dennis Ritchie, Ken Thompson, and even James Gosling (father of the Java programming language) are and were employees at Google.

Like all projects that try to do to much MULTICS stalled in government gridlock between the different companies and the demands of the government.  This left one crafty engineers with much free time and (for those days) a true rarity - unused copmuters PDP-7s to be exact.  Thompson understood why the inner workings of the MULTICS project went wrong.  He had his own ideas of what he would create and he set about doing that very thing.  Using these PDP-7s Thompson began experiementing on his own operating system, that would solve his work prelated problems and serve his purposes.  Another realted figure, Brian Kernighan, gave it the name UNIX.  This was a play on words-- MULTI vs UNI in the name.  Thompson begane writting this operating system in assember and others in his team and then research division found out about it and began to use it as well, seeing how it solved their problems and enabled them to continue to develop.

For this time 1969-70 this is something radical, and Thompson had no idea that his pet work project was going to become part of a cmputing revolution.  See where as MULTICS and other computer systems were designed by committees and based on marketable features--due to the nature of the upfron financial investment.  Plus the fact that computers were still large final investments only the governement and large corporations could purchase.  The overall reason that Unix took hold was that it was designed by engineers to solve other problems that engineers were having--enabling them to get work done.  THis was pure genius and this is how Ken Thompson's mind worked.  

Unix differences

  * Written by Ken Thompson on his spare time
  * No company owned it or committee designed it
  * Solved problems that engineers had
  * Built by engineers
  * Had a consistent design philosophy
 
 Between 1970 and 1974 Unix grew in its maturity.  And one of its crowning achienvements--its portability came to life.  See Unix was originally written in assembly lanugage for the PDP-7 because it needed to be as low level code as possible because disk storage space was a HUGE premium in those days.  This was good, but the problem with writting in low level assembly means that the code is optimized to only run on a PDP-7 system.  Not on a PDP-11 or a DEC Vac, or an IBM 360, etc, etc.  So what you gain in efficiency you lose in protablitiy and that is what you need in the computer world--your code to be portable to other platforms easily.
 
 Enter Dennis Ritchie, who championed Ken Thompson's Unix in Bell Labs.  Ritchie helped create a [language called "B"](https://en.wikipedia.org/wiki/B_(programming_language "B Lanugage") which was written after A and derived from a language called BCPL.  B was designed to execute applications and operating system specific tasks but didn't handle numeric data - (needed to save space) B was also missing many other features you would expect in modern programming languages.  What happened was that Thompson and Ritchie went to work extending "B" with all the features they would need to make an operating system fully function.  They called this language surprsingly, "C" -- the same "C" lanugage you know today.  C was different from assembler in that is resembled it in being close to the code but had a high enough level of abstraction that the "C" code could be recomplied on different architectures, PDP-7, PDP-11, DEC VAX, DEC Alpha, IBM 360, etc, etc.  
 
![C Programming language "Hello World!"](../images/hello-c.png "C language") ![Intel x86 Assembly code of "Hello World!"](../images/hello-asm.png "Assembly Language")   
 
Since Ritchie created "C" to solve all the problems Unix had -- it became the defacto lanuage of Unix and from that point on pretty much all operating systems are designed in "C" after Thompson and Rithie showed that you could use a high level lanuage to make Unix portable accross many platforms.  

Now come 1974/75 Unix is growing in its maturity and also in its tooling use.  Other Bell Labs divisions get wind of this and begin to request "tapes."  There were giant mounted magnetic tape reels that contained all the operating system installation code. At the same time Universities began to also request this source code to teach in their Operating Systems classes.  Unix was unique because it was fully operational but also the source code was freely given away by Ken Thompson.  You sent him a letter, paid for shipping, and you got a reel within a week or so.  Thompson had no concept of "ownership" and freely shared his project with anyone who was interested.  This presented a dilema, Bell Labs was technically a "For Profit" company but they didn't understand what was they had right under their noses.  They let Thompson distribute Unix in this way.  By the end of the decade all those students who had learned on Unix in school went to work in corporations and began to request Unix be used on their hardware platforms at work.  This was possible because of Unix being written in C.  No other operating system was portable to other platforms at this point in time.  Every operating sysetm was tied to its own custom hardware.  

In 1975 Ken Thompson took a sabbatical from Bell Labs and went back to his Alma Mater, Berkly, in California.  Installing their what was now Version 6 of Unix.  The students at Berkley loved Unix and started adding their own features to improve it to solve their workload flows.  One student in 1978, Bill Joy, added vi and the C Shell (two things in use still today in modern Linux) and started redistributing his "re-mix" of Unix called BSD Berkely System Distrubition.  

So at this time you start to see a split in Unix.  AT&T maintained the official commercial Unix distribution called System V and the university at Berkely began to reverse engineer parts of Unix so that they could have their own non-commercial version of Unix.   As the decade of the 70's came to an end AT&T began to realize that they were sitting on a commercial goldmine with Unix.  They began to sell corporate licenses, support, and also began to withhold the source code.  This lead to some fundamental philisophical disagrements about the nature of software.  Some argued that the sharing and induvidual original spirit of Unix should be preserved and that everyone had the right to view and modify the code for their own use.  Other's saw this as a business and you needed to protect your trade secrects at all costs.  One who stronly and passionately saw software as needing to be "free" was Richard Mathhew Stallman, known also as RMS.    

#### 1.2.2 - Ricahrd Stallman and GNU

<a title="By Dkoukoul (Own work) [CC BY-SA 4.0 (http://creativecommons.org/licenses/by-sa/4.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3ARichard_Stallman_at_CommonsFest_Athens_2015_2.JPG"><img width="256" alt="Richard Stallman at CommonsFest Athens 2015 2" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG/256px-Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG"/></a>

Best short interview I ever heard with Richard Stallmand from Will Backmand of [BSDTalk](http://bsdtalk.blogspot.com/ "BSD Talk")

[Link to .ogg audio interview file](https://archive.org/download/bsdtalk132/bsdtalk132.ogg "RMS Interview")

Ricahrd Stallman was a student and a researcher at MIT in the early 1980's.  He realized that users of computers were not "free." Free here doesn't mean cost, but free as in freedom.  His passion was to develop a fully free operating system so that everyone who could use a computer could have access to an operating system.  

RMS was a brilliant man--on the level on Ken Thompson.  But he realized that the Unix he was using at the University was not free.  Students did not have the right to modify the source code.  Unix for all its utility, was not free.  Richard wrote his GNU manifesto stating his plans in 1985.  [GNU Manifesto](http://www.gnu.org/gnu/manifesto.html "GNU Manifesto") 

Unix was not free.  All code was owned by AT&T at the time.  No one could legally improve or modify source code, even though the school or department paid for it.  RMS saw this not as a legal issue but as a moral issue.

In 1983 RMS issues his GNU Manifesto elliciting help for volunteers to help him to create the GNU operating system. GNU is a recursive acronym meaning *"GNU's not Unix."*  So the [FSF](http://www.fsf.org/ "FSF") was formed.  

RMS started this work of creating a free Unix-like operating system.  The first tool build was a C complier that was needed so that the code could be recomplied to different hardware.  The Unix C complier -- cc -- GNU's version adds a "g" to all the reverse engineered applications and tools so "cc" became "gcc."  GNU has been working now for about 20 years.  They did remarkably well and had reverse engineered all the components of Unix by 1991 (8 years.) They built everything except 1 critial piece...  they didn't have a kernel for their operating system.  Turns out that writing a kernel is much harder than it looks.  A project was started called [GNU Hurd](http://www.gnu.org/software/hurd/ "GNU Hurd") was started to be the kernel for the GNU operating system.  Development stalled and was never finished (in the time period of the late 80's and mid 90's).  (hurd is in alpha stage downloadable today but is about 10 years behind in its hardware support)      



#### 1.2.3 - Rise of AT&T and commercial Linux vs academic Linux

  AT&T SysV and BSD lawsuit

#### 1.2.4 - Linus Torvalds and Linux

<a title="By Krd (Own work) [CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0) or CC BY-SA 4.0 (http://creativecommons.org/licenses/by-sa/4.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3ALinuxCon_Europe_Linus_Torvalds_03.jpg"><img width="256" alt="LinuxCon Europe Linus Torvalds 03" src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/LinuxCon_Europe_Linus_Torvalds_03.jpg/256px-LinuxCon_Europe_Linus_Torvalds_03.jpg"/></a>

  * Talk about good timing

#### 1.2.5 - The rise of commercial Linux

  * Ubuntu 
  * Red Hat

#### 1.2.6 - Rise of OpenSource

* Free software vs opensource

#### 1.2.7 Impending Linux Civil War

* cover breifly here and then again later in the end of the book
* SysVInit vs systemd 
* Lennart Poetering
* Red Hat's grab for Linux?
* Can Linux survive as an opensource project?


#### 1.2.8 Licensing

  * Not patents but Licensing
  

### 1.3.0 - Chapter Conclusion and Summary

#### 1.3.1 - Review Questions

#### 1.3.2 - Podcast Review Questions


#### 1.3.3 - Review Lab

- - - 