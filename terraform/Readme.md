**Terraform**

Versões utilizadas:
Vixtualbox 6.1.18_Ubuntu142142
Terraform v0.12.31
Terraform-provider-virtualbox-v0.2.0 (wget -O ~/.terraform.d/plugins/terraform-provider-virtualbox https://github.com/terra-farm/terraform-provider-virtualbox/releases/download/v0.2.0/terraform-provider-virtualbox-v0.2.0-linux_amd64)


Deploy de VM no Virtualbox, utilizando provedor terrafarm

Comando
>terraform init
>terraform apply

A saída do deploy gera o arquivos hosts para o Ansible (próximo passo)


*OBS. O "host_interface" utilizado precisa ser alterado para o dispositivo do computador que estiver rodando o terraform.*

Adaptado de: http://carolinux.com.br/terraform-virtualbox/
