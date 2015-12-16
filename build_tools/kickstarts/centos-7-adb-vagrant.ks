#repo http://mirror.centos.org/centos/7/os/x86_64/
install
text
keyboard us
lang en_US.UTF-8
skipx
network --device eth0 --bootproto dhcp --hostname centos7-adb
rootpw vagrant
firewall --disabled
authconfig --enableshadow --enablemd5
selinux --enforcing
timezone --utc America/New_York
# The biosdevname and ifnames options ensure we get "eth0" as our interface
# even in environments like virtualbox that emulate a real NW card
bootloader --location=mbr --append="no_timer_check console=tty0 console=ttyS0,115200 net.ifnames=0 biosdevname=0"
zerombr
clearpart --all --drives=vda

user --name=vagrant --password=vagrant

part biosboot --fstype=biosboot --size=1
part /boot --size=300 --fstype="xfs"
part pv.01 --grow
volgroup vg001 pv.01
logvol / --size=8192 --fstype="xfs" --name=root --vgname=vg001

reboot

%packages
@core
@development
docker
deltarpm
rsync
screen
git
kubernetes
etcd
flannel
bash-completion
man-pages
atomic
docker-registry
nfs-utils
PyYAML
libyaml-devel
tuned

%end

%post

# Needed to allow this to boot a second time with an unknown MAC
sed -i "/HWADDR/d" /etc/sysconfig/network-scripts/ifcfg-eth*
sed -i "/UUID/d" /etc/sysconfig/network-scripts/ifcfg-eth*

#Fixing https://github.com/projectatomic/adb-atomic-developer-bundle/issues/155
echo "127.0.0.1     centos7-adb" >> /etc/hosts

## TODO: Remove this once issue #154 is resolved
#https://github.com/projectatomic/adb-atomic-developer-bundle/issues/154
yum remove -y docker-selinux
yum install -y docker-selinux

#Fixing issue #29
cat << EOF > kube-apiserver.service
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/GoogleCloudPlatform/kubernetes
After=network.target

[Service]
EnvironmentFile=-/etc/kubernetes/config
EnvironmentFile=-/etc/kubernetes/apiserver
User=kube
ExecStart=/usr/bin/kube-apiserver \\
            \$KUBE_LOGTOSTDERR \\
            \$KUBE_LOG_LEVEL \\
            \$KUBE_ETCD_SERVERS \\
            \$KUBE_API_ADDRESS \\
            \$KUBE_API_PORT \\
            \$KUBELET_PORT \\
            \$KUBE_ALLOW_PRIV \\
            \$KUBE_SERVICE_ADDRESSES \\
            \$KUBE_ADMISSION_CONTROL \\
            \$KUBE_API_ARGS
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

mv kube-apiserver.service /etc/systemd/system/
systemctl daemon-reload

# set tuned profile to force virtual-guest
tuned-adm profile virtual-guest

# sudo
echo "%vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Fix for #128 (https://github.com/projectatomic/adb-atomic-developer-bundle/issues/128)
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
DEVICE="eth0"
BOOTPROTO="dhcp"
ONBOOT="yes"
TYPE="Ethernet"
PERSISTENT_DHCLIENT="yes"
EOF

systemctl enable docker

groupadd docker
usermod -a -G docker vagrant

