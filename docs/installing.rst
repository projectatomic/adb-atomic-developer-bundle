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

  * VirtualBox installation instructions are available `online at the VirtualBox website <https://www.virtualbox.org/manual/ch02.html#startingvboxonlinux>`_.

    A summary of the installation is listed below:

    ::

      $ sudo dnf -y install dkms
      $ curl -O http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
      $ sudo mv virtualbox.repo /etc/yum.repos.d/
      $ sudo dnf -y install VirtualBox-4.3
      $ sudo /etc/init.d/vboxdrv setup
    
    While the latest stable release should work, the majority of testing has been done with version 4.3.30.

  * Installing libvirt dependencies can be skipped as they are automatically installed together with `vagrant-libvirt` package.

* CentOS

  Two different virtualization providers are supported on Linux, `VirtualBox <https://www.virtualbox.org/>`_ and `libvirt <http://libvirt.org/>`_.  The choice as to which to use should be driven by your preferences and environmental concerns and is outside of the scope of this document.  Both will work equally well in their default configuration.  You may wish to read the section on file synchronization when making this decision.

  * VirtualBox installation instructions are available `online at the VirtualBox website <https://www.virtualbox.org/manual/ch02.html#startingvboxonlinux>`_.  `CentOS specific instructions <https://wiki.centos.org/HowTos/Virtualization/VirtualBox>`_ are also available.

    While the latest stable release should work, the majority of testing has been done with version 4.3.30.

    A summary of the installation is listed below:

    ::

      $ sudo yum -y install epel-release
      $ sudo yum -y install dkms
      $ curl -O http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
      $ sudo mv virtualbox.repo /etc/yum.repos.d/
      $ sudo yum -y install VirtualBox-4.3
      $ sudo /etc/init.d/vboxdrv setup
    
  * Installing libvirt dependencies can be skipped as they are automatically installed together with `vagrant-libvirt` package.

------------------
2. Install Vagrant
------------------

* Microsoft Windows

  1. Follow the directions at `vagrantup.com <https://docs.vagrantup.com/v2/installation/index.html>`_
  2. Install an ``ssh`` client.  Two good options are:

     * `Cygwin <https://cygwin.com/install.html>`_
     * `mingw <http://www.mingw.org/>`_
     * Putty is not recommended as it doesn't currently interface with Vagrant

* Mac OS X

  Follow the directions at `vagrantup.com <https://docs.vagrantup.com/v2/installation/index.html>`_

* Fedora 21/22/23

  To install Vagrant with VirtualBox in Fedora 21/22/23:

  ``$ sudo dnf install -y vagrant``

  To install Vagrant with libvirt in Fedora 21/22/23:

  ::
  
    $ sudo dnf install -y vagrant-libvirt
    
    # Start libvirtd
    $ sudo systemctl start libvirtd

    # Set libvirtd to start automatically on system boot
    $ sudo systemctl enable libvirtd

* CentOS

  Vagrant packages are not available directly in CentOS core. However they are available through official CentOS `Software Collections <http://softwarecollections.org>`_ builds.

  Here are the commands to get Vagrant in CentOS with `libvirt` support:

  ::
  
    $ sudo yum -y install centos-release-scl
    $ sudo yum -y install sclo-vagrant1
    $ sudo scl enable sclo-vagrant1 bash
    
    # Start libvirtd
    $ sudo systemctl start libvirtd

    # Set libvirtd to start automatically on system boot
    $ sudo systemctl enable libvirtd

-------------------
3. Download the ADB
-------------------

There are two ways to download the ADB.  You can have ``vagrant`` do it for you the first time you install it or you can download it manually.

* ``vagrant`` Initiated Download

  The image is available at `https://atlas.hashicorp.com/atomicapp/boxes/dev <https://atlas.hashicorp.com/atomicapp/boxes/dev>`_. The ``vagrant`` program is capable of downloading the box the first time it is needed.  This happens when you first initialize a new vagrant environment by creating a Vagrantfile with this command:

  ::

    # Add the image to vagrant
    $ vagrant init projectatomic/adb
    $ vagrant up

* Manually Downloading the Vagrant Box Image

  Alternatively, you can manually download the vagrant box from `cloud.centos.org <http://cloud.centos.org/centos/7/atomic/images/>`_ using your web browser or curl.  For example:

  ::

    # To get the libvirt image
    $ wget http://cloud.centos.org/centos/7/atomic/images/AtomicDeveloperBundle-<latest>.box

    # To get the virtual box image
    $ wget http://cloud.centos.org/centos/7/atomic/images/AtomicDeveloperBundle-<latest>.box

  Once you have downloaded the image, you can add it to ``vagrant`` with this command:

  ::

    # Add the image to vagrant
    $ vagrant box add adb <local path to the downloded image>
    $ vagrant init adb
    $ vagrant up


-------------------
4. Using custom vagrantfiles for specific use cases
-------------------

There are custom vagrantfiles at `components  <../components>`_ directory which can be used for creating specific environments.

* git clone the adb git repo
* change in to the directory containing specific vagrantfile
* do vagrant up

Example:

::
     
     $ git clone https://github.com/projectatomic/adb-atomic-developer-bundle.git
     $ cd adb-atomic-developer-bundle/components/centos/centos-with-kubernetes
     $ vagrant up

