---
title: Understanding Free and Opensource Operating Systems, The Technology and Philosophy Of - Part I
author: Jeremy Hajek
date: 07/30/2015
...

# Introduction

![*One of the survivors, poking around in the ruins with the point of a spear, uncovers a singed photo of Richard Stallman. They stare in silence. "This," one of them finally says, "This is a man who BELIEVED in something."*](images/Chapter-Header/Chapter-01/operating_systems.png "Operating Systems")

## Objectives of this book
 
  __Dennis Ritchie:__ *"I think the Linux phenomenon is quite delightful, because it draws so strongly on the basis that Unix provided. Linux seems to be the among the healthiest of the direct Unix derivatives, though there are also the various BSD systems as well as the more official offerings from the workstation and mainframe manufacturers."* [Interview with Dennis Ritchie](http://www.linuxfocus.org/English/July1999/article79.html Ritchie Quote")

  __Richard Stallman:__ *"Free software is a matter of liberty, not price. To understand the concept, you should think of free as in free speech, not as in free beer."* [What is free software?](https://www.gnu.org/philosophy/free-sw.html "Free Software") 
  
  __Linus Torvalds:__ *"To kind of explain what Linux is, you have to explain what an operating system is. And the thing about an operating system is that you're never ever supposed to see it. Because nobody really uses an operating system; people use programs on their computer. And the only mission in life of an operating system is to help those programs run. So an operating system never does anything on its own; it's only waiting for the programs to ask for certain resources, or ask for a certain file on the disk, or ask to connect to the outside world. And then the operating system steps in and tries to make it easy for people to write programs."* [Linus  Torvalds Interview in Revolution OS, documentary, 2001.](https://en.wikiquote.org/wiki/Linus_Torvalds#2000-04 "Interview")

  __Steve Ballmer:__ *"Linux is not in the public domain. Linux is a cancer that attaches itself in an intellectual property sense to everything it touches. That's the way that the license works."*  [1 June 2001 Chicago Sun Times](https://web.archive.org/web/20011108013601/http://www.suntimes.com/output/tech/cst-fin-micro01.html "Steve Ballmer calls Linux a cancer")

  __Scott Guthrie__ "*Today I’m excited to announce our plans to bring SQL Server to Linux as well. This will enable SQL Server to deliver a consistent data platform across Windows Server and Linux, as well as on-premises and cloud. We are bringing the core relational database capabilities to preview today, and are targeting availability in mid-2017.*" [March 7, 2016 Scott Guthrie, Executive Vice President, Cloud and Enterprise Group, Microsoft](https://blogs.microsoft.com/blog/2016/03/07/announcing-sql-server-on-linux/#sm.0000164n8bkaqfeawtecf32pv82bz "Microsoft Loves Linux")

When you hear the term *"free and opensource software"* what comes to mind? The quotes listed above state a range of opinions and outlooks. Do you agree with any of these quotes?  Do you disagree? These are the questions to keep in mind as you begin to understand *free and opensource software*. 

Most people are exposed to opensource through using Linux either in school or at work. In reading the above quotes it is clear there is more then a technological discussion going on, this is really a philosophy of technology discussion.  Operating systems are what powers our computers and smart phones, it is what allows us to interact with the hardware contained within. 
  
This text strives to be different than other books in the market in two areas; 

1) We will describe the philosophy of free and opensource software and it's origin and impact upon our computing world.  
2) This book will cover the basic technical structure and how to use free and opensource operating systems--primarily Linux but where noted Unix and BSD based systems.  
  
### For Instructors

In addition to the text material this book includes:

  *  Chapter review questions with answers in Appendix B
     + Online quizzes with support for Blackboard importing 
  *  Weekly supplemental podcast questions
  *  Chapter Labs for reinforcing chapter content
     + Provided in text format
     + For those who use it, provided in Blackboard quiz form -- ready for import
  * Standard PowerPoint chapter slides in template form
  * Additional Microsoft Sway presentations for the first six chapters   
  * Example programs and source code for exercises
   
The text of the book is opensource and build instructions are in our GitHub repository for download at [https://github.com/jhajek/Linux-text-book-part-1](https://github.com/jhajek/Linux-text-book-part-1 "GitHub repo") Instructors can feel free to fork the repo or submit pull requests.  This is to ensure that we have a living document that can be changed and updated and republished quickly.  

###For Students

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
 * Chapter 13 image - [http://imgs.xkcd.com/comics/network.png ](http://imgs.xkcd.com/comics/network.png  "Aquarium")
 * Chapter 14 image - [http://imgs.xkcd.com/comics/2038.png](http://imgs.xkcd.com/comics/2038.png "2038")
 * Chapter 15 image - [http://imgs.xkcd.com/comics/tech_loops.png](http://imgs.xkcd.com/comics/tech_loops.png "Tech Loops")
 * Appendix A image - [http://imgs.xkcd.com/comics/iso_8601.png](http://imgs.xkcd.com/comics/iso_8601.png  "Dates")
 * Appendix B images - [http://imgs.xkcd.com/comics/git_commit.png](http://imgs.xkcd.com/comics/git_commit.png  "Git Commit")
 * Appendix C images - 
 
### Links to Microsoft Sway Presentations

 * [Chapter 2](https://sway.com/i5Cx_zt57c-YGmIr?ref=Link&loc=mysways "Chapter 02")
 * [Chapter 3](https://sway.com/qxWQ6byqAI2bInXn?ref=Link&loc=mysways "Chapter 03")
 * [Chapter 4](https://sway.com/McBZPp8hXVHiMQO0?ref=Link&loc=mysways "Chapter 04")
 * [Chapter 5](https://sway.com/Yxo8uWW38K0L66WC?ref=Link&loc=mysways "Chapter 05") 
 * [Chapter 6](https://sway.com/jqtPt3oXBh6rHZOG?ref=Link&loc=mysways "Chapter 06")

## Author(s)

[Jeremy Hajek](https://appliedtech.iit.edu/people/jeremy-hajek "Jeremy Hajek") - Industry Associate Professor at the Illinois Institute of Technology 

## Thanks 

* Professor Sam - who taught me that it is pronounced *"ee tee cee F-stab"* not *"etc F S tab"* and how to read error messages. 
* Professor Ray Trygstad and Dean Robert Carlson, who gave me my first real IT job and showed me the wonders of Perl.
* Illinois Institute of Technology who has entrusted me with much.
* My wife and kids who supported me always.
* Sean Hughes-Durkin who inspired me to write this book based on his quote above.
