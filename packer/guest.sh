#!/bin/bash

echo "passo1" > guest.txt
echo "packer" | sudo -S mount -o loop VBoxGuestAdditions.iso /mnt >> guest.txt
echo "passo2" >> guest.txt
echo "packer" | sudo -S /mnt/VBoxLinuxAdditions.run >> guest.txt

echo "ok" >> guest.txt
