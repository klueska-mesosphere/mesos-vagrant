#!/usr/bin/env bash

# Install a few utility tools
sudo yum install -y tar wget which

# 'Mesos > 0.21.0' requires a C++ compiler with full C++11 support,
# (e.g. GCC > 4.8) which is available via 'devtoolset-2'.
# Fetch the Scientific Linux CERN devtoolset repo file.
sudo wget -O /etc/yum.repos.d/slc6-devtoolset.repo http://linuxsoft.cern.ch/cern/devtoolset/slc6-devtoolset.repo

# Import the CERN GPG key.
sudo rpm --import http://linuxsoft.cern.ch/cern/centos/7/os/x86_64/RPM-GPG-KEY-cern

# Fetch the Apache Maven repo file.
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo

# 'Mesos > 0.21.0' requires 'subversion > 1.8' devel package, which is
# not available in the default repositories.
# Add the WANdisco SVN repo file: '/etc/yum.repos.d/wandisco-svn.repo' with content:

sudo cat > /etc/yum.repos.d/wandisco-svn.repo <<EOF
[WANdiscoSVN]
name=WANdisco SVN Repo 1.8
enabled=1
baseurl=http://opensource.wandisco.com/centos/6/svn-1.8/RPMS/$basearch/
gpgcheck=1
gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
EOF

# Install essential development tools.
sudo yum groupinstall -y "Development Tools"

# Install 'devtoolset-2-toolchain' which includes GCC 4.8.2 and related packages.
sudo yum install -y devtoolset-2-toolchain

# Install other Mesos dependencies.
sudo yum install -y apache-maven python-devel java-1.7.0-openjdk-devel zlib-devel libcurl-devel openssl-devel cyrus-sasl-devel cyrus-sasl-md5 apr-devel subversion-devel apr-util-devel

# Install git.
sudo yum install -y git

# Source env.sh for mesos in .bashrc
SET_MESOS_ENV=$(cat <<EOF

# Source env.sh for mesos
source \${HOME}/projects/mesos-vagrant/mesos-dev/env.sh
EOF
)
sed -i -n '/\# Source env.sh for mesos/{x;d;};1h;1!{x;p;};${x;p;}' /home/vagrant/.bashrc
sed -i '/\# Source env.sh for mesos/,+2d' /home/vagrant/.bashrc
echo "${SET_MESOS_ENV}" >> /home/vagrant/.bashrc

# Enter a shell with 'devtoolset-2' enabled when sshing in.
SET_MESOS_ENV=$(cat <<EOF

# Enter a shell with "devtoolset-2" enabled.
scl enable devtoolset-2 bash
EOF
)
sed -i -n '/\# Enter a shell with "devtoolset-2" enabled/{x;d;};1h;1!{x;p;};${x;p;}' /home/vagrant/.bash_profile
sed -i '/\# Enter a shell with "devtoolset-2" enabled/,+2d' /home/vagrant/.bash_profile
echo "${SET_MESOS_ENV}" >> /home/vagrant/.bash_profile

