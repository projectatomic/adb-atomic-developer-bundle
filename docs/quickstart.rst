=========================================
Quick start guide to run the Vagrant box.
=========================================
--------------------
Setting up Vagrant
--------------------

Fedora 21/22
=========
To install Vagrant with libvirt backend in Fedora 21/22
``yum/dnf install -y vagrant-libvirt vagrant``

CentOS
======
Vagrant packages are not available in CentOS core. However these are available throgh Fedora Copr and SCL(i.e. softwarecollections.org).

Here are the commands to get Vagrant in CentOS

::

  $cat > /etc/yum.repos.d/vagrant.repo <<- EOM

  [jstribny-vagrant1]
  name=Copr repo for vagrant1 owned by jstribny
  baseurl=https://copr-be.cloud.fedoraproject.org/results/jstribny/vagrant1/epel-7-x86_64/
  gpgcheck=1
  gpgkey=https://copr-be.cloud.fedoraproject.org/results/jstribny/vagrant1/pubkey.gpg
  enabled=1

  [ruby200-copr]
  name=ruby200-copr
  baseurl=http://copr-be.cloud.fedoraproject.org/results/rhscl/ruby200-el7/epel-7-x86_64/
  enabled=1
  gpgcheck=0

  [ror40-copr]
  name=ror40-copr
  baseurl=http://copr-be.cloud.fedoraproject.org/results/rhscl/ror40-el7/epel-7-x86_64/
  enabled=1
  gpgcheck=0

  EOM

  $yum -y -d 0 install vagrant1 rsync

  $service libvirtd start

  $scl enable vagrant1 bash

------------------------
Running the Vagrant box
------------------------

The image is available in https://atlas.hashicorp.com/atomicapp/boxes/dev

*Step-1* : Initialising a new Vagrant environment by creating a Vagrantfile

    **vagrant init atomicapp/dev**

*Step-2* : To start the vagrant image and ssh in to it, please run following command

    **vagrant up**
    
    **vagrant ssh**

vagrant ssh should take you inside of the Vagrant box

To destroy the Vagrant box
==========================
    **vagrant destroy**

Running docker inside the Vagrant box
=====================================

Inside the vagrant box, you should be run docker containers
Example: (following commands should be run inside the Vagrant box)

    **docker pull centos**
    
    **docker run -t -i centos /bin/bash**

**For running atomicapp in the Vagrant box refer below [1] page**

[1] https://github.com/LalatenduMohanty/centos7-container-app-vagrant-box/blob/master/docs/runningatomicapp.rst/
