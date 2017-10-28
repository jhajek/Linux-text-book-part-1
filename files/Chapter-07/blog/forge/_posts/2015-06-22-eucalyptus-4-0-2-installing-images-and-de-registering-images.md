---
layout: post
status: publish
published: true
title: Eucalyptus 4.0.2 Installing Images and De-registering images
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1431
wordpress_url: https://forge.sat.iit.edu/?p=1431
date: '2015-06-22 23:40:29 -0500'
date_gmt: '2015-06-23 04:40:29 -0500'
categories:
- Cloud
tags:
- Eucalyptus
- HP
comments: []
---
<p>Since Eucalyptus 4.0.2 adding images and deregistering images has become vastly simple.  Before hand it seemed as a mystery how to create custom images. </p>
<p>The secret is in this repo <a href="https:&#47;&#47;github.com&#47;SAT-Hadoop&#47;cloud-images">https:&#47;&#47;github.com&#47;SAT-Hadoop&#47;cloud-images<&#47;a>  Basically you use <a href="http:&#47;&#47;packer.io">Packer.io<&#47;a> to build your custom images and then use euca-install-image:<br />
<code>euca-install-image -i output-qemu&#47;centos-6-base.raw --virtualization-type hvm -b centos-base -r x86_64 --name centos-base<&#47;code></p>
<p>Using this repo I have added the Ubuntu 14.04.2 image and removed 12.04.5 images, as well as the Fedora image.</p>
<p>You can use the commands here: euca-deregister  and euca-delete-bundle <a href="https:&#47;&#47;www.eucalyptus.com&#47;docs&#47;eucalyptus&#47;4.0.2&#47;index.html#image-guide&#47;img_task_remove_image.html">https:&#47;&#47;www.eucalyptus.com&#47;docs&#47;eucalyptus&#47;4.0.2&#47;index.html#image-guide&#47;img_task_remove_image.html<&#47;a></p>
<p>Find the image you want to remove. </p>
<blockquote><p><code>euca-describe-images<br />
IMAGE   emi-E533392E    alpha&#47;centos.5-3.x86-64.img.manifest.xml    965590394582<br />
available   public   i386    machine eki-345135C9    eri-C4F135BC  instance-store<br />
IMAGE   emi-623C38B0  alpha&#47;ubuntu.9-04.x86-64.img.manifest.xml   965590394582<br />
available   public   i386    machine eki-E6B13926    eri-94DB3AB9  instance-store<br />
<&#47;code><&#47;blockquote></p>
<p>Note the image file name (for example, emi-623C38B0). </p>
<p>Deregister the image. </p>
<blockquote><p><code>euca-deregister emi-623C38B0<br />
IMAGE   emi-623C38B0<br />
<&#47;code><br />
<&#47;blockquote></p>
<p>Delete the bundle. </p>
<blockquote><p><code>euca-delete-bundle -b alpha -p ubuntu.9-04.x86-64.img<br />
<&#47;code><&#47;blockquote></p>
