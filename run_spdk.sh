#!/bin/bash
set -e -x
export file=$1
lspci -nn | grep -i nvm
lspci -nnk -s 0000:00:1f.0
# list devices  and partitions
lsblk
# bashdb ../spdk/scripts/setup_junk.sh
#this drops the volume
# echo "0000:00:1f.0" | sudo tee /sys/bus/pci/devices/0000:00:1f.0/driver/unbind
# sudo modprobe vfio-pci
# sudo modprobe -r vfio-pci
# sudo modprobe vfio-pci enable_unsafe_noiommu_mode=1

# Set the driver override for the device
# echo "vfio-pci" | sudo tee /sys/bus/pci/devices/0000:00:1f.0/driver_override

# Bind the device to vfio-pci driver
# echo "0000:00:1f.0" | sudo tee /sys/bus/pci/drivers/vfio-pci/bind
# echo "0000:00:1f.0" | sudo tee /sys/bus/pci/drivers/nvme/bind


# to format disk into paritions N option  , W option to write the changes
# sudo fdisk /dev/nvme1n1
# sudo mkfs.ext4 /dev/nvme1n1p1
# sudo mkdir /mnt/partition1
# sudo mount /dev/nvme1n1p1 /mnt/partition1

# sudo env "DRIVER_OVERRIDE=vfio-pci" "PCI_ALLOWED=0000:00:1f.0" ../spdk/scripts/setup.sh status
sudo env "DRIVER_OVERRIDE=vfio_pci" "PCI_ALLOWED=0000:00:1f.0" ../spdk/scripts/setup.sh 
# sudo env "PCI_ALLOWED=0000:00:1f.0" ../spdk/scripts/setup.sh 
# sudo env "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" "RTE_EAL_PCI_WHITELIST=0000:00:1f.0" ./$file