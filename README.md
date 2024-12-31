# algo



# spdk with dpdk as  submodule
```
git clone https://github.com/spdk/spdk
cd spdk
git submodule update --init
./configure --enable-debug
make
sudo sysctl -w vm.nr_hugepages=1024
sudo sh -c 'echo "vm.nr_hugepages=1024" >> /etc/sysctl.conf'
sudo sysctl -p
```

finding unresolved   to build lbrary list in .vscode/*
```
cd ../spdk/build/lib
for sym in spdk_pci_vmd_get_driver; do
    echo "Searching for $sym:"
    nm -A *.a | grep $sym
done

Searching for spdk_nvme_probe:
libspdk_bdev_nvme.a:bdev_nvme.o:                 U spdk_nvme_probe_async
libspdk_bdev_nvme.a:bdev_nvme.o:                 U spdk_nvme_probe_poll_async
libspdk_nvme.a:nvme.o:0000000000002b10 T spdk_nvme_probe
libspdk_nvme.a:nvme.o:00000000000025d0 T spdk_nvme_probe_async


for sym in rte_tel_data_add_dict_uint_hex; do
    echo "Searching for $sym:"
    nm -A *.a | grep $sym
done
```

12/29/2024
-use install at https://github.com/spdk/spdk

-compile/link/run - ok via vscode 
-run needs root
-fail later

```
lspci -nn
 grep -i nvm
00:04.0 Non-Volatile memory controller [0108]: Amazon.com, Inc. NVMe EBS Controller [1d0f:8061]
 sudo env LD_LIBRARY_PATH=/home/ubuntu/spdk/dpdk/build/lib RTE_EAL_PCI_WHITELIST=00:00:04.0 ./spdk_sample
SPDK environment initialized successfully
[2024-12-29 22:56:34.004302] nvme.c: 833:nvme_probe_internal: *ERROR*: NVMe trtype 256 (PCIE) not available
[2024-12-29 22:56:34.004356] nvme.c: 951:spdk_nvme_probe_ext: *ERROR*: Create probe context failed
```

12/31
-switch to amazon linux
-switch to make file 

# vscode remote as root

2 blocks for root/non-root. Have to reboot linux inbetween 

```
ssh -i C:\Users\alexe\.ssh\av4_m5 ubuntu@18.218.65.153 "sudo -E -u root /bin/bash"


Host av4_m5
    HostName 18.218.65.153
    User ubuntu
    IdentityFile C:\Users\alexe\.ssh\av4_m5
Host av4_m5_root
    HostName 18.218.65.153
    User ubuntu
    IdentityFile C:\Users\alexe\.ssh\av4_m5
    RemoteCommand /usr/bin/sudo -E -u root /usr/bin/bash
    RequestTTY yes



```

setting.json
```
    // "remote.SSH.remotePlatform": {
    //     "av3": "linux",
    //     "av4_m5": "linux"
    // },
    "cmake.showOptionsMovedNotification": false,
    "workbench.startupEditor": "none",
    "remote.SSH.useLocalServer": true,
    "remote.SSH.enableRemoteCommand": true,
    "remote.SSH.suppressWindowsSshWarning": true
```

# todo
- vscode run as root(done)
- aws + spdk review(add 2nd disk) (done)