#!/bin/sh
case "$ARCH" in
armv7)
ARCH_DOCKER="arm"
;;
aarch64)
ARCH_DOCKER="arm64"
;;
esac
export RELEASE=$(date +"%Y%m%d")
echo "RELEASE=$RELEASE" >> "$GITHUB_OUTPUT"
echo "ARCH=$ARCH" >> "$GITHUB_OUTPUT"

curl -L http://os.archlinuxarm.org/os/ArchLinuxARM-$ARCH-latest.tar.gz --output archlinux.tar.gz
mkdir dump
sudo tar -xzf archlinux.tar.gz -C dump

cat <<- EOF | sudo unshare -mpf bash -e -
rm -f "./dump/etc/resolv.conf"
echo "nameserver 1.1.1.1" > "./dump/etc/resolv.conf"
sed -i 's/^#DisableSandbox/DisableSandbox/' "./dump/etc/pacman.conf"
mount --bind "./dump" "./dump"
mount --bind /dev "./dump/dev"
mount --bind /proc "./dump/proc"
mount --bind /sys "./dump/sys"
#chroot "./dump" useradd -r -s /usr/bin/nologin -d /var/lib/pacman alpm
chroot "./dump" pacman-key --init
chroot "./dump" pacman-key --populate archlinuxarm
chroot "./dump" pacman -Rnsc --noconfirm linux-$ARCH linux-firmware
chroot "./dump" pacman -Syu --noconfirm
chroot "./dump" rm -f /var/cache/pacman/pkg/*
sed -i 's/#DisableSandbox/DisableSandbox/' "./dump/etc/pacman.conf"
EOF
          
cd $GITHUB_WORKSPACE/dump
sudo tar --exclude=dev/* -cpf - * | xz -9 -T0 -c > $GITHUB_WORKSPACE/archlinux-$RELEASE-$ARCH_DOCKER.tar.xz
