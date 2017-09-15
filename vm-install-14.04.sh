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
sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Anaconda
# cd /tmp
curl -O https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
chmod +x Anaconda3-4.4.0-Linux-x86_64.sh
./Anaconda3-4.4.0-Linux-x86_64.sh
rm ./Anaconda3-4.4.0-Linux-x86_64.sh
source ~/.bashrc
~/anaconda3/bin/conda install -y notebook='5.0.0'
~/anaconda3/bin/conda install pyspark
~/anaconda3/bin/conda install -y nb_conda='2.2.0'
# Add Python 2 environment
~/anaconda3/bin/conda create -n py27 python=2.7 anaconda

# Add R Environment
~/anaconda3/bin/conda create -n r -c r r-essentials
# sudo apt-get install r-base



# INSTALL Java/Maven/Hadoop/Spark/PySpark
# Install Java 8 (Oracle) from webupd8
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
sudo update-alternatives --config java
java -version

sudo apt-get install mvn

cd /usr/local 
export APACHE_SPARK_VERSION=2.2.0
export HADOOP_VERSION=2.7
sudo wget -q http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
sudo tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local
sudo ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

sudo wget http://www-eu.apache.org/dist/hadoop/common/hadoop-2.7.4/hadoop-2.7.4.tar.gz
sudo tar zxf hadoop-2.7.4.tar.gz
sudo rm hadoop-2.7.4.tar.gz

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
mkdir ~/.npm-packages

# Set all environment variables before we run npm and bower
sudo echo "
export JAVA_HOME=\"\$(readlink -f /usr/bin/java | sed \"s:bin/java::\")\"
export HADOOP_HOME=\"/usr/local/hadoop-2.7.4\"
export SPARK_HOME=\"/usr/local/spark\"
export SPARK_OPTS=\"--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info\"
export PATH=\"\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin:\$SPARK_HOME/bin:\$SPARK_HOME/sbin\"
export NPM_PACKAGES=\"\$HOME/.npm-packages\"
export PATH=\"\$NPM_PACKAGES/bin:\$PATH\"
" >> ~/.bashrc

source ~/.bashrc

sudo chown $USER:$USER ~/.npm-packages

npm config set prefix '~/.npm-packages'
npm install -g http-server 
npm install -g bower