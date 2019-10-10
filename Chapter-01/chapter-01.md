---
title: Understanding Free and Opensource Operating Systems, The Technology and Philosophy Of - Part I
author: Jeremy Hajek
date: 07/30/2015
...

# Introduction

![*One of the survivors, poking around in the ruins with the point of a spear, uncovers a singed photo of Richard Stallman. They stare in silence. "This," one of them finally says, "This is a man who BELIEVED in something."*](images/Chapter-Header/Chapter-01/operating_systems.png "Operating Systems")

## Objectives of this book

__Dennis Ritchie:__ *"I think the Linux phenomenon is quite delightful, because it draws so strongly on the basis that Unix provided. Linux seems to be the among the healthiest of the direct Unix derivatives, though there are also the various BSD systems as well as the more official offerings from the workstation and mainframe manufacturers."* [Interview with Dennis Ritchie](http://www.linuxfocus.org/English/July1999/article79.html "Dennis Ritchie Quote")

__Richard Stallman:__ *"Free software is a matter of liberty, not price. To understand the concept, you should think of free as in free speech, not as in free beer."* [What is free software?](https://www.gnu.org/philosophy/free-sw.html "Free Software")
  
__Linus Torvalds:__ *"To kind of explain what Linux is, you have to explain what an operating system is. And the thing about an operating system is that you're never ever supposed to see it. Because nobody really uses an operating system; people use programs on their computer. And the only mission in life of an operating system is to help those programs run. So an operating system never does anything on its own; it's only waiting for the programs to ask for certain resources, or ask for a certain file on the disk, or ask to connect to the outside world. And then the operating system steps in and tries to make it easy for people to write programs."* [Linus  Torvalds Interview in Revolution OS, documentary, 2001.](https://en.wikiquote.org/wiki/Linus_Torvalds#2000-04 "Interview")

__Steve Ballmer:__ *"Linux is not in the public domain. Linux is a cancer that attaches itself in an intellectual property sense to everything it touches. That's the way that the license works."*  [1 June 2001 Chicago Sun Times](https://web.archive.org/web/20011108013601/http://www.suntimes.com/output/tech/cst-fin-micro01.html "Steve Ballmer calls Linux a cancer")

__Scott Guthrie__ "*Today I’m excited to announce our plans to bring SQL Server to Linux as well. This will enable SQL Server to deliver a consistent data platform across Windows Server and Linux, as well as on-premises and cloud. We are bringing the core relational database capabilities to preview today, and are targeting availability in mid-2017.*" [March 7, 2016 Scott Guthrie, Executive Vice President, Cloud and Enterprise Group, Microsoft](https://blogs.microsoft.com/blog/2016/03/07/announcing-sql-server-on-linux/#sm.0000164n8bkaqfeawtecf32pv82bz "Microsoft Loves Linux")

__GitHub__ [Microsoft buys GitHub - June 4, 2018](https://news.microsoft.com/2018/06/04/microsoft-to-acquire-github-for-7-5-billion/ "Microsoft buys GitHub")

"*Microsoft Corp. on Monday announced it has reached an agreement to acquire [GitHub](https://github.com "GitHub"), the world’s leading software development platform where more than 28 million developers learn, share and collaborate to create the future. Together, the two companies will empower developers to achieve more at every stage of the development lifecycle, accelerate enterprise use of GitHub, and bring Microsoft’s developer tools and services to new audiences.*"

__Android__  "*Android is a Linux distribution according to the Linux Foundation, Google's open-source chief Chris DiBona, and several journalists. Others, such as Google engineer Patrick Brady, say that Android is not Linux in the traditional Unix-like Linux distribution sense; Android does not include the GNU C Library (it uses Bionic as an alternative C library) and some of other components typically found in Linux distributions.*"

When you hear the term *"free and opensource software"* what comes to mind? The quotes listed above state a range of opinions and outlooks. Do you agree with any of these quotes?  Do you disagree? These are the questions to keep in mind as you begin to understand *free and opensource software*.

Everyday people are exposed to free and opensource software without even knowing it. What does this mean?  And what are the advantages/disadvantages with proprietary or closed-source software?  What are the different development paradigms and what do these things mean in relation to privacy, security, and impact on your daily life.  In reading the above quotes it is clear there is more than a technological discussion going on, this is really a philosophy of technology discussion.  Operating systems power our computers and smart phones; they allow us to interact with the hardware contained within and to impact society.

This text strives to focus on two areas:

1) We will describe the philosophy of free and opensource software and its origin and impact upon our computing world.  
1) This book will cover the basic technical structure and how to use free and opensource operating systems--primarily Linux, but where noted Unix and BSD based systems.  
  
### For Instructors

In addition to the text material this book includes:

* Chapter review questions with answers in Appendix B
  * Online quizzes with support for Blackboard importing
* Weekly supplemental podcast questions
* Chapter Labs for reinforcing chapter content
  * Provided in text format
  * For those who use it, provided in Blackboard quiz form -- ready for import
* Example programs and source code for exercises

The text of the book is opensource and build instructions are in our GitHub repository for download at [https://github.com/jhajek/Linux-text-book-part-1](https://github.com/jhajek/Linux-text-book-part-1 "GitHub repo") Instructors can feel free to fork the repo or submit pull requests.  This is to ensure that we have a living document that can be changed, updated, and republished quickly.  

### For Students

All source code from this book as well as examples are available on our GitHub page: [https://github.com/jhajek/Linux-text-book-part-1](https://github.com/jhajek/Linux-text-book-part-1 "GitHub repo") 

Part of this book was inspired by a quote from my friend in regards to Linux textbooks, he said, *"Most text books move along well, but then out of nowhere introduce unrelated content."*  At the same time, I had the feeling that most Linux Text books out were actually Unix text books with some updated content relating to Linux.

### Chapter Title Images
  
* Chapter 1 image - [http://imgs.xkcd.com/comics/operating_systems.png](http://imgs.xkcd.com/comics/operating_systems.png "Operating Systems")
* Chapter 2 image - [http://imgs.xkcd.com/comics/open_source.png](http://imgs.xkcd.com/comics/open_source.png "Open Source")
* Chapter 3 image - [http://imgs.xkcd.com/comics/surgery.png](http://imgs.xkcd.com/comics/surgery.png "surgery")
* Chapter 4 image - [http://imgs.xkcd.com/comics/supported_features.png](http://imgs.xkcd.com/comics/supported_features.png "Features")
* Chapter 5 image - [http://imgs.xkcd.com/comics/seashell.png](http://imgs.xkcd.com/comics/seashell.png  "Linux Shells")
* Chapter 6 image - [http://imgs.xkcd.com/comics/tar.png](http://imgs.xkcd.com/comics/tar.png "tar")
* Chapter 7 image - [http://imgs.xkcd.com/comics/real_programmers.png](http://imgs.xkcd.com/comics/real_programmers.png "vi")
* Chapter 8 image - [http://imgs.xkcd.com/comics/sandwich.png](http://imgs.xkcd.com/comics/sandwich.png "Sandwich")
* Chapter 9 image - [http://imgs.xkcd.com/comics/security_holes.png](http://imgs.xkcd.com/comics/security_holes.png "Security Holes")
* Chapter 10 image - [http://imgs.xkcd.com/comics/debian_main.png](http://imgs.xkcd.com/comics/debian_main.png "Debian Locusts")
* Chapter 11 image - [http://imgs.xkcd.com/comics/authorization.png](http://imgs.xkcd.com/comics/authorization.png "Authorization")
* Chapter 12 image - [http://imgs.xkcd.com/comics/server_problem.png](http://imgs.xkcd.com/comics/server_problem.png "Server problems")
* Chapter 13 image - [http://imgs.xkcd.com/comics/network.png](http://imgs.xkcd.com/comics/network.png  "Aquarium")
* Chapter 14 image - [http://imgs.xkcd.com/comics/2038.png](http://imgs.xkcd.com/comics/2038.png "2038")
* Chapter 15 image - [http://imgs.xkcd.com/comics/tech_loops.png](http://imgs.xkcd.com/comics/tech_loops.png "Tech Loops")
* Appendix A image - [http://imgs.xkcd.com/comics/iso_8601.png](http://imgs.xkcd.com/comics/iso_8601.png  "Dates")
* Appendix B image - [http://imgs.xkcd.com/comics/git_commit.png](http://imgs.xkcd.com/comics/git_commit.png  "Git Commit")
* Appendix C image - [https://imgs.xkcd.com/comics/authorization.png](https://imgs.xkcd.com/comics/authorization.png "Authorization")
* Appendix D image - [https://imgs.xkcd.com/comics/cautionary.png](https://imgs.xkcd.com/comics/cautionary.png "Cautionary")

## Authors and Contributors

[Jeremy Hajek](https://appliedtech.iit.edu/people/jeremy-hajek "Jeremy Hajek") - Industry Associate Professor at the Illinois Institute of Technology

Special thanks to those who have submitted pull requests and bug reports:

* [njdwklopper](https://github.com/njdwklopper "GitHub Profile for njdwklopper")
* [HackingGate](https://github.com/HackingGate "GitHub profile for HackingGate")
* [ttruty](https://github.com/ttruty "GitHub profile for ttruty")
* [kwillet7](https://github.com/kwillett7 "GitHub profile for kwillet7")
* [paul-arg](https://github.com/paul-arg "GitHub profile for paul-arg")
* [calennert](https://github.com/calennert "GitHub profile for calennert")
* [liamvu2501](https://github.com/liamvu2501 "GitHub profile for liamvu2501")
* [trevhead0](https://github.com/trevhead0 "GitHub profile for trevhead0")

## Special Thanks

* [Professor Sam](https://appliedtech.iit.edu/people/sheikh-sam-shamsuddin "Sam") - who taught me that it is pronounced *"ee tee cee F-stab"* not *"etc F S tab"* and how to read error messages.
* Professor Ray Trygstad and Dean Robert Carlson, who gave me my first real IT job and showed me the wonders of Perl.
* Illinois Institute of Technology who has entrusted me with much.
* My wife and kids who supported me always.
* [Sean Hughes-Durkin](https://appliedtech.iit.edu/people/sean-hughes-durkin "Sean Hughes-Durkin Info") who inspired me to write this book based on his quote above.
