---
layout: post
title:  "Why You Need a Hadoop Cluster" 
date:   2017-07-16 20:15:25 -0500
categories: jekyll update
---
## Hadoop Remote Cluster

*TL; DR*

Creating a shared computing cluster for Hadoop based MapReduce applciation and query design benefits the ITM department by enabling large scale research and industry best practice teaching by adjuncts and full time, further this resource does not exist on the IIT campus at the moment and could (properly done) open up opporturtunity to conduct joint research with other departments who are lacking this expertise and hardware capabilities.


   At the same time, Google released two white papers, GFS (Google File System) and MapReduce.  Both of these white papers, released far after Google had commercialized these technologies, became the solutions Doug Cutting was looking for.   Launching the Hadoop project, named after his son's toy elephant, he implemented the Google Filesystem into the HDFS (Hadoop Filesystem).  This filesystem is optimized for handling large scale data and for processing large scale ad-hoc queries.  In fact much in the same way a drag racer car is optimized to win a short quarter mile race, not to drive to the store for milk, in the same way HDFS is optimized.  
   At the same time, Google released two white papers, GFS (Google File System) and MapReduce.  Both of these white papers, released far after Google had commercialized these technologies, became the solutions Doug Cutting was looking for.   Launching the Hadoop project, named after his son's toy elephant, he implemented the Google Filesystem into the HDFS (Hadoop Filesystem).  This filesystem is optimized for handling large scale data and for processing large scale ad-hoc queries.  In fact much in the same way a drag racer car is optimized to win a short quarter mile race, not to drive to the store for milk, in the same way HDFS is optimized.  
   At the same time, Google released two white papers, GFS (Google File System) and MapReduce.  Both of these white papers, released far after Google had commercialized these technologies, became the solutions Doug Cutting was looking for.   Launching the Hadoop project, named after his son's toy elephant, he implemented the Google Filesystem into the HDFS (Hadoop Filesystem).  This filesystem is optimized for handling large scale data and for processing large scale ad-hoc queries.  In fact much in the same way a drag racer car is optimized to win a short quarter mile race, not to drive to the store for milk, in the same way HDFS is optimized.  
   At the same time, Google released two white papers, GFS (Google File System) and MapReduce.  Both of these white papers, released far after Google had commercialized these technologies, became the solutions Doug Cutting was looking for.   Launching the Hadoop project, named after his son's toy elephant, he implemented the Google Filesystem into the HDFS (Hadoop Filesystem).  This filesystem is optimized for handling large scale data and for processing large scale ad-hoc queries.  In fact much in the same way a drag racer car is optimized to win a short quarter mile race, not to drive to the store for milk, in the same way HDFS is optimized.  

   The MapReduce paper by Google was written to explain the ways and theories behind Google's handling, indexing, and qerying large amounts of data.  In 2005, when the paper was released we would assume they had a scale of data problem that no one else on the planet had relating to indexing the web.  Doug Cutting implemented the MapReduce paradigm in Java, combined with the HDFS, and created and opensourced the Hadoop platform.

   The MapReduce paper by Google was written to explain the ways and theories behind Google's handling, indexing, and qerying large amounts of data.  In 2005, when the paper was released we would assume they had a scale of data problem that no one else on the planet had relating to indexing the web.  Doug Cutting implemented the MapReduce paradigm in Java, combined with the HDFS, and created and opensourced the Hadoop platform.

   The MapReduce paper by Google was written to explain the ways and theories behind Google's handling, indexing, and qerying large amounts of data.  In 2005, when the paper was released we would assume they had a scale of data problem that no one else on the planet had relating to indexing the web.  Doug Cutting implemented the MapReduce paradigm in Java, combined with the HDFS, and created and opensourced the Hadoop platform.

   The MapReduce paper by Google was written to explain the ways and theories behind Google's handling, indexing, and qerying large amounts of data.  In 2005, when the paper was released we would assume they had a scale of data problem that no one else on the planet had relating to indexing the web.  Doug Cutting implemented the MapReduce paradigm in Java, combined with the HDFS, and created and opensourced the Hadoop platform.
### Abstract

The nature and need for data processing is ever increasing.  Novel methods have been designed to analyze this data.  This paper seeks to show the positive arguments for building a large scale Hadoop/MapReduce cluster that provides a department level service for researcher professors, teaching professors, and students alike.   Having this "Big Data" cluster as a resource will give our student body unparallel access to research tools as well as seperate our program in terms of tooling offered.

