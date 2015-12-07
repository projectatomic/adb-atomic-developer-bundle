Getting started with Vagrantfile
-----------------------------------------------------------

* This Vagrantfile is for setting up a single node kubernetes setup with ADB Vagrant box.
* i.e. The master and node setup in the single machine.

Steps
-----

* git clone the adb git repo
* change in to the directory containing this vagrant file
* do vagrant up

::
     
     git clone https://github.com/projectatomic/adb-atomic-developer-bundle.git
     cd adb-atomic-developer-bundle/components/centos/centos-with-kubernetes
     vagrant up

After the `vagrant up`, you can do a `vagrant ssh` in to the box and run `kubectl get nodes` command to see if the setup is done correctly.
::

  $ kubectl get nodes                                                                         
  NAME        LABELS                             STATUS
  127.0.0.1   kubernetes.io/hostname=127.0.0.1   Ready
