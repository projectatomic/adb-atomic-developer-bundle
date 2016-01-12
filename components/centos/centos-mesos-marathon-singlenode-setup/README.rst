Vagrantfile: CentOS Mesos Marathon Single-Node Setup
====================================================

This Vagrantfile sets up ADB for development with Mesos and Marathon. It also sets up private networking that will be used to expose the services to the host. This Vagrantfile is based on `ADB <https://atlas.hashicorp.com/projectatomic/boxes/adb>`_ vagrant box. It sets up Mesos master & slave and Marathon on a CentOS 7 system. It uses the rpm packages for these from `Mesosphere repo <http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm>`_.

Start the Vagrant box
---------------------

To setup a virtualization provider or install Vagrant refer `this document <https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/docs/installing.rst>`_. 

To bring up a Vagrant box using a different virtualization provider, replace ``libvirt`` in below command with the provider of your choice.

::

$ sudo vagrant up --provider=libvirt


Note
----

Vagrantfile for this setup is pretty small. That is because `Ansible <http://www.ansible.com/>`_ is used for most of the provisioning. Depending on your Internet connection, box should be up and running with all the necessary packages installed within a few minutes to about an hour.

Once the box is up, you can access Mesos master UI on `10.2.2.2:5050 <http://10.2.2.2:5050>`_ and Marathon UI on `10.2.2.2:8080 <http://10.2.2.2:8080>`_ if you've not changed the value of the parameter **ip** in Vagrantfile.
