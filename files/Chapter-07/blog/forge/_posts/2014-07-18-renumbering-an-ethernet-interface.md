---
layout: post
status: publish
published: true
title: Renumbering an Ethernet Interface
author:
  display_name: Eric Macorkel
  login: emacorke
  email: emacorke@hawk.iit.edu
  url: ''
author_login: emacorke
author_email: emacorke@hawk.iit.edu
wordpress_id: 1129
wordpress_url: https://blog.sat.iit.edu/?p=1129
date: '2014-07-18 21:35:17 -0500'
date_gmt: '2014-07-19 02:35:17 -0500'
categories:
- GPU
tags:
- gpu
comments: []
---
<p>Due to a mishap with a motherboard that had bent CPU slot pins we needed to replace our motherboard. After receiving the new motherboard we took the CPU, GPUs, and the RAM of our previous motherboard and put them in the new motherboard. We booted up our server and expected everything to work the way they always have but we encountered a problem. Specifically, we couldn&Gamma;&Ccedil;&Ouml;t access the local network and internet. We typed in ifconfig at the command prompt and noted that a different Ethernet interface was detected. Instead of showing eth0, the interface we had been using all along, eth1 was shown instead.</p>
<p>When we tried to bring up eth0 by typing into the command prompt ifconfig eth0 up the system responded that eth0 didn&Gamma;&Ccedil;&Ouml;t exist. After some brainstorming we remembered that we were using the Ethernet interface of the motherboard. By using a new motherboard we were in fact using a different Ethernet interface which the system made a note of and called eth1. Since all of the networking scripts, IP table settings, and other files were configured with the Ethernet interface of our previous motherboard (eth0) we couldn&Gamma;&Ccedil;&Ouml;t get on the internet. The solution was to rename&#47;renumber our current Ethernet interface to say its eth0. To do this we needed to edit two files.</p>
<p>The first file we edited was the 70-persistent-net.rules file. So at the command prompt we typed in&Gamma;&Ccedil;&ordf;</p>
<p><code>vim &#47;etc&#47;udev&#47;rules.d&#47;70-persistent-net.rules<&#47;code></p>
<p>When we opened up the file using vim we saw entries that looked like the following&Gamma;&Ccedil;&ordf;</p>
<p><code>SUBSYSTEM==&Gamma;&Ccedil;&yen;net&Gamma;&Ccedil;&yen;, ACTION==&Gamma;&Ccedil;&yen;add&Gamma;&Ccedil;&yen;, DRIVERS==&Gamma;&Ccedil;&yen;?*&Gamma;&Ccedil;&yen;, ATTR{address}==&Gamma;&Ccedil;&yen;00:0c:29:de:ad:20&Gamma;&Ccedil;│, ATTR{type}==&Gamma;&Ccedil;&yen;1&Gamma;&Ccedil;│, KERNEL==&Gamma;&Ccedil;&yen;eth*&Gamma;&Ccedil;&yen;, NAME=&Gamma;&Ccedil;&yen;eth0&Gamma;&Ccedil;│<&#47;code><br />
<code>SUBSYSTEM==&Gamma;&Ccedil;&yen;net&Gamma;&Ccedil;&yen;, ACTION==&Gamma;&Ccedil;&yen;add&Gamma;&Ccedil;&yen;, DRIVERS==&Gamma;&Ccedil;&yen;?*&Gamma;&Ccedil;&yen;, ATTR{address}==&Gamma;&Ccedil;&yen;00:0c:29:de:ad:2a&Gamma;&Ccedil;&yen;, ATTR{type}==&Gamma;&Ccedil;&yen;1&Gamma;&Ccedil;│, KERNEL==&Gamma;&Ccedil;&yen;eth*&Gamma;&Ccedil;&yen;, NAME=&Gamma;&Ccedil;&yen;eth1&Gamma;&Ccedil;│<&#47;code></p>
<p>The first entry showed information regarding our previous motherboard&Gamma;&Ccedil;&Ouml;s Ethernet interface card eth0. The second entry showed information regarding our new motherboard&Gamma;&Ccedil;&Ouml;s Ethernet interface card eth1.  What we needed to do was delete the first entry and then edit the second entry. Under the second entry there was an attribute called &Gamma;&Ccedil;&pound;NAME&Gamma;&Ccedil;&yen;.  We changed the entry of eth1 to eth0. Finally, we wrote down the MAC address of our card which was 00:0c:29:de:ad:2a. We would use the MAC address we wrote down to edit the second file. We saved our changes and exited vim.</p>
<p>The second file we needed to edit was our networking script for eth0. So at the command prompt we typed in&Gamma;&Ccedil;&ordf;</p>
<p><code>vim &#47;etc&#47;sysconfig&#47;network-scripts&#47;ifcfg-eth0<&#47;code></p>
<p>This file has an entry called &Gamma;&Ccedil;&pound;HWADDR&Gamma;&Ccedil;&yen; which has the MAC address of eth0. The MAC address in this file mapped to the MAC address of the Ethernet Interface of our previous motherboard. We replaced the MAC address with the MAC address we wrote down earlier. It should be noted that If this file doesn&Gamma;&Ccedil;&Ouml;t have an entry called &Gamma;&Ccedil;&pound;HWADDR&Gamma;&Ccedil;&yen; then one must create this entry and type in the MAC address written down earlier. We saved, exited VIM, and rebooted the system. Once that was done we did ifconfig at the command prompt and checked to see if our edits went through. It did and we then checked to see if we were able to connect to the network and internet. To our relief we were able to.</p>
