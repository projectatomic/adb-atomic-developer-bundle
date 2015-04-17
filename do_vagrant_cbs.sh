#!/bin/sh

koji -p cbs image-build \
  centos-7-container-scratch 1  bananas7-el7 \
  http://mirror.centos.org/centos/7/os/x86_64/ x86_64 \
  --release=1 \
  --distro RHEL-7.0 \
  --ksver RHEL7 \
  --kickstart=./centos7-container-vagrant.ks \
  --format=qcow2 \
  --format=vsphere-ova \
  --format=rhevm-ova \
  --ova-option vsphere_ova_format=vagrant-virtualbox \
  --ova-option rhevm_ova_format=vagrant-libvirt \
  --ova-option vagrant_sync_directory=/home/vagrant/sync \
  --scratch \
  --nowait \
  --disk-size=10

