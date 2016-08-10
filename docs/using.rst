


.. contents::
   :local:
   :depth: 2
   :backlinks: none

=================================
Using the Atomic Developer Bundle
=================================

Principles
==========

Consider the ADB to be ephemeral and do not store data in it long term. It is
recommended that you do the following:

* Back up your code.
* Use a source control system.
* Mount your code into the box from your host system. The provided `custom Vagrantfile examples
  <#using-custom-vagrantfiles-for-specific-use-cases>`_ already mount your home directory on the host
  into the guest using `vagrant-sshfs <https://github.com/dustymabe/vagrant-sshfs/>`_.
  Additional shares can also be defined. Refer to the `bi-directional folder sync
  section <#vagrant-bi-directional-folder-sync>`_ for more information.

Doing these things is beyond the scope of this document. Consult your Operating
System manuals and the `Vagrant <http://vagrantup.com/>`_ website for more
details.

Starting the Vagrant Box
========================

1. Initialize a new Vagrant environment by creating a Vagrantfile. You may find
   it helpful to first create a new directory for use by this environment.
   Create the Vagrantfile with this command:

   ``vagrant init <box name>``

   Box name is typically ``projectatomic/adb`` or whatever you named it when you
   loaded it manually.

2. Edit the ``Vagrantfile`` to setup private networking. The private network is
   used to expose ADB-based services, such as the docker daemon, to the host.
   This is done by adding the following line in the ``Vagrant.configure``
   section.

   ``config.vm.network "private_network", type: "dhcp"``

3. Start the Vagrant image with this command:

   ``vagrant up``

   **Note:** On Fedora and CentOS you may need to specify which virtualization
   provider to use.  For example, to use VirtualBox, the command would be
   ``vagrant up --provider virtualbox``

Using Custom Vagrantfiles for Specific Use Cases
================================================

Custom Vagrant files are shipped for specific use cases. The README files
contain useful documentation and a quickstart guide.

* Docker for use with host-based tools, such as Eclipse and the docker CLI, or
  via ``vagrant ssh``

  * `Vagrantfile <../components/centos/centos-docker-base-setup/Vagrantfile>`_
  * `README <../components/centos/centos-docker-base-setup/README.rst>`_

* Kubernetes for use with host-based tools or via ``vagrant ssh``

  * `Vagrantfile <../components/centos/centos-k8s-singlenode-setup/Vagrantfile>`_
  * `README <../components/centos/centos-k8s-singlenode-setup/README.rst>`_

* OpenShift Origin for use with host-based tools or via ``vagrant ssh``

  * `Vagrantfile <../components/centos/centos-openshift-setup/Vagrantfile>`_
  * `README <../components/centos/centos-openshift-setup/README.rst>`_

* Apache Mesos Marathon for use with host-based tools or via ``vagrant ssh``

  * `Vagrantfile <../components/centos/centos-mesos-marathon-singlenode-setup/Vagrantfile>`_
  * `README <../components/centos/centos-mesos-marathon-singlenode-setup/README.rst>`_

Using the ADB with Host-based Tools (Eclipse and CLIs)
======================================================

Many users have preferred development environments built from tools running on
their development workstation. Even if these workstations are unable to run
containers or container-components natively, the user may still want to use their
preferred tools, editors, etc.
The ADB can be used with these tools in a way that makes it seamless to interact
with files, preferred development tools, etc.

The ADB exposes the docker daemon port and orchestrator access points so that tools
like Eclipse and various CLIs can interact with them. For security reasons,
some ports, such as the docker daemon port, are TLS protected. Therefore some
configuration is required before the service can be accessed.
Vagrant-service-manager makes this configuration simple by providing easy access
to the TLS certificates and the other environment variables or configuration information.

To use ADB with Host-Based tools:

1. Install the vagrant-service-manager plugin. ::

       vagrant plugin install vagrant-service-manager

   More information about the vagrant-service-manager plugin is available in the `source repository`_.

 .. _source repository: https://github.com/projectatomic/vagrant-service-manager

2. Enable the desired service(s) in the ADB Vagrantfile as::

    config.servicemanager.services = 'openshift'

   **Note:**
* Docker is a default service for the ADB and does not require any configuration to ensure it is started.
  Additionally, the Red Hat Enterprise Linux Container Development Kit, which is
  based on the Atomic Developer Bundle, automatically starts OpenShift as well.
* You can enable multiple services as a comma separated list. For instance: `docker, openshift`.

