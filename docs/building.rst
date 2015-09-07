============================
Building the ADB Vagrant Box
============================

The vagrant box is based on CentOS7. It is built using the latest packages from CentOS core.  Some components of the ADB will be delivered in containers and will use code drawn from upstream projects to add newer features.  Today no containers are including a fully built box.  The box can be built using the CentOS powered `Community Build System (CBS) <https://wiki.centos.org/HowTos/Commun  ityBuildSystem>`_.

To build the box:

* Get access for building images in the CBS by following the directions here: http://wiki.centos.org/HowTos/CommunityBuildSystem
* Checkout/git clone this repository ``git clone https://github.com/projectatomic/adb-atomic-developer-bundle``
* ``cd adb-atomic-developer-bundle``
* Run the ``./build_tools/build_scripts/do_vagrant_cbs.sh``

Here is an example koji scratch build : http://cbs.centos.org/koji/taskinfo?taskID=13349
