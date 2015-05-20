=========================================
Quick start guide to run the Vagrant box.
=========================================
--------------------
Setting up Vagrant
--------------------

Fedora 21
=========
To install Vagrant with libvirt backend in Fedora 21
``yum/dnf install -y vagrant-libvirt vagrant``

CentOS
======
TBD

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

*For running atomicapp in the Vagrant box refer "runningatomicapp" page*
