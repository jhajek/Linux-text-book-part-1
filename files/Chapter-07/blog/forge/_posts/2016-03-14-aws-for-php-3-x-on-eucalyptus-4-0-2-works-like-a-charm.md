---
layout: post
status: publish
published: true
title: AWS for PHP 3.x on Eucalyptus 4.0.2 - EC2 commands works like a charm
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1659
wordpress_url: https://forge.sat.iit.edu/?p=1659
date: '2016-03-14 14:39:26 -0500'
date_gmt: '2016-03-14 19:39:26 -0500'
categories:
- Cloud
- fun
- Eucalyptus
tags:
- cloud
- HP Eucalyptus 4.0.2
- AWS-SDK-PHP-V3
comments: []
---
<p>Hello,</p>
<p>  My mission started off to see if I could figure out how to integrate the <a href="http:&#47;&#47;docs.aws.amazon.com&#47;aws-sdk-php&#47;v3&#47;api&#47;">AWS SDK for PHP v3<&#47;a> to use it on Eucalyptus 4.0.2 production systems.</p>
<p>Researching the internet turned up not much current information.  But it did turn up these two original pieces of information about getting the AWS PHP SDK v1 to run from 2013.</p>
<ul>
<li><a href="https:&#47;&#47;github.com&#47;eucalyptus&#47;eucalyptus&#47;wiki&#47;Using-PHP-with-Eucalyptus">https:&#47;&#47;github.com&#47;eucalyptus&#47;eucalyptus&#47;wiki&#47;Using-PHP-with-Eucalyptus<&#47;a><&#47;li>
<li><a href="https:&#47;&#47;github.com&#47;eucalyptus&#47;eucalyptus&#47;wiki&#47;AWS-SDK-for-PHP">https:&#47;&#47;github.com&#47;eucalyptus&#47;eucalyptus&#47;wiki&#47;AWS-SDK-for-PHP<&#47;a><&#47;li><br />
<&#47;ul></p>
<p>But AWS PHP SDK 1.0 is <a href="https:&#47;&#47;github.com&#47;amazonwebservices&#47;aws-sdk-for-php">deprecated<&#47;a>, big time. </p>
<p>So what to do?  Perhaps you could just make a drop in replacement?  If only that was possible.  It seems that AWS always modifys there API terminology per version.  B</p>
<p>To the rescue! As of Eucalyptus 4.x branch the developers have managed to match their code perfectly and v3 api works right out of the box.</p>
<p>Steps to recreate:<br />
Install the AWS PHP SDK v3 via composer following <a href="http:&#47;&#47;docs.aws.amazon.com&#47;aws-sdk-php&#47;v3&#47;guide&#47;getting-started&#47;installation.html">normal AWS directions<&#47;a></p>
<p>Once that is done - you need to do some reading.   </p>
<p>Based on the two articles of the hardwork done to make the AWS PHP SDK work with Eucalyptus no longer work directly - you have to read the Aws&#47;Ec2&#47;Ec2Client constructor.  All the information is actually encased in the previous Eucalyptus wiki articles but the constructor names have changed!</p>
<p>So after 10 minutes of reading I realized that this was an easy fix.<br />
<a href="http:&#47;&#47;docs.aws.amazon.com&#47;aws-sdk-php&#47;v3&#47;api&#47;class-Aws.Ec2.Ec2Client.html">Go directly to the Elastic Compute Cloud portion of the AWS PHP SDK<&#47;a> and scroll down to the constructor and see for yourself.</p>
<p><a href="/assets/2016&#47;03&#47;ec2.png" rel="attachment wp-att-1661"><img src="/assets/2016&#47;03&#47;ec2-300x180.png" alt="ec2" width="300" height="180" class="alignnone size-medium wp-image-1661" &#47;><&#47;a></p>
<p>Once that work was done here is all that is needed to get the EC2 tools via PHP running:</p>
<pre lang="PHP">
<p>&#060;&#063;php<br />
require 'vendor&#47;autoload.php';<br />
use Aws\Ec2\Ec2Client;</p>
<p>$client = new Ec2Client([<br />
  'scheme' => 'http',<br />
  'endpoint' => 'Your-CLC-IP-Here:8773&#47;',<br />
  'validate' => false,<br />
  'version' => '2015-10-01',<br />
  'region' => 'us-east-1',<br />
  'credentials' => [<br />
     'key' => 'Your-KEY-HERE',<br />
     'secret' => 'Your-Secret-Key_here',<br />
     ],</p>
<p>]);</p>
<p>$result = $client->describeInstances([</p>
<p>]);</p>
<p>print_r($result);<br />
?><&#47;pre></p>
<p>Note I hard coded the credentials for two reasons:  1 you have to change the permissions of any credentials file - like ~&#47;.aws&#47;crednetials because it is owned by root:root on any Eucalyptus created image.</p>
<p>Or you could use IAM - which I am working on =) </p>
<p>But at least this gets you started!</p>
<p>S3 is my next take but their constructor is not so straight forward.</p>
<p>take care<br />
Jeremy Hajek </p>
