# Remote Access, Firewall Technologies, and Opensource applications ROUGH DRAFT
![*Good thing we avoided that one...*](images/Chapter-Header/Chapter-14/2038-2.png "2038")

### Objectives

  * SSH
    + RSA keys
    + OpenSSL
    + LibreSSL
  * SFTP
  * SCP
  * Firewall
    + iptables
    + ufw
    + pf

### Outcomes

At the conlcusion of this chapter you will have a basic understadning of remote access and file transfer commands availabe in Linux.  You will also have a basic undertanding of firewall commands and basic Server port configuration.

## Secure Shell

The internet and networks were developed in a day and age where trust was implied and limited to large institutions.  There was seen as no need for security or encryption of data sent over a network.  But as the ability to access data grew and the need to remotely access systems accross untrusted networks became a reality the ```rsh``` remote shell was no longer viable.   SSH or Secure Shell became a reality in 199x introduced by the security focused OpenBSD project and quickly adopted universally across Unix, Linux, and now even Microsoft Windows.  (Add link here to announcement)

> You can access SSH from the command line via typing: ```ssh -V```

### RSA keys

SSH works because of Public/Private Key Encryption and a standard created and widely adopted by the RSA company.  Without going to deep into RSA encryption, this set of public and private keys allows you to securely transmit information accross an untrusted network.  How does it work?

Each person generates a **keypair**, a public key and a private key. Both halves of the key make up the single key used for authentication.  These keys are exactly what they sound like.  The public key is something that is revealed openly, but without the unique private key the "lock" cannot be opened.  Think of the public key as the lock on your front door.  Conceivably anyone can come up to that lock and try to insert a key.  Unless they have the particular key, the lock won't open.  

The private key is then something to be guarded with your life as anyone who has that key can log into any system where it has permission.

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