### History of Big Data

   No history of Big Data would be replete without a short history of computing.  Computing resources and and processing power have increased steadily and predictibly due to Moore's law.  At the turn of the century we were looking at laptops and desktops with 512 megabytes of memory and server class systems with 1 or 2 gigbytes of memory.  Now we see laptop/tablet devices with 16 GB of memory and beyond and server class systems containing multiple terabes of storage and hundreds of gigabytes of memory.  

   There was a force pushing the need for all this storage and processing power, and that was data creation.  Many would look to Fall of 2007 and the introduction of the iPhone and Google Android Phones shortly thereafter.  With devices in the hands of almost everyone on the planet, you can see how the wave of data was created.  Last October alone, Apple sold 65 million iPhone 7 and 20 million iPad tablets; Samsung sold a similar number of phones last year alone.  

   A further thing happened, Intel x86 based hardware became a very cheap commodity.  The processors themselves became very good and the devices lasting a long time.  The laptop I am writing this on is 7 years old Core i3 with 8 GB of memory that I use as my daily driver computer for teaching and research.  It is good enough and will last a good while longer.  

   At the same time, Google released two white papers, GFS (Google File System) and MapReduce.  Both of these white papers, released far after Google had commercialized these technologies, became the solutions Doug Cutting was looking for.   Launching the Hadoop project, named after his son's toy elephant, he implemented the Google Filesystem into the HDFS (Hadoop Filesystem).  This filesystem is optimized for handling large scale data and for processing large scale ad-hoc queries.  In fact much in the same way a drag racer car is optimized to win a short quarter mile race, not to drive to the store for milk, in the same way HDFS is optimized.  
   This led to (anmong other things, see my RFC on, "What is Cloud and why you need it,") the creation of what we call Cloud Computing.  The main idea you need to know here is Cloud Computing means ephemeral computing; services not servers.   The data became more important than the hardware.   

### Big Data's arrival

   he creation of and nuturing of the Hadoop project.   Initially started by Doug Cutting and a few like minded people in early 2005, this was a project initially called Nutch and set out to reverse engineer the Google search engine platform in order to provide and opensource alternative.   The project had many sub-projects, a webcrawler, and indexer, and a search algorithm.   Initially this work was stored and indexed on a SQL database.  Doug Cutting realized that the amount of storage and the nature of searching was poorly aligned to using RDBMS on top of a traditional (UFS, ext3, ext4) based filesystem.  These filesystems were not designed to handle this kind of work.

   At the same time, Google released two white papers, GFS (Google File System) and MapReduce.  Both of these white papers, released far after Google had commercialized these technologies, became the solutions Doug Cutting was looking for.   Launching the Hadoop project, named after his son's toy elephant, he implemented the Google Filesystem into the HDFS (Hadoop Filesystem).  This filesystem is optimized for handling large scale data and for processing large scale ad-hoc queries.  In fact much in the same way a drag racer car is optimized to win a short quarter mile race, not to drive to the store for milk, in the same way HDFS is optimized.  

   The MapReduce paper by Google was written to explain the ways and theories behind Google's handling, indexing, and qerying large amounts of data.  In 2005, when the paper was released we would assume they had a scale of data problem that no one else on the planet had relating to indexing the web.  Doug Cutting implemented the MapReduce paradigm in Java, combined with the HDFS, and created and opensourced the Hadoop platform.

### A Perfect Storm

   MapReduce works in a way the is different from SQL and RDBMS--Michael Stonebreaker to this day is highly highly critical of Hadoop and MapReduce.  I prefer to look at it as different tools for different problems and MapReduce and SQL and not fair comparisons.  In 2007, Doug Cutting was hired by Yahoo to implement Hadoop accross Yahoo for its web search indexing, replacing an outdated in house solution.  

#### Short Primer: How is MapReduce different from SQL 

  MapReduce in the simplest sense works by breaking a data query up. 

  MapReduce is functional programming language, SQL is declarative by design. SQL starts stating the result you want and lets the database engine figure out how to get it.  MapReduce allows you to specify how the actual steps of data processing happen MapReduce is written in Java.  This difference is the key to processing large numbers of gigabytes up to petabytes.  
  
   The Hadoop system capitalizes on 4 distinct technology advantages that had become accessable and prevelant in late 2008-2010 that were not in existance during the development of the early RDMBS:

- Accessible
    + Hadoop is designed from the ground up to run on commodity Intel based hardware
- Robust
    + Hadoop is architected to assume frequent hardware failures (Reliability)
- Scalable  
    + Hadoop scales linearly by simply adding commodity nodes (Servers)
- Simple
    + Hadoop code (MapReduce) is automatically parallelized accross a cluster

### Scaling a Cluster

  Seeing as a cluster can scale lineraly by adding commodity hardware this becomes and advantage as any 86 based system (real or virtual) can be added to increase capacity.  With the nature of parallel jobs being run, this allows for maximum hardware usage and efficency.

#### The Need for a Cluster


   **Note this section may be overly specific to the School of Applied Technology, Information Technology and Management Program at IIT**  As the nature of teaching, industry, data creation (just think about the documents, reports, emails, web page entries, text messages, and all the other data you created just today) 



