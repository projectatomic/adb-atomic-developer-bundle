install
text
keyboard us
lang en_US.UTF-8
skipx
network --device eth0 --bootproto dhcp --hostname rhel-cdk
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
volgroup VolGroup00 pv.01
logvol / --size=8192 --fstype="xfs" --name=root --vgname=VolGroup00

reboot

%packages  --excludedocs --instLangs=en --nocore
docker
deltarpm
rsync
nfs-utils
screen
@core
#Added from Lala's original upstream kube host
git
kubernetes
etcd
bash-completion
man-pages
atomic
PyYAML
#libyaml-devel
tuned
httpd-tools
cdk-entitlements
cdk-utils
fuse-sshfs
openshift2nulecule

#Packages to be removed
-btrfs-progs
-parted
-rsyslog
-iprutils
-e2fsprogs
-aic94xx-firmware
-alsa-firmware
-ivtv-firmware
-iwl100-firmware
-iwl1000-firmware
-iwl105-firmware
-iwl135-firmware
-iwl2000-firmware
-iwl2030-firmware
-iwl3160-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6000g2a-firmware
-iwl6000g2b-firmware
-iwl6050-firmware
-iwl7260-firmware
-iwl7265-firmware
-postfix
%end

%post
# Originally taken entirely from original upstream Atomic project kickstart

# Workaround for BZ1336857
restorecon -v /usr/bin/docker*

# Workaround for BZ1335635#c12
echo "dockerlog:x:4294967295:4294967295::/var/lib/docker:/bin/nologin" >> /etc/passwd
echo "dockerlog:x:4294967295:4294967295::/var/lib/docker:/bin/nologin" >> /etc/group

LANG="en_US"
echo "%_install_lang $LANG" > /etc/rpm/macros.image-language-conf

# Fix for #117 and #289
chcon -Rt svirt_sandbox_file_t /var/lib/kubelet
sed -i -e 's/SecurityContextDeny,//' /etc/kubernetes/apiserver

# Add cdk version info to consumed by adbinfo
# https://github.com/projectatomic/adb-atomic-developer-bundle/issues/183
echo "VARIANT=\"Container Development Kit (CDK)\"" >> /etc/os-release
echo "VARIANT_ID=\"cdk\"" >> /etc/os-release
echo "VARIANT_VERSION=\"2.1\"" >> /etc/os-release

echo "127.0.0.1     rhel-cdk" >> /etc/hosts

# set tuned profile to force virtual-guest
tuned-adm profile virtual-guest

# sudo
echo "%vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

#Fix for issue #128 upstrem ADB
# VM won't start consistenly and abort startup with a timeout #128
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

# update docker.service file to exec the certificate generation script
sed -i.back 's/ExecStart=/ExecStartPre=\/opt\/adb\/cert-gen.sh\n&/' /usr/lib/systemd/system/docker.service

# update the docker config to listen on TCP as well as unix socket
sed -i.back '/OPTIONS=*/c\OPTIONS="--selinux-enabled -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem --tlsverify"' /etc/sysconfig/docker

# Enable VMWare PVSCSI support for VMWare Fusion guests
# This produces a tiny increase in image size and is benign for the other Vagrant environments
pushd /etc/dracut.conf.d
echo 'add_drivers+="mptspi"' > vmware-fusion-drivers.conf
popd
# Rerun dracut for the installed kernel (not the running kernel):
KERNEL_VERSION=$(rpm -q kernel --qf '%{version}-%{release}.%{arch}\n')
dracut -f /boot/initramfs-$KERNEL_VERSION.img $KERNEL_VERSION
%end


%post --nochroot
# This gets us some, but not all, of the mounts we need for a workable docker daemon
# NOTE: THE ORDERING OF THESE POST SECTIONS IS IMPORTANT!
# Anything unrelated to docker should be put in the section above which is run
# before these bind mounts are set up.
mount -o bind /dev /mnt/sysimage/dev
mount -o bind /sys /mnt/sysimage/sys
mount -o bind /proc /mnt/sysimage/proc

# Without this, docker-storage-setup will fail if the installed kernel differs
# from the Anaconda kernel
modprobe dm_thin_pool

%end

%post
#Uncomment this, and the close parens content below for persistent
#debug output in the completed image.
#(
#Complicated, and embeds details of the unit file but may work
#Without this the storage setup script gets confused by the Anaconda storage env
echo "VG=VolGroup00" >> /etc/sysconfig/docker-storage-setup
docker-storage-setup

#Without this rather elaborate setup, the daemon will not start
mount -t tmpfs -o uid=0,gid=0,mode=0755 cgroup /sys/fs/cgroup
cd /sys/fs/cgroup
for sys in $(awk '!/^#/ { if ($4 == 1) print $1 }' /proc/cgroups); do
  mkdir -p $sys
  if ! mountpoint -q $sys; then
    if ! mount -n -t cgroup -o $sys cgroup $sys; then
      rmdir $sys || true
    fi
  fi
done

# This points us at the internal pulp repo which is insecure
# The final/eventual config pointing to access.redhat remains unchanged
# Note also the two directives disabling networking features - without
# these the startup fails due to the unusual nature of the KS post
# execution environment
/usr/bin/docker daemon --selinux-enabled --storage-driver devicemapper --storage-opt dm.fs=xfs --storage-opt dm.thinpooldev=/dev/mapper/VolGroup00-docker--pool --add-registry registry.access.redhat.com --ip-forward=false --iptables=false &
DOCKER_PID=$!
echo  "Waiting 120 seconds for it to settle"
sleep 120

# Modify this as needed based on what you want to pre-pull
# The tag renaming may not be strictly needed but having an image name
# that points to an internal hostname will likely confuse people
OPENSHIFT_TAG="v3.2.0.44"

docker pull openshift3/ose:$OPENSHIFT_TAG
docker pull openshift3/ose-haproxy-router:$OPENSHIFT_TAG
docker pull openshift3/ose-deployer:$OPENSHIFT_TAG
docker pull openshift3/ose-docker-registry:$OPENSHIFT_TAG
docker pull openshift3/ose-sti-builder:$OPENSHIFT_TAG

echo "Finished pull, running docker images for log debugging"
docker images
kill -9 $DOCKER_PID

# Edit openshift_options to reflect the desired default version of OpenShift
sed -i "/IMAGE=.*/d" /etc/sysconfig/openshift_option
echo "IMAGE=\"registry.access.redhat.com/openshift3/ose:${OPENSHIFT_TAG}\"" >> /etc/sysconfig/openshift_option

# Remove redhat-logo and firmware package to help with reduce box size
yum remove -y redhat-logos linux-firmware
# Remove doc except copyright
find /usr/share/doc -depth -type f ! -name copyright|xargs rm || true
# Clear yum package and metadata cache
yum clean all
rm -f /usr/lib/locale/locale-archive
rm -rf /var/cache/yum/*

# Fix #104 (https://github.com/projectatomic/adb-atomic-developer-bundle/issues/103)
localedef -v -c -i en_US -f UTF-8 en_US.UTF-8

# Something in what we do above seems to generate an inappropriately labeled resolv.conf
# This breaks DNS setup when the box actually starts - fix here
rm -f /etc/resolv.conf

# Uncomment this, and the one at the start of this section to get additional
# debug logging.
#) 2>&1 | /usr/bin/tee /root/post_install.log | tee /dev/console
%end