# Default insecure vagrant key
mkdir -m 0700 -p /home/vagrant/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# Set up certificate generation on first boot
# Below is the base64 cert-gen.sh
cat << EOF > cert-gen.sh.base64
IyEvYmluL2Jhc2gKIyBHZW5lcmF0ZSBjZXJ0cyBwYWlyIGZvciBjb25maWd1cmluZyBUTFMgZW5h
YmxlZCBkb2NrZXIgZGFlbW9uCi4gL2V0Yy9zeXNjb25maWcvZG9ja2VyCgppZiBbIC1lICRET0NL
RVJfQ0VSVF9QQVRIL2NhLnBlbSBdOyB0aGVuCiAgIyBDZXJ0aWZpY2F0ZXMgYWxyZWFkeSBnZW5l
cmF0ZWQKICBleGl0CmZpCgpmdW5jdGlvbiByYW5kb21TdHJpbmcgewogICAgICAgICMgaWYgYSBw
YXJhbSB3YXMgcGFzc2VkLCBpdCdzIHRoZSBsZW5ndGggb2YgdGhlIHN0cmluZyB3ZSB3YW50CiAg
ICAgICAgaWYgW1sgLW4gJDEgXV0gJiYgW1sgIiQxIiAtbHQgMjAgXV07IHRoZW4KICAgICAgICAg
ICAgICAgIGxvY2FsIG15U3RyTGVuZ3RoPSQxOwogICAgICAgIGVsc2UKICAgICAgICAgICAgICAg
ICMgb3RoZXJ3aXNlIHNldCB0byBkZWZhdWx0CiAgICAgICAgICAgICAgICBsb2NhbCBteVN0ckxl
bmd0aD04OwogICAgICAgIGZpCgogICAgICAgIGRkIGlmPS9kZXYvdXJhbmRvbSBicz0xIDI+L2Rl
di9udWxsIHwgdHIgLWRjICdbOmFsbnVtOl0nIHwgZGQgYnM9MSBjb3VudD0kbXlTdHJMZW5ndGgg
Mj4vZGV2L251bGwKfQoKIyBHZXQgYSB0ZW1wb3Jhcnkgd29ya3NwYWNlCmRpcj1gbWt0ZW1wIC1k
YApjZCAkZGlyCgojIEdldCBhIHJhbmRvbSBwYXNzd29yZCBmb3IgdGhlIENBIGFuZCBzYXZlIGl0
CnBhc3NmaWxlPXRtcC5wYXNzCnBhc3N3b3JkPSQocmFuZG9tU3RyaW5nIDEwKQplY2hvICRwYXNz
d29yZCA+ICRwYXNzZmlsZQoKIyBHZW5lcmF0ZSB0aGUgQ0EKb3BlbnNzbCBnZW5yc2EgLWFlczI1
NiAtcGFzc291dCBmaWxlOiRwYXNzZmlsZSAtb3V0IGNhLWtleS5wZW0gMjA0OApvcGVuc3NsIHJl
cSAtbmV3IC14NTA5IC1wYXNzaW4gZmlsZTokcGFzc2ZpbGUgLWRheXMgMzY1IC1rZXkgY2Eta2V5
LnBlbSAtc2hhMjU2IC1vdXQgY2EucGVtIC1zdWJqICIvQz0vU1Q9L0w9L089L09VPS9DTj1leGFt
cGxlLmNvbSIKCiMgR2VuZXJhdGUgU2VydmVyIEtleSBhbmQgU2lnbiBpdApvcGVuc3NsIGdlbnJz
YSAtb3V0IHNlcnZlci1rZXkucGVtIDIwNDgKb3BlbnNzbCByZXEgLXN1YmogIi9DTj1leGFtcGxl
LmNvbSIgLW5ldyAta2V5IHNlcnZlci1rZXkucGVtIC1vdXQgc2VydmVyLmNzcgojIEFsbG93IGZy
b20gcm91dGFibGUgbG9jYWwgSVAKZXh0aXA9YGlwIGFkZHIgc2hvdyBldGgxIDI+L2Rldi9udWxs
IHwgYXdrICdOUj09MyB7cHJpbnQgJDJ9JyB8IGN1dCAtZjEgLWRcL2AKaWYgW1sgLXogIiRleHRp
cCIgXV07IHRoZW4KICAgICAgZXh0aXA9YGlwIHJvdXRlIGdldCA4LjguOC44IHwgYXdrICdOUj09
MSB7cHJpbnQgJE5GfSdgCmZpCmV4dGlwZmlsZT1leHRmaWxlLmNuZgplY2hvIHN1YmplY3RBbHRO
YW1lID0gSVA6JGV4dGlwID4gJGV4dGlwZmlsZQpvcGVuc3NsIHg1MDkgLXJlcSAtZGF5cyAzNjUg
LWluIHNlcnZlci5jc3IgLUNBIGNhLnBlbSAtQ0FrZXkgY2Eta2V5LnBlbSAtQ0FjcmVhdGVzZXJp
YWwgLW91dCBzZXJ2ZXItY2VydC5wZW0gLXBhc3NpbiBmaWxlOiRwYXNzZmlsZSAtZXh0ZmlsZSAk
ZXh0aXBmaWxlCgojIEdlbmVyYXRlIHRoZSBDbGllbnQgS2V5IGFuZCBTaWduIGl0Cm9wZW5zc2wg
Z2VucnNhIC1vdXQga2V5LnBlbSAyMDQ4Cm9wZW5zc2wgcmVxIC1zdWJqICcvQ049Y2xpZW50JyAt
bmV3IC1rZXkga2V5LnBlbSAtb3V0IGNsaWVudC5jc3IKZXh0ZmlsZT10bXAuZXh0CmVjaG8gZXh0
ZW5kZWRLZXlVc2FnZSA9IGNsaWVudEF1dGggPiAkZXh0ZmlsZQpvcGVuc3NsIHg1MDkgLXJlcSAt
ZGF5cyAzNjUgLWluIGNsaWVudC5jc3IgLUNBIGNhLnBlbSAtQ0FrZXkgY2Eta2V5LnBlbSAtQ0Fj
cmVhdGVzZXJpYWwgLW91dCBjZXJ0LnBlbSAtZXh0ZmlsZSAkZXh0ZmlsZSAtcGFzc2luIGZpbGU6
JHBhc3NmaWxlCgojIENsZWFuIHVwCgojIHNldCB0aGUgY2VydCBwYXRoIGFzIGNvbmZpZ3VyZWQg
aW4gL2V0Yy9zeXNjb25maWcvZG9ja2VyCgojIyBNb3ZlIGZpbGVzIGludG8gcGxhY2UKbXYgY2Eu
cGVtICRET0NLRVJfQ0VSVF9QQVRICm12IHNlcnZlci1jZXJ0LnBlbSAkRE9DS0VSX0NFUlRfUEFU
SAptdiBzZXJ2ZXIta2V5LnBlbSAkRE9DS0VSX0NFUlRfUEFUSAoKIyBzaW5jZSB0aGUgZGVmYXVs
dCB1c2VyIGlzIHZhZ3JhbnQgYW5kIGl0IGNhbiBydW4gZG9ja2VyIHdpdGhvdXQgc3VkbwpDTElF
TlRfU0lERV9DRVJUX1BBVEg9L2hvbWUvdmFncmFudC8uZG9ja2VyCgpta2RpciAtcCAkQ0xJRU5U
X1NJREVfQ0VSVF9QQVRICmNwICRET0NLRVJfQ0VSVF9QQVRIL2NhLnBlbSAkQ0xJRU5UX1NJREVf
Q0VSVF9QQVRICm12IGNlcnQucGVtIGtleS5wZW0gJENMSUVOVF9TSURFX0NFUlRfUEFUSAoKY2hv
d24gdmFncmFudDp2YWdyYW50ICRDTElFTlRfU0lERV9DRVJUX1BBVEgKCmNobW9kIDA0NDQgJENM
SUVOVF9TSURFX0NFUlRfUEFUSC9jYS5wZW0KY2htb2QgMDQ0NCAkQ0xJRU5UX1NJREVfQ0VSVF9Q
QVRIL2NlcnQucGVtCmNobW9kIDA0NDQgJENMSUVOVF9TSURFX0NFUlRfUEFUSC9rZXkucGVtCmNo
b3duIHZhZ3JhbnQ6dmFncmFudCAkQ0xJRU5UX1NJREVfQ0VSVF9QQVRIL2NhLnBlbQpjaG93biB2
YWdyYW50OnZhZ3JhbnQgJENMSUVOVF9TSURFX0NFUlRfUEFUSC9jZXJ0LnBlbQpjaG93biB2YWdy
YW50OnZhZ3JhbnQgJENMSUVOVF9TSURFX0NFUlRfUEFUSC9rZXkucGVtCgpjaG1vZCAtdiAwNDAw
ICRET0NLRVJfQ0VSVF9QQVRIL2NhLnBlbSAkRE9DS0VSX0NFUlRfUEFUSC9zZXJ2ZXItY2VydC5w
ZW0gJERPQ0tFUl9DRVJUX1BBVEgvc2VydmVyLWtleS5wZW0KCiMjIFJlbW92ZSByZW1haW5pbmcg
ZmlsZXMKY2QKcm0gLXJmICRkaXIKCiMgRW5kIG9mIGNlcnRzIHBhaXIgZ2VuZXJhdGlvbiBzdGVw
cyBmb3IgVExTIGVuYWJsZWQgZG9ja2VyIGRhZW1vbgo=
EOF

mkdir -p /opt/adb
base64 -d < cert-gen.sh.base64 > cert-gen.sh
mv cert-gen.sh /opt/adb/
chmod u+x /opt/adb/cert-gen.sh

# update docker.service file to exec the certificate generation script
sed -i.back 's/ExecStart=/ExecStartPre=\/opt\/adb\/cert-gen.sh\n&/' /usr/lib/systemd/system/docker.service

# update the docker config to listen on TCP as well as unix socket
sed -i.back '/OPTIONS=*/c\OPTIONS="--selinux-enabled -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem --tlsverify"' /etc/sysconfig/docker

%end
