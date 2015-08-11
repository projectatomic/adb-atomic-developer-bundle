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

The image is available in https://atlas.hashicorp.com/atomicapp/boxes/dev . However you don't have to download the box image manually. The following steps will take care of it implicitly.

*Step-1* : Initialising a new Vagrant environment by creating a Vagrantfile

    **vagrant init atomicapp/dev**

*Step-2* : To start the vagrant image and ssh in to it, run following command

    **vagrant up**
    
    **vagrant ssh**

vagrant ssh should place you inside of the Vagrant box

Manually downloading the Vagrant box image
==========================================

If the above steps fail to download the Vagrant image or you have very low internet bandwidth, you can then manually download the box image and start it.

The images are kept at: http://cloud.centos.org/centos/7/vagrant/x86_64/images/
::

  #To get the libvirt image
  $ wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/centos-7-atomicapp-dev-1-1.x86_64.rhevm.ova

  #To get the virtual box image
  $ wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/centos-7-atomicapp-dev-1-1.x86_64.vsphere.ova

  #Add the image to vagrant
  $ vagrant box add atomicappbox <local path to the downloded image>

  #Initialize the atomicapp vagrant box
  $ vagrant init atomicappbox

  #Start the atomicapp vagrant box
  $ vagrant up

  #SSH in to it
  $ vagrant ssh

To destroy the Vagrant box
==========================
    **vagrant destroy**

Running docker inside the Vagrant box
=====================================

Inside the vagrant box, you should be able to run docker containers
Example: (following commands should be run inside the Vagrant box)

    **docker pull centos**
    
    **docker run -t -i centos /bin/bash**

Running Atomic App in the Vagrant box
====================================

Refer documentaion for `Runng Atomic App 
<https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/docs/runningatomicapp.rst>`_.
