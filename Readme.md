**Infra local com Virtualbox**

Projeto para teste de integração packer - terraform - ansible em um ambiente local.

O Virtualbox é o ambiente utilizado neste projeto

Packer: cria template de VM por meio de uma instalação de uma iso do ubuntu. A instalação automatizada cria um usuario ubuntu (senha: ubuntu), um usuario packer com validade de 1 dia e instala alguns pacotes. A rede fica definida por dhcp. É gerada uma chave ssh e injetada no template, em caso de problemas, realize o procedimento manualmente.

Terraform: levanta uma VM baseado no template criado pelo packer. A saída do terraform gera o arquivo de inventário para o ansible.

Ansible: Instala um ambiente kubernetes com apenas 1 servidor e faz um deploy de um pod com nginx. Os dados para acessar o nginx ficam são salvos no arquivo nginx.out. Uma cópia do arquivo de configuração do cluster também é salvo.


**Como usar**

1 - sudo sh install-req.sh
2 - sh auto.sh
