#!/bin/bash

#Script em construcao

# add hashicorp repo
apt update
apt install curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository -y "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# install packages
apt update
apt install -y terraform=0.12.31 ansible packer virtualbox
echo virtualbox-ext-pack virtualbox-ext-pack/license select true | apt install virtualbox-ext-pack -y
apt-mark hold terraform

# configure plugin
if [ ! -d "/root/.terraform.d/plugins" ]; then
        mkdir -p /root/.terraform.d/plugins
fi
if [ ! -d "~/.terraform.d/plugins/terraform-provider-virtualbox" ]; then
        wget -O ~/.terraform.d/plugins/terraform-provider-virtualbox https://github.com/terra-farm/terraform-provider-virtualbox/releases/download/v0.2.0/terraform-provider-virtualbox-v0.2.0-linux_amd64
        chmod +x ~/.terraform.d/plugins/terraform-provider-virtualbox
fi

# download ubuntu iso
if [ ! -f "packer/ubuntu20.04.iso" ]; then
        wget -O packer/ubuntu20.04.iso https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso
fi
