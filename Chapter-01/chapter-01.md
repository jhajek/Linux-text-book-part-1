---
title: __Understanding the Technology and Philosophy of Linux__
  __Part I__
author: Jeremy Hajek
date: 07/30/2015
...

# Introduction to the Technology and Philosophy of Linux Part I

![*One of the survivors, poking around in the ruins with the point of a spear, uncovers a singed photo of Richard Stallman. They stare in silence. "This," one of them finally says, "This is a man who BELIEVED in something."*](images/Chapter-Header/Chapter-01/operating_systems.png "Operating Systems")

[*"I'm doing a (free) operating system (just a hobby, won't be big and professional like gnu) for 386(486) AT clones..." Linus Torvalds 1991*](https://groups.google.com/forum/?hl=en#!msg/comp.os.minix/dlNtH7RRrGA/SwRavCzVE7gJ "Initial Post About Linux.")

## Objectives of this book

  As you know there are many, many books on Linux out there.  This book strives to be different in trying to highlight two areas.  First the philosophy of Linux and its design.  Anyone can teach you how to push a button, but this book aims to go beyond that and help you understand the reason the button is there in the first place.  Above all Linux is merely a tool to help you get your work done.  Seeing as this book is self-published its exercises and sections can be updated rapidly to cover the ever-changing tools in Linux. I have found over the years understanding the history of Linux goes along way to understanding how it works.  This book strives to be different as well.  In addition to being pegged to the LPIC-I/Linux+ content it will go beyond being just a training book.  
  
  For instructors - we are going beyond the traditional PowerPoint world, and looking into using new technologies like Microsoft Sway for presentations. The book is being published on Github under a Creative Commons CC-SA Share alike license -- this way as things change code can be updated or removed and new digital versions can be published quickly.  

  Some of these chapters are heavier in content then others.  Some are lighter.  Feel free to combine and remix the chapters.  You are even welcome to fork the project on Github and remix it or contribute back patches and pull requests.  Part of this book was inspired by a quote from my friend Sean in regards to Linux text books, he said, "Most text books are good, but then they just add in content from nowhere." I got that same feeling and when he expressed it in words it hit me.  At the same time I got the feeling that most Linux Text books out were actually Unix text books with some updated content realting to Linux. 

## Presentation Style

 This book doubles as a university text book.  It has a 16 week semester structure, along with review questions, podcast assignments, and lab exercises.  But the book can be used beyond that.  There is a wealth of other material that is can be covered in depth depending on your needs. 

## Book Images
  
 * ePub cover image -  
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
## Author(s)

My name is Enigo Montoya...

## Thanks 

| Professor Sam - who taught me that it is pronounced *"etc ef-stab"* not *"etc ef es tab"* and how to read error messages. 
| Professor Ray Trygstad who gave me my first real IT job and showed me the wonders of Perl.
| Illinois Institute of Technology who has entrusted me with much.
| My wife and kids who supported me always.

