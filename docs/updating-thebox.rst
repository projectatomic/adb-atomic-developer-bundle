==========================================
How to update the vagrant box to latest version
==========================================

--------------------
If you are using the image from atlas.hashicorp.com
--------------------

To check if a newer version of the box is available at https://atlas.hashicorp.com/atomicapp/boxes/dev run:

``vagrant box outdated`` 

If a newer version is available, the output should look like this:

::

    # vagrant box outdated

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
