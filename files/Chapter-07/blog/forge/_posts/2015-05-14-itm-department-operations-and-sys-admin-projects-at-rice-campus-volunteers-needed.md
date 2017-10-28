---
layout: post
status: publish
published: true
title: Operations and Sys-Admin Projects at Rice Campus - Volunteers needed
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1375
wordpress_url: https://forge.sat.iit.edu/?p=1375
date: '2015-05-14 10:53:51 -0500'
date_gmt: '2015-05-14 15:53:51 -0500'
categories:
- Uncategorized
tags: []
comments: []
---
<p>This is professor Jeremy Hajek, some of you know me, some do not.  My area of interest is in Operations-systems administration and large scale deployments.  I have some research projects that I could use your help on this summer at the Wheaton Rice Campus of IIT.</p>
<p>Alas I cannot pay anyone but the experience you will gain on these projects will be very valuable and help set you apart from your classmates and those you will be competing with for jobs.  If the technologies listed here are unfamiliar to you that is ok as well &Gamma;&Ccedil;&ocirc; I will train you to get up to speed all I need are willing people who are in the ITM program, there will be some self-learning and independent work.   </p>
<p>These projects will provide infrastructure to support existing and future research as well as fresh vegetables*.  Schedules can be flexible too.  There may be some work from home opportunities pending a VPN getting setup.   (P.S. if terms here are new &Gamma;&Ccedil;&ocirc; type them into Wikipedia to get an idea of what they are)</p>
<p><strong>GPU passthrough of VFIO in Linux with KVM<&#47;strong></p>
<p>	This project is a cutting edge project that just recently became possible.  The purpose would be to enable GPU passthrough directly to a virtual machine in <a href="https:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Kernel-based_Virtual_Machine">KVM<&#47;a> (Linux Kernel Virtualization Module) Standard VM solution using the newer <a href="https:&#47;&#47;www.kernel.org&#47;doc&#47;Documentation&#47;vfio.txt">VFIO<&#47;a> (in supported kernels).   The ultimate goal is to use this in conjunction with 4 AMD Radeon GPUs in order to use them for <a href="https:&#47;&#47;en.wikipedia.org&#47;wiki&#47;OpenCL">OPENCL<&#47;a> processing (basically using the GPU for its floating point number calculation power)  This will enable us to couple this with KVM and make on demand GPU compute clusters.   Lots of work in Linux and all on the command line. Previous work listed here: <a href="https:&#47;&#47;forge.sat.iit.edu&#47;tag&#47;gpu&#47;">https:&#47;&#47;forge.sat.iit.edu&#47;tag&#47;gpu&#47;<&#47;a> </p>
<p><strong>Using Ubuntu MAAS & Juju to build a CEPH cluster<&#47;strong></p>
<p><a href="http:&#47;&#47;maas.ubuntu.com">MAAS (pronounced mass) Metal as a Service<&#47;a> is a tool from Ubuntu for deploying metal (rack mounted servers) and dynamically installing application and operating systems from scratch via 1 command.</p>
<p><a href="https:&#47;&#47;jujucharms.com&#47;">Juju<&#47;a> is the application magic that allows premade programs or charms to install software across multiple nodes.  Think like a package manager (apt or yum) but at web scale.  </p>
<p><a href="https:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Ceph_(software)">CEPH is a distributed object store and file system<&#47;a> designed to provide excellent performance, reliability and scalability.  Once we created a MAAS system we can use the testbed of servers at Rice Campus to create a CEPH cluster (object store)</p>
<p><strong>Eucalyptus Cloud platform building<&#47;strong></p>
<p> <a href="https:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Eucalyptus_(software)">Eucalyptus<&#47;a> is a cloud platform compatible with AWS (recently bought by HP but still opensource)  All of the above projects would be integrated into a custom cloud solution to make an extensible cloud that can offer CPU based and GPU based compute offerings as well as have a dynamic storage backend based on CEPH.  Current platform supports Centos but the GPU project will need to be compiled from source on Ubuntu.</p>
<p><strong>*Building a Vertical Garden<&#47;strong></p>
<p>	We have the remnants of two projects involving building self-contained gardens for growing food indoors.  I have all the supplies and materials.  This project involves IoT Internet of Things using Arduinos and a bit of ingenuity.  </p>
<p>Code is here (home automation)<br />
<a href="https:&#47;&#47;github.com&#47;jhajek&#47;ITMT492-FALL">https:&#47;&#47;github.com&#47;jhajek&#47;ITMT492-FALL<&#47;a></p>
<p>Videos here:  <a href="https:&#47;&#47;forge.sat.iit.edu&#47;tag&#47;iot">https:&#47;&#47;forge.sat.iit.edu&#47;tag&#47;iot<&#47;a><br />
Look for home automation video </p>
<p>Intelligent growing module<br />
<a href="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2014&#47;05&#47;ITMT492-project3-intelligent-indoor-growing-module-small.mp4">https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2014&#47;05&#47;ITMT492-project3-intelligent-indoor-growing-module-small.mp4<&#47;a></p>
<p>If you are interested we can start any time contact me via email <strong>hajek@iit.edu<&#47;strong></p>
