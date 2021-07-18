#!/bin/bash

export IMG=qemu-image.img
export FLAG_IMG=flag-image.img
export DIR=qemu-image-dir
export BUILD_DIR=/bsides_files
export FLAG="BSidesTLV2021{...}"

cd $BUILD_DIR
mkdir -p $DIR
qemu-img create $IMG 2g
mkfs.ext4 -F $IMG
mkdir -p /mnt/$DIR
mount -o loop $IMG /mnt/$DIR
debootstrap --arch amd64 --include=vim,wget,curl,git,toilet,openssl,xz-utils,ifupdown,ca-certificates,dbus-x11,build-essential,netcat buster $DIR
cp -a $DIR/. /mnt/$DIR/.
rm -rf $DIR

cp -r $BUILD_DIR/fe-site /mnt/$DIR/
cp $BUILD_DIR/prepare_chrooted_system.sh /mnt/$DIR/usr/local/bin
chmod +x /mnt/$DIR/usr/local/bin/prepare_chrooted_system.sh
chroot /mnt/$DIR /usr/local/bin/prepare_chrooted_system.sh
umount /mnt/$DIR

qemu-img create $FLAG_IMG 500m
mkfs.ext4 -F $FLAG_IMG
mount -o loop $FLAG_IMG /mnt/$DIR
echo $FLAG > /mnt/$DIR/flag.txt
umount /mnt/$DIR

