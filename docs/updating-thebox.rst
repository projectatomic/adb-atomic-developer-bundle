==========================================
How to update the vagrant box to latest version
==========================================

--------------------
If you are using image from atlas.hashicorp.com
--------------------

To check if a nwer version of box available at https://atlas.hashicorp.com/atomicapp/boxes/dev

* Run ``vagrant box outdated`` 

If a newer version is available, the outout should look like below

::

    [root@n7 atomicapp-dev]# vagrant box outdated

    Checking if box 'atomicapp/dev-testing' is up to date...
    A newer version of the box 'atomicapp/dev-testing' is available! You currently
    have version '1.3.1'. The latest is version '1.3.2'. Run
    `vagrant box update` to update.


If you see the above output

* Run ``vagrant box update``

Once the box is updated

* Run ``vagrant up``

--------------------
If you are using image from cloud.centos.org
--------------------

TBD
