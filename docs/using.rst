=================================
Using the Atomic Developer Bundle
=================================

Principles
==========

* Consider the ADB to be ephemeral and do not store data in it long term.  It is recommended that you do the following:

  * back up your code
  * use a source control system
  * mount your code into the box from your host system

  Doing these things is beyond the scope of this document.  Consult your Operating System manuals and the `Vagrant <http://vagrantup.com/>`_ website for more details.

Starting the Vagrant Box
========================

1. Initialize a new Vagrant environment by creating a Vagrantfile.  You may find it helpful to first create a new directory for use by this environment.  Create the Vagrantfile with this command:

   ``vagrant init <box name>``

   Box name is typically ``atomicapp/dev`` or whatever you named it when you loaded it manually.

2. Start the vagrant image with this command:
    
   ``vagrant up``

   **Note:** On Fedora and CentOS you may need to specify which virtualization provider to use.  For example, to use VirtualBox, the command would be ``vagrant up --provider virtualbox``

Using the box via SSH
=====================
   
Today most users will do their work inside the vagrant box.  Access the box by using ``ssh`` to login to it with the following command:

``vagrant ssh``

You are now at a shell prompt inside the vagrant box.  You can now execute commands and use the tools provided.

Using ``docker``
################

The ADB provides a full container environment and is running both ``docker`` and ``kubernetes``.  All standard commands will work, for example::

   docker pull centos
   docker run -t -i centos /bin/bash

Using Atomic App and Nulecule
#############################

Details on these projects can be found at these urls:

* Atomic App: https://github.com/projectatomic/atomicapp
* Nulecule: https://github.com/projectatomic/nulecule

The `helloapache <https://registry.hub.docker.com/u/projectatomic/helloapache/>`_ example can be used to test your installation.

*Note:* Many Nulecule examples expect a working kubernetes environment.  To setup a single node kubernetes environment use the `Vagrantfile <../components/centos/centos-k8s-singlenode-setup/Vagrantfile>`_ and refer the corresponding `README <../components/centos/centos-k8s-singlenode-setup/README.rst>`_

You can verify your environment with by executing ``kubectl get nodes``.  The expected output is:

::

  $ kubectl get nodes                                                                         
  NAME        LABELS                             STATUS
  127.0.0.1   kubernetes.io/hostname=127.0.0.1   Ready

Using the box from the Host
===========================

Many users may wish to use the ADB from their Host so it can seamlessly interact with their files, preferred development tools, etc.

Today, the only support is for the exposure of the docker daemon port.  The docker daemon is TLS protected, so in addition to exposing the port you must configure the docker command on the host to use TLS and the right port.  This can be done via environment variables.

1. Install the ``vagrant-adbinfo`` plugin in order to get easy access to the correct environment variables and the TLS certificates.

   ``vagrant plugin install vagrant-adbinfo``

More information about the vagrant-adbinfo plugin is `available in the source repository <https://github.com/bexelbie/vagrant-adbinfo>`_

2. If you haven't already, modify your Vagrantfile to expose the docker daemon port by adding this line:

   ``config.vm.network "forwarded_port", guest: 2376, host: 2379, auto_correct: true``

3. Reload your vagrant box to set up the new port forward, if necessary.

   ``vagrant reload``
   
4. Get the correct environment variables and TLS certificates from the plugin.  The example below shows the command and the output::

    $ vagrant adbinfo
    Set the following environment variables to enable access to the
    docker daemon running inside of the vagrant virtual machine:
    
    export DOCKER_HOST=tcp://127.0.0.1:5555
    export DOCKER_CERT_PATH=/home/bexelbie/Repositories/vagrant-adbinfo/.vagrant/machines/default/virtualbox/.docker
    export DOCKER_TLS_VERIFY=1
    export DOCKER_MACHINE_NAME="90d3e96"

Setting these environment variables allows commands, such as docker to access the docker daemon.  There is no need to pass any special options to the ``docker`` command.


Destroying the Vagrant Box
==========================

Warning, this will destroy any data you have stored in the vagrant box.  You will not be able to restart this instance and will have to create a new one using ``vagrant up``.

``vagrant destroy``
