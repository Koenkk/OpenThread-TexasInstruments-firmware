#!/bin/bash -e

# Install dependencies
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install git wget sudo tzdata make zip -y

# Bootstrap ot-ti
cd ot-ti
./script/bootstrap
mkdir -p $HOME/ti
ln -s /opt/ti/sysconfig_1.18.1 $HOME/ti/sysconfig_1.18.1

# Install ticlang (required for tiarmobjcopy)
cd /tmp
wget https://dr-download.ti.com/software-development/ide-configuration-compiler-or-debugger/MD-ayxs93eZNN/4.0.1.LTS/ti_cgt_armllvm_4.0.1.LTS_linux-x64_installer.bin
chmod +x ti_cgt_armllvm_4.0.1.LTS_linux-x64_installer.bin
./ti_cgt_armllvm_4.0.1.LTS_linux-x64_installer.bin --mode unattended --prefix /opt/ti