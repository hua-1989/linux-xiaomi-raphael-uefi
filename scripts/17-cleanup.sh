#!/bin/bash
set -e

SYSTEM_TYPE="${SYSTEM_TYPE:-ubuntu-server}"

echo "[$(date +'%Y-%m-%d %H:%M:%S')] 🧹 清理临时文件"

export DEBIAN_FRONTEND=noninteractive

echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 清理 apt-get 缓存"
chroot rootdir apt-get -q clean

echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 重命名内核文件"
mv rootdir/boot/initrd.img-* rootdir/boot/initramfs 2>/dev/null || true
mv rootdir/boot/vmlinuz-* rootdir/boot/linux.efi 2>/dev/null || true

echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 清理固件文件"
rm -f rootdir/lib/firmware/reg* 2>/dev/null || true

echo ""
echo "========================================== 📋 配置文件预览 =========================================="

echo ""
if [[ "$SYSTEM_TYPE" == *"debian-"* ]]; then
    echo "[/etc/apt/sources.list.d/debian.sources]"
    cat rootdir/etc/apt/sources.list.d/debian.sources 2>/dev/null || echo "(文件不存在)"
elif [[ "$SYSTEM_TYPE" == *"ubuntu-"* ]]; then
    echo "[/etc/apt/sources.list.d/ubuntu.sources]"
    cat rootdir/etc/apt/sources.list.d/ubuntu.sources 2>/dev/null || echo "(文件不存在)"
fi

echo ""
echo "[/etc/fstab]"
cat rootdir/etc/fstab 2>/dev/null || echo "(文件不存在)"

echo ""
echo "[/etc/default/zramswap]"
cat rootdir/etc/default/zramswap 2>/dev/null || echo "(文件不存在)"

echo ""
echo "========================================== 📋 配置文件预览结束 =========================================="

echo "[$(date +'%Y-%m-%d %H:%M:%S')] ✅ 清理完成"
