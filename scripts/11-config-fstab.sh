#!/bin/bash
set -e

echo "[$(date +'%Y-%m-%d %H:%M:%S')] 🗂️ 配置 fstab"

mkdir -p rootdir/boot/efi

cat > rootdir/etc/fstab << 'EOF'
PARTLABEL=linux / ext4 errors=remount-ro,x-systemd.growfs 0 1
PARTLABEL=esp /boot/efi vfat umask=0077 0 1
EOF

# GRUB EFI 配置
sed --in-place 's/^#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' rootdir/etc/default/grub
sed --in-place 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT=""/' rootdir/etc/default/grub

echo "[$(date +'%Y-%m-%d %H:%M:%S')] ✅ fstab 配置完成"
