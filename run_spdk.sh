#!/bin/bash
set -e -x
lspci -nn | grep -i nvm
sudo env "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" "RTE_EAL_PCI_WHITELIST=00:00:04.0" ./spdk_sample