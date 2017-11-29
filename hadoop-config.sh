#!/usr/bin/env bash

# We seem to need this, otherwise it breaks from permission error
sudo mkdir -p /usr/local/hadoop-2.7.4/logs
sudo chown -R user:user /usr/local/hadoop-2.7.4/logs

path=/usr/local/hadoop-2.7.4/etc/hadoop
echo $path

for file in core-site.xml hadoop-env.sh mapred-site.xml yarn-site.xml hdfs-site.xml; do
    output=$path/$file
    echo $output
    wget -O $output https://raw.githubusercontent.com/huwf/data-science-vm/master/etc/hadoop/$file
    cat $output
done

mkdir -p /usr/local/hadoop-2.7.4/logs
chown -R user:user /usr/local/hadoop-2.7.4/logs