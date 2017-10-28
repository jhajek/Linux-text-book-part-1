---
layout: post
status: publish
published: true
title: Resizing KVM Images
author:
  display_name: warrken
  login: warrken
  email: warrken@hawk.iit.edu
  url: ''
author_login: warrken
author_email: warrken@hawk.iit.edu
wordpress_id: 173
wordpress_url: http://blog.sat.iit.edu/?p=173
date: '2011-11-02 10:22:09 -0500'
date_gmt: '2011-11-02 15:22:09 -0500'
categories:
- tools
- Projects
- Cloud
- fun
tags:
- Eucalyptus
- KVM
comments: []
---
<p>There is a post <a title="Resizing and Uploading UEC image" href="http:&#47;&#47;blog.sat.iit.edu&#47;2011&#47;09&#47;resizing-and-uploading-uec-image&#47;">below<&#47;a> regarding resizing UEC images. This works great if you're using preexisting images from a tarball. However, if you have created your own images using the kvm-img tool, you'll need to do something a little different.</p>
<p>The kvm-img tool provides a resize utility that is <em>very<&#47;em> easy to use.</p>
<p>&nbsp;<code>kvm-image resize filename [+|-]size<&#47;code></p>
<p>You simply give it the filename of your image and either the explicit new size you want to use, or add or subtract space by using the optional plus or minus signs.</p>
<p>You'll need to go into the VM and use the file system tools to actually access the new space, but this is the fastest way to get more space for your virtual images created with KVM, as these won't work with regular file image&#47;system tools.</p>
