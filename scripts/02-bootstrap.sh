#!/bin/bash
set -e

DEBIAN_VERSION="${DEBIAN_VERSION:-trixie}"
UBUNTU_VERSION="${UBUNTU_VERSION:-resolute}"
SYSTEM_TYPE="${SYSTEM_TYPE:-ubuntu-server}"
BOOTSTRAP_TOOL="${BOOTSTRAP_TOOL:-mmdebstrap}"

echo "[$(date +'%Y-%m-%d %H:%M:%S')] 🚀 安装基础系统"

if [[ "$SYSTEM_TYPE" == *"debian-"* ]]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 使用 $BOOTSTRAP_TOOL 构建 Debian $DEBIAN_VERSION 🐧"
    OS_VERSION="$DEBIAN_VERSION"
    MIRROR="http://deb.debian.org/debian/"
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 使用 $BOOTSTRAP_TOOL 构建 Ubuntu $UBUNTU_VERSION 🦁"
    OS_VERSION="$UBUNTU_VERSION"
    MIRROR="http://ports.ubuntu.com/ubuntu-ports/"
fi

echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 开始 bootstrap (这可能需要几分钟...)"
if [ "$BOOTSTRAP_TOOL" = "mmdebstrap" ]; then
    mmdebstrap $OS_VERSION rootdir
elif [ "$BOOTSTRAP_TOOL" = "debootstrap" ]; then
    debootstrap $OS_VERSION rootdir $MIRROR
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] ❌ 错误: 不支持的构建工具: $BOOTSTRAP_TOOL"
    exit 1
fi

echo "[$(date +'%Y-%m-%d %H:%M:%S')] ✅ 基础系统安装完成"