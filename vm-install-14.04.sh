#!/usr/bin/env bash

# VM Install for Ubuntu 14.04
# ===========================

# Install Git and Docker:
sudo apt-get install -y git

# INSTALL DOCKER-CE
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# Assuming x86 (64 bit)
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
# Might already be installed on some systems.
sudo apt-get install -y docker-ce

# Gives user permissions to run docker
# Needs to log out and log in again before this will work
sudo groupadd docker
sudo usermod -aG docker $USER

# INSTALL docker-compose
curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install Anaconda
# cd /tmp
curl -O https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
chmod +x Anaconda3-4.4.0-Linux-x86_64.sh
./Anaconda3-4.4.0-Linux-x86_64.sh
rm ./Anaconda3-4.4.0-Linux-x86_64.sh
conda install -y notebook='5.0.0'

# Add Python 2 environment
conda create -n py27 python=2.7 anaconda
source activate py27
conda install -y nb_conda='2.2.0'
source deactivate

# Add R environment
conda create -n r -c r r-essentials
source activate

# Install Docker
sudo apt-get update

# INSTALL DOCKER-CE
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# Assuming x86 (64 bit)
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
# Might already be installed on some systems.
sudo apt-get install -y docker-ce

# Gives user permissions to run docker
# Needs to log out and log in again before this will work
sudo groupadd docker
sudo usermod -aG docker $USER

# INSTALL docker-compose
curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# INSTALL Java/Hadoop/Spark/PySpark
# sudo apt-get install openjdk-7-jre-headless ca-certificates-java

# Install Java 8 (Oracle) from webupd8
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
sudo update-alternatives --config java
java -version

cd /usr/local 
export APACHE_SPARK_VERSION=2.2.0
export HADOOP_VERSION=2.7
wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local
sudo ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

wget http://www-eu.apache.org/dist/hadoop/common/hadoop-2.7.4/hadoop-2.7.4.tar.gz
sudo tar zxf hadoop-2.7.4.tar.gz
sudo rm hadoop-2.7.4.tar.gz

sudo echo "
export HADOOP_HOME=/usr/local/hadoop-2.7.4
export SPARK_HOME=/usr/local/spark
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$SPARK_HOME/sbin
" >> ~/.bashrc

source ~/.bashrc

# INSTALL mongo 3.2
# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# INSTALL Node JS
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install npm --global
mkdir .npm-packages
echo "
export NPM_PACKAGES=\"${HOME}/.npm-packages\"

export PATH=\"$NPM_PACKAGES/bin:$PATH\"
" >> ~/.bashrc
source ~/.bashrc

sudo chown user:user ~/.npm-packages

npm config set prefix '~/.npm-packages'
npm install -g http-server bower
bower install jQuery d3 underscore