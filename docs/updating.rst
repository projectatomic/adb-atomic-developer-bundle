===============================================================
How to update the Atomic Developer Bundle to the latest version
===============================================================

* If you are using the image from atlas.hashicorp.com

  1. Check if a newer version of the box is available use this command::

      # vagrant box outdated

  2. If a newer version is available, the output should look like this::

        # vagrant box outdated

     Checking if box 'projectatomic/adb' is up to date...
     A newer version of the box 'projectatomic/adb-testing' is available! You
     currently have version '1.3.1'. The latest is version '1.3.2'. Run ``vagrant
     box update`` to update.

  3. If you see the above output, update the ADB Vagrant image with this
     command::

      # vagrant box update

  4. Once the image is updated, you can restart the ADB with the new version
     with this command::

      # vagrant up

* If you are using image from cloud.centos.org

  You will need to monitor the mailing list and other announcement points to
  determine if a new image is available. If an image is available, download it
  and install it using the instructions in the `installation documentation
  <installing.rst>`_.

