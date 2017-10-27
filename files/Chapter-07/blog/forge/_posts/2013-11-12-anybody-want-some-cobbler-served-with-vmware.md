---
layout: post
status: publish
published: true
title: Anybody want some Cobbler served with VMware?
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1003
wordpress_url: https://blog.sat.iit.edu/?p=1003
date: '2013-11-12 23:13:38 -0600'
date_gmt: '2013-11-13 05:13:38 -0600'
categories:
- tools
- Projects
tags:
- cobbler
- Ubuntu
- VMWear
comments: []
---
<p>Dear World,</p>
<p>  After finding <a href="http:&#47;&#47;www.cobblerd.org" title="Cobbler! Woot!">cobbler<&#47;a> it has made installing so much easier.  Being 2014 I guess I should have found this earlier - but basically I haven't used a CD or flashdrive in about 2 months!  </p>
<p>  Here are some resources to cobble together a way to place VMware esxi 4.1 onto cobbler:<br />
Note: I am using cobbler 2.2.3 in Ubuntu 12.04  </p>
<p><code>sudo cobbler import --name=esxi-4.1u3 --arch=x86_64 --path=&#47;mnt&#47;disk<&#47;code>   &#47;mnt&#47;disk is the vmware iso mounted to the local system - this was all that was needed to get the instance appear in the distros category. Enjoy!</p>
<p>Next up - FreeBSD on cobbler! <a href="http:&#47;&#47;blog.hostileadmin.com&#47;2013&#47;04&#47;11&#47;installing-freebsd-via-cobbler&#47;">here<&#47;a> and <a href="http:&#47;&#47;www.cobblerd.org&#47;manuals&#47;2.2.3&#47;1&#47;2_-_Distribution_Support.html">here<&#47;a>  (Yes I do like pain thank you very much!)</p>
