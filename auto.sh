#!/bin/bash

echo "Limpando execuções previas"

if [ -d "packer/Ubuntu-20.04" ]; then
	rm -rf packer/Ubuntu-20.04
fi

if [ -f "terraform/terraform.tfstate" ]; then
	cd terraform
	terraform destroy -auto-approve
	rm terraform.tfstate  terraform.tfstate.backup  Ubuntu-20.04.box
	cd ..
fi

if [ -d "$HOME/.terraform/virtualbox" ]; then
        rm -rf $HOME/.terraform/virtualbox
fi

if [ -f "ansible/config" ]; then
	rm -rf ansible/config
	rm -rf ansible/nginx.out
fi

echo "Criando template com Packer"

# download ubuntu iso
if [ ! -f "packer/ubuntu20.04.iso" ]; then
        wget -O packer/ubuntu20.04.iso https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso
fi

# generate ssh key
if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
	ssh-keygen -q -t rsa -N '' -f $HOME/.ssh/id_rsa

fi

cd packer

# updating ssh key in file
dir=$HOME/.ssh/id_rsa.pub
PUB_KEY=$(cat $dir)
sed -i "/^    - echo .*keys/ s##    - echo \'$PUB_KEY\' >> \/target\/root\/.ssh\/authorized_keys#" ./user-data
unset PUB_KEY

#build packer template
packer build -var-file=var_ubuntulocal.json ubuntusata.json

#moving template to terraform dir
cd ..
mv packer/Ubuntu-20.04.box terraform/Ubuntu-20.04.box
sleep 5

echo "Deploy de VM com o Terraform"

# configure plugin
if [ ! -d "$HOME/.terraform.d/plugins" ]; then
        mkdir -p $HOME/.terraform.d/plugins
fi
if [ ! -f "$HOME/.terraform.d/plugins/terraform-provider-virtualbox" ]; then
        wget -O $HOME/.terraform.d/plugins/terraform-provider-virtualbox https://github.com/terra-farm/terraform-provider-virtualbox/releases/download/v0.2.0/terraform-provider-virtualbox-v0.2.0-linux_amd64
        chmod +x $HOME/.terraform.d/plugins/terraform-provider-virtualbox
fi

cd terraform

terraform init
terraform apply -auto-approve

echo "Deploy da aplicação com o Ansible"

cd ../ansible

ansible-playbook -i hosts main.yml --ssh-common-args='-o StrictHostKeyChecking=no' -vv
