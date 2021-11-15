#!/bin/bash

cat << EOT >> ~/.bashrc 

########## Inserted by Jeremy
export JAVA_HOME=/usr
export HADOOP_HOME=/datapool1/hadoop-2.6.5
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/datapool1/hadoop-2.6.5/bin:/datapool1/hadoop-2.6.5/sbin:/usr/local/bin
export HADOOP_CLASSPATH=/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar
EOT

# http://askubuntu.com/questions/493460/how-to-install-add-apt-repository-using-the-terminal
sudo apt-get update ; sudo apt-get install -y software-properties-common 
# http://blog.cloudera.com/blog/2009/11/hadoop-at-twitter-part-1-splittable-lzo-compression/
sudo apt-get -y update
sudo apt-get install -y openjdk-8-jdk

sudo apt-get -y update ; sudo apt-get -y install pkgconf wget liblzo2-dev sysstat iotop vim libssl-dev libsnappy-dev libsnappy-java libbz2-dev libgcrypt11-dev zlib1g-dev lzop htop fail2ban

cd /tmp; wget http://archive.apache.org/dist/hadoop/common/hadoop-2.7.5/hadoop-2.7.5.tar.gz
tar -xvzf hadoop-2.7.5.tar.gz 
mv -v /tmp/hadoop-2.7.5 /datapool1

mv -v ./hadoop-env.sh /home/hajek/hadoop-2.7.5/etc/hadoop
  
sudo sed -i "s/ignoreip = 127.0.0.1\/8/ignoreip = 127.0.0.01\/8 64.131.111.178/g" /etc/fail2ban/jail.conf
# http://www.fail2ban.org/wiki/index.php/MANUAL_0_8#Jails
sudo sed -i "s/bantime=600/bantime=-1/g" /etc/fail2ban/jail.conf
sudo service fail2ban restart