3. Enable any specific options for the services you have selected as:

   For instance, in OpenShift, specific versions can be specified using the following variables:

   1. ``config.servicemanager.openshift_docker_registry = "docker.io"`` - Specifies the registry from where the service should be pulled.
   2. ``config.servicemanager.openshift_image_name = "openshift/origin"`` - Specifies the image to be used.
   3. ``config.servicemanager.openshift_image_tag = "v1.2.0"`` - Specifies the version of the image to be used.

4. Start the ADB using ``vagrant up``. For details consult the `Installation documentation`_.

.. _Installation documentation: https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/docs/installing.rst


5. Configure the environment and download the required TLS certificates using
   the plugin. The example below shows the command and the output for Linux and Mac OS X.
   On Microsoft Windows the output may vary depending on the execution environment::

     $ vagrant service-manager env
     # docker env:
     # Set the following environment variables to enable access to the
     # docker daemon running inside of the vagrant virtual machine:
     export DOCKER_HOST=tcp://10.1.2.2:2376
     export DOCKER_CERT_PATH=/foo/bar/.vagrant/machines/default/virtualbox/docker
     export DOCKER_TLS_VERIFY=1
     export DOCKER_API_VERSION=1.21

     # run following command to configure your shell:
     # eval "$(vagrant service-manager env)"

   Setting these environment variables allows programs, such as Eclipse and the
   docker CLI to access the docker daemon.

   **Note:** When the OpenShift service is running in the VM, a docker registry
   is also started. This Docker registry can be consumed by external
   tools such as Eclipse to push or pull images. The Docker registry url is exported
   as a variable, and can be accessed as shown below::

     $ vagrant service-manager env openshift
     # openshift env:
     # You can access the OpenShift console on: https://10.1.2.2:8443/console
     # To use OpenShift CLI, run: oc login https://10.1.2.2:8443
     export OPENSHIFT_URL=https://10.1.2.2:8443
     export OPENSHIFT_WEB_CONSOLE=https://10.1.2.2:8443/console
     export DOCKER_REGISTRY=hub.openshift.centos7-adb.10.1.2.2.xip.io

6. Begin developing.

   If you do not have the docker CLI, you can use the ``install-cli`` command as
   shown below::

     $ vagrant service-manager install-cli docker

   However, if you are using the docker CLI, you can just run it from the command
   line and it will work as expected.

   **Note:** If you encounter a Docker client and server version mismatch such as::

    $ docker ps
    Error response from daemon: client is newer than server (client API version: 1.21, server API version: 1.20)

   You will need to download an earlier compatible version of Docker for your
   host machine. Docker release versions and docker API versions are not the same.
   Typically, you will need to try the previous release (i.e. if you get this error
   message using a docker 1.9 CLI, try a docker 1.8 CLI).


   If you are using Eclipse, you should follow these steps:

   1. Install the `Docker Tooling`_ plugin.

   2. Enable the three Docker Views (Docker Explorer, Docker Containers, and
      Docker Images) by choosing **Windows->Show Views->Others**.

   3. Enable the Console by choosing **Windows->Show Views->Console**.

   4. In the ``Docker Explorer`` view, click to add a connection. You should provide a "connection name".
      If your Environment Variables are set correctly, the remaining fields will auto-populate. If not, using the
      output from ``vagrant service-manager env docker``, put the DOCKER_HOST
      variable in the "TCP Connection" field and the DOCKER_CERT_PATH in the
      "Authentication Section" Path.

   5. You can test the connection and then accept the results. At this point, you are ready to use the ADB with Eclipse.

.. _Docker Tooling: http://www.eclipse.org/community/eclipse_newsletter/2015/june/article3.php
      **Note:** Testing has been done with Eclipse 4.5.0.

Using the ADB behind http proxy
===============================

ADB can be setup behind a proxy server. You need to export the proxy server information in to the environment and then run ``vagrant up``.

**Note:** Currently, only HTTP and HTTPS proxy servers are supported.

For GNU/Linux. OS X and Cygwin shell::
    
    export PROXY="<proxy_server>:<port>"
    export PROXY_USER="foo"
    export PROXY_PASSWORD="mysecretpass"

For Windows CMD or Powershell::

    setx PROXY="<proxy_server>:<port>"
    setx PROXY_USER="foo"
    setx PROXY_PASSWORD="mysecretpass"

Using the box via SSH
=====================

Today, most users will work inside the Vagrant box.
Access the box by using ``ssh`` to login to it with the following command::

    vagrant ssh

