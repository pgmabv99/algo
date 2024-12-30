#!/bin/bash
set -e -x
export workspaceFolder=$(pwd)
export file=$1
export fileDirname=$(dirname $file)
export fileBasenameNoExtension=$(basename $file .c)
gcc -fdiagnostics-color=always -g \
    -I${workspaceFolder}/../spdk/include \
    -L${workspaceFolder}/../spdk/build/lib/ \
    -L${workspaceFolder}/../spdk/dpdk/build/lib/ \
    ${file} \
    -lspdk_nvme -lspdk_env_dpdk -lspdk_util -lspdk_log -lspdk_trace -lspdk_keyring -lspdk_json \
    -lrte_eal -lrte_mempool -lrte_ring -lrte_pci -lrte_log -lrte_bus_pci -lrte_telemetry -lrte_kvargs \
    -lcrypto -lssl -luuid \
    -o ${fileDirname}/${fileBasenameNoExtension}
