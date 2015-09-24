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

# Fixes issue #71
mkdir -p /etc/pki/kube-apiserver/
openssl genrsa -out /etc/pki/kube-apiserver/serviceaccount.key 2048

sed -i.back '/KUBE_API_ARGS=*/c\KUBE_API_ARGS="--service_account_key_file=/etc/pki/kube-apiserver/serviceaccount.key"' /etc/kubernetes/apiserver

sed -i.back '/KUBE_CONTROLLER_MANAGER_ARGS=*/c\KUBE_CONTROLLER_MANAGER_ARGS="--service_account_private_key_file=/etc/pki/kube-apiserver/serviceaccount.key"' /etc/kubernetes/controller-manager

#enable Kubernetes master services
#etcd kube-apiserver kube-controller-manager kube-scheduler

systemctl enable etcd

systemctl enable kube-apiserver kube-controller-manager kube-scheduler

#enable Kubernetes minion services
#kube-proxy kubelet docker

systemctl enable kube-proxy kubelet
systemctl enable docker

groupadd docker
usermod -a -G docker vagrant

# Default insecure vagrant key
mkdir -m 0700 -p /home/vagrant/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# Generate certs pair for configuring TLS enabled docker daemon

. /etc/sysconfig/docker

function randomString {
        # if a param was passed, it's the length of the string we want
        if [[ -n $1 ]] && [[ "$1" -lt 20 ]]; then
                local myStrLength=$1;
        else
                # otherwise set to default
                local myStrLength=8;
        fi

        dd if=/dev/urandom bs=1 2>/dev/null | tr -dc '[:alnum:]' | dd bs=1 count=$myStrLength 2>/dev/null
}

# Get a temporary workspace
dir=`mktemp -d`
cd $dir

# Get a random password for the CA and save it
passfile=tmp.pass
password=$(randomString 10)
echo $password > $passfile

# Generate the CA
openssl genrsa -aes256 -passout file:$passfile -out ca-key.pem 2048
openssl req -new -x509 -passin file:$passfile -days 365 -key ca-key.pem -sha256 -out ca.pem -subj "/C=/ST=/L=/O=/OU=/CN=example.com"

# Generate Server Key and Sign it
openssl genrsa -out server-key.pem 2048
openssl req -subj "/CN=example.com" -new -key server-key.pem -out server.csr
# Allow from 127.0.0.1
extipfile=extfile.cnf
echo subjectAltName = IP:127.0.0.1 > $extipfile
openssl x509 -req -days 365 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -passin file:$passfile -extfile $extipfile

# Generate the Client Key and Sign it
openssl genrsa -out key.pem 2048
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
extfile=tmp.ext
echo extendedKeyUsage = clientAuth > $extfile
openssl x509 -req -days 365 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile $extfile -passin file:$passfile

# Clean up

# set the cert path as configured in /etc/sysconfig/docker

## Move files into place
mv ca.pem $DOCKER_CERT_PATH
mv server-cert.pem $DOCKER_CERT_PATH
mv server-key.pem $DOCKER_CERT_PATH

# since the default user is vagrant and it can run docker without sudo
CLIENT_SIDE_CERT_PATH=/home/vagrant/.docker

mkdir -p $CLIENT_SIDE_CERT_PATH
cp $DOCKER_CERT_PATH/ca.pem $CLIENT_SIDE_CERT_PATH
mv cert.pem key.pem $CLIENT_SIDE_CERT_PATH

chown vagrant:vagrant $CLIENT_SIDE_CERT_PATH

chmod 0444 $CLIENT_SIDE_CERT_PATH/ca.pem
chmod 0444 $CLIENT_SIDE_CERT_PATH/cert.pem
chmod 0444 $CLIENT_SIDE_CERT_PATH/key.pem
chown vagrant:vagrant $CLIENT_SIDE_CERT_PATH/ca.pem
chown vagrant:vagrant $CLIENT_SIDE_CERT_PATH/cert.pem
chown vagrant:vagrant $CLIENT_SIDE_CERT_PATH/key.pem

chmod -v 0400 $DOCKER_CERT_PATH/ca.pem $DOCKER_CERT_PATH/server-cert.pem $DOCKER_CERT_PATH/server-key.pem

## Remove remaining files
cd
echo rm -rf $dir

# End of certs pair generation steps for TLS enabled docker daemon

# update the docker config to listen on TCP as well as unix socket
sed -i.back '/OPTIONS=*/c\OPTIONS="--selinux-enabled -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem --tlsverify"' /etc/sysconfig/docker

%end
