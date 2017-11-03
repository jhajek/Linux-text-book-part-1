#!/bin/bash

# Move site xml files
cp -v ~/hajek/itmd-521/hadoop-conf/production-cluster/mapred-site.xml /datapool1/hadoop-2.6.5/etc/hadoop/
cp -v ~/hajek/itmd-521/hadoop-conf/production-cluster/core-site.xml   /datapool1/hadoop-2.6.5/etc/hadoop/
cp -v ~/hajek/itmd-521/hadoop-conf/production-cluster/hdfs-site.xml   /datapool1/hadoop-2.6.5/etc/hadoop/
cp -v ~/hajek/itmd-521/hadoop-conf/production-cluster/hadoop-env.sh   /datapool1/hadoop-2.6.5/etc/hadoop/
cp -v ~/hajek/itmd-521/hadoop-conf/production-cluster/yarn-site.xml   /datapool1/hadoop-2.6.5/etc/hadoop/
cp -v ~/hajek/itmd-521/hadoop-conf/production-cluster/slaves          /datapool1/hadoop-2.6.5/etc/hadoop/