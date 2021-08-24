#!/bin/bash

#Script em construcao

apt update
apt install terraform=0.12.31 ansible packer virtualbox virtualbox-ext-pack
apt-mark hold terraform

wget -O ~/.terraform.d/plugins/terraform-provider-virtualbox https://github.com/terra-farm/terraform-provider-virtualbox/releases/download/v0.2.0/terraform-provider-virtualbox-v0.2.0-linux_amd64

chmod +x ~/.terraform.d/plugins/terraform-provider-virtualbox


