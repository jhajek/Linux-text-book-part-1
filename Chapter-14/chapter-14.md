# Remote Access, Firewall Technologies, and Opensource applications ROUGH DRAFT
![*Good thing we avoided that one...*](images/Chapter-Header/Chapter-14/2038-2.png "2038")

## Objectives

  * SSH
    + RSA keys
  * SFTP
  * SCP
  * Firewall
    + iptables
    + ufw
    + pf

### Outcomes

  At the conlcusion of this chapter you will have a basic understadning of remote access and file transfer commands availabe in Linux.  You will also have a basic undertanding of firewall commands and basic Server port configuration.

## Secure Shell

SSH goes here

### RSA keys

Public Private Key Encryption

### SFTP

Secure FTP

ALlows you to use the old but reliable ```FTP``` File Transfer Protocol.  Normally FTP usage is discouraged as the protocol was developed at a time when security was not a consideration.  All text, including passwords are trasnmitted in clear text.  SFTP solves that issue of allowing you to use FTP but over an established SSH connection--there by using an SSH tunnel to provide encryption for the transmitted packets.

## SCP

Secure cp (copy) Allows for using the ```cp``` command to a remote system via SSH.

## Firewall

Used to block exteral communication on you system ports.   Not unlike plugs in the wall of your home, your server has ports that different services connect to and communication on.  This allows the operating system and applications to communicate as well with multiple programs.  There are 65000 ports available to use.  The first 1024 ports are reserved for well known services.

 * SSH - 22
 * FTP - 21
 * SMTP - 25 (depricated not used as it is an unsecured transport method)
 * HTTP - 80
 * HTTPS - 443 (HTTP with TLS/SSL)
 * SMTP over SSL - 990
 * MySQL - 3309
 * Oracle DB - 1025
 * SQL Server (Microsoft)

You can use rules to deny or allows traffic based on source IP, source Port, Destination IP, or Destination Port.

## Chapter Conclusions and Review

  Conclusion goes here

### Review Questions

  Questions go here

### Podcast Questions

Rise of Illumos slides [http://www.slideshare.net/bcantrill/fork-yeah-the-rise-and-development-of-illumos](http://www.slideshare.net/bcantrill/fork-yeah-the-rise-and-development-of-illumos "Illumos")
Video By Brian Cantrill [https://www.youtube.com/watch?v=-zRN7XLCRhc](https://www.youtube.com/watch?v=-zRN7XLCRhc "SmrtOS")

### Lab

 Lab goes here

#### Footnotes
