FROM alpine:latest

RUN apk update \
	&& apk add qemu-system-x86_64 debootstrap qemu-img xz perl e2fsprogs bash

RUN mkdir -p /bsides_files

COPY build_filesystem.sh prepare_chrooted_system.sh /bsides_files/

COPY fe-site /bsides_files/fe-site

# copy ready kernel binary
COPY bzImage /bsides_files

#build kernel
# COPY bsidestlv2021krnl/linux-4.19.173 /bsides_files
# RUN cd /bsides_files/linux-4.19.173 \
# 	&& make -j $(nproc) \
# 	&& cp /bsides_files/linux-4.19.173/arch/x86/boot/bzImage /bsides_files

RUN chmod +x /bsides_files/build_filesystem.sh

CMD /bsides_files/build_filesystem.sh \
	&& /bin/bash -c "qemu-system-x86_64 \
-nographic \
-drive file=/bsides_files/qemu-image.img,index=0,media=disk,format=raw \
-drive file=/bsides_files/flag-image.img,index=1,media=disk,format=raw \
-net nic -net user,hostfwd=tcp::3000-:3000 \
-kernel /bsides_files/bzImage \
-append \"console=ttyS0 root=/dev/sda rw nokaslr\" -m 2048 -smp 4"
