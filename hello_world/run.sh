#!/bin/bash
set -e -x



lspci -nn | grep -i nvm
lspci -nnk -s 0000:00:04.0
# list devices  and partitions
lsblk

echo "0000:00:04.0" | sudo tee /sys/bus/pci/devices/0000:00:04.0/driver/unbind
sudo modprobe uio_pci_generic
sudo env "PCI_ALLOWED=0000:00:04.0" /home/ec2-user/spdk/scripts/setup.sh 
sudo env "PCI_ALLOWED=0000:00:04.0" /home/ec2-user/spdk/scripts/setup.sh status
export LD_LIBRARY_PATH=../spdk/dpdk/build/lib
sudo env "DRIVER_OVERRIDE=uio_pci_generic" "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" "RTE_EAL_PCI_WHITELIST=0000:00:04.0" ./hello_world