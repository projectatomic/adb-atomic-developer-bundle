Vagrantfile: CentOS Docker Base
===============================

This Vagrantfile is the default suggested configuration for the ADB.  This file sets up private networking that will be used to expose the docker daemon to the host.  This Vagrantfile is useful for anyone using host-based tools, such as the `Eclipse docker tooling <https://wiki.eclipse.org/Linux_Tools_Project/Docker_Tooling>`_ or the docker CLI, with the ADB.

QuickStart
----------

1. Get latest ADB box and add it to vagrant per `Installing the Atomic Developer Bundle <../../../docs/installing.rst>`_.

2. Create a directory for the Vagrant Box

  ``$ mkdir directory && cd directory``

3. Download this Vagrantfile

  ``$ curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-docker-base-setup/Vagrantfile > Vagrantfile``

4. Start the Vagrant Box

  ``$ vagrant up``

5. Proceed with using the ADB per `Using the Atomic Developer Bundle <../../../docs/using.rst>`_.
