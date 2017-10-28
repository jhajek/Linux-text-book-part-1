---
layout: post
status: publish
published: true
title: Using S3cmd with Walrus and HP Eucalyptus 4.0.2 works but with a twist...
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1741
wordpress_url: https://forge.sat.iit.edu/?p=1741
date: '2016-05-31 00:16:34 -0500'
date_gmt: '2016-05-31 05:16:34 -0500'
categories:
- Cloud
- jeremy
- Eucalyptus
tags:
- cloud
- Eucalyptus
- S3cmd
comments: []
---
<p>Dear Team,</p>
<p>  I would like to pass on that using S3cmd works fine with Eucalyptus 4.0.2 (will be installing and testing 4.2.2 soon) with a twist...   Assuming you are using Linux or the Bash on Windows 10 (Linux subsystem) for this exercise...</p>
<p><a href="https:&#47;&#47;github.com&#47;s3tools&#47;s3cmd">S3cmd<&#47;a> is a commandline tool built in Python for accessing Object Storage via the commandline.  This is useful for <a href="https:&#47;&#47;aws.amazon.com&#47;s3&#47;">AWS S3<&#47;a>, but also for <a href="http:&#47;&#47;www8.hp.com&#47;us&#47;en&#47;cloud&#47;helion-eucalyptus.html">HP Eucalyptus Walrus<&#47;a> (Eucalyptus S3 Object storage--AWS compatible).</p>
<p><a href="/assets/2016&#47;05&#47;s3cmd-permission-denied.png"><img src="/assets/2016&#47;05&#47;s3cmd-permission-denied.png" alt="s3cmd-permission-denied" width="847" height="88" class="aligncenter size-full wp-image-1742" &#47;><&#47;a></p>
<p><strong><em>My command<&#47;em><&#47;strong> was as follows: <code>.&#47;s3cmd -v -c .&#47;s3cfg la s3:&#47;&#47;vagrant-builds<&#47;code></p>
<p>A bucket I created with my account credentials should have list and read permission.  Even switching to the ADMIN credentials the same error appears.</p>
<p>Then I noticed a little tidbit in the S3cmd --help file that said this:  </p>
<p><a href="/assets/2016&#47;05&#47;signature-v2.png"><img src="/assets/2016&#47;05&#47;signature-v2.png" alt="signature-v2" width="817" height="127" class="aligncenter size-full wp-image-1743" &#47;><&#47;a></p>
<p>Look at the entry that says:  <code><br />
--signature-v2    Use AWS Signature version 2 instead of newer signature methods. Helpful for S3-like systems that don't have AWS Signature v4 yet.<&#47;code> </p>
<p><a href="/assets/2016&#47;05&#47;velma_jinkies_by_tinent.png"><img src="/assets/2016&#47;05&#47;velma_jinkies_by_tinent.png" alt="velma_jinkies_by_tinent" width="300" height="212" class="aligncenter size-full wp-image-1746" &#47;><&#47;a></p>
<p>Thats right Velma, <em>jinkees<&#47;em>, a clue.</p>
<p> AWS changes their API often and certain aspects of their code changes that invalidates using old APIs--which I guess makes sense from their upkeep point of view.  BUT it makes it hard for honest Eucalyptus developers that are trying to peg their product to AWS Java SDK, so it seems they are a few signature versions back.</p>
<p><strong>How to generate s3cfg<&#47;strong></p>
<p>These are detailed links to S3cmd and its setup.</p>
<ul>
<li><a href="https:&#47;&#47;support.eucalyptus.com&#47;hc&#47;en-us&#47;articles&#47;202810049-Using-s3cmd-with-Eucalyptus">https:&#47;&#47;support.eucalyptus.com&#47;hc&#47;en-us&#47;articles&#47;202810049-Using-s3cmd-with-Eucalyptus<&#47;a><&#47;li></p>
<li><a href="https:&#47;&#47;kushaldas.in&#47;posts&#47;s3cmd-and-walrus.html">https:&#47;&#47;kushaldas.in&#47;posts&#47;s3cmd-and-walrus.html<&#47;a><&#47;li><br />
<&#47;ul></p>
<p>Copy the text below and place it in a file named .s3cfg in your home directory.</p>
<p><code>[default]<br />
access_key = YOURKEYHERE<br />
secret_key = YOURSECRETKEYHERE<br />
host_base = xxx.xxx.xxx.xxx:8773<br />
host_bucket = xxx.xxx.xxx.xxx:8773<br />
service_path = &#47;services&#47;objectstorage<br />
bucket_location = US<br />
default_mime_type = binary&#47;octet-stream<br />
delete_removed = False<br />
dry_run = False<br />
enable_multipart = True<br />
encoding = UTF-8<br />
encrypt = False<br />
follow_symlinks = False<br />
force = False<br />
get_continue = False<br />
gpg_command = &#47;usr&#47;bin&#47;gpg<br />
gpg_decrypt = %(gpg_command)s -d --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s<br />
gpg_encrypt = %(gpg_command)s -c --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s<br />
gpg_passphrase = password<br />
guess_mime_type = True<br />
human_readable_sizes = False<br />
invalidate_on_cf = False<br />
list_md5 = False<br />
log_target_prefix =<br />
mime_type =<br />
multipart_chunk_size_mb = 15<br />
preserve_attrs = True<br />
progress_meter = True<br />
proxy_host =<br />
proxy_port = 0<br />
recursive = False<br />
recv_chunk = 4096<br />
reduced_redundancy = False<br />
send_chunk = 4096<br />
skip_existing = False<br />
socket_timeout = 300<br />
urlencoding_mode = normal<br />
use_https = False<br />
verbosity = WARNING<&#47;code></p>
<p>Adding this flag to the S3cmd solves the long listing problem using my own credentials.<br />
<code>.&#47;s3cmd -v --signature-v2 -c .&#47;s3cfg la s3:&#47;&#47;vagrant-builds<&#47;code></p>
<p>Now the results are what I was looking for!</p>
<p><a href="/assets/2016&#47;05&#47;s3cmd-works.png"><img src="/assets/2016&#47;05&#47;s3cmd-works.png" alt="s3cmd-works"  class="aligncenter size-full wp-image-1748" &#47;><&#47;a></p>
