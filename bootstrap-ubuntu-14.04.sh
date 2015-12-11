#!/usr/bin/env bash

# Update the packages.
sudo apt-get update

# Install the latest OpenJDK.
sudo apt-get install -y openjdk-7-jdk

# Install autotools (Only necessary if building from git repository).
sudo apt-get install -y autoconf libtool

# Install other Mesos dependencies.
sudo apt-get -y install build-essential python-dev python-boto libcurl4-nss-dev libsasl2-dev maven libapr1-dev libsvn-dev

# Install git.
sudo apt-get install -y git

# Set up symlink for .bash_profile.
rm -rf /home/vagrant/.bash_profile
ln -s /home/vagrant/projects/mesos-dev/env.sh /home/vagrant/.bash_profile
