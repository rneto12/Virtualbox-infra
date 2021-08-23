#!/bin/bash

echo "Limpando execuções previas"

if [ -d "packer/Ubuntu-20.04" ]; then
	rm -rf packer/Ubuntu-20.04
fi

if [ -d "~/.terraform/virtualbox" ]; then
	rm -rf ~/.terraform/virtualbox
fi

echo "Criando template com Packer"

cd packer

packer build -var-file=var_ubuntulocal.json ubuntusata.json

cd ..

mv packer/Ubuntu-20.04.box terraform/Ubuntu-20.04.box
sleep 5

echo "Deploy de VM com o Terraform"

cd terraform

terraform apply -auto-approve

echo "Deploy da aplicação com o Ansible"

cd ../ansible

ansible-playbook -i hosts main.yml --ssh-common-args='-o StrictHostKeyChecking=no' -vv
