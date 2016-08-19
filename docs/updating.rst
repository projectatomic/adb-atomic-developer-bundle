===========================================================
How to update Atomic Developer Bundle to the latest version
===========================================================

Depending on your implementation of the ADB, you might be able to directly
update your Vagrant box. In some cases, you will need to perform a clean
installation or follow additional steps to complete the update.

-------------
Prerequisites
-------------

1. If ADB is running, run the `vagrant halt` command::

    # vagrant halt

2. Delete the virtual machine with the `vagrant destroy` command. This
   action will also delete any data or configuration in your ADB that is not saved
   on your host machine::

    # vagrant destroy

-----------------------------------
Update ADB from atlas.hashicorp.com
-----------------------------------

If you use ADB images from atlas.hashicorp.com, you can perform a direct update of
the Vagrant boxes.

1. Run the following command to check if a newer version of the box is available::

    # vagrant box outdated

2. If a newer version is available, the output should look like this::


      Checking if box 'projectatomic/adb' is up to date...
      A newer version of the box 'projectatomic/adb-testing' is available! You
      currently have version '1.3.1'. The latest is version '1.3.2'. Run `vagrant
      box update` to update.

3. If you see the above output, update the ADB Vagrant image with this
   command::

    # vagrant box update

--------------------------------
Update ADB from cloud.centos.org
--------------------------------

If you use ADB images from cloud.centos.org, you must manually remove the
previously-installed boxes from your host machine and perform a clean installation.

1. Monitor the mailing list and other announcement points to determine if a new image
   is available.

2. If you are updating ADB on a Windows machine, run the following command to
   delete the `.vagrant.d` directory::

     # rm -rf C:/Users/<user_name>/.vagrant.d/

3. Download the latest image and perform a clean install as described in
   the `installation documentation <installing.rst>`_.
