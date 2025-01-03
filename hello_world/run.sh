#!/bin/bash
set -e -x


export LD_LIBRARY_PATH=../spdk/dpdk/build/lib
sudo env "DRIVER_OVERRIDE=uio_pci_generic" "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" "RTE_EAL_PCI_WHITELIST=0000:00:04.0" ./hello_world/hello_world