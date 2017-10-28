---
layout: post
status: publish
published: true
title: 'ITM Student Portfolio: How to Use'
author:
  display_name: Jeffrey Hartmann
  login: jhartma3
  email: jhartma3@hawk.iit.edu
  url: http://www.linkedin.com/in/jeffreyhartmann
author_login: jhartma3
author_email: jhartma3@hawk.iit.edu
author_url: http://www.linkedin.com/in/jeffreyhartmann
wordpress_id: 369
wordpress_url: http://blog.sat.iit.edu/?p=369
date: '2012-07-16 12:07:52 -0500'
date_gmt: '2012-07-16 18:07:52 -0500'
categories:
- Uncategorized
tags: []
comments: []
---
<p><em><strong>This project is a work-in-progress. These notes may reflect aspects of the project which have yet to be fully realized. As the project progresses, these notes may be amended at any time.<&#47;strong><&#47;em></p>
<p>Student Portfolio is a project designed for the Information Technology and Management Department (ITM) of the Illinois Institute of Technology (IIT). The goal is to enable students to upload resumes, screenshots and relevant hyperlinks (such as links to projects as well as LinkedIn profiles) to a server and thus help students promote themselves with a link to their portfolios.</p>
<p><strong><em>The Portfolio Database<&#47;em><&#47;strong></p>
<p>For those who hold the proper credentials, the database can be found at <a href="http:&#47;&#47;diamond.sat.iit.edu&#47;phpmyadmin&#47;">http:&#47;&#47;diamond.sat.iit.edu&#47;phpmyadmin&#47;<&#47;a>. Upon successfully logging in, look for a database called &Gamma;&Ccedil;&pound;pmdb&Gamma;&Ccedil;&yen; (all lower-case).</p>
<p>The &Gamma;&Ccedil;&pound;pmdb&Gamma;&Ccedil;&yen; database consists of three tables:</p>
<ul>
<li>&Gamma;&Ccedil;&pound;<strong>profile<&#47;strong>&Gamma;&Ccedil;&yen; is a &Gamma;&Ccedil;&pound;parent&Gamma;&Ccedil;&yen; table which consists of general information about the portfolio user.
<ul>
<li>&Gamma;&Ccedil;&pound;<strong>idprofile<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; Populated automatically, this is a unique key field which identifies a profile; it also ties to the &Gamma;&Ccedil;&pound;project&Gamma;&Ccedil;&yen; table.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>username<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the LDAP username of the portfolio user.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>namefirst<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the portfolio user&Gamma;&Ccedil;&Ouml;s first name.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>namelast<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the portfolio user&Gamma;&Ccedil;&Ouml;s last name.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>urllinkedin<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the portfolio user&Gamma;&Ccedil;&Ouml;s link to the LinkedIn profile.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>fileresume<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the filename, including extension, of the user&Gamma;&Ccedil;&Ouml;s resume.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>contactemail<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the user&Gamma;&Ccedil;&Ouml;s contact e-mail address; the portfolio&Gamma;&Ccedil;&Ouml;s &Gamma;&Ccedil;&pound;Contact Me&Gamma;&Ccedil;&yen; form would not appear without it.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>contactmessage<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; a custom message which the user could create for the portfolio&Gamma;&Ccedil;&Ouml;s &Gamma;&Ccedil;&pound;Contact Me&Gamma;&Ccedil;&yen; form.<br &#47;><br />
(I am open to hard-coding a brief, generic message explaining the contact form and then eliminating this field and the data-entry option on the site for this field.)<&#47;li></p>
<li>The remaining fields (&Gamma;&Ccedil;&pound;<strong>datecreated<&#47;strong>&Gamma;&Ccedil;&yen;, &Gamma;&Ccedil;&pound;<strong>dateupdated<&#47;strong>&Gamma;&Ccedil;&yen;) are populated automatically.<&#47;li><br />
<&#47;ul><br />
<&#47;li></p>
<li>&Gamma;&Ccedil;&pound;<strong>project<&#47;strong>&Gamma;&Ccedil;&yen; is a &Gamma;&Ccedil;&pound;child&Gamma;&Ccedil;&yen; table which consists of information about the portfolio user&Gamma;&Ccedil;&Ouml;s projects.
<ul>
<li>&Gamma;&Ccedil;&pound;<strong>idproject<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; Populated automatically, this is a unique key field which identifies a project.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>title<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the title of the project.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>description<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the description of the project.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>urlwork<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the link to the live project. <strong><&#47;strong><&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>imgleft<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the filename, including extension, of the large screenshot to the left of the portfolio.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>altleft<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; a description of &Gamma;&Ccedil;&pound;imglect&Gamma;&Ccedil;&yen;, a caption of a sort which appears upon mouseover of the image.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>imgrighttop<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the filename, including extension, of the large screenshot to the top-right of the portfolio.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>altrighttop<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; a description of &Gamma;&Ccedil;&pound;imgrighttop&Gamma;&Ccedil;&yen;, a caption of a sort which appears upon mouseover of the image.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>imgrightbottom<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; the filename, including extension, of the large screenshot to the bottom-right of the portfolio.<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>altrightbottom<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; a description of &Gamma;&Ccedil;&pound;imgrightbottom&Gamma;&Ccedil;&yen;, a caption of a sort which appears upon mouseover of the image.<&#47;li>
<li>The remaining fields (&Gamma;&Ccedil;&pound;<strong>datecreated<&#47;strong>&Gamma;&Ccedil;&yen;, &Gamma;&Ccedil;&pound;<strong>dateupdated<&#47;strong>&Gamma;&Ccedil;&yen;) are populated automatically.<&#47;li><br />
<&#47;ul><br />
<&#47;li></p>
<li>&Gamma;&Ccedil;&pound;<strong>users<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; a temporary login system, &Gamma;&Ccedil;&pound;temporary&Gamma;&Ccedil;&yen; meaning that we ultimately remove this table and replace it with an LDAP-based login system. For now it must remain in place to maintain functionality during development.
<ul>
<li>&Gamma;&Ccedil;&pound;<strong>iduser<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; Populated automatically. [Note: Review code to see whether it is in use; it ought not to be.]<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>username<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; LDAP username<&#47;li>
<li>&Gamma;&Ccedil;&pound;<strong>password<&#47;strong>&Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&ocirc; MD5-encrypted LDAP password; during the development process a password would be created and then run through an online MD5-conversion website; the resulting MD5-encrypted version of the password would be pasted here.<&#47;li>
<li>The remaining fields (&Gamma;&Ccedil;&pound;<strong>datecreated<&#47;strong>&Gamma;&Ccedil;&yen;, &Gamma;&Ccedil;&pound;<strong>dateupdated<&#47;strong>&Gamma;&Ccedil;&yen;) are populated automatically.<&#47;li><br />
<&#47;ul><br />
<&#47;li><br />
<&#47;ul><br />
<strong><em>The Portfolio Itself<&#47;em><&#47;strong></p>
<p>[Documentation in Progress]</p>
<p>The URL for the Portfolio is http:&#47;&#47;diamond.sat.iit.edu&#47;[student's LDAP username]&#47;.</p>
<p>The portfolio is based on a template which at first consisted of HTML and jQuery. PHP and MySQL were applied so that data for the student&Gamma;&Ccedil;&Ouml;s profile and projects could be retrieved quickly instead of manually added to the HTML code, especially per project. The programming is procedural, without additional frameworks involved (unlike the supporting CMS System, which uses CodeIgniter).</p>
<p>The portfolio is available to the public, with no login.</p>
<p>Without data in the database for the student, the Portfolio begins blank. The students would add the data themselves via the Portfolio CMS System.</p>
<p>Data retrieval is based in no small part on the portion of the URL which holds the student&Gamma;&Ccedil;&Ouml;s LDAP username.</p>
<p><strong><em>The Portfolio CMS System<&#47;em><&#47;strong></p>
<p>[Documentation in Progress]</p>
<p>The URL for the Portfolio CMS System is http:&#47;&#47;diamond.sat.iit.edu&#47;[student's LDAP username]&#47;cms&#47;. The portfolio owner simply adds "cms&#47;" to the Portfolio URL and login.</p>
<p>The CMS is a PHP&#47;MySQL-based project built via CodeIgniter (http:&#47;&#47;codeigniter.com&#47;) The version used is 2.0.3; as of this writing CodeIgniter may be up to Version 2.1.2. Portions of the CMS are based in turn on a CodeIgniter 1.6.2 tutorial readapted for 2.0.3:┬&aacute;<a href="http:&#47;&#47;henrihnr.wordpress.com&#47;2009&#47;04&#47;26&#47;simple-crud-application&#47;">http:&#47;&#47;henrihnr.wordpress.com&#47;2009&#47;04&#47;26&#47;simple-crud-application&#47;<&#47;a></p>
<p>In CodeIgniter, traditional file management does not apply. CodeIgniter is a PHP framework based on the MVC (Model-View-Controller) design pattern. Rather than calling an actual file by name and extension via a URL, a call to the name of a function in a Controller generates a URL which retrieves files related to the View (HTML, CSS, etc) while, as needed, retrieving data based on a given Model. CodeIgniter has very strict, case-sensitive, file-naming and function-naming conventions.</p>
<p><strong><em>File Management and Troubleshooting<&#47;em><&#47;strong></p>
<p>[Documentation in Progress]</p>
<p>Many files and folders common to both the Portfolio and its CMS are in "&#47;var&#47;www&#47;portfolio". This was done to reduce the "footprint" of each student's portfolio to be added to the server. If errors occur which are common across all portfolios, this directory is a good place to start your troubleshooting.</p>
<p>Each student portolio directory is referenced by the student's LDAP username. Thus each student's portfolio shall be found at "<strong>&#47;var&#47;www&#47;[student's LDAP username]&#47;<&#47;strong>".</p>
<p>The "cms" directory in each student portfolio folder is a CodeIgniter package, consisting of all the folders and files which drive CodeIgniter. Being a CodeIgniter package, most of the files and directories within "cms" need not and ought not to be touched. That said, the files which were created for the CMS can be found in the following directories within "<strong>...&#47;cms&#47;application&#47;<&#47;strong>":</p>
<ul>
<li><strong>models<&#47;strong> (where you find the SQL statements and calls to the MySQL database)<&#47;li>
<li><strong>views<&#47;strong> (the html files which comprise the visual aspects of the CMS, which in turn summon CSS files -- many of which are in the common "...&#47;portfolio&#47;" directory)<&#47;li>
<li><strong>controllers<&#47;strong>
<ul>
<li>login.php and verifylogin.php<br />
(The conversion from a database-based login system to an LDAP-based login system might be applied in one or both of these files.)<&#47;li></p>
<li>project.php<&#47;li>
<li>profile.php<&#47;li><br />
<&#47;ul><br />
<&#47;li></p>
<li><strong>config<&#47;strong>
<ul>
<li>config.php<&#47;li>
<li>routes.php<&#47;li>
<li>database.php<&#47;li>
<li>autoload.php<&#47;li><br />
<&#47;ul><br />
<&#47;li><br />
<&#47;ul><br />
Besides "...&#47;application&#47;", "...&#47;system&#47;" is also a directory which comes with CodeIgniter. This directory rarely needs to be touched.</p>
<p>Added to the CodeIgniter package are directories intended to be unique to each student. In an unused portfolio, especially a source from which copies would be made, these directories would exist as empty folders.</p>
<ul>
<li>docs -- the resumes go here.<&#47;li>
<li>imgs -- the screenshots go here.(In the event that we further enhance the project to allow the public to click on the screenshots and see a larger image, I would recommend that the original, unresized images either go in this directory under similar names with a common prefix or in a separate directory within "cms"; jQuery-style gallery options may be explored as well.)<&#47;li><br />
<&#47;ul><br />
<strong><em>Goals for Deployment<&#47;em><&#47;strong></p>
<p>[Documentation in Progress]</p>
<p>Presumably a Bash script run on the Apache server would read ┬&aacute;from a list of student LDAP usernames (and related information?), create directories named after the usernames, and insert files and folders from an unused portfolio.</p>
<p>If the temporary database-based login system currently in use during development is retained, the script must also add student records to the "users" table. A purely LDAP-based login system would eliminate this step.</p>
<p><em><strong>Remaining Issues and Enhancements<&#47;strong><&#47;em></p>
<p>Lest we add any enhancements or correct issues for each of many student portfolios, the following issues and enhancements should be addressed before deployment so that we have a relatively ideal if not perfect portfolio from which to make copies.</p>
<ul>
<li>Part of the original goals for the portfolio project include a jQuery Mobile version of the public portfolio pages. Code is already in place to determine whether a mobile device is calling the portfolio and, if so, redirect to another page which would display a mobile version. Said mobile version has yet to be built.<&#47;li>
<li>A version of the student portfolio is currently serving as a live "guinea pig", linked on the original developer's own LinkedIn profile for all LinkedIn members to see. Via LinkedIn, the developer has received at least one suggestion, particularly the option of viewers "zooming" onto larger versions of the screenshots.<&#47;li>
<li>Conversion from a database-based login sytem to an LDAP-based login system is in progress.<&#47;li><br />
<&#47;ul></p>
