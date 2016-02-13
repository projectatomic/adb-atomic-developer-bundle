#!/bin/sh
#To see all options in koji -p command check "koji -p cbs image-build --help"
COMMIT_ID=`git log | head -n 1 | cut -f 2 -d " "`

koji -p cbs image-build \
  centos-7-adb 1.5 atomic7-adb-common-el7 \
  http://mirror.centos.org/centos/7/os/x86_64/ x86_64 \
  --release=1 \
  --distro RHEL-7.0 \
  --ksver RHEL7 \
  --ksurl=https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/build_tools/kickstarts/centos-7-adb-vagrant.ks#$COMMIT_ID \
  --kickstart=./build_tools/kickstarts/centos-7-adb-vagrant.ks \
  --format=qcow2 \
  --format=vsphere-ova \
  --format=rhevm-ova \
  --ova-option vsphere_ova_format=vagrant-virtualbox \
  --ova-option rhevm_ova_format=vagrant-libvirt \
  --ova-option vagrant_sync_directory=/vagrant \
  --repo http://mirror.centos.org/centos/7/extras/x86_64/\
  --repo http://mirror.centos.org/centos/7/updates/x86_64/\
  --nowait \
  --disk-size=40

