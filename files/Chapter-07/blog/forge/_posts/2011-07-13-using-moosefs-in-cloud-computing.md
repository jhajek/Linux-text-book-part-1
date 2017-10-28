---
layout: post
status: publish
published: true
title: Using MooseFS in Cloud Computing
author:
  display_name: zwagner
  login: zwagner
  email: zwagner@iit.edu
  url: ''
author_login: zwagner
author_email: zwagner@iit.edu
wordpress_id: 6
wordpress_url: http://aurora.rice.iit.edu/?p=6
date: '2011-07-13 14:31:38 -0500'
date_gmt: '2011-07-13 20:31:38 -0500'
categories:
- Uncategorized
tags:
- MooseFS
- cloud
- IT
- IIT
- file system
comments: []
---
<p>The cloud computing project that our team here at IIT has been working on is still chugging along. ┬&aacute;My role has been to research and test a file system for our cloud's storage. ┬&aacute;The file system I've been using is <em>MooseFS<&#47;em> (<a title="www.moosefs.org" href="http:&#47;&#47;www.moosefs.org" target="_blank">www.moosefs.org<&#47;a>).</p>
<p><strong><em>MooseFS<&#47;em> Background<&#47;strong></p>
<p><strong><&#47;strong>As far as standard file operations go, <em>MooseFS<&#47;em> is similar to any other Unix-based file system. ┬&aacute;However, <em>MooseFS<&#47;em> also has:</p>
<ul>
<li>High Reliability - multiple copies of data can be stored over different servers<&#47;li>
<li>Dynamic Expandability - more capacity is attained by adding more servers and&#47;or disks<&#47;li>
<li>"Trash Bin" - deleted files are still retained for a configurable period of time<&#47;li>
<li>File Snapshots - even when files are being written or read<&#47;li><br />
<&#47;ul></p>
<div><em>MooseFS<&#47;em> architecture is made up of four major components: ┬&aacute;master server, chunk server, metalogger server, and a mount.<&#47;div></p>
<div>
<ul>
<li><em>Master Server<&#47;em> is a managing server. ┬&aacute;It is a single machine that manages the whole file system and stores metadata for every file.<&#47;li>
<li><em>Chunk Servers<&#47;em> are the data servers. ┬&aacute;They store file data and synchronize it among themselves (if multiple copies are to be stored).<&#47;li>
<li><em>Metalogger Server<&#47;em> is a metadata backup server. ┬&aacute;This stores metadata changelogs and periodically downloads the main metadata file. ┬&aacute;Also serves as a back-up master server.<&#47;li>
<li><em>Mounts<&#47;em> are the client computers that access the files in <em>MooseFS<&#47;em>. ┬&aacute;Mounts use the mfsmount process to communicate with the master server and chunk servers.<&#47;li><br />
<&#47;ul></p>
<div><em>MooseFS<&#47;em> is available on Linux, FreeBSD, OpenSolaris, and MacOS X.<&#47;div><br />
<&#47;div><br />
&nbsp;</p>
<div><strong>My <em>MooseFS<&#47;em> Test System for the Cloud<&#47;strong><&#47;div><br />
&nbsp;</p>
<div>My test system consists of 5 PC's: ┬&aacute;1 Master Server, 1 Metalogger Server, 2 Chunk Servers, and 1 Client System. ┬&aacute;Eventually the Client System won't be needed because my test system will be attached to the storage controller for the cloud.<&#47;div><br />
&nbsp;</p>
<div>I installed MooseFS on top of machines running the Ubuntu server OS. ┬&aacute;The installs on each of the machines were straightforward since the <em>MooseFS<&#47;em>┬&aacute;contained a step-by-step installation document for each machine. ┬&aacute;There was a small hiccup. ┬&aacute;After trying to configure <em>MooseFS<&#47;em>, I realized I needed to install the <em>zlib<&#47;em> data compression package (<a title="zlib.net" href="http:&#47;&#47;zlib.net" target="_blank">www.zlib.net<&#47;a>). ┬&aacute;After getting that installed, the <em>MooseFS<&#47;em> install was a breeze.<&#47;div><br />
&nbsp;</p>
<div>Trying to mount the Client to the Master Server also proved troublesome at first. ┬&aacute;It turned out to be a faulty ethernet cable. ┬&aacute;After that was fixed I had my entire test system up and running.<&#47;div><br />
&nbsp;</p>
<div>With that out of the way, my next goal is to try and configure the Metalogger Server as a back-up to the Master Server. ┬&aacute;I hope my next post proves that I was successful.<&#47;div><br />
&nbsp;</p>
<div>Take care,<&#47;div></p>
<div>Zachary Wagner<&#47;div></p>
