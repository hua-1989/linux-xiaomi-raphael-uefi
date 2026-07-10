#!/bin/bash
set -e

IMAGE_NAME="${IMAGE_NAME:-rootfs.img}"

echo "[$(date +'%Y-%m-%d %H:%M:%S')] 📦 卸载并完成镜像"

echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ 卸载挂载点..."
umount rootdir/sys 2>/dev/null || true
umount rootdir/proc 2>/dev/null || true
umount rootdir/dev/pts 2>/dev/null || true
umount rootdir/dev 2>/dev/null || true
umount rootdir 2>/dev/null || true

rm -d rootdir 2>/dev/null || true

echo ""
echo "[$(date +'%Y-%m-%d %H:%M:%S')]   └─ cmdline for legacy boot: root=PARTLABEL=linux"

7z a rootfs.7z rootfs.img

echo "[$(date +'%Y-%m-%d %H:%M:%S')] ✅ 镜像完成"
ls -lh rootfs.7z
