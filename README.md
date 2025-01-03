
### spdk make + pages + device setup
```
sudo dnf install git -y
git config --global user.name "alexey vorovich"
git config --global user.email "alexey.vorovich@gmail.com"
sudo dnf install gdb -y
git clone https://github.com/pgmabv/algo

git clone https://github.com/spdk/spdk
cd spdk
git submodule update --init
sudo ./scripts/pkgdep.sh
# needed on wsl ubuntu
# sudo apt-get install -y python3-pyelftools 
./configure --enable-debug
make
./test/unit/unittest.sh
#  huge pages do not change physcal adress
sudo sysctl -w vm.nr_hugepages=1024
sudo sh -c 'echo "vm.nr_hugepages=1024" >> /etc/sysctl.conf'
sudo sysctl -p

#list drivers
lspci -nn | grep -i nvm
lspci -nnk -s 0000:00:04.0
# list devices  and partitions
lsblk

echo "0000:00:04.0" | sudo tee /sys/bus/pci/devices/0000:00:04.0/driver/unbind
sudo modprobe uio_pci_generic
sudo env "PCI_ALLOWED=0000:00:04.0" /home/ec2-user/spdk/scripts/setup.sh 
sudo env "PCI_ALLOWED=0000:00:04.0" /home/ec2-user/spdk/scripts/setup.sh status

```



### work log
#### todo
 - split hello
 - confirm write with read ??

#### 1/2
- attempt at wsl on laptop
- python missing package fir elk symbol .. fixed after 2 h
- look for simulator. seems like little usage and no instructions.fail
- back to aws i3.large with gp3 to save cost.
- stepping/logging  in hello_world.  seems that spdk_nvme_ns_cmd_write does not retrun err :)
- create by hand make2.sh to allow split of c code 
- cleanup to remove dup flag for link

#### 12/31
- switch to amazon linux
- switch to make file 
- hello worl seems to run to "hello"
#### 12/30
- aws ubuntu
- manual compile
- run errs
#### 12/29 
- use install at https://github.com/spdk/spdk
- compile/link/run - ok via vscode 
- run needs root
- fail later


### vscode remote as root


2 blocks for root/non-root. Have to reboot linux inbetween (maybe)

```
needed at fitst connect to new instance
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

