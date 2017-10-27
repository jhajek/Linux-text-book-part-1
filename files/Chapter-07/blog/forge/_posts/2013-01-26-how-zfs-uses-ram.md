---
layout: post
status: publish
published: true
title: How ZFS uses RAM - do you know?
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 805
wordpress_url: https://blog.sat.iit.edu/?p=805
date: '2013-01-26 21:01:40 -0600'
date_gmt: '2013-01-27 03:01:40 -0600'
categories:
- Uncategorized
tags: []
comments: []
---
<p>This is a repost from <a href="http:&#47;&#47;hardforum.com&#47;showpost.php?s=8d31305e57c1dd2853eb817124ff18d9&p=1036865233&postcount=3" title="How ZFS uses RAM">http:&#47;&#47;hardforum.com&#47;showpost.php?s=8d31305e57c1dd2853eb817124ff18d9&p=1036865233&postcount=3<&#47;a></p>
<blockquote><p>EDIT: A note about ZFS in general:<br />
Keep in mind that ZFS was designed to be the ideal filesystem for the enterprise storage server, where cost is no object, performance can be scaled by adding additional hardware (regardless of cost), and the number 1 concern is the safety of the data itself. ZFS does not trust your hardware, and double-checks each operation using checksums, parity, and logging. All these aspects factor into the requirements for running ZFS. Also keep in mind that unless you are putting Enterprise-Grade loads on your storage server, you may not notice an immediate benefit to adding additional hardware.</p>
<p>ZFS uses RAM in a few ways:</p>
<p>1) Read cache. This function is known as ARC. Estimate this at about 1 GB per TB of zpool.<br />
2) Temporary Write cache. Incoming writes queue up here before being added to the ZFS Intent Log (ZIL), and then ultimately to the live filesystem. This is generally only 200-500 MB, but estimate at least 1 GB.<br />
3) Checksums: ZFS performs checksumming on all blocks of data stored within the zpool, and those checksums have to be calculated and verified for each read and write. These operations use considerable CPU and RAM. Difficult to estimate.<br />
4) Parity-Data: If your drives are in a RAID-Z configuration, then ZFS uses RAM during the calculation of Parity Data which allows the fault-tolerance offered by RAID-Z. Calculating parity data uses considerable CPU and RAM, and must be done in addition to the standard checksum operations. Difficult to estimate.</p>
<p>Optional Functions: <strong>added in EDIT1<&#47;strong></p>
<p>5) Deduplication Table: Logging a deduplication table increases the amount of calculation work that needs to be performed, which increases the amount of RAM utilization for those calculations. Additionally, ZFS will try to store the dedup-table in RAM as much as possible, and keep a cache of it on the disk as well. Deduplication hurts throughput considerably, but allows a capacity gain if many potentially redundant instances of the same data exist in the zpool: OS-filesystem backups, media collection backups, etc. Databases may or may not be impacted by deduplication.<br />
6) Compression: Like deduplication, compression also increases the calculation load, and thereby the CPU and RAM utilization. Once files are compressed and stored to the zpool, they consume no additional memory (unlike the dedup-table), until they are loaded and then must be decompressed, at which point the calculation load again increases, files inflate in memory, and RAM usage skyrockets. The default LZJB compression algorithm is quick and relatively painless, but if the GZip compression algorithm is used instead, the CPU and RAM utilization are significantly heavier.</p>
<p><!--more But wait, there's more!--></p>
<p>Additionally, the OS itself requires some RAM (I'd estimate 1 GB). ZFS will leave 1GB of RAM free for the OS automatically, but if additional services running on the OS require more RAM, they will steal it from ZFS, causing ZFS to swap the contents to disk.</p>
<p>So if you have 6x2TB, and are using them in a single RAID-Z2 vdev, then your zpool is 12TB total (minus 4GB for parity data, leaivng 8GB usable), meaning it would be ideal to have at least 12 TB of RAM for the ARC. You did not mention using a dedicated ZIL device, so the ZIL will be interleaved with the rest of the storage, which puts some additional strain on the zpool, so I'd allocate at least 1 GB of RAM for write cache, maybe more. You also need some for the checksumming, parity, and OS...</p>
<p>ZFS leaves 1GB of RAM available to the OS automatically. That means ZFS is assuming control of 11GB of your RAM right now, which isn't enough. You would stand to benefit from increasing your RAM at least a bit. 24GB wouldn't hurt you at all. ZFS will use all the RAM you give it, and manage that RAM allocation manually.</p>
<p>EDIT2: A note on performance:<br />
The Write-IOPS that a single vdev can produce is limited to the IOPS of the single slowest drive in the vdev. This is because each member of a vdev must sign off on any changes made to any files on that vdev, and the operation is performed individually. If you want more performance, add additional vdevs to the zpool, rather than making a single larger vdev.</p>
<p>For example: you have 6x2TB drives. in a single RAID-Z2 vdev, you have 12TB zpool, 8TB space. You could instead create 2 RAID-Z1 vdevs: 3x2TB each, leaving you the same 8TB of usable space out of your 12TB zpool, one parity disk per vdev. However, in this configuration, you would have 2x the IOPS, as IOPS are the aggregate of the single slowest drive from each vdev. If you wanted to retain RAID-Z2, you would need to add 2 additional 2TB drives, bringing you to 8x2TB, 16TB pool, 8TB space: 4x2TB per vdev, 2 parity instances per vdev, and 2x the IOPS of your original configuration. To maximize IOPS, you could skip RAID-Z entirely, and instead mirror your disks: 2x2TB mirrors per vdev, 3 vdevs, so 6TB and 3x the IOPS. No parity per-se, but still fault tolerant per vdev. The RAM requirement of this configuration would be significantly less as no parity data would be calculated. More importantly, you can always add additional vdevs to the zpool, but no vdev can be expanded. This means you could add additional storage space to your zpool by simply adding pairs of disks. During a data-reconstruction and resilvering, only the contents of the mirrored drive would have to be rewritten, rather than the entire zpool. This means a quicker recovery. <&#47;blockquote></p>
