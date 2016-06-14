Vagrantfile: Single Node Kubernetes
===================================

This Vagrantfile is the suggested configuration for using the CDK with Kubernetes.  

This file expects an external type virtual switch for HyperV. The Vagrant box IP should be used to expose the ``docker`` daemon and ``Kubernetes`` to the host.  

This Vagrantfile also sets up a single node Kubernetes instance where the master and node are on the same machine.

This Vagrantfile is useful for anyone using host-based tools, such as the `Eclipse docker tooling <https://wiki.eclipse.org/Linux_Tools_Project/Docker_Tooling>`_ or the kubectl, oc and docker CLIs, with the CDK.

QuickStart
----------

1. Get latest CDK box and add it to Vagrant.

2. Create a directory for the Vagrant box.

  ``$ mkdir directory && cd directory``

3. Use this Vagrantfile.


4. Start the Vagrant box.

  ``$ vagrant up --provider hyperv``

5. Proceed with using the CDK box.

  You may wish to ``vagrant ssh`` into the CDK and verify that Kubernetes is set up using the ``kubectl`` CLI as follows:

  ::

    $ kubectl get nodes
    NAME        LABELS                             STATUS
    127.0.0.1   kubernetes.io/hostname=127.0.0.1   Ready
