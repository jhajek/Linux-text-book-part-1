---
layout: page
status: publish
published: true
title: Cloud Operations Lab Hardware
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1568
wordpress_url: https://forge.sat.iit.edu/?page_id=1568
date: '2015-08-22 16:35:41 -0500'
date_gmt: '2015-08-22 21:35:41 -0500'
categories: []
tags: []
comments: []
---
<p>For a while I wanted to publish all of our research capabilities for the Cloud and Operations research group in the <a href="http:&#47;&#47;appliedtech.iit.edu&#47;" title="School of Applied Technology">School of Applied Technology <&#47;a> <a href="http:&#47;&#47;appliedtech.iit.edu&#47;itm" title="ITM">Information Technology and Management Program<&#47;a>.</p>
<p><a href="https:&#47;&#47;forge.sat.iit.edu&#47;wp-content&#47;uploads&#47;2015&#47;05&#47;AppendixForITResroucesABET.pdf">AppendixForITResroucesABET.pdf from 05&#47;15<&#47;a></p>
<p><strong>HP Eucalyptus 4.0.2 Cloud Computing Stack<&#47;strong><br />
<strong>Updated: 08&#47;10&#47;2016<&#47;strong><br />
<strong>Updated: 12&#47;02&#47;2016<&#47;strong></p>
<p>Eucalyptus is a private cloud platform now owned by <a href="http:&#47;&#47;www8.hp.com&#47;us&#47;en&#47;cloud&#47;helion-eucalyptus.html">HPE<&#47;a>.  Similar products would include <a href="https:&#47;&#47;www.openstack.org&#47;">OpenStack<&#47;a>.  Eucalyptus made the choice to make itself <a href="https:&#47;&#47;www.openstack.org&#47;">Amazon Web Services<&#47;a>compatible.  Though they lag behind in some cases, but the core functionality and syntax makes this still a useful product.</p>
<p>Our capacity is over 100 IPs supporting potentially over 200 virtual machine instances.  There are currently 4 node controllers (using Linux KVM), <del datetime="2016-12-02T16:58:56+00:00">1 TB of object based storage <&#47;del>(Object Storage Gateway) 500 GB of object based storage and <del datetime="2016-12-02T16:58:56+00:00">750 GB of Elastic Block based storage (EBS)<&#47;del> 11 TB of Elastic Block based storage (EBS) using <a href="https:&#47;&#47;www.cdw.com&#47;shop&#47;products&#47;WD-Red-WD30EFRX-hard-drive-3-TB-SATA-600&#47;2764461.aspx">Western Digital Red<&#47;a> drives.  The HP Eucalyptus cloud supports similar function and control as AWS cloud.   Capabilities include:</p>
<ul>
<li>Elastic Load-balancing<&#47;li>
<li>Security Groups (Firewall)<&#47;li>
<li>RSA key based authentication (no passwords ever)<&#47;li>
<li>Cloud-watch (internal metrics)<&#47;li>
<li>Auto-scaling groups<&#47;li>
<li><del datetime="2016-12-02T16:58:56+00:00">University VPN access has been configured and used<&#47;del><&#47;li><br />
<&#47;ul></p>
<p> There is a matrix of AWS API support as well that I configured and published:</p>
<ul>
<li><a href="https:&#47;&#47;forge.sat.iit.edu&#47;2016&#47;06&#47;eucalyptus-4-0-2-supports-using-walrus-aws-java-sdk-1-11-4-but-really-1-9-4&#47;">Eucalyptus 4.0.2 supports using AWS Java SDK 1.11.4 for Walrus but really 1.9.4<&#47;a><&#47;li>
<li><a href="https:&#47;&#47;forge.sat.iit.edu&#47;2016&#47;03&#47;aws-for-php-3-x-on-eucalyptus-4-0-2-works-like-a-charm&#47;">AWS SDK for PHP 3.x on Eucalyptus 4.0.2 Works Like a Charm<&#47;a><&#47;li>
<li><a href="https:&#47;&#47;forge.sat.iit.edu&#47;2016&#47;05&#47;using-s3cmd-with-walrus-and-hp-eucalyptus-4-0-2-works-but-with-a-twist&#47;">Using S3cmd with Walrus on Eucalyptus 4.0.2 works but with a twist.<&#47;a><&#47;li>
<li><a href="https:&#47;&#47;forge.sat.iit.edu&#47;2016&#47;02&#47;euca2ools-3-1-x-installation-and-connection-testing-to-eucalyptus-4-0-2&#47;">Euca2ools 3.1.x installation and connection testing<&#47;a><&#47;li><br />
        <&#47;ul></p>
