======================================
Installing the Atomic Developer Bundle
======================================

------------------------------------
1. Install a Virtualization Provider
------------------------------------

Two virtualization providers have been tested with the ADB.

* Microsoft Windows and Mac OS X

  The suggested virtualization provider is `VirtualBox`_. Installation
  instructions are available `online`_. While the latest stable shipping release
  should work, the majority of testing has been done with version 5.0.0 on Mac
  OS X and 5.0.8 on Microsoft Windows.

.. _VirtualBox: https://www.virtualbox.org
.. _oneline: https://www.virtualbox.org/manual/UserManual.html

* Fedora

  Two different virtualization providers are supported on Linux, `VirtualBox`_
  and `libvirt <http://libvirt.org/>`_. The choice as to which to use should be
  driven by your preferences and environmental concerns and is outside of the
  scope of this document. Both will work equally well in their default
  configuration. You may wish to read the section on file synchronization when
  making this decision.

  * VirtualBox installation instructions are available `online at the VirtualBox
    website`_. Testing has been done with versions 4.3.34 and 5.0.0.

    A summary of the installation is listed below::

      $ sudo dnf -y install dkms
      $ curl -O http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
      $ sudo mv virtualbox.repo /etc/yum.repos.d/
      $ sudo dnf -y install VirtualBox-4.3
      $ sudo /etc/init.d/vboxdrv setup

    While the latest stable release should work, the majority of testing has
    been done with version 4.3.30.

    Testing has been done with libvirt version 1.2.18 and vagrant-libvirt
    versions through to 0.0.32.

* CentOS

  Two different virtualization providers are supported on Linux, `VirtualBox`_
  and `libvirt <http://libvirt.org/>`_. The choice as to which to use should be
  driven by your preferences and environmental concerns and is outside of the
  scope of this document. Both will work equally well in their default
  configuration. You may wish to read the section on file synchronization when
  making this decision.

  * VirtualBox installation instructions are available `online at the VirtualBox
    website`_. `CentOS specific instructions`_ are also available.

    While the latest stable release should work, the majority of testing has
    been done with version 4.3.30.

    A summary of the installation is listed below::

      $ sudo yum -y install epel-release
      $ sudo yum -y install dkms
      $ curl -O http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
      $ sudo mv virtualbox.repo /etc/yum.repos.d/
      $ sudo yum -y install VirtualBox-4.3
      $ sudo /etc/init.d/vboxdrv setup

  * Installing libvirt dependencies can be skipped as they are automatically
    installed together with ``vagrant-libvirt`` package.

.. _CentOS specific instructions: https://wiki.centos.org/HowTos/Virtualization/VirtualBox
.. _online at the VirtualBox website: https://www.virtualbox.org/manual/ch02.html#startingvboxonlinux
.. _VirtualBox: https://www.virtualbox.org

------------------
2. Install Vagrant
------------------

* Microsoft Windows

  1. Follow the directions at `vagrantup.com`_  Testing has been done with
     version 1.7.4.

  2. Install an ``ssh`` client. Two good options are:

     * `Cygwin <https://cygwin.com/install.html>`_
     * `mingw <http://www.mingw.org/>`_
     * Putty is not recommended as it doesn't currently interface with Vagrant

* Mac OS X

  Follow the directions at `vagrantup.com`_ Testing has been done with version
  1.7.4.

.. _vagrantup.com: https://docs.vagrantup.com/v2/installation/index.html

* Fedora 22/23/Rawhide(24)

  Testing has been done with version 1.7.2.

  * To install Vagrant with VirtualBox in Fedora 22/23/24 (Rawhide)::

    $ sudo dnf install -y vagrant

  * To install Vagrant with libvirt in Fedora 22/23/24 (Rawhide)::

      $ sudo dnf -y install vagrant-libvirt

      # Start libvirtd
      $ sudo systemctl start libvirtd

      # Set libvirtd to start automatically on system boot
      $ sudo systemctl enable libvirtd

* CentOS

  Vagrant packages are not available directly in CentOS core. However they are
  available through official CentOS `Software Collections
  <http://softwarecollections.org>`_ builds.

  Here are the commands to get Vagrant in CentOS with `libvirt` support::

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

There are two ways to download the ADB.  You can have ``vagrant`` do it for you
the first time you install it or you can download it manually.

* ``vagrant`` Initiated Download

  The image is available at https://atlas.hashicorp.com/projectatomic/boxes/adb.
  The ``vagrant`` program is capable of downloading the box the first time it is
  needed. This happens when you first initialize a new vagrant environment.

  If you wish to use a project provided vagrant file you should first get the
  Vagrantfile as directed in `Using the Atomic Developer Bundle`_ in
  the *Using Custom Vagrantfiles for Specific Use Cases* section.

  Otherwise you can issue a ``vagrant init`` command per the below. You may wish
  to review the `Using the Atomic Developer Bundle`_ documentation before
  starting the ADB, especially if you are using host-based tools.

  ::

    # Add the image to vagrant
    $ vagrant init projectatomic/adb

.. _Using the Atomic Developer Bundle: using.rst

* Manually Downloading the Vagrant Box Image

  Alternatively, you can manually download the vagrant box from
  `cloud.centos.org <http://cloud.centos.org/centos/7/atomic/images/>`_ using
  your web browser or curl. For example::

    # To get the libvirt image
    $ wget http://cloud.centos.org/centos/7/atomic/images/AtomicDeveloperBundle-<latest>.box

    # To get the virtual box image
    $ wget http://cloud.centos.org/centos/7/atomic/images/AtomicDeveloperBundle-<latest>.box

  Once you have downloaded the image, you can add it to ``vagrant`` with this
  command::

    # Add the image to vagrant
    $ vagrant box add adb <local path to the downloded image>

At this point your Atomic Developer Bundle installation is complete. You can
find `Usage Information <using.rst>`_ in the documentation directory.

.. [#F1] If you wish to downgrade back to your distributions included vagrant-libvirt, use `dnf downgrade`.

    $ sudo dnf downgrade vagrant-libvirt
