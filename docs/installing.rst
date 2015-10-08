======================================
Installing the Atomic Developer Bundle
======================================

------------------
1. Install Vagrant
------------------

* Microsoft Windows

  1. Follow the directions at `vagrantup.com <https://docs.vagrantup.com/v2/installation/index.html>`_
  2. Install an ``ssh`` client.  Two good options are:

     * `Cygwin <https://cygwin.com/install.html>`_
     * `mingw <http://www.mingw.org/>`_
     * Putty is not recommended as it doesn't currently interface with vagrant

* Mac OS X

  Follow the directions at `vagrantup.com <https://docs.vagrantup.com/v2/installation/index.html>`_

* Fedora 21/22

  To install Vagrant with libvirt backend in Fedora 21/22

  ``yum/dnf install -y vagrant-libvirt vagrant``

* CentOS

  Vagrant packages are not available in CentOS core. However these are available through Fedora Copr and SCL(i.e. softwarecollections.org).

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

-------------------
2. Download the ADB
-------------------

There are two ways to download the ADB.  You can have ``vagrant`` do it for you the first time you install it or you can download it manually.

* ``vagrant`` Initiated Download

  The image is available at `https://atlas.hashicorp.com/atomicapp/boxes/dev <https://atlas.hashicorp.com/atomicapp/boxes/dev>`_. The ``vagrant`` program is capable of downloading the box the first time it is needed.  This happens when you first initialize a new vagrant environment by creating a Vagrantfile with this command:

  ``vagrant init atomicapp/dev``

* Manually Downloading the Vagrant Box Image

  Alternatively, you can manually download the vagrant box from `cloud.centos.org <http://cloud.centos.org/centos/7/vagrant/x86_64/images/>`_ using your web browser or curl.  For example:

  ::

    #To get the libvirt image
    $ wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-Atomicapp-Dev-<latest>.box

    #To get the virtual box image
    $ wget http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-Atomicapp-Dev-<latest>.box

  Once you have downloaded the image, you can add it to ``vagrant`` with this command:

  ::

    #Add the image to vagrant
    $ vagrant box add atomicappbox <local path to the downloded image>
