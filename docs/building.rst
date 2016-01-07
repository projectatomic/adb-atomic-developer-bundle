============================
Building the ADB Vagrant Box
============================

The Vagrant box is based on CentOS7. It is built using the latest packages from
CentOS core.  Some components of the ADB will be delivered in containers and
will use code drawn from upstream projects to add newer features. Today no
containers are including a fully built box.  The box can be built using the
CentOS powered `Community Build System (CBS)`_

.. _Community Build System (CBS): https://wiki.centos.org/HowTos/CommunityBuildSystem

To build the box:

* Get access for building images in the CBS by following the directions here:
  http://wiki.centos.org/HowTos/CommunityBuildSystem

  **Note:** You need to request both "build" and "image" permissions

* Checkout/git clone this repository ``git clone https://github.com/projectatomic/adb-atomic-developer-bundle``
* ``cd adb-atomic-developer-bundle``
* Run the ``./build_tools/build_scripts/do_vagrant_cbs.sh``

  **Note:** This script assumes you have a profile in your $HOME/.koji/config
  called "cbs"  If this is your only usage of koji, delete the ``-p cbs`` from
  the command in the script. If you use multiple instances of koji, either
  rename your config for the CBS or change the script.

Here is an example koji scratch build: http://cbs.centos.org/koji/taskinfo?taskID=13349
