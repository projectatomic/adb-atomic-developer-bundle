=================================
Using the Atomic Developer Bundle
=================================

Principles
==========

* Consider the ADB to be ephemeral and do not store data in it long term.  It is recommended that you do the following:

  * back up your code
  * use a source control system
  * mount your code into the box from your host system

  Doing these things is beyond the scope of this document.  Consult your Operating System manuals and the `Vagrant <http://vagrantup.com/>` website for more details.

Starting the Vagrant Box
========================

1. Initialize a new Vagrant environment by creating a Vagrantfile.  You may find it helpful to first create a new directory for use by this environment.  Create the Vagrantfile with this command:

   ``vagrant init <box name>``

   Box name is typically ``atomicapp/dev`` or whatever you named it when you loaded it manually.

2. Start the vagrant image with this command:
    
   ``vagrant up``
   
3.  Today all work is done inside the vagrant box.  Access the box by using ``ssh`` to login to it with the following command:

    ``vagrant ssh``

You are now at a shell prompt inside the vagrant box.  You can now execute commands and use the tools provided.

Using ``docker``
================

The ADB provides a full container environment and is running both ``docker`` and ``kubernetes``.  All standard commands will work, for example:

``docker pull centos``
    
``docker run -t -i centos /bin/bash``

Using Atomic App and Nulecule
=============================

Details on these projects can be found at these urls:

* Atomic App: https://github.com/projectatomic/atomicapp
* Nulecule: https://github.com/projectatomic/nulecule

The `helloapache <https://registry.hub.docker.com/u/projectatomic/helloapache/>`_ example can be used to test your installation.

*Note:* Many Nulecule examples expect a working kubernetes environment.  You can verify your environment with by executing ``kubectl get nodes``.  The expected output is:

::

  $ kubectl get nodes                                                                         

  NAME                LABELS              STATUS
  127.0.0.1           <none>              Ready

Destroying the Vagrant Box
==========================

Warning, this will destroy any data you have stored in the vagrant box.  You will not be able to restart this instance and will have to create a new one using ``vagrant up``.

``vagrant destroy``
