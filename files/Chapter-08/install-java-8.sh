#!/bin/bash

cat << EOT >> ~/.bashrc 

########## Inserted by Jeremy
export JAVA_HOME=/usr
export HADOOP_HOME=/datapool1/hadoop-2.6.5
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/datapool1/hadoop-2.6.5/bin:/datapool1/hadoop-2.6.5/sbin:/usr/local/bin
export HADOOP_CLASSPATH=/usr/lib/jvm/java-8-oracle/lib/tools.jar
EOT

# http://askubuntu.com/questions/493460/how-to-install-add-apt-repository-using-the-terminal
sudo apt-get update ; sudo apt-get install -y software-properties-common 
sudo add-apt-repository -y ppa:webupd8team/java
# Oracle JDK needed for version 1.8 as openJDK is not backported for Ubuntu 14.04.5 - http://askubuntu.com/questions/521145/how-to-install-oracle-java-on-ubuntu-14-04
# It has a license you need to accpet - here is how to auto do that
# http://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option

sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections

#http://www.himpfen.com/install-java-ubuntu/
#http://blog.cloudera.com/blog/2009/11/hadoop-at-twitter-part-1-splittable-lzo-compression/
sudo apt-get -y update; 
sudo apt-get install -y oracle-java8-installer

sudo apt-get -y update ; sudo apt-get -y install pkgconf wget liblzo2-dev sysstat iotop vim libssl-dev libsnappy-dev libsnappy-java libbz2-dev libgcrypt11-dev zlib1g-dev lzop htop

# Download Hadoop 2.6.5 source and extract tarbal
cd /tmp; wget http://mirror.cc.columbia.edu/pub/software/apache/hadoop/common/hadoop-2.6.5/hadoop-2.6.5.tar.gz
tar -xvzf hadoop-2.6.5.tar.gz

# Move hadoop directory to ZFS stripe
mv /tmp/hadoop-2.6.5 /datapool1



# make sure you have installed the fail2ban application via apt-get
# use sed to replace lines in the /etc/fail2ban/jail.conf files
sudo sed -i "s/ignoreip = 127.0.0.1\/8/ignoreip = 127.0.0.01\/8 64.131.111.178/g" /etc/fail2ban/jail.conf
#http://www.fail2ban.org/wiki/index.php/MANUAL_0_8#Jails
sudo sed -i "s/bantime=600/bantime=-1/g" /etc/fail2ban/jail.conf
sudo service fail2ban restart
