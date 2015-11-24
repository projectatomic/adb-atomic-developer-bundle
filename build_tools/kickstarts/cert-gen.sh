#!/bin/bash
# Generate certs pair for configuring TLS enabled docker daemon
. /etc/sysconfig/docker

if [ -e $DOCKER_CERT_PATH/ca.pem ]; then
  # Certificates already generated
  exit
fi

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
# Allow from routable local IP
extip=`ip addr show eth1 2>/dev/null | awk 'NR==3 {print $2}' | cut -f1 -d\/`
if [[ -z "$extip" ]]; then
      extip=`ip route get 8.8.8.8 | awk 'NR==1 {print $NF}'`
fi
extipfile=extfile.cnf
echo subjectAltName = IP:$extip > $extipfile
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
rm -rf $dir

# End of certs pair generation steps for TLS enabled docker daemon
