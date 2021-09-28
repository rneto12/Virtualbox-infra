#!/bin/bash

#Run this script as sudo

# add hashicorp repo
apt update
apt install curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository -y "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# install packages
apt update
apt install -y terraform=0.12.31 ansible=2.10.7-1 packer=1.7.6 virtualbox mkisofs
echo virtualbox-ext-pack virtualbox-ext-pack/license select true | debconf-set-selections | apt install virtualbox-ext-pack -y
apt-mark hold terraform
