text
lang en_US.UTF-8
keyboard us
timezone --utc Etc/UTC

auth --useshadow --enablemd5
selinux --enforcing
rootpw --lock --iscrypted locked
user --name=vagrant --password=vagrant

firewall --disabled

bootloader --timeout=1 --append="no_timer_check console=tty1 console=ttyS0,115200n8"

network --bootproto=dhcp --device=eth0 --activate --onboot=on
services --disabled=cloud-init,cloud-init-local,cloud-config,cloud-final
# We use NetworkManager, and Avahi doesn't make much sense in the cloud
services --disabled=network,avahi-daemon

zerombr
clearpart --all

part /boot --size=300 --fstype="xfs"
part pv.01 --grow
volgroup atomicos pv.01
logvol / --size=3000 --fstype="xfs" --name=root --vgname=atomicos

ostreesetup --osname="rhel-atomic-host" --remote="rhel-atomic-host" --ref="rhel-atomic-host/7/x86_64/standard" --url="http://download.eng.bos.redhat.com/rel-eng/Atomic/trees/prod/ostree/repo/" --nogpg

reboot

%post --erroronfail

# For RHEL, it doesn't make sense to have a default remote configuration,
# because you need to use subscription manager.
rm /etc/ostree/remotes.d/@OSTREE_OSNAME@.conf
echo 'unconfigured-state=This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.' >> $(ostree admin --print-current-dir).origin

# Anaconda is writing a /etc/resolv.conf from the generating environment.
# The system should start out with an empty file.
truncate -s 0 /etc/resolv.conf

# older versions of livecd-tools do not follow "rootpw --lock" line above
# https://bugzilla.redhat.com/show_bug.cgi?id=964299
passwd -l root
# remove the user anaconda forces us to make
userdel -r none

# If you want to remove rsyslog and just use journald, remove this!
echo -n "Disabling persistent journal"
rmdir /var/log/journal/ 
echo . 

echo -n "Getty fixes"
# although we want console output going to the serial console, we don't
# actually have the opportunity to login there. FIX.
# we don't really need to auto-spawn _any_ gettys.
sed -i '/^#NAutoVTs=.*/ a\
NAutoVTs=0' /etc/systemd/logind.conf

echo -n "Network fixes"
# initscripts don't like this file to be missing.
cat > /etc/sysconfig/network << EOF
NETWORKING=yes
NOZEROCONF=yes
EOF

# For cloud images, 'eth0' _is_ the predictable device name, since
# we don't want to be tied to specific virtual (!) hardware
rm -f /etc/udev/rules.d/70*
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

# simple eth0 config, again not hard-coded to the build hardware
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
DEVICE="eth0"
BOOTPROTO="dhcp"
ONBOOT="yes"
TYPE="Ethernet"
PERSISTENT_DHCLIENT="yes"
EOF

# generic localhost names
cat > /etc/hosts << EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

EOF
echo .


# Because memory is scarce resource in most cloud/virt environments,
# and because this impedes forensics, we are differing from the Fedora
# default of having /tmp on tmpfs.
echo "Disabling tmpfs for /tmp."
systemctl mask tmp.mount

# make sure firstboot doesn't start
echo "RUN_FIRSTBOOT=NO" > /etc/sysconfig/firstboot

echo "Removing random-seed so it's not the same in every image."
rm -f /var/lib/random-seed

echo "Packages within this cloud image:"
echo "-----------------------------------------------------------------------"
rpm -qa
echo "-----------------------------------------------------------------------"
# Note that running rpm recreates the rpm db files which aren't needed/wanted
rm -f /var/lib/rpm/__db*

%end

%post --erroronfail

# Work around cloud-init being both disabled and enabled; need
# to refactor to a common base.
rm /etc/systemd/system/multi-user.target.wants/{cloud-config.service,cloud-final.service,cloud-init-local.service,cloud-init.service}

# Vagrant setup
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
echo 'vagrant ALL=NOPASSWD: ALL' > /etc/sudoers.d/vagrant-nopasswd
sed -i 's/.*UseDNS.*/UseDNS no/' /etc/ssh/sshd_config
mkdir -m 0700 -p ~vagrant/.ssh
cat > ~vagrant/.ssh/authorized_keys << EOKEYS
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOKEYS
chmod 600 ~vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant ~vagrant/.ssh/

%end

