#!/bin/bash

docker build -t langdon/vagrant .

docker run -it -v /var/lib/libvirt:/var/lib/libvirt -v /var/run/libvirt:/var/run/libvirt -v /home/lwhite/loc-projects:/mnt/host-projects -v /mnt/vms/vagrant-home:/mnt/vagrant-home--privileged langdon/vagrant bash

