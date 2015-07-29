==========================================
Running atomic app inside the vagrant box
==========================================

Login to the vagrant box using ``vagrant ssh`` command. 

Run ``kubectl get nodes`` to check if k8s has setup as expected.

The outout should look like below

::

    $ kubectl get nodes                                                                         

    NAME                LABELS              STATUS
    127.0.0.1           <none>              Ready

Then follow the below link for running an example atomic application

Refer: https://registry.hub.docker.com/u/projectatomic/helloapache/

*Related projects*

* Atomicapp: https://github.com/projectatomic/atomicapp

* Nulecule: https://github.com/projectatomic/nulecule
