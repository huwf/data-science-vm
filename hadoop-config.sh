#!/usr/bin/env bash

echo /usr/local/hadoop-2.7.4
path=${HADOOP_HOME}/etc/hadoop
echo $path

for file in core-site.xml hadoop-env.sh mapred-site.xml yarn-site.xml hdfs-site.xml; do
    output=$path/$file
    echo $output
    wget -O $output https://raw.githubusercontent.com/huwf/data-science-vm/master/etc/hadoop/$file
    cat $output
done
