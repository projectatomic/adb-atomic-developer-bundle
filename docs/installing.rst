======================================
Installing the Atomic Developer Bundle
======================================

------------------------------------
1. Install a Virtualization Provider
------------------------------------

Two virtualization providers have been tested with the ADB.

* Microsoft Windows and Mac OS X

  The suggested virtualization provider is `VirtualBox <https://www.virtualbox.org/>`_.  Installation instructions are available `online <https://www.virtualbox.org/manual/UserManual.html>`_.  While the latest stable shipping release should work, the majority of testing has been done with version 5.0.0 on Mac OS X and **XXX** on Microsoft Windows.

* Fedora

  Two different virtualization providers are supported on Linux, `VirtualBox <https://www.virtualbox.org/>`_ and `libvirt <http://libvirt.org/>`_.  The choice as to which to use should be driven by your preferences and environmental concerns and is outside of the scope of this document.  Both will work equally well in their default configuration.  You may wish to read the section on file synchronization when making this decision.

  * VirtualBox Installation instructions are available `online at the VirtualBox website <https://www.virtualbox.org/manual/ch02.html#startingvboxonlinux>`_.

    A summary of the installation is listed below:

    ::

      $ dnf install dkms
      $ curl -O http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
      $ mv virtualbox.repo /etc/yum.repos.d/
      $ dnf install VirtualBox-4.3
      $ sudo /etc/init.d/vboxdrv setup
    
    While the latest stable shipping release should work, the majority of testing has been done with version 4.3.30.

  * libvirt provider for vagrant is enabled using *vagrant-libvirt* package which is shipped in Fedora. Summary of installation is listed below:
    
    ::

      $ yum/dnf install vagrant-libvirt
      $ systemctl start libvirtd
      $ systemctl enable libvirtd

* CentOS

  Two different virtualization providers are supported on Linux, `VirtualBox <https://www.virtualbox.org/>`_ and `libvirt <http://libvirt.org/>`_.  The choice as to which to use should be driven by your preferences and environmental concerns and is outside of the scope of this document.  Both will work equally well in their default configuration.  You may wish to read the section on file synchronization when making this decision.

  * VirtualBox Installation instructions are available `online at the VirtualBox website <https://www.virtualbox.org/manual/ch02.html#startingvboxonlinux>`_.  `CentOS specific instructions <https://wiki.centos.org/HowTos/Virtualization/VirtualBox>`_ are also available.

    While the latest stable shipping release should work, the majority of testing has been done with version 4.3.30.  **Note:** Currently the CentOS ``vagrant`` packages below only support versions 4.0, 4.1, 4.2, and 4.3.

    A summary of the installation is listed below:

    ::

      $ yum install epel-release
      $ yum install dkms
      $ curl -O http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
      $ mv virtualbox.repo /etc/yum.repos.d/
      $ yum install VirtualBox-4.3
      $ sudo /etc/init.d/vboxdrv setup

  * libvirt provider for vagrant is enabled using *vagrant1-vagrant-libvirt* packages which is not available in CentOS core however it is available through Fedora Copr and `Software Collections <http://softwarecollections.org>`_ other core dependencies like libvirt will taken from CentOS offical repo.

.. _vagrantRepo:

::

      $ cat > /etc/yum.repos.d/vagrant.repo <<- EOM
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


A summary of the installation is listed below:

::

  $ yum install vagrant1-vagrant-libvirt
  $ systemctl start libvirtd
  $ systemctl enable libvirtd

------------------
2. Install Vagrant
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

  To install Vagrant with VirtualBox in Fedora 21/22

  ``$ yum/dnf install -y vagrant``

  To install Vagrant with libvirt in Fedora 21/22

  ``$ yum/dnf install -y vagrant-libvirt vagrant``

* CentOS

  Vagrant packages are not available in CentOS core. However they are available through Fedora Copr and `Software Collections <http://softwarecollections.org>`_.
  Set software collection vagrantRepo_.

  Here are the commands to get Vagrant in CentOS

  ::

    $ yum -y install vagrant1 rsync
    $ scl enable vagrant1 bash

-------------------
3. Download the ADB
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
