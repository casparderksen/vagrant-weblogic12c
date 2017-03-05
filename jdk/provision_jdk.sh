#!/bin/sh -x

# Install Java JDK 1.8
rpm -iv /vagrant/jdk/jdk-8u121-linux-x64.rpm

cat << --- > /etc/profile.d/java.sh
export JAVA_HOME=/usr/java/latest
export PATH=\$PATH:\$JAVA_HOME/bin
---
