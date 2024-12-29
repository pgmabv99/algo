# algo

# dpdk

git clone https://github.com/DPDK/dpdk.git
cd dpdk

meson setup build
ninja -C build
sudo ninja -C build install


sudo sysctl -w vm.nr_hugepages=1024
sudo sh -c 'echo "vm.nr_hugepages=1024" >> /etc/sysctl.conf'
sudo sysctl -p


sudo modprobe uio
sudo modprobe igb_uio   --not founf
sudo modprobe vfio-pci

crash

ubuntu@ip-172-31-11-219:~/dpdk$ sudo dpdk-proc-info
EAL: Cannot open '/var/run/dpdk/rte/config' for rte_mem_config
EAL: Cannot init config
EAL: PANIC in main():
Cannot init EAL
0: dpdk-proc-info (rte_dump_stack+0x42) [5edb947711d2]
1: dpdk-proc-info (__rte_panic+0xd0) [5edb942b8b4c]
2: dpdk-proc-info (5edb94128000+0x16d80e) [5edb9429580e]
3: /lib/x86_64-linux-gnu/libc.so.6 (7c6530e00000+0x2a1ca) [7c6530e2a1ca]
4: /lib/x86_64-linux-gnu/libc.so.6 (__libc_start_main+0x8b) [7c6530e2a28b]
5: dpdk-proc-info (_start+0x25) [5edb9455b665]
Aborted



https://github.com/spdk/spdk


used to build vscode launch json 

for sym in spdk_json_write_named_string; do
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


12/29/2024
-use install at https://github.com/spdk/spdk

-compile/link/run ok via vscode (aunch/etc)
-run needs root
-fail 

+ lspci -nn
+ grep -i nvm
00:04.0 Non-Volatile memory controller [0108]: Amazon.com, Inc. NVMe EBS Controller [1d0f:8061]
+ sudo env LD_LIBRARY_PATH=/home/ubuntu/spdk/dpdk/build/lib RTE_EAL_PCI_WHITELIST=00:00:04.0 ./spdk_sample
SPDK environment initialized successfully
[2024-12-29 22:56:34.004302] nvme.c: 833:nvme_probe_internal: *ERROR*: NVMe trtype 256 (PCIE) not available
[2024-12-29 22:56:34.004356] nvme.c: 951:spdk_nvme_probe_ext: *ERROR*: Create probe context failed