---
layout: post
status: publish
published: true
title: Making a GPU Cluster. (Part 2)
author:
  display_name: Eric Macorkel
  login: emacorke
  email: emacorke@hawk.iit.edu
  url: ''
author_login: emacorke
author_email: emacorke@hawk.iit.edu
wordpress_id: 1112
wordpress_url: https://blog.sat.iit.edu/?p=1112
date: '2014-07-06 19:07:20 -0500'
date_gmt: '2014-07-07 00:07:20 -0500'
categories:
- GPU
tags:
- gpu
comments: []
---
<p>This blog entry is a continuation of Making a GPU Cluster Part 1. In part 1 we created a GPU cluster using an ASUS P8Z77-V LK motherboard with three Radeon HD 6450 cards. We downloaded the AMD APP SDK onto the machine and installed OpenCL(A programming framework that lets users manage GPUs) by running the APP SDK. Aside from the AMD APP SDK installing OpenCL it also came with OpenCL samples which could be run to see if the system supported OpenCL. We ran the samples and found that our system supported OpenCL. The next thing we wanted to do was create a virtual machine or two that would simulate computers joining a network and asking our GPU cluster to share some of its GPU processing power. If the virtual machines can run the OpenCL samples off of our GPU cluster then we figured that this experiment in creating a GPU cluster would be a success.</p>
<p>Before creating the virtual machine maintenance and some installations are required. The first thing we installed was the required KVM RPMs&#47;packages. To do this we did the following commands at the command prompt&Gamma;&Ccedil;&ordf;</p>
<p><code>yum groupinstall &Gamma;&Ccedil;&pound;Virtualization Tools&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&pound;Virtualization Platform&Gamma;&Ccedil;&yen;<&#47;code></p>
<p><code>yum install python-virtinst<&#47;code></p>
<p>Then we turned on libvirtd service by doing&Gamma;&Ccedil;&ordf;</p>
<p><code>chkconfig libvirtd on<&#47;code></p>
<p>And started it using&Gamma;&Ccedil;&ordf;</p>
<p><code>service libvirtd start<&#47;code></p>
<p>Virtual machines normally only have access to host and other virtual machines on the same physical server via private a private network. If you want a virtual machine to have access to a LAN or the internet you&Gamma;&Ccedil;&Ouml;re going to need to set up a network bridge. Since we wanted to be able to ssh into our virtual machine setting up a network bridge was required. First we needed to download the required utilities for the network bridge. We did&Gamma;&Ccedil;&ordf;</p>
<p><code>yum install bridge-utils<&#47;code></p>
<p>To create the network bridge we had to edit or create a couple of files. By using the linux commands vi and cat you can edit and view files through the command prompt. We did&Gamma;&Ccedil;&ordf;</p>
<p><code>vim &#47;etc&#47;sysconfig&#47;network-scripts&#47;ifcfg-eth0<&#47;code></p>
<p>And added or edited the following lines&Gamma;&Ccedil;&ordf;</p>
<p><code>DEVICE=eth0<br />
ONBOOT=yes<br />
BRIDGE=br0<&#47;code></p>
<p>Next, we did&Gamma;&Ccedil;&ordf;</p>
<p><code>vim &#47;etc&#47;sysconfig&#47;network-scripts&#47;ifcfg-br0<&#47;code></p>
<p>And added or edited the following lines&Gamma;&Ccedil;&ordf;</p>
<p><code>DEVICE=br0<br />
TYPE=Bridge<br />
BOOTPROTO=static<br />
ONBOOT=yes</p>
<p>&#47;&#47;Enter LAN IPs as per your needs<br />
IPADDR=10.10.29.66<br />
NETMASK=255.255.255.192<br />
DELAY=0<&#47;code></p>
<p>Once we finished configuring our bridge we restarted our GPU cluster. A word of warning though, make sure that the br0 configuration entries are correct before you restart because you might lose ssh access to the server if there are mistakes in the files you edited&#47;made. You can restart the GPU cluster&#47;server with the command&Gamma;&Ccedil;&ordf;</p>
<p><code>service network restart<&#47;code></p>
<p>Once the system restarted we wanted to confirm that our bridge was created so we entered at the command prompt&Gamma;&Ccedil;&ordf;</p>
<p><code>Ifconfig<&#47;code></p>
<p>Making a GPU Cluster Part 3 will cover how we set up the virtual machine.<br />
<a href="https:&#47;&#47;blog.sat.iit.edu&#47;2014&#47;08&#47;making-a-gpu-cluster-part-3&#47;"><&#47;a></p>
