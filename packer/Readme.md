**PACKER**

Cria template de VM baseado em instalação automatizada do ubuntu 20.04

Comando bash:
> packer build -var-file=var_ubuntulocal.json ubuntusata.json

Comando Powershell:
> packer build -var-file .\var_ubuntulocal.json .\ubuntusata.json


Imagem iso baixada de: https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso
