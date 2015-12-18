Vagrantfile: CentOS Single Node Kubernetes
==========================================

This Vagrantfile is the suggested configuration for using the ADB with Kubernetes.  This file sets up private networking that will be used to expose the docker daemon and kubernetes to the host.  This file also sets up a single node Kubernetes instance where the master and node are on the same machine.

This Vagrantfile is useful for anyone using host-based tools, such as the `Eclipse docker tooling <https://wiki.eclipse.org/Linux_Tools_Project/Docker_Tooling>`_ or the kubernetes and docker CLIs, with the ADB.

QuickStart
----------

1. Get latest ADB box and add it to vagrant per `Installing the Atomic Developer Bundle <../../../docs/installing.rst>`_.

2. Create a directory for the Vagrant Box

  ``$ mkdir directory && cd directory``

3. Download this Vagrantfile

  ``$ curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-k8s-singlenode-setup/Vagrantfile > Vagrantfile``

4. Start the Vagrant Box

  ``$ vagrant up``

5. Proceed with using the ADB per `Using the Atomic Developer Bundle <../../../docs/using.rst>`_.

  You may wish to ``vagrant ssh`` into the ADB and verify that Kubernetes is setup using the ``kubectl`` CLI as follows:

  ::

    $ kubectl get nodes                                                                         
    NAME        LABELS                             STATUS
    127.0.0.1   kubernetes.io/hostname=127.0.0.1   Ready
