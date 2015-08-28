==========================================
Running Atomic App inside the vagrant box
==========================================

Login to the vagrant box using ``vagrant ssh`` command. 

Run ``kubectl get nodes`` to check if k8s has setup as expected.

The outout should look like below

::

    $ kubectl get nodes                                                                         

    NAME                LABELS              STATUS
    127.0.0.1           <none>              Ready

The `helloapache`<https://registry.hub.docker.com/u/projectatomic/helloapache/>`_ can be used to test your installation.

*Related projects*

* Atomic App: https://github.com/projectatomic/atomicapp
* Nulecule: https://github.com/projectatomic/nulecule