<p>There are two choices of instances that are currently available - Centos 6.8 and Ubuntu 14.04.5</p>
<p>The most recent course to run using this system was ITMT 430 Undergraduate Capstone Course which spent a semester building and deploying salable applications. Services are self-serve via a portal <a href="https:&#47;&#47;eucalyptus.sat.iit.edu">https:&#47;&#47;eucalyptus.sat.iit.edu<&#47;a> or via command line tool kit called Euca2ools.   Current status requires a username password to be created for access - Active Directory integration is available and I would like to pursue this over the winter break of 2016 to have ready for Spring of 2017 and expand the availability to a larger group.</p>
<p>Location IIT Rice Campus</p>
<ul>
<li>Incheon - Dell PowerEdge 2970 12 cores 32 GB of memory 1 TB of 15K SCSI local storage<&#47;li>
<li>Alexandria - Dell PowerEdge R710 8 cores 96 GB of memory 3 TB of local storage  <&#47;li>
<li>Quantas - Dell PowerEdge R510 8 cores 32 GB of memory 3 TB of local storage <&#47;li>
<li>Nebelet - Dell PowerEdge R510 8 cores 32 GB of memory 3 TB of local storage   <&#47;li>
<li>eucalyptus.sat.iit.edu 1 Dell PowerEdge 1850<&#47;li>
<li>White Box Cloud Controller Intel G850 Processor 16 GB of memory 11 TB of storage<&#47;li>
<li><del datetime="2016-12-02T16:58:56+00:00">oswego.sat.iit.edu -> Cobbler server 1 Dell PowerEdge SC 1425<&#47;del><&#47;li><br />
<&#47;ul></p>
<p><strong>Deployment and Operations Research Cluster<&#47;strong></p>
<p>Provides research capabilities into CEPH distributed file system clusters and MAAS (Metal as a Service) clustering for application install.</p>
<p>16 Dell Poweredge 1425 40 GB hard drive 4 GB of memory 2 Single core Xeon processors</p>
<p><strong>Eucalyptus Private Test Cloud<br />
<&#47;strong><br />
Test Cloud 1 is used for the practice of installation and upgrade testing for production cloud, using Centos 6</p>
<ul>
<li>1 WhiteBox servers 8 cores 16 GB memory 1 TB of local storage<&#47;li>
<li>3 ASUS RS100-X7 4 cores each &Gamma;&Ccedil;&ocirc; 8 GB memory 1 TB local storage <&#47;li><br />
<&#47;ul></p>
<p><strong>Test Cloud 2 is used for research into pass-through via VFIO in the Linux Kernel for use in on demand GPU cloud computing resources.<&#47;strong></p>
<ul>
<li>1 White Box servers 8 cores 16 GB memory 1 TB of local storage<&#47;li>
<li>3 ASUS RS100-X7 4 cores each &Gamma;&Ccedil;&ocirc; 8 GB memory 1 TB local storage <&#47;li>
<li>1 GPU cluster for GPU research &Gamma;&Ccedil;&ocirc; Containing for AMD Radeon<&#47;li>
<li>3 white box storage systems.<&#47;li><br />
<&#47;ul></p>
<p>Actual Image Located at the Wheaton Rice Campus - Room 242<br />
<a href="https:&#47;&#47;forge.sat.iit.edu&#47;wp-content&#47;uploads&#47;2015&#47;08&#47;WP_20150506_12_32_34_Pro.jpg"><img src="https:&#47;&#47;forge.sat.iit.edu&#47;wp-content&#47;uploads&#47;2015&#47;08&#47;WP_20150506_12_32_34_Pro-169x300.jpg" alt="WP_20150506_12_32_34_Pro" width="169" height="300" class="aligncenter size-medium wp-image-1934" &#47;><&#47;a></p>
