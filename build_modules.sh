#!/bin/bash
set -e

KERNEL_VERSION="6.13.7-107.bazzite.fc42.x86_64"
KERNEL_DIR="/lib/modules/${KERNEL_VERSION}/build"

echo "=== Creating modules directory ===="
mkdir -p /usr/lib/modules/${KERNEL_VERSION}/extra

# Install v4l2loopback
echo "=== Compiling v4l2loopback ===="
cd /tmp
rm -rf v4l2loopback 2>/dev/null || true
git clone https://github.com/umlaeute/v4l2loopback.git
cd v4l2loopback
make KERNELRELEASE=${KERNEL_VERSION}
make install KERNELRELEASE=${KERNEL_VERSION}

# Configure automatic module loading
echo "=== Setting up automatic module loading ===="
mkdir -p /usr/lib/modules-load.d/
echo "v4l2loopback" > /usr/lib/modules-load.d/v4l2loopback.conf

echo "=== Cleanup ===="
rm -rf /tmp/v4l2loopback

echo "=== Modules installed successfully ====" 
depmod -a ${KERNEL_VERSION} 