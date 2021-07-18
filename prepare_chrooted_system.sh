#!/bin/sh

echo "bsidestlv2021" > /etc/hostname

useradd -p $(openssl passwd -1 bsides) --home /home/bsides -s /bin/bash bsides
mkdir /home/bsides
chown -R bsides:bsides /home/bsides/
cd /home/bsides
mv /fe-site .

wget https://nodejs.org/dist/latest-v10.x/node-v10.24.1-linux-x64.tar.xz
tar -xJf node-v10.24.1-linux-x64.tar.xz
ln -s /home/bsides/node-v10.24.1-linux-x64/bin/node /usr/local/bin/node
ln -s /home/bsides/node-v10.24.1-linux-x64/bin/npm /usr/local/bin/npm

npm install -g pm2
npm install express

mkdir -p /root/flag
echo "/dev/sdb        /root/flag      ext4    defaults,ro     0       0" >> /etc/fstab

echo auto enp0s3 >> /etc/network/interfaces
echo iface enp0s3 inet dhcp >> /etc/network/interfaces

echo "@reboot su bsides -c \
'cd /home/bsides/fe-site && PATH=/usr/local/bin:\$PATH pm2 start main.js > \
/home/bsides/crontab.log 2>&1'" | crontab -u root -

(crontab -l ; echo "@reboot echo 0 | tee /proc/sys/kernel/kptr_restrict > \
/dev/null") | crontab -u root -

(crontab -l ; echo "@reboot echo 0 | tee /proc/sys/kernel/perf_event_paranoid > \
/dev/null") | crontab -u root -


exit