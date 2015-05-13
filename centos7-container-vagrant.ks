#repo http://mirror.centos.org/centos/7/os/x86_64/
install
text
keyboard us
lang en_US.UTF-8
skipx
network --device eth0 --bootproto dhcp
rootpw %ROOTPW%
firewall --disabled
authconfig --enableshadow --enablemd5
selinux --enforcing
timezone --utc America/New_York
# The biosdevname and ifnames options ensure we get "eth0" as our interface
# even in environments like virtualbox that emulate a real NW card
bootloader --location=mbr --append="console=tty0 console=ttyS0,115200 net.ifnames=0 biosdevname=0"
zerombr
clearpart --all --drives=vda

user --name=vagrant --password=vagrant

part biosboot --fstype=biosboot --size=1
part /boot --fstype ext4 --size=200 --ondisk=vda
part pv.2 --size=1 --grow --ondisk=vda
volgroup VolGroup00 --pesize=32768 pv.2
logvol swap --fstype swap --name=LogVol01 --vgname=VolGroup00 --size=768 --grow --maxsize=1536
logvol / --fstype ext4 --name=LogVol00 --vgname=VolGroup00 --size=1024 --grow
reboot

%packages
@core
@development
docker
deltarpm
rsync
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
sed -i "/HWADDR/d" /mnt/sysimage/etc/sysconfig/network-scripts/ifcfg-eth*
sed -i "/UUID/d" /mnt/sysimage/etc/sysconfig/network-scripts/ifcfg-eth*

# set tuned profile to force virtual-guest
tuned-adm profile virtual-guest

# sudo
echo "%vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

#enable Kubernetes master services
#etcd kube-apiserver kube-controller-manager kube-scheduler

systemctl enable etcd
systemctl start etcd

systemctl enable kube-apiserver
systemctl start kube-apiserver

systemctl enable kube-controller-manager
systemctl start kube-controller-manager

systemctl enable kube-scheduler
systemctl start kube-scheduler

#enable Kubernetes minion services
#kube-proxy kubelet docker

systemctl enable kube-proxy
systemctl start kube-proxy

systemctl enable kubelet
systemctl start kubelet

systemctl enable docker
systemctl start docker

groupadd docker
usermod -a -G docker vagrant

# Default insecure vagrant key
mkdir -m 0700 -p /home/vagrant/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

%end
