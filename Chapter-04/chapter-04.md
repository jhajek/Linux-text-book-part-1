# Desktop Linux and GUIs

![*GUIs??? NIH*](images/Chapter-Header/Chapter-04/supported_features2.png "GUIs NIH")

## Objectives

* Explore the different types of desktop Linux
* Understand the nature and use of X, Wayland, and other GUI compositors
* Understand the purpose of window managers and the nature of desktop environments
* Understand GUI package managers and application stores

## Outcomes

At the conclusion of this chapter you will have a strong knowledge of the X Windows system and why it is the foundation of Desktop Linux.  You will be able to implement various window managers and desktop environments, selecting the proper environment to utilize and suit your hardware needs.  You will be comfortable using and recognizing the features of GNOME desktop environment.

## From Paper Tape to CLI to GUIs to 4K

When you think about how we use computers today the one thing we take for granted is a *GUI*, __Graphical User Interface__.  The GUI is intricately tied to the way computers are used, why do think Microsoft calls its operating system Windows? Unix however, had its start in the late 1960s and 1970s--there was vastly different technology available at that time. The PDP-7s that Thompson and Ritchie used were called [*Teletypes*](https://en.wikipedia.org/wiki/Teleprinter "TTYs") or *TTYs* that had punch card readers for data entry and paper tape for output connected to a PDP-7 via a modem. You will notice that even today in Unix screen outputs are still referred to as TTYs. By the mid 1970s we begin to see what are called *dumb terminals* appear which could be considered primitive monitors.

The [Datapoint 3300](https://en.wikipedia.org/wiki/Datapoint_3300 "Datapoint 3300") was one of the more common models representing the era.  It supported control codes to move the cursor up, down, left and right, to the top left of the screen, or to the start of the bottom line and displayed a whopping 72 by 25 rows of characters in the days before microprocessors and ram were part of terminals. By 1978 Digital Equipment Corporation (DEC) had released something akin to an upgrade for the dumb terminal called a *smart terminal*.

The [DEC VT-100](https://en.wikipedia.org/wiki/VT100 "VT-100") was the most popular model: it had character and cursor positioning and was connected to the Unix system via serial ports and a modem.  The VT-100 set the standard for 80 by 24 rows and columns still in use today.  These terminals had the backing of DRAM and an Intel 8080 processor.  Open up any terminal emulator in Linux and see its default size.  Open up cmd.exe in Windows and you will notice the same default dimensions.  Why? Sociologists always talk about nature vs. nurture. Nature plays a huge part in software development.  All the developers who built Terminal emulators and cmd.exe for Windows "grew up" using Unix systems on a DEC VT-100 screen in college and at work.  It was a natural fit.  The VT-100 and VT-220 continued with wide deployment and success but the concept of color or being able to draw any shapes to the screen was in the hands of a few expensive and proprietary companies; everything was still [ASCII](https://en.wikipedia.org/wiki/ASCII "ASCII") or character based.

### VT-100

![*VT-100*](images/Chapter-04/Terminals/DEC_VT100_terminal.jpg "VT-100")[^25]

This screenshot is a file listing from the ```/dev``` (devices) folder on a Fedora 22 system

![*TTY Alive Today*](images/Chapter-04/tty.png "TTYs")

![*Windows cmd.exe eerily similar to the VT-100*](images/Chapter-04/cmd-399-by-200.png "cmd.exe")

![*Ubuntu's GNOME Terminal emulates the VT-100 directly*](images/Chapter-04/linux-terminal-299-by-200.png "Linux Terminal")

### Virtual Consoles

With the X system the idea of having discrete terminals went away. Now you could have multiple *virtual terminals* on one system that emulated the features of a DEC VT-100 or VT-220 terminal. If you hit the  ```ctrl + alt + F1-F7``` within your Linux distro you will jump to 1 of 7 different virtual terminals enabled by default.  Usually F7 is the default GUI but it can vary from operating system to operating system.

## Along Comes an X

Beyond the simple green screen terminals by the mid 1980s we began to see proprietary primitive UNIX GUIs from commercial vendors, especially from Sun. These GUI interfaces were placed on high-end workstations sold at premium prices for the day. One may wonder why you would even bother to create a GUI in the first place. Computing at that time was beginning to take less of an iterative/batch processing approach to computing and a more of an interactive approach. GUIs were in the hand of the privileged few vendors but not of anyone else. By 1985 MIT opensourced a project called X. This project was after Richard Stallman had left the school but continued in his spirit. X was a continuation of a primitive GUI called "*W*". As Unix originally had no concept of a GUI, one had to be bolted on. But the spirit of X was not to enforce any standards on the user.

X uses a client–server model[^24]: an X server communicates with various client programs. The server accepts requests for graphical output (windows) and sends back user input (from keyboard, mouse, or touchscreen). The server may function as:

* An application displaying to a window of another display system
* A system program controlling the video output of a PC
* A dedicated piece of hardware.

### X

![*X Diagram*](images/Chapter-04/X/X_client_server_example.svg-3.png "X diagram")

Even in the mid 1980s the dream of having your own desktop PC was a bit of a ways off.  Large single Unix systems were still the nature of computing so the X system fit in, especially in the idea of remote terminals or underpowered system connecting remotely to a central server and running their own *X Window* remotely. X is often misnamed as X Windows, but the name for the project is *"X"*.

> *"...in 1987-1988 X established itself as the standard graphics engine for Unix machines, a hardware-independent neutral platform on top of which to build GUIs"* [Eric S. Raymond writings](http://www.catb.org/~esr/writings/taouu/html/ch02s06.html "Early history of Unix").

> *"X provides the basic framework for a GUI environment: drawing and moving windows on the display device and interacting with a mouse and keyboard. X does not mandate the user interface — this is handled by individual programs."* [https://en.wikipedia.org/wiki/X_Window_System](https://en.wikipedia.org/wiki/X_Window_System "X Windows")

By 1987 version 11 of the protocol had been released, being commonly referred to as X11.  The industry wanted to prevent fragmentation and they asked MIT to form a steering consortium for the project.  The MIT X Consortium became the X Consortium Inc. in 1993.  By 1996 the X Consortium, with vendor input, released one of the first standard Unix GUIs called the `CDE` *Common Desktop Environment*. By 1997 the X Consortium transformed into the Open Group.  The Open Group angered many people by relicensing the project under stricter commercial terms in an effort to make some money to support the project--but this action backfired.  By 1999 the Open Group had ceased functioning and ceased really developing X. The Open Group created *X.Org* to maintain the X11 standard.

At the same time a parallel implementation base on X11R5 was being developed by IBM for their PCs.  The project was started in 1992 as XFree86.  This code was donated to the X Consortium and the code has been part of the larger code base that the X Consortium managed.  So while the X Consortium/Open Group/[X.Org](http://www.x.org "X") was in charge of X development, they actually weren't innovating or developing anything.  It was the group at XFree86 that was doing all the innovation.

The story gets more complicated.  As the userbase of Linux surges in the early 2000s as desktop Linux and GUIs grow, X use would naturally follow that growth curve as well.  You have two problems: [X.Org](http://www.x.org "X"), a vendor controlled stewardship organization, was not doing any development on X, and XFree86 was starting to narrow its *openness* just like the OpenGroup did in 1997, expelling some of the original X creators who had joined the XFree86 project and changing open licenses to be non-GPL compliant (non-Linux compatible license).

This led to the founding of the X.Org Foundation merging the two groups.  This was a breakthrough event.  It basically reconciled the two groups under one new foundation, [X.Org Foundation](http://www.x.org "X.Org Foundation"), it also ensured that the creators of the X project were once again the stewards, and finally it insured that there was a GPL based and protected X project that developers and companies could contribute to as well. The X.Org Foundation continues to innovate and foster the project to this day.

As X was being developed, the most breakthrough commercial GUI available in the early 80s was released by Apple in 1984[^23].  Here is a [link to an article](http://www.folklore.org/StoryView.py?story=Busy_Being_Born.txt "Mac") from the developers about how it came to be.

![*Apple Macintosh 1984*](images/Chapter-04/Terminals/205px-Macintosh_128k_transparency.png "Apple Macintosh")

X has a definite advantage in that it is very mature and very stable for better or worse.  In the diagram earlier in the chapter you can see one of X's major faults.  It was designed not with a desktop GUI in mind, those didn't exist at the time. Every desktop element is a client that has to make calls to the X server in order to render any changes to the screen.  This adds extra layers of overhead and also becomes a [security issue](http://www.windowsecurity.com/whitepapers/unix_security/Securing_X_Windows.html#3.0 "Security Issues") with an X client being able to connect unauthenticated in some cases to other X servers remotely on the network.

### Project Wayland

In the late part of the 2000s, then Red Hat engineer Kristian Høgsberg, began to reimagine the nature of the Linux GUI compositor with a simpler desktop driven protocol. With the help of other senior X.Org developers they began to create a successor project to the X project.  By 2012 they had their first code release usable for beta testing. This project was called [Wayland](http://wayland.freedesktop.org "Wayland").  The famous architect of the City of Chicago Daniel Burnham once said, *"Make no little plans. They have no magic to stir men's blood and probably will not themselves be realized."*  Every single desktop environment and window manager runs on X--this means rewriting or extending every single graphical toolkit and graphical development environment out there. The Wayland project had that just in mind. What is Wayland then?

> *"Wayland[^26] is a protocol for a compositor to talk to its clients as well as a C library implementation of that protocol. The compositor can be a standalone display server running on Linux kernel modesetting and evdev input devices, an X application, or a wayland client itself. The clients can be traditional applications, X servers (rootless or fullscreen) or other display servers."* [Wayland Project](http://wayland.freedesktop.org/ "Wayland Project")

![*Wayland Rendering Model*](images/Chapter-04/wayland-architecture.png "Wayland Architecture")

* The kernel gets an event and sends it to the compositor. This is similar to the X case, which is great, since we get to reuse all the input drivers in the kernel.
* The compositor looks through its scenegraph to determine which window should receive the event. The scenegraph corresponds to what's on screen and the compositor understands the transformations that it may have applied to the elements in the scenegraph. Thus, the compositor can pick the right window and transform the screen coordinates to window local coordinates, by applying the inverse transformations. The types of transformation that can be applied to a window is only restricted to what the compositor can do, as long as it can compute the inverse transformation for the input events.
* As in the X case, when the client receives the event, it updates the UI in response. But in the Wayland case, the rendering happens in the client, and the client just sends a request to the compositor to indicate the region that was updated.
* The compositor collects damage requests from its clients and then recomposites the screen. The compositor can then directly issue an ioctl to schedule a pageflip with KMS.

At one time it was thought that X was too deep into the bones of Linux and may never be ever fully replaced. But we are seeing massive amounts of work from industry to make Wayland a reality. With Intel, Nvidia, the X.Org Foundation and Red Hat leading the way, Fedora 25 was one of the first distros to run Wayland natively.  

![*X on Wayland*](images/Chapter-04/x-on-wayland.png "X on Wayland")

### Ubuntu Mir - Depricated

Not to be outdone Ubuntu saw an opportunity to come up with an X replacement and announced the Mir project in early 2013.  Unfortunately this has met with serious opposition from the X and Wayland communities seeing this as an outside effort to *"corner the market"*, even to the point in 2013 of Intel, who supports Wayland, [rejecting XMir support](http://arstechnica.com/information-technology/2013/09/intel-rejection-of-ubuntus-mir-patch-forces-canonical-to-go-own-way/ "Intel Rejects XMir") in its Linux opensource graphic driver package.

Ubuntu is the only Linux operating system to support Mir and development has been delayed as the project has taken on the monumental task of replacing X.  Ubuntu was criticized for not joining the Wayland group's work but I think that may have been somewhat without warrant.  Ubuntu has a business use case--they are looking to make a compositor that could adapt based on form factor, something not unlike how Android works.  This would enable them to make Ubuntu for tablets, phones, TVs, even smaller devices electronic devices.  Mir would be customizable to Ubuntu's hardware dreams and they could sell hardware and perhaps make some money.

> *"In March 2014, Mark Shuttleworth confirmed that Mir development had been delayed and that it was now forecast to be default for desktop use in Ubuntu 16.04 LTS, expected to be released in April 2016."* [^27]

As of [April 5th 2017](https://arstechnica.com/information-technology/2017/04/ubuntu-unity-is-dead-desktop-will-switch-back-to-gnome-next-year/ "Unity Dead"), Mark Shuttleworth announced that in Ubuntu 18.04 the UNITY[^40] interface and the Mir compositing engine would be deprecated in favor of GNOME 3 and Wayland.  But the Mir Project and Unity lives on in the Ubuntu Touch port maintained for phones and tablets by the [Ubuntu-Touch.io](https://ubuntu-touch.io/ "Ubuntu Touch webpage") project.  The Mir display server is now gaining popularity running Ubuntu Touch on the [Librem 5](https://fossbytes.com/librem-5-ubuntu-touch-support/ "librem 5 ubuntu touch web page") and the [Pinephone](https://devices.ubuntu-touch.io/device/pinephone/ "pinephone running ubuntu touch") Linux based cell phones.

## Window Managers

X will let you display a window and let you capture mouse and keyboard commands.  But what if you want to render multiple windows on one machine and manage their state as well such as opening and closing them. How about arranging them?  Do you need them tiled or overlapping? Then you need a window manager to sit on top of X and handle that rendering.  Thankfully window managers are essentially common in Desktop Linux and almost inseparable from X. Window Managers are not the full GUIs you might be used to. They are one step below a full blown desktop environment but window managers are very fast because they render simple windows and simple sets of icons.  Their job is to render content inside of particular windows and manage that window's state. Since Linux and X were developed independently, you will see a depth and breadth of different window managers serving different functions and features.  Some are very simple, some serve direct purposes, some are tied to full blown desktop environments. You can break window managers into 3 categories based on their window behavior.

### Compositing

The first compositing window managers came about in 2005/2006 as the necessary extensions were added to the X server.  The compositing window managers are now considered standard and default part of desktop environments such as GNOME, KDE, and XFCE.  

* [Xfwm](https://en.wikipedia.org/wiki/Xfwm "Xfwm") - Xfce window manager
* [KWin](https://en.wikipedia.org/wiki/KWin "KWin") - Window manager for the KDE Desktop Environment
* [Mutter](https://en.wikipedia.org/wiki/Mutter_%28software%29 "Mutter") - Window manager for the GNOME Desktop Environment

### Stacking

These allow for overlapping windows, like Windows or MacOS. The LXQT desktop environment uses  [Openbox](http://openbox.org/wiki/Main_Page "Openbox") as it's window manager.

* [Afterstep](http://afterstep.org/ "Afterstep") - NEXTSTEP look and feel
* [Fluxbox](http://fluxbox.org/ "Fluxbox") - Highly configurable and low resource
* [FLWM](https://en.wikipedia.org/wiki/FLWM "Fast and Light Window Manager") Fast and Light Window Manager
* [FVWM](http://www.fvwm.org/ "FVWM") - Minimize memory consumption, provide a 3D look to windows, and a virtual desktop
* [IceWM](https://ice-wm.org/ "ICEWM") - Win95-OS/2-Motif-like window manager
* [Openbox](http://openbox.org/wiki/Main_Page "Openbox") - Standards compliant, fast, light-weight, extensible window manager
  * The LXQT Desktop Environment uses Openbox as its default window manager.

### Tiling

Tiling Window Managers place window next to each other like tiles on the floor and are non-overlapping. This lets you optimize your work-flow, maximize screen usage and ditch the use of the mouse (saving your wrists!). This style is popular with many coders and developers who want to see many windows open at once.

* [dwm](http://dwm.suckless.org/ "dwm") - Dynamic window manager
  * [dwm tutorial](https://dwm.suckless.org/tutorial/ "Tutorial for dwm")
* [i3](http://i3wm.org/ "i3") - Good documentation, reasonable defaults, and good multi-monitor support
  * [i3 keyboard command reference](https://i3wm.org/docs/refcard.html "i3 keyboard command reference")
  * X11 based
* [Sway](https://github.com/swaywm/sway "Sway tiling window manager")
  * Update for i3 focused on using Wayland
* [Xmonad](http://xmonad.org/ "Xmonad") - Minimalist, tiling window manager written in Haskell
  * [Xmonad User Guide](https://xmonad.org/tour.html "Xmonad User Guide")
* [Qtile](https://qtile.org/ "webpage of qtile")

There is a sub-category of Tiling Window Managers called [Dynamic Window Managers](https://en.wikipedia.org/wiki/Dynamic_window_manager "webpage for Dynamic Window Managers"), which can combine some of the stacking features with tiling features. But according to an [article by Jerome Belleman](http://jeromebelleman.gitlab.io/posts/productivity/tiling/ "webpage explaining dynamic windows managers are part of tiling") that dynamic is really a part of tiling and not its own category--*However, reading the Dynamic window manager article reveals a Wikipedia definition which describes dynamic as specifically being a tiling window manager paradigm after all – nothing to do with stacking – and which relies on layouts rather than the user's freedom.*

## Desktop Environments

About the time that the OSI movement was launching in late 1990s, there was a growing need for more than just window managers too. On x86 Intel and AMD CPUs at that time were gaining in processing power and processor based multimedia extensions began to appear by 1997, [collectively called MMX](https://en.wikipedia.org/wiki/MMX_(instruction_set) "MMX"). What is the difference between a desktop environment and a window manager? Simple things that you may take for granted such as as a clock, or a text editor, office suite or an email client, even a web browser.

Also a desktop environment provides an IPC method for inter-window communication.  Most important, a desktop environment includes a file manager application, a start or action menu feature and a login manager (display manager) such as GDM, KDM, or SDDM. On top of that all the elements of the desktop have a changeable but consistent usage pattern and look-and-feel. Let us look first at the development history of the two main desktop environments followed by a few other desktop environments.

### KDE

The KDE project[^33] was the first opensource Linux desktop environment project. Started by Matthias Ettrich at the university of Tübingen in Germany in 1996. The first release of the `Kool Desktop Environment` was in 1998 and the name was a *"clever hack"* of the CDE--`Common Desktop Environment`--developed for Unix by Sun, HP, and IBM. KDE focused on the lack of perceived usability in CDE. You and I may take desktop environments for granted based on our experience with Mac and Windows respectively. Unix and Linux in 1998, did not have the same capabilities--just a mix of window managers and independent applications.

At the time of development there were only a few toolkits available that could be used for creating desktop environments in Linux. One of them was [Qt](https://www.qt.io/ "Qt"), pronounced *"cute-ee"*. Qt was a good choice for developers because at the time was the only toolkit that had C++ language bindings. GTK was C only at this point. Matthias Ettrich chose the best technology at the time for developing GUIs. Qt was initially developed by a company called Trolltech.

In 1998 Qt was not available under a completely *"free software"* license. It had a modified license called the QPL, stating that non-commercial software projects for Unix/Linux were allowable. By 2000 Trolltech relicensed Qt to be GPL compliant. This fact still upset Richard Stallman who never forgave KDE for initially using a non-GPL compatible license. As an aside, Nokia bought Trolltech in 2008 but Qt remained under GPL license[^34]. Qt was used by Nokia to power their Symbian OS which dominated the cellular market as the predominant OS until Android unseated it by 2010.

KDE is unique because although Qt has vendor input to the project, KDE itself is not vendor owned. KDE is also not tied to a single Linux distro. Distros such as [openSUSE](opensuse.org "opensuse"), [Mageia](mageia.org "Mageia"), [Chakra](www.chakralinux.org "Chakra Linux"), [KDE Neon Ubuntu](https://neon.kde.org "KDE Neon Ubuntu webpage"), [PCLinuxOS](www.pclinuxos.com "PC Linux OS") and even FreeBSD are using KDE by default or have it available in software repositories. The Steam Deck portable hand-held gaming system [uses KDE as its desktop](https://arstechnica.com/gaming/2022/02/linux-on-steam-deck-what-you-need-to-know-what-currently-works/ "webpage article about KDE use on Steam Deck").

#### Plasma Desktop

The KDE desktop runs an environment called [Plasma](https://kde.org/plasma-desktop/ "website for KDE Plasma"). This desktop includes controls all the software, notifications, launcher activity, and system tray integrations for you. [KDE 6 is now available](https://kde.org/announcements/megarelease/6/ "KDE 6 release webpage"). There is a [mobile Plasma](https://plasma-mobile.org/ "webpage for mobile Plasma") framework available for Linux based phones and tablets.

### GNOME

Shortly after the initial release of KDE and its licensing confusion, an enterprising opensource advocate saw the need for a truly open and free desktop environment. His name was [Miguel De Icaza](https://en.wikipedia.org/wiki/Miguel_de_Icaza "Miguel").

#### Miguel de Icaza and GNOME history

![*Miguel de Icaza*](images/Chapter-04/People/351px-Miguel_de_Icaza.jpg "Miguel de Icaza")

GNOME[^33] initially stood for GNU Network Object Model Environment but the acronym is no longer used[^28]. GNOME was a GNU project directly created under the GPL. The first major GNOME release was done by Miguel in March of 1999. This project used the [*GTK+*](http://www.gtk.org/ "GTK+"), commonly mistaken as the *Gnome Tool Kit*, used to stand for the GIMP Tool Kit. The toolkit is once again known as **GTK**. GTK is a library useful for creating standalone applications with multiple development language bindings as well.

In an interesting development Miguel ended up forming the company that became Xamarin, a cross development mobile platform using C# to develop for Android and iOS--shortly after Microsoft began opensourcing the C# language. Xamarin was purchased by Microsoft and Miguel was a Microsoft VP. Miguel has always been a software pragmatist, always chasing the best technology and open sourcing it. He took much criticism because he started the Mono project in bringing Microsoft's C# and .NET platform to Linux, because he saw C# as the best language to develop in cross platform. This brought about the condemnation of Richard Stallman, calling Miguel, "*A traitor to free software[^30].*". Miguel's response to Stallman was a beautiful example of how to diffuse an inflammatory situation:

> *"I want to say that God loves all creatures. From the formidable elephant to the tiniest ant. And that includes Richard Stallman. As for me, I think that there is a world of possibility, and if Richard wants to discuss how we can improve the pool of open source/free software in the world he has my email address. Love, Miguel[^35]."*

In the early 2000s Sun and HP adopted the GNOME desktop as the replacement for CDE for their Unix distros. Red Hat and Debian adopted GNOME as well. With the release of Ubuntu 18.04, Ubuntu returned to the GNOME desktop. GNOME 2 was released in early 2002, GNOME 3 was released in 2010[^37], and GNOME 4--now known as GNOME 40, released March 2021.  

What made GNOME 3 so different is that it took on a different structure from the traditional Windows desktop--called the GNOME shell[^36]. Think of the GNOME shell as a way to manage or view multiple tasks and applications happening at once. Instead of a single desktop, think of the new metaphor as a table top using the shell as a magnifying glass to view all tasks. The GNOME naming convention has changed from the previous 2.x and 3.x to just GNOME desktop, starting at version 40.

You can check the version of your GNOME desktop from the cli by issuing the command: `gnome-desktop --version`.

\newpage

#### KDE and GNOME Desktop Comparison 

![*KDE 6 and GNOME Desktop Comparison*](./images/Chapter-04/GNOME40/gnome40-kde6.png "image of KDE 6 and GNOME Desktop Comparison")

#### GNOME Forks

GNOME is considered the Linux default desktop due to its tight integration with systemd. So much so that GNOME community contributed development has begun to wane[^29]. Which is better GNOME or KDE? With all major Linux systems that are using systemd you now have no choice but to adopt GNOME as the default desktop.  Both have had great set backs and great feature advancements over the years. In the end it is up to you based on your usage patterns, development environment preferences, even which distro you use or prefer. Try them both and choose the best one for your needs.

#### GNOME Forks: Mate

The [Mate desktop](https://mate-desktop.org/ "Webpage mate desktop") (pronounced *mah-tay*) is a fork maintaining the older GNOME 2 platform. Linus Torvalds was quoted as saying, *"People don't want Gnome 2 because it was a pinnacle of some GUI design. They want it because Gnome 3 removed features they used, and made it harder to get their work done[^38]..."*.  

#### GNOME Forks: Cinnamon

The [Cinnamon desktop](https://projects.linuxmint.com/cinnamon/ "Webpage for Cinnamon Desktop") was a fork of GNOME 3 with an added features set for the Linux Mint distro in 2013 started by the [Linux Mint](https://linuxmint.com/ "Webpage Linux Mint") project. Cinnamon is no longer compatible with the stock GNOME plugins.

#### GNOME Forks: Ubuntu Unity 

From 2010 to 2018, Ubuntu maintained the [Unity Shell](https://en.wikipedia.org/wiki/Unity_(user_interface) "Webpage for Unity Shell"), which was a reimplementation of the GNOME shell, not a full desktop. Ubuntu had plans to design a single desktop that would run across various sized devices, PCs, laptops, phones, and tablets. Support for Unity was dropped as of Ubuntu 18.04 but Unity lives on though in an official [Ubuntu Unity](https://en.wikipedia.org/wiki/Ubuntu_Unity "webpage for Ubuntu unity") distro and the [Ubuntu Touch phone OS project](https://ubuntu-touch.io/ "webpage for Ubuntu Touch project"). 

#### GNOME Forks: Pop!_OS

In April of 2021, [Linux open laptop manufacturer, System76](https://system76.com/ "Website for System76 Linux Laptop manufacturer") released a themed GNOME 3 desktop called [Pop!_OS](https://pop.system76.com/ "Website to Pop OS") with a custom windows manager that defaults to a tiling mode rather than a stacking mode.  

In 2024, Pop!_OS in a dispute with the GNOME project, began work on their own bespoke Rust based desktop named the [Cosmos Desktop Environment](https://blog.system76.com/post/cosmic-the-road-to-alpha "webpage for Cosmos DE"). The project is still in early alpha. 

### Xfce

There is a third desktop environment that targets lower hardware requirements with a simpler ambiance and lower hardware requirements, named [Xfce](https://xfce.org/ "webpage xfce site") was born. [Xfce](https://xfce.org/ "webpage xfce site") was developed in parallel to KDE and GNOME by Olivier Fourdan. Xfce wrote all of its [components](https://en.wikipedia.org/wiki/Xfce#Software_components "Xfce components") by itself--not relying on or forking any of GNOME.

Originally based on a proprietary toolkit, when Xfce was rejected for inclusion in Red Hat Linux because of this license, Xfce moved to GTK+ 2 toolkit by 1999. At one point Debian was considering it as an alternative to GNOME, but dropped it because of the systemd requirement in GNOME. [Xubuntu](https://xubuntu.org/ "webpage for xubuntu") is a common derivative distro made up of Ubuntu using Xfce instead of GNOME. One of the biggest drawbacks of Xfce is that it only runs on X11 and not on the Wayland compositor.

### LXQT

The [LXQT](https://lxqt-project.org/ "webpage for LXQT project") project was started as the LXDE[^39] project in 2006 by Hong Jen Yee. This desktop environment is even more spartan than Xfce and is one step above a window manager. LXDE's focus is on making laptops or PCs made in the last decade usable for modern Linux. The lead developer Hong Jen Yee had disagreements with the direction GTK+ 3 was taking and moved his development team to merge with another desktop environment, razor-qt. This produced a new desktop environment called LXQT. The [Lubuntu](https://lubuntu.me "webpage for lubuntu disto") distribution uses LQXT as its default desktop environment on top of modern Ubuntu.

### Budgie

A MacOS inspired desktop, [The Budgie desktop](https://buddiesofbudgie.org/ "Webpage Budgie desktop") is independent of any Linux distro. Its design emphasizes simplicity, minimalism, and elegance, while providing the means to extend or customize the desktop in various ways[^32]. Their are Budgie versions available for most Linux distributions. There design has a very Windows-esque design.

### Enlightenment

This project started in 1997 and intended to be a virtual desktop window manager. This would involve a grid of desktops a user could move windows around and onto. The initial release was in 1999 called E16. The second release E17 took 12 years. But E17 had grown from just a window manager into a full-fledged desktop environment using its own libraries called Enlightenment Foundation Libraries. Enlightenment can also be a shell that can sit on top of KDE and GNOME.

### Who Uses What

-------------------------------------------------------- ------------------------ ------------------------------------
[KDE](https://www.kde.org/ "KDE")[^31]                     Qt 5 & 6                    https://www.kde.org/
[GNOME 40+](https://www.GNome.org/ "GNOME")                   GTK+ 4                  https://GNome.org/
[Xfce](http://www.xfce.org/ "Xfce")                           GTK+ 3                  https://www.xfce.org/
[LXQT](http://lxqt.org/about/ "LXQT")                         Qt 5                    https://lxqt.org/about/
[MATE](http://mate-desktop.org/ "Ma-tay")                     GTK+ 3                  https://mate-desktop.org/
[Cinnamon](http://cinnamon.linuxmint.com/ "Cinnamon")         GTK+ 3                  https://cinnamon.linuxmint.com/
[Enlightenment](https://www.enlightenment.org/ "E24")         EFL                     https://www.enlightenment.org/
[Budgie](https://buddiesofbudgie.org/ "Website Budgie")       C, Vala                 https://buddiesofbudgie.org/ 
-------------------------------------------------------- ------------------------- -----------------------------------

Wikipedia has a sample gallery of all these desktop environments and more at [https://en.wikipedia.org/wiki/Desktop_environment#Gallery](https://en.wikipedia.org/wiki/Desktop_environment#Gallery "sample gallery"). As always there are many other desktops we couldn't cover.  Also keep in mind that most of these have been ported to work on the various BSDs as well.

### Gnome Features

![*GNOME*](images/Chapter-04/GNOME40/gnome-desktop46.png "GNOME")

Everything in [GNOME](https://www.gnome.org/gnome-3/ "GNOME") starts with the `Workspace Indicator` button in the upper left-hand corner. There is no traditional "Start Button" in GNOME. Just activities to be launched in a workspace. There is also a `Type to Search` box for searching everything in GNOME 40+ from documents to applications to even suggested software. There is also a `favorites dash` on the bottom of the screen. You will see preinstalled icons for FireFox Web Browser, the file manager, Nautilus, the Software Store application, the clock, and finally a grid launcher for everything else. Note there are no *"categories"* such as system tools or office software. This is a design feature of GNOME.

![*GNOME FAVORITES DASH*](images/Chapter-04/GNOME40/favorites.png "Image of GNOME favorites dash")

Each application has a preferences and content menu area in GNOME. It is located right next to the Activities button.  You will see the application name with a small white drop down arrow. In order to find the window commands for open, close, resize, tiling, and so forth you just need to right click on the gray toolbar on top of the window that has the focus.

![*GNOME Taskbar*](images/Chapter-04/GNOME40/workspace-identifier.png "Image of Workspace Identifier")

#### GNOME Remove and Add Favorites

You can remove default icons from the favorite menu as well as add your own favorite applications in GNOME. By right-clicking on the icon you have an option to remove it from the Favorites menu.

For example to add a Favorite for the Terminal program click the `Workspace Identifier` > `Search` > type `Terminal` > right click on the icon > `Add to Favorites`. There has also been an [integration of track pad gestures](https://forty.gnome.org/ "Website GNOME 40 what is new") to quickly switch workspaces.

* Touchpad
  * Three Fingers ↑ ↓ Toggle Overview
  * Three Fingers ← → Switch Workspaces
* Keyboard
  * Super + Alt + ↑ ↓ Toggle Overview
  * Super + Alt + ← → Switch Workspaces
* Mouse
  * Super + Alt + Scroll  

#### GNOME Extensions

To extend the functionality of GNOME there is a [GNOME extensions website](https://extensions.gnome.org "GNOME extensions").  This site allows you to add on additional features to GNOME that you may want.  If visit the site while using Fedora or any GNOME enabled site and you allow the GNOME plugin to run in your FireFox browser, then the website will allow you to interactively install plugins.  Try it.  Go to the second page and choose a plugin called *Caffeine*.  This is handy because it allows you to disable the screensaver and system suspend and is very handy if you are working on a virtual machine.  Note how the caffeine plugin simply places a coffee cup icon in the top toolbar? 

A few others you may want to try are the [Drop Down Terminal](https://extensions.gnome.org/extension/442/drop-down-terminal/ "Drop Down Terminal"), [Logout Button on Panel](https://extensions.gnome.org/extension/944/logout-button-on-panel/ "Add Logout button"), or the [System Monitor](https://extensions.gnome.org/extension/9/systemmonitor/ "System Monitor"). Most GNOME 3 extensions should work on GNOME 40 but not all have been ported. 

You can find that some [Linux distros need an additional plugin](https://wiki.gnome.org/action/show/Projects/GnomeShellIntegration/Installation?action=show&redirect=Projects%2FGnomeShellIntegrationForChrome%2FInstallation "webpage for installting gnome extensions browser plugin") to make the extensions work directly from the browser (Ubuntu), some already work by default (Fedora).

![*GNOME Extensions*](images/Chapter-04/extensions.png "Extensions")

### Installing Windows Managers and Desktop Environments

Previously Linux distributions had made an effort to build in Software Stores, much like we saw in iOS and Android. The issue with a software store became the ability to make money, charge money, and distribute money. All though the distributions still support Software Stores, their heart is not in this manner of software installation. The original way to install software was via a package manager, which the stores were a front for anyway. There are two competing standards to replace packages or more appropriately bring "app" like functionality to Linux. These are called [Flatpak](https://flatpak.org "Flatpak") on Fedora and [Snaps](https://www.ubuntu.com/desktop/snappy "Snaps").

To access the terminal on a GNOME desktop, click the `Activities Identifier` button at the top and in the `Search` box type: *terminal*.
  
#### Ubuntu

> `sudo apt-get update`  then `sudo apt-get install i3 icewm fvwm flwm evilwm fluxbox dwm xmonad mwm xfce4`

#### Fedora

> `sudo dnf install i3 icewm xmonad mwm @xfce`

#### GNOME Software Store

![*GNOME Software Store*](images/Chapter-04/software-store.png "Software Store")

This is a feature added by Red Hat to improve upon Gnome Packages, which is the default package manager in GNOME. The package manager is called **Software**. There is a wide selection of free and opensource software to choose from. The GNOME Software store now is mostly a front for Flatpak or Snap (Ubuntu based distros) package managers.

## Conclusion

In this chapter we learned about the creation and evolution of the desktop GUI. From ttys to X to Wayland and a modern compositor.  We also learned about window managers and the four major desktop environments. Finally we learned about the major GUI desktop environment development kits and how each major DE uses them on the Linux GUI desktop.

### Review Questions

1.  What was the original and most popular Unix “Smart Terminal?”
    a.  VIC-100
    b.  VT-100
    c.  VT-220
    d.  VC-100
1.  What is the three letter abbreviation still in use today in modern Linux to refer to “terminal devices?”
    a.  TCY
    b.  TTY
    c.  VT-100
    d.  Virtual Terminal
1.  Why is the GNOME terminal and Windows cmd.exe terminal emulator screens 80 by 25 by default?
    a.  The technology cannot process any larger size
    b.  The technology doesn’t need to have any larger screen size
    c.  The developers of these technologies were seeking to emulate the popular VT-100 and VT-220 terminals they used prior.
    d.  Hey it's Windows, do they need a reason?
1.  What is the key combo sequence you can hit to switch to a new virtual terminal in Linux?
    a.  Alt + Ctrl + Del
    b.  Alt + Ctrl + F1 - F7
    c.  Right Ctrl
    d.  Shift 5 times
1.  What is the name of the original Unix based GUI that came out of MIT in ~1984?
    a.  W
    b.  X
    c.  Y
    d.  Z
1.  Most modern Linux distros using GNOME use which compositor by default?
    a.  X
    b.  Y
    c.  Wayland
    d.  XWayland
1.  What is the name of the successor GUI compositor to X being created by the X.org foundation?
    a.  KDE
    b.  Y
    c.  Wayland Project
    d.  Jennings Project
1.  What is the name of Ubuntu’s, now deprecated, GUI compositor replacement for X?
    a.  soyez
    b.  cosmo
    c.  aero
    d.  mir
1.  What are the 3 types of Linux window managers?
    a.  stacking, tiling, compositing
    b.  stacking, tiling, hybrid
    c.  hybrid, tiling, compositing
    d.  stacking, hybrid, compositing
1.  There are 4 major Linux desktop environments in use today: which grouping is correct?
    a.  KDE, GNOME, CDE, LXQT
    b.  KDE, GNOME, E17, GNUSTEP
    c.  KDE, GNOME, X, LXQT
    d.  KDE, GNOME, Xfce, LXQT
1.  What is the name of the windowing toolkit that KDE uses?
    a.  Nokia
    b.  Gtk
    c.  Gnome
    d.  Qt
1.  What is the name of the windowing toolkit that GNOME uses?
    a.  Nokia
    b.  Gtk
    c.  Gnome
    d.  Qt
1.  What is the name of the founder of the GNOME project?
    a.  Miguel De Icaza
    b.  Richard Stallman
    c.  Matthias Ettrich
    d.  Linus Torvalds
1.  What are the 3 major Linux desktop environment projects started to preserve GNOME 2?
    a.  Enlightenment, LXQT, Xfce
    b.  Mint, Unity, Mate
    c.  Unity, Mate, Cinnamon
    d.  Cinnamon, Mint, Mate
1.  When released in 2006, what was the main development goal of the LXDE desktop environment?
    a.  GUI desktop features
    b.  Multi-desktop paradigm
    c.  Energy saving and extremely fast
    d.  Made for high end gaming systems
1.  Which of these statements are true in regards to Linux desktop environments? (choose all that apply)
    a.  Desktop environments have a File Manager
    b.  Desktop Environments have start or action buttons and task and notification bars
    c.  Desktop environments have a changeable but consistent look-and-feel
    d.  Desktop environments have system configuration tools and user applications built in
    e.  Desktop environments have lower memory requirements than window managers
1.  What is the name of the default desktop environment and version for the latest Fedora desktop?
    a.  Qt
    b.  Xfce
    c.  Gnome
    d.  KDE
1.  What is the name of the button on the upper left hand corner of the GNOME desktop that you use to “launch applications?”
    a.  Launcher
    b.  Spotlight
    c.  Activities
    d.  Start
1.  What is the name of the desktop environment used in Xubuntu?
    a.  LXQT
    b.  Qt
    c.  Gnome
    d.  Xfce
1.  Choose the two Tiling window managers
    a.  IceWM
    b.  Openbox
    c.  Sway
    d.  i3
1.  Choose the two Stacking window managers
    a.  IceWM
    b.  dwm
    c.  Fluxbox
    d.  i3
1.  The Sway window manager requires which compositor?
    a.  mir
    b.  Y
    c.  X11
    d.  Wayland
1.  The i3 window manager requires which compositor?
    a.  mir
    b.  Y
    c.  X11
    d.  Wayland
1.  What is the current version of the X window project?
    a.  x86
    b.  10
    c.  2023
    d.  11
1.  What is the name of the current KDE desktop?
    a.  Qt
    b.  Liquid
    c.  Plasma
    d.  Mosh

### Podcast Questions

Please answer these questions from the Fedora Project podcast on [FLOSS - http://twit.tv/floss/71](http://twit.tv/floss/71 "Fedora Project")

* ~9:11 What is the Fedora Project?
* ~11:35 How does Red Hat make money on Fedora if it is free?
* ~12:30 What is the Fedora release cycle and can businesses use this release cycle?
* ~13:30 What is the relationship between Fedora and Red Hat Enterprise Linux (RHEL)?
* ~25:00 What percentage of the Fedora Project is open source?
* ~35:00 On further inspection is Fedora Project really opened source according to the Free Software Foundation?
* ~36:20 Does Fedora include proprietary Nvidia drivers? Why or why not?
* ~45:00 Does Fedora say "Linux" or "GNU/Linux"?
* ~46:12 Who is the most famous Fedora user?

### Lab

Using the virtual machines you installed in the previous chapter, Fedora Workstation and Ubuntu Desktop, you will now install additional software, themes, desktop environments, and window managers. You will combine screenshots of this newly installed software into a single document for submission. We will be focusing on package based installs in the first part of the lab.

#### GNOME Extensions

You will need to install the listed GNOME extensions from [https://extensions.gnome.org](https://extensions.gnome.org "Gnome extensions"). The first one is the example in the book called *Caffeine*. Make sure you have the Gnome Shell integration installed to configure and install plugins directly from the browser. If you are using Ubuntu Desktop, you first need to install one commandline pre-req via apt. Open a terminal and type the command `sudo apt install chrome-gnome-shell` and choose 'Y' on Ubuntu Desktop 22.04. On Ubuntu Desktop 23.04+ type on the terminal: `sudo apt install gnome-browser-connector` and choose 'Y'.

1) Caffeine (screenshot of coffee cup icon in upper right corner)
1) Bring out submenu of Power Off/Logout Button (Expands all poweroff and logout buttons)
1) Extension List (List all extensions and their configs in upper right corner)

## Snaps Install

To install and configure snaps, reference chapter 3. To show these packages are installed take a screenshot of the output of the command: `sudo snap list`. Install these packages via Snap on an **Ubuntu** based desktop.

1) From the Software store: KdenLive
1) From the Software store: VSCode - If you are on an M1 Mac install Sublime Text
1) From the Software store: Search for obs-studio - Not available skip for M1 Mac
1) From Commandline search for and install: Arduino
1) From Commandline search for and install: Kicad - If you are on an M1 Mac install 
itrue-kicad

#### Flatpak Install

To install and configure flatpak and flathub, reference chapter 3.  To show these packages are installed take a screenshot of the output of the command: `sudo flatpak list`. Install these packages via flatpak on s **Fedora** virtual machine:

1) From the Software store: Gnome Notes
1) From the Software store: Develop -> Visual Studio Code
1) From the Software store: Socialize -> Falkon Web Browser
1) From Commandline search for and install: VLC (video player)
1) From Commandline search for and install: GtkStressTesting

#### AppImage Install

Using these three [AppImage install packages](https://appimage.org/ "AppImages install"), follow the instructions to install and run these AppImages on either Ubuntu or Fedora. Take a screenshot of the command needed to run the AppImage and the corresponding first screen of that application from the [AppImage GitHub repo](https://appimage.github.io/apps "AppImage GitHub Repo"). You will need to from the terminal execute the command `cd Downloads` and then give execute permission to each of the AppImages: `chmod +x LibreWolf.x86_64.AppImage` for example.

1) Lagrange ([Gemini client](https://en.wikipedia.org/wiki/Gemini_(protocol) "wiki article for Gemini Protocol"))
1) LibreWolf (Firefox fork)
1) LibrePCB

#### Installing Window Managers

You will install 3 of the window managers from the categories listed earlier in the chapter. Once installed you need to log out and restart your session. In order to change the default window manager or desktop environment--from the login screen, you need to click on the user name and select the little gear below the password field. In your screenshot open a terminal window, you might need to do some research to understand how to operate in a window manager.

![*Change Window Managers*](images/Chapter-04/GNOME3/window-manager.png "Change")

* Stacking window manager - [IceWM](http://ice-wm.org/ "webpage for Ice WM")
  * Show 3 Windows stacked (FireFox, Terminal, and the File Manager)
* Tiling window manager - i3
  * [i3 keyboard command reference](https://i3wm.org/docs/refcard.html "i3 keyboard command reference")
  * Show 3 Windows tiled, 2 Terminal Windows and 1 FireFox.
  * Use the link above to learn the key commands to launch windows, remember there is no mouse!
* Tiling window manager - Sway
  * [Sway documentation](https://github.com/swaywm/sway/wiki/ "webpage Sway reference")
  * Show 3 Windows tiled, 2 Terminal Windows and 1 FireFox.

**Note:** the names of packages are not always obvious so you can use search features of package managers.  For example, here would be how to search for the i3 package.

* `sudo apt-cache search i3`
* `sudo dnf search i3`

#### Desktop Environment Installs

Install these desktops, restart your system and as you login switch your desktop environment and take a screenshot of the new environment.

1) Install the Budgie desktop on Fedora Workstation -> `budgie-desktop`
1) Install the Ubuntu Mate Desktop on Ubuntu Desktop -> `ubuntu-mate-desktop`

**Deliverable:** Take screenshots of all successful installs of software.

#### Footnotes

[^23]: <a href="http://www.allaboutapple.com/" rel="nofollow">http://www.allaboutapple.com/</a>
  <a href="http://creativecommons.org/licenses/by-sa/2.5/it/deed.en">CC BY-SA 2.5 it</a>,
  <a href="http://creativecommons.org/licenses/by-sa/2.5/it/deed.en">CC BY-SA 2.5 it</a>,
  <a href="www.gnu.org/copyleft/fdl.html">GFDL</a> or
  <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a>,
  <a href="https://commons.wikimedia.org/wiki/File%3AMacintosh_128k_transparency.png">via Wikimedia Commons</a>

[^24]: By Original by David Gerard, recreated by Efitu (Wikimedia Commons)
  <a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a> or
  <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a>,
  <a href="https://commons.wikimedia.org/wiki/File%3AX_client_server_example.svg">via Wikimedia Commons</a>

[^25]: By Jason Scott (Flickr: IMG_9976) <a href="http://creativecommons.org/licenses/by/2.0">CC BY 2.0</a>,
<a href="https://commons.wikimedia.org/wiki/File%3ADEC_VT100_terminal.jpg">via Wikimedia Commons</a>

[^26]: Diagram provided by: <a href="http://wayland.freedesktop.org/architecture.html">http://wayland.freedesktop.org/architecture.html</a>

[^27]: [http://www.omgubuntu.co.uk/2014/03/mir-default-display-server-ubuntu-2016](http://www.omgubuntu.co.uk/2014/03/mir-default-display-server-ubuntu-2016)

[^28]: <a href="https://commons.wikimedia.org/wiki/File:Miguel_de_Icaza.jpg#/media/File:Miguel_de_Icaza.jpg">Miguel de Icaza</a>
  Licensed under <a title="Creative Commons Attribution 2.0" href="http://creativecommons.org/licenses/by/2.0">CC BY 2.0</a>
  via <a href="https://commons.wikimedia.org/wiki/">Commons</a>.

[^29]: <a href="https://blogs.gnome.org/otte/2012/07/27/staring-into-the-abyss/">https://blogs.gnome.org/otte/2012/07/27/staring-into-the-abyss/</a>

[^30]: <a href="http://www.osnews.com/story/22225/RMS_De_Icaza_Traitor_to_Free_Software_Community/">http://www.osnews.com/story/22225/RMS_De_Icaza_Traitor_to_Free_Software_Community/</a>

[^31]: <a href="https://en.wikipedia.org/wiki/Qt_%28software%29#Qt_5">https://en.wikipedia.org/wiki/Qt_%28software%29#Qt_5</a>

[^32]: <a href="https://en.wikipedia.org/wiki/Budgie_(desktop_environment)">https://en.wikipedia.org/wiki/Budgie_(desktop_environment)</a>

[^33]: <a href="https://en.wikipedia.org/wiki/Comparison_of_X_Window_System_desktop_environments">https://en.wikipedia.org/wiki/Comparison_of_X_Window_System_desktop_environments</a>

[^34]: <a href=http://arstechnica.com/information-technology/2008/01/nokia-buys-trolltech-will-become-a-patron-of-kde>Nokia buys Trolltech</a>

[^35]: <a href="http://tirania.org/blog/archive/2009/Sep-23.html">http://tirania.org/blog/archive/2009/Sep-23.html</a>

[^36]: <a href="http://www.zdnet.com/article/linus-torvalds-finds-gnome-3-4-to-be-a-total-user-experience-design-failure/#!">http://www.zdnet.com/article/linus-torvalds-finds-gnome-3-4-to-be-a-total-user-experience-design-failure/#!</a>

[^37]: <a href="http://www.zdnet.com/article/linus-torvalds-switches-back-to-gnome-3-x-desktop/">http://www.zdnet.com/article/linus-torvalds-switches-back-to-gnome-3-x-desktop/</a>

[^38]: [https://plus.google.com/115250422803614415116/posts/KygiWsQc4Wm](https://plus.google.com/115250422803614415116/posts/KygiWsQc4Wm)

[^39]: <a href="http://lxde.org/lxde/index.html">http://lxde.org/lxde/index.html</a>

[^40]: <a href="http://unity.ubuntu.com/projects/unity">http://unity.ubuntu.com/projects/unity</a>
