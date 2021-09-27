#!/bin/bash

echo "Limpando execuções previas"

if [ -d "packer/Ubuntu-20.04" ]; then
	rm -rf packer/Ubuntu-20.04
fi

if [ -d "~/.terraform/virtualbox" ]; then
	rm -rf ~/.terraform/virtualbox
fi

echo "Criando template com Packer"

# download ubuntu iso
if [ ! -f "packer/ubuntu20.04.iso" ]; then
        wget -O packer/ubuntu20.04.iso https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso
fi

cd packer

packer build -var-file=var_ubuntulocal.json ubuntusata.json

cd ..

mv packer/Ubuntu-20.04.box terraform/Ubuntu-20.04.box
sleep 5

echo "Deploy de VM com o Terraform"

# configure plugin
if [ ! -d "~/.terraform.d/plugins" ]; then
        mkdir -p ~/.terraform.d/plugins
fi
if [ ! -f "~/.terraform.d/plugins/terraform-provider-virtualbox" ]; then
        wget -O ~/.terraform.d/plugins/terraform-provider-virtualbox https://github.com/terra-farm/terraform-provider-virtualbox/releases/download/v0.2.0/terraform-provider-virtualbox-v0.2.0-linux_amd64
        chmod +x ~/.terraform.d/plugins/terraform-provider-virtualbox
fi

cd terraform

terraform init
terraform apply -auto-approve

echo "Deploy da aplicação com o Ansible"

cd ../ansible

ansible-playbook -i hosts main.yml --ssh-common-args='-o StrictHostKeyChecking=no' -vv
