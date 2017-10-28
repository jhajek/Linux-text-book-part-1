---
layout: post
status: publish
published: true
title: Amazon AWS S3 vs Cloudwatch Performance Grudgematch.
author:
  display_name: jbrown20
  login: jbrown20
  email: jbrown20@hawk.iit.edu
  url: ''
author_login: jbrown20
author_email: jbrown20@hawk.iit.edu
wordpress_id: 227
wordpress_url: http://blog.sat.iit.edu/?p=227
date: '2011-12-20 08:35:22 -0600'
date_gmt: '2011-12-20 14:35:22 -0600'
categories:
- Uncategorized
tags: []
comments: []
---
<p><a href="http:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;12&#47;Ali3.jpg"><img class="alignleft size-medium wp-image-243" style="border: 20px solid white" src="http:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;12&#47;Ali3-300x223.jpg" alt="Ali KO" width="300" height="223" &#47;><&#47;a></p>
<p>The great thing about AWS is options, it's almost as if the Amazon Web Services Board of Directors just can't say no to any of it's Software Engineers ideas. For that last six years Amazon's S3 has provided cheap, reliable file hosting. But in spite of everything S3 has to offer it has some serious flaws. In order to overcome these flaws Amazon has released Cloudfront. Cloudfront offers increased file security and management over S3. Cloudfront allows you to protect streaming video from being saved by clients to disk. Cloudfront can also stop other websites from linking to your files, and passing hosting cost on to you. Of course those things are great but Cloudfront is also the clear winner in bandwidth, and as I will clearly demonstrate, it's not even close. But, how do we test it?</p>
<p>In the past I had always been annoyed that OS X decided to include CURL in it's default bins and instead of WGET. I really like WGET, It's lightweight and just downloads the target URL to the current working directory without some terse list of options. CURL on the other hand is annoying and noisy. The user has to specify the output directory and use the proper switch options or the download will either fail or fill up the terminal with a pointless series of download indicators which finally end with a self important list of download stats. Oh wait, download stats, I guess I finally get to use those for something!</p>
<p>At first I was very confused by the results of my tests because I had read post after post drooling over Cloudfront and it's clear superiority in performance, but I just wasn't seeing it. I ran download tests of an identical sample file from S3 and Cloudfront from my home and office Internet connections and the numbers came out pretty flat. On an average of five tests, Cloudfront from work was 1232kB and from home it was 1119kB. S3 from work was 1837kB and from home was 1561kB. After both of these tests I realized that while both of these connections are pretty fast, they were in no way fast enough to test Amazon.</p>
<p>After failing to come up with a test that told me anything using my connections, I had to try a different approach. In thinking about the flaws of testing via my connections I realized there was another issue. End users are everywhere and my connections are only in Chicago. But, I could kill both of these birds with one stone by testing Amazon with Amazon. I decided to spin up CentOS instances in Singapore, Ireland and Virginia and test from fast nodes distributed all over the globe. The results from an average of five tests were strikingly different. Cloudfront in Singapore beat S3 7649kB to 351kB, from Ireland Cloudfront destroyed S3 29461kB to 839kB, and finally from Virginia Cloudfront won 12753kB to 5064kB. The overall results were Cloudfront 16621kB to 2084kB.</p>
<p>The Judges score cards for our Amazon AWS S3 vs Cloudwatch Performance Grudgematch just hit the garbage can because this one is a KO in the second round. By protecting your data and distributing your files over nodes globally, Cloudfront proves to be the obvious choice for file downloading and streaming in the Amazon set of tools.</p>
<p>Test file <a href="https:&#47;&#47;s3.amazonaws.com&#47;ImageProJeremyBrown&#47;S3CloudfrontCurlStats.txt">link<&#47;a>, for your viewing enjoyment.</p>
<p style="padding:2px 6px 4px 6px;color: #555555;background-color: #ffffff;border: #dddddd 2px solid"> <strong> Jeremy Brown<&#47;strong><br />
Jeremy Programs and Designs. An odd combination indeed. He is a MFA in Visual Art and Design who has worked on projects in Germany, Thailand, and Russia. Follow him on <a href="https:&#47;&#47;plus.google.com&#47;112740017414925643339&#47;">Google+<&#47;a> while he tries to learn this ITM stuff.<&#47;p></p>
