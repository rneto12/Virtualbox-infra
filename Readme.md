**Infra local com Virtualbox**

Projeto para teste de integração packer - terraform - ansible em um ambiente local.

O Virtualbox é o ambiente utilizado neste projeto

Packer: cria template de VM por meio de uma instalação de uma iso do ubuntu. A instalação automatizada cria um usuario ubuntu (senha: ubuntu), um usuario packer com validade de 1 dia e instala alguns pacotes. A rede fica definida por dhcp. É inserido na imagem uma chave publica para posterior acesso pelo ansible (troque para a sua chave publica).

Terraform: levanta uma VM baseado no template criado pelo packer. A saída do terraform gera o arquivo de inventário para o ansible.

Ansible: Instala um ambiente kubernetes com apenas 1 servidor e faz um deploy de um pod com nginx.
