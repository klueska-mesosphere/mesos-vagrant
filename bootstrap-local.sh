#!/usr/bin/env bash

git submodule init
git submodule update
cd mesos-dev/mesos
git checkout master
git pull origin master
./bootstrap
rm -rf .reviewboardrc
ln -s ../reviewboardrc .reviewboardrc
cd - > /dev/null
