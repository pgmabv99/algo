#!/bin/bash
set -e -x
export HOME1=/home/ec2-user
export HOME_ALGO=$HOME1/algo
export HOME_SPDK=$HOME1/spdk
export APP=hello_world
rm -f $HOME_ALGO/$APP/*.o
rm -f $HOME_ALGO/$APP/*.d
rm -f $HOME_ALGO/$APP/$APP

compile_app() {
    echo "  compile  $FNAME"; 
    local FNAME=$1
    cc  -o $HOME_ALGO/$APP/$FNAME.o \
        -c $HOME_ALGO/$APP/$FNAME.c \
        -I$HOME_SPDK/include \
        -I$HOME_SPDK/isa-l/.. \
        -I$HOME_SPDK/isalbuild \
        -I$HOME_SPDK/isa-l-crypto/.. \
        -I$HOME_SPDK/isalcryptobuild \
        -g \
        -Wall \
        -Wextra \
        -Wno-unused-parameter \
        -Wno-missing-field-initializers \
        -Wmissing-declarations \
        -fno-strict-aliasing \
        -march=native \
        -mno-avx512f \
        -fno-lto \
        -Wformat \
        -Wformat-security \
        -D_GNU_SOURCE \
        -fPIC \
        -fstack-protector \
        -fno-common \
        -DDEBUG \
        -g3 \
        -O0 \
        -fno-omit-frame-pointer \
        -DSPDK_GIT_COMMIT=d57bac3 \
        -pthread \
        -Wno-pointer-sign \
        -Wstrict-prototypes \
        -Wold-style-definition \
        -std=gnu11 
}

compile_app $APP

echo "  LINK "; 
cc -o $HOME_ALGO/$APP/$APP \
    $HOME_ALGO/$APP/$APP.o \
    -g \
    -g3 \
    -O0 \
    -pthread \
    -Wl,-z,relro,-z,now \
    -Wl,-z,noexecstack \
    -fuse-ld=bfd \
    -L$HOME_SPDK/build/lib \
    -Wl,--whole-archive \
    -Wl,--no-as-needed \
    -lspdk_sock_posix \
    -lspdk_thread \
    -lspdk_nvme \
    -lspdk_keyring \
    -lspdk_sock \
    -lspdk_trace \
    -lspdk_rpc \
    -lspdk_jsonrpc \
    -lspdk_json \
    -lspdk_dma \
    -lspdk_vmd \
    -lspdk_util \
    -lspdk_log \
    -Wl,--no-whole-archive \
    $HOME_SPDK/build/lib/libspdk_env_dpdk.a \
    -Wl,--whole-archive \
    $HOME_SPDK/dpdk/build/lib/librte_bus_pci.a \
    $HOME_SPDK/dpdk/build/lib/librte_cryptodev.a \
    $HOME_SPDK/dpdk/build/lib/librte_dmadev.a \
    $HOME_SPDK/dpdk/build/lib/librte_eal.a \
    $HOME_SPDK/dpdk/build/lib/librte_ethdev.a \
    $HOME_SPDK/dpdk/build/lib/librte_hash.a \
    $HOME_SPDK/dpdk/build/lib/librte_kvargs.a \
    $HOME_SPDK/dpdk/build/lib/librte_log.a \
    $HOME_SPDK/dpdk/build/lib/librte_mbuf.a \
    $HOME_SPDK/dpdk/build/lib/librte_mempool.a \
    $HOME_SPDK/dpdk/build/lib/librte_mempool_ring.a \
    $HOME_SPDK/dpdk/build/lib/librte_net.a \
    $HOME_SPDK/dpdk/build/lib/librte_pci.a \
    $HOME_SPDK/dpdk/build/lib/librte_power.a \
    $HOME_SPDK/dpdk/build/lib/librte_rcu.a \
    $HOME_SPDK/dpdk/build/lib/librte_ring.a \
    $HOME_SPDK/dpdk/build/lib/librte_telemetry.a \
    $HOME_SPDK/dpdk/build/lib/librte_vhost.a \
    -Wl,--no-whole-archive \
    -lnuma \
    -ldl \
    $HOME_SPDK/isa-l/.libs/libisal.a \
    $HOME_SPDK/isa-l-crypto/.libs/libisal_crypto.a \
    -pthread \
    -lrt \
    -luuid \
    -lssl \
    -lcrypto \
    -lm \
    -lfuse3 \
    -lkeyutils \
    -laio