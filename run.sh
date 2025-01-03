#!/bin/bash
set -e -x

export HOME1=/home/ec2-user
export HOME_ALGO=$HOME1/algo
export HOME_SPDK=$HOME1/spdk
export APP=hello_world
export LD_LIBRARY_PATH=$HOME_SPDK/dpdk/build/lib
sudo env "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"  $HOME_ALGO/$APP/hello_world