#!/bin/bash
######################################################################################################
#  This shell script run on Ubuntu will download the Hadoop Executable https://hadoop.apache.org
#  It will set up the neccesary pre-reqs and configure the system properly.
#  It has some errors that you need to fix.  Run the script, examine the error and solve the issue on
#  that line.  Repeat the process until the script runs without errors.   
#  You might need to reference Chapter 3.
######################################################################################################

sudo apt-get update ; sudo apt-get install -y software-properties-common 
sudo apt-get -y update; 
sudo apt-get install -y openjdk-8-jdk

sudo apt-get -y update ; sudo apt-get -y install pkgconf wget liblzo2-dev sysstat iotop vim libssl-dev libsnappy-dev libsnappy-java libbz2-dev libgcrypt11-dev zlib1g-dev lzop htop fail2ban

cd /tmp; wget http://archive.apache.org/dist/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz
tar -xvzf hadoop-2.8.5.tar.gz 
mv -v /tmp/hadoop-2.8.5 /datapool1
  
sudo sed -x "s/ignoreip = 127.0.0.1\/8/ignoreip = 127.0.0.01\/8 64.131.111.178/g" /etc/fail2ban/jail.conf
# http://www.fail2ban.org/wiki/index.php/MANUAL_0_8#Jails
sudo sed -x "s/bantime=600/bantime=-1/g" /etc/fail2ban/jail.conf
sudo service fail2ban restart

cat << EOT >> ~/.bashrc 

########## Inserted by User
export JAVA_HOME=/usr
export HADOOP_HOME=/datapool1/hadoop-2.8.5
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/datapool1/hadoop-2.8.5/bin:/datapool1/hadoop-2.8.5/sbin:/usr/local/bin
export HADOOP_CLASSPATH=$TOOLSPATH
EOT