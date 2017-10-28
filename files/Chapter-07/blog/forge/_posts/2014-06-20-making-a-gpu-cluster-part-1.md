---
layout: post
status: publish
published: true
title: Making a GPU Cluster. (Part 1)
author:
  display_name: Eric Macorkel
  login: emacorke
  email: emacorke@hawk.iit.edu
  url: ''
author_login: emacorke
author_email: emacorke@hawk.iit.edu
wordpress_id: 1109
wordpress_url: https://blog.sat.iit.edu/?p=1109
date: '2014-06-20 19:11:19 -0500'
date_gmt: '2014-06-21 00:11:19 -0500'
categories:
- GPU
tags:
- gpu
comments: []
---
<p>During the final weeks of spring semester I was hired on as a Student Assistant. My boss, Jeremy, explained to me that I would help him in creating a GPU cluster. This GPU cluster would be a server running multiple graphic cards. The purpose of this GPU cluster is to allow users to lease processing power from the graphic cards of the server to help in the running of computation heavy applications. In essence we were creating a cloud computing service, specifically, a PaaS(Platform as a Service).</p>
<p>Creating a GPU cluster can be a daunting task for anyone who has never done it before, such as myself, because there are many considerations to take into account before you even begin really creating a GPU cluster. First and foremost is the consideration that we needed a framework that would allow applications access to GPUs for non-graphical computing needs. The two most popular frameworks out there is OpenCL(Open Computing Language) and OpenGL(Open Graphics Library). OpenCL is the framework that most AMD cards work with while OpenGL is the framework most Nvidea cards work with. Since we had a lot of AMD cards lying around in the computing lab we were working out of and had more familiarity with AMD cards we decided to go with OpenCL as our framework. We were then prepared to start creating this GPU cluster in earnest but we hit a snag. Specifically, we found out that the AMD cards we had lying around were not OpenCL compatible. So in response we tracked down a list of AMD cards that were compatible with OpenCL.</p>
<p><a href="http:&#47;&#47;developer.amd.com&#47;tools-and-sdks&#47;opencl-zone&#47;opencl-tools-sdks&#47;amd-accelerated-parallel-processing-app-sdk&#47;system-requirements-driver-compatibility&#47;">http:&#47;&#47;developer.amd.com&#47;tools-and-sdks&#47;opencl-zone&#47;opencl-tools-sdks&#47;amd-accelerated-parallel-processing-app-sdk&#47;system-requirements-driver-compatibility&#47;<&#47;a></p>
<p>The link provided shows all the AMD cards that support the APP SDK that is used to install OpenCL onto a machine. After deciding on an OpenCL compatible AMD GPU, in our case the Radeon HD 6450, we needed to consider whether the motherboards we had lying around supported our GPU and whether they had enough PCI-e slots to support multiple copies of our GPU. As it turns out the motherboards we had lying around weren&Gamma;&Ccedil;&Ouml;t up to the task so we had to purchase a new motherboard along with multiple copies of the Radeon HD 6450. The motherboard we decided on was the ASUS P8Z77-V LK.</p>
<p>Once we received the motherboard and graphics cards we used a case of a server we weren&Gamma;&Ccedil;&Ouml;t using and built the server for our GPU cluster. With the hardware considerations of the GPU cluster out of the way we turned our attention to the software considerations for the GPU cluster. The first thing we had to decide was what OS we would use for the server that would become a GPU cluster. Since we wanted to save some money we decided to go with a Linux installation. The question then became what flavor of Linux should we install that would work with OpenCL? We decided to visit the AMD site and took a look at the APP SDK download section. While there we found out that OpenCL would work with openSUSE, Ubuntu, and Red Hat Enterprise Linux.</p>
<p><a href="http:&#47;&#47;developer.amd.com&#47;tools-and-sdks&#47;opencl-zone&#47;opencl-tools-sdks&#47;amd-accelerated-parallel-processing-app-sdk&#47;">http:&#47;&#47;developer.amd.com&#47;tools-and-sdks&#47;opencl-zone&#47;opencl-tools-sdks&#47;amd-accelerated-parallel-processing-app-sdk&#47;<&#47;a></p>
<p>In the end we decided to go with a CentOS installation which is a free Linux OS offshoot of Red Hat Enterprise Linux. The link for the OS download can be found here.</p>
<p><a href="http:&#47;&#47;wiki.centos.org&#47;Download">http:&#47;&#47;wiki.centos.org&#47;Download<br />
<&#47;a></p>
<p>After installing a minimal installation of CentOS the next thing we needed to do was install OpenCL onto the server. We did wget followed by the path to the download at the command prompt to download the APP SDK. (link for it was provided earlier) When we finished downloading the APP SDK we navigated to where we downloaded it using cd at the command prompt and did a tar-xzvf followed by the file name at the command prompt to unpack it. We then ran the file that would install the APP SDK&#47;OpenCL onto our machine but ran into some problems installing it. It turns out that we needed kernel headers and a C++ compiler for the samples provided in the SDK. So we typed into the command prompt...</p>
<p><code><br />
yum install kernel-devel kernel-headers gcc gcc-c++ 2.6.32-431.23.3.el6.x86_64<&#47;code></p>
<p>After the installation of the headers and compilers we then were able to successfully install the APP SDK. We then navigated to where the samples were which should look similar to this:</p>
<p><code>&#47;opt&#47;AMDAPP&#47;samples&#47;opencl&#47;bin&#47;x86_64 (this is for a 64 bit installation of the APP SDK. Adjust accordingly for a 32 bit installation)<&#47;code></p>
<p>We then ran a couple of samples and were happy that they worked because it proved that OpenCL could be run on our system. We were finally on our way to creating a GPU cluster.</p>
<p>Part 2</p>
<p><a href="https:&#47;&#47;blog.sat.iit.edu&#47;2014&#47;07&#47;making-a-gpu-cluster-part-2&#47;">https:&#47;&#47;blog.sat.iit.edu&#47;2014&#47;07&#47;making-a-gpu-cluster-part-2&#47;<&#47;a></p>
