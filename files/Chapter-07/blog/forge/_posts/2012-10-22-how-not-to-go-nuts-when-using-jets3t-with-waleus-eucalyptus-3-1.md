---
layout: post
status: publish
published: true
title: How not to go nuts when using JetS3t with Waleus & Eucalyptus 3.1
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 438
wordpress_url: http://blog.sat.iit.edu/?p=438
date: '2012-10-22 10:20:15 -0500'
date_gmt: '2012-10-22 15:20:15 -0500'
categories:
- tools
- Projects
- Cloud
- fun
tags:
- Eucalyptus
- HP
- Ubuntu
comments: []
---
<p>The open source Cloud Computing Platform <a href="http:&#47;&#47;www.eucalyptus.com" title="Eucalyptus">Eucalyptus<&#47;a> has a neat feature called Walrus or W3.  It is a <a href="http:&#47;&#47;en.wikipedia.org&#47;wiki&#47;SaaS" title="SaaS">Storage as a Service<&#47;a>  compatible with <a href="http:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Amazon_S3" title="S3">Amazons S3<&#47;a> -- but for use in-house.  </p>
<p> I have been using an opensource library called <a href="http:&#47;&#47;jets3t.s3.amazonaws.com&#47;index.html" title="JetS3t">JetS3t (pronounced JetSet)<&#47;a> configured to be able to work with Amazon S3 - <a href="http:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Amazon_S3" title="Google Storage Servcice">Google Storage Service<&#47;a> - and Eucalyptus.  The image below shows the configuration file for JetS3t.</p>
<p>There are a few settings that need changing</p>
<ul>
<code>s3service.https-only      needs to be set to false (no https yet for Walrus)<br />
s3service.s3-endpoint     needs to be set to the IP address of your Walrus instance<br />
s3service.s3-endpoint-virtual-path    needs to be set to the Walrus service location - which is &#47;services&#47;Walrus (no trailing slash)<&#47;ul><&#47;code><br />
If you change these three you will be able to list your buckets but not objects - hmm...  what is the issue.<br />
There is one more setting that needs to be changed...</p>
<ul>
s3.service-disable-dns-buckets      needs to be set to true<br />
<&#47;ul><br />
I beleive this allows the JetS3t library to look up bucket names via direct IP instead of using a FQDN.</p>
<p>Now the next post is how to get the Amazon Java SDK to work with Eucalyptus - this should point me in the right direction.  NOTE - this configuration should work for older Walruses as well.<br />
<a href="http:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2012&#47;11&#47;EucalyptusJetS3t.png"><img src="http:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2012&#47;11&#47;EucalyptusJetS3t-300x139.png" alt="" title="EucalyptusJetS3t" width="300" height="139" class="alignnone size-medium wp-image-459" &#47;><&#47;a></p>