You are now at a shell prompt inside the Vagrant box. You can now execute
commands and use the tools provided.

You can use the `sccli <https://github.com/projectatomic/adb-utils/blob/master/README.rst>`_
to manage the orchestration services inside of the ADB.
``sccli`` makes it easy to start and stop orchestration providers like Kubernetes
or OpenShift.

Using ``docker``
################

The ADB provides a full container environment and runs both ``docker`` and
``kubernetes``. All standard commands work, for example::

   docker pull centos
   docker run -t -i centos /bin/bash

Using Atomic App and Nulecule
#############################

Details on these projects can be found at these urls:

* Atomic App: https://github.com/projectatomic/atomicapp
* Nulecule: https://github.com/projectatomic/nulecule

The `helloapache`_ example can be used to test your installation.

**Note:** Many Nulecule examples expect a working kubernetes environment. Use the `Vagrantfile <../components/centos/centos-k8s-singlenode-setup/Vagrantfile>`_ and refer the corresponding `README <../components/centos/centos-k8s-singlenode-setup/README.rst>`_ to set up a single node kubernetes environment.

You can verify your environment by executing ``kubectl get nodes``. The
expected output is::

    $ kubectl get nodes
    NAME        LABELS                             STATUS
    127.0.0.1   kubernetes.io/hostname=127.0.0.1   Ready

.. _helloapache: https://registry.hub.docker.com/u/projectatomic/helloapache/

Vagrant bi-directional folder sync
==================================

For an introduction into Vagrant's synced folders feature, we recommend you to start with the
corresponding `Vagrant documentation <https://www.vagrantup.com/docs/synced-folders/basic_usage.html>`_.

Synced folders enable movement of files (such as, code files) between the host and the Vagrant guest. Apart from the
`rsync synced folder type <https://www.vagrantup.com/docs/synced-folders/rsync.html>`_, synced folder
types are usually bi-directional and continuously sync the folder while the guest is running.

The following synced folder types work out of the box with the ADB Vagrant box, for both Virtualbox as well as Libvirt/KVM :

* `vagrant-sshfs <https://github.com/dustymabe/vagrant-sshfs>`_: Works with Linux/GNU, OS X
  and Microsoft Windows. It is the recommended choice for enabling synced folders and the
  `custom Vagrantfile examples <#using-custom-vagrantfiles-for-specific-use-cases>`_ use it per default.
  In the suggested default configuration, your home directory on the host (for example, ``/home/john``)
  is synced to the equivalent path on the guest VM (``/home/john``). For Windows users, there is
  a little caveat, their home directory (for example, `C:\Users\john`) must be mapped to a Unix style
  path (``/c/users/john``).

* `NFS <https://www.vagrantup.com/docs/synced-folders/nfs.html>`_: Works with Linux/GNU and OS X.

There are also some other alternatives, which are, however, not yet properly tested with ADB.

* `SMB <https://www.vagrantup.com/docs/synced-folders/smb.html>`_: For Microsoft Windows.

  * You need to install cifs-utils RPM inside ADB, for the SMB synced folder type to work::

     sudo yum install cifs-utils

* `Virtualbox shared folder  <https://www.virtualbox.org/manual/ch04.html#sharedfolders>`_: For Virtualbox users with Virtualbox guest additions.

  * At this point of time Virtualbox guest additions do not come pre-installed in the ADB Vagrant box.
  * For installation details, please refer to `Virtualbox documentation <https://www.virtualbox.org/manual/ch04.html>`_.
  * You can also use `vagrant-vbguest <https://github.com/dotless-de/vagrant-vbguest>`_ plugin to install Virtualbox guest additions in ADB Vagrant box.


Some Useful Commands
====================
* ``vagrant halt`` - Stop the vagrant box, temporarily:

  You can use ``vagrant halt`` to gracefully stop the vagrant box and continue with
  your work when you start next with ``vagrant up``. This will not cause any loss
  of data. It is recommended to stop the vagrant box before you shutdown your machine,
  to save CPU and RAM consumption. Also, powering off your machine without stopping
  the vagrant box, could cause errors when you resume using it.

* ``vagrant status`` - Check the Status of the Vagrant box:

  Use ``vagrant status`` to check the status of ADB and to check which virtualization
  provider is being used and the status of the provider.

* ``vagrant destroy`` - Destroy the Vagrant Box:

  **Warning:**
  Using ``vagrant destroy``, will destroy any data you have stored in the Vagrant
  box. You will not be able to restart this instance and will have to create a
  new one using ``vagrant up``.
