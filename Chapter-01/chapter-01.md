---
title: __Understanding the Technology and Philosophy of Free and Opensource Operating Systems__
  __Part I__
author: Jeremy Hajek
date: 07/30/2015
...

# Introduction to the Technology and Philosophy of Linux Part I

![*One of the survivors, poking around in the ruins with the point of a spear, uncovers a singed photo of Richard Stallman. They stare in silence. "This," one of them finally says, "This is a man who BELIEVED in something."*](images/Chapter-Header/Chapter-01/operating_systems.png "Operating Systems")



## Objectives of this book

  Jim Barksdale quote - relating to opensourceing netscape) 
  Eric S. Raymond quote - about the future of opensource or else...
  Linux Torvalds quote -
    [*"I'm doing a (free) operating system (just a hobby, won't be big and professional like gnu) for 386(486) AT clones..." - Linus Torvalds 1991*](https://groups.google.com/forum/?hl=en#!msg/comp.os.minix/dlNtH7RRrGA/SwRavCzVE7gJ "Initial Post About Linux.")
 RMS - quote about Free software
 Dennis Ritchie - quote about Linux being a good Unix
 Lennnart Poettering quote on systemd?

  In reading the above quotes relating to free and opensource operating systems a thought comes to mind. There is more then a technological discussion going on, this is really a philosophy of technology discussion.  Operating systems are what powers our computers and smart phones, it is what allows us to interact with the hardware contained within.  This text strives to be different than other books in the market in two areas;  first the philosophy of free and opensource movements and its origin and impact upon computing.  Anyone can teach you how to push a button, but this book aims to go beyond that and help you understand the reason the button is there in the first place. Second, this book will cover the basic technical structure and how to use opensource operating systems--Unix and Linux based.  This book and it's exercises and sections can be updated rapidly to cover the ever-changing tools in opensource.    
 
  __For instructors__ we are going beyond the traditional PowerPoint world, and looking into using new technologies like Microsoft Sway for presentations. The book is being published on GitHub under a Creative Commons CC-SA Share alike license -- this way as things change code can be updated or removed and new digital versions can be published quickly.  

  Some of these chapters are heavier in content then others.  Some are lighter.  Feel free to combine and remix the chapters.  You are even welcome to fork the project on GitHub and remix it or contribute back patches and pull requests.  Part of this book was inspired by a quote from my friend in regards to Linux text books, he said, *"Most text books are good, but then they just add in content from nowhere."* I had that same feeling and when he expressed it in words it hit me.  At the same time, I got the feeling that most Linux Text books out were actually Unix text books with some updated content relating to Linux.
   
## Presentation Style

 This book doubles as a university textbook.  It has a 16-week semester structure, along with review questions, podcast assignments, and lab exercises.  But the book can be used beyond that.  There is a wealth of other material that is can be covered in depth depending on your needs. 

## Chapter Title Images
  
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

## Colophone

 * ePub cover image -  

### Links to Microsoft Sway Presentations

 * [https://doc.co/sxnt6y](https://doc.co/sxnt6y) - chapter 2
 * [https://doc.co/ZYPjx4](https://doc.co/ZYPjx4) - chapter 3
 * [https://doc.co/6nNWXx](https://doc.co/6nNWXx) - chapter 4
 * [https://doc.co/URDkkn](https://doc.co/URDkkn) - chapter 5
 * [https://doc.co/coScgt](https://doc.co/coScgt) - chapter 6

## Author(s)

My name is Inigo Montoya...

## Thanks 

| Professor Sam - who taught me that it is pronounced *"etc ef-stab"* not *"etc ef es tab"* and how to read error messages. 
| Professor Ray Trygstad who gave me my first real IT job and showed me the wonders of Perl.
| Illinois Institute of Technology who has entrusted me with much.
| My wife and kids who supported me always.

