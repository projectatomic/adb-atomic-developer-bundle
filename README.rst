What is the Atomic Developer Bundle (ADB)?
==========================================

The Atomic Developer Bundle (ADB) helps developers package their microservice architecture applications for delivery in linux containers.  Today the docker container format is supported, but nothing prevents additional formats, such as rkt, from being supported in the future.  While the environment can be used from the beginning of the development process, it is expected that most users will have their  core code working prior to starting the containerization process.  The ADB will assist developers by providing a platform that supports:

* `DevAssistant <http://devassistant.org/>`_ to help write Dockerfiles
* The building of docker images (critical for operating systems such as Windows and OS X that do not support containers natively)
* The `Atomic CLI <https://github.com/projectatomic/atomic>`_ to allow for LABELs that make the containers easier to start
* `DevAssistant <http://devassistant.org/>`_ to help write a `Nulecule <https://github.com/projectatomic/nulecule>`_ application descriptions for multiple providers (OpenShift, Kubernetes, native docker) to allow for easy install and configuration
* `Atomic App <https://github.com/projectatomic/atomicapp>`_ to execute the `Nulecule Specification <https://github.com/projectatomic/nulecule>`_ and wrap the application up as a single installation container

A developer begins using the ADB, in most cases, once they have a working application that has been decomposed into micro-services.  They then follow this general outline of steps:

1. Build a Dockerfile for each microservice that is not able to be used from another source.  In other words, build containers for the parts of the application that are unique and reuse for those that aren't (i.e. a database service)
2. Confirm the application works in the ADB by manually launching the application's container components or by using the instance of OpenShift in the container to launch the application
3. Build a Nulecule description of the application or complete the OpenShift application configuration
4. Test the application

The original `motivation <docs/motivation.md>`_ behind this project may also be of interest.

What is full feature set?
=========================

Today the box supports the following:

* Providing docker support to unsupported platforms (i.e. Microsoft Windows, Mac OS X, etc.)
* Kubernetes orchestration for local testing of applications
* Application definition using the Nulecule specification
* Additional goals, objectives and work in progress can be found in the `architecture and roadmap <docs/architecture.rst>`_ document and on the Project Atomic `trello board <https://trello.com/b/j1rEolFe/container-tools>`_

What are the deliverables and how do I get it?
==============================================

The ADB is delivered as a vagrant box for various (currently libvirt and VirtualBox) providers.  The boxes are built using the CentOS powered `Community Build System <https://wiki.centos.org/HowTos/CommunityBuildSystem>`_.  Boxes are delivered via `Hashicorp's Atlas <https://atlas.hashicorp.com/boxes/search>`_ and are available at `cloud.centos.org <http://cloud.centos.org/centos/7/vagrant/x86_64/images/>`_.  These boxes differ from existing vagrant boxes for CentOS as they have specific build requirements that are not enabled in those boxes.

Detailed `installation instructions <docs/installing.rst>`_ are available.  Installation of the ADB is essentially:

1. Install vagrant and a virtualization provider

   * For Microsoft Windows and Mac OS X:

     1. Install a virtualization provider, the recommended provider is `VirtualBox <https://www.virtualbox.org/>`_
     2. Install vagrant from `vagrantup.com <https://docs.vagrantup.com/v2/installation/index.html>`_

   * For Linux, the recommended provider is `libvirt <http://libvirt.org>`_.  This is packaged for most distributions.

     * Centos 7: ``yum install libvirt``
     * Fedora 22: ``dnf install libvirt``

2. Download the latest ADB from `atlas.hashicorp.com <https://atlas.hashicorp.com/boxes/search>`_.  This can be done automatically by vagrant:

   ``$ vagrant init atomicapp/dev``

3. Start the ADB

   ``$ vagrant up``

What does interacting with the ADB look like?
=============================================

Today all work is done inside the vagrant box.  To access the ADB, use the ``vagrant ssh`` command.  Once you are logged in you can run ``docker`` and the other tools.  More information about `using the ADB <docs/usinging.rst>`_ is available.

Documentation
=============

* `Architecture and Roadmap <docs/architecture.rst>`_
* `Building the Vagrant box <docs/building.rst>`_ for Developers
* `Installing the ADB <docs/installing.rst>`_
* `How to use the ADB <docs/using.rst>`_
* `Updating the ADB <docs/updating.rst>`_

Interested in Contributing to this project?
===========================================

We welcome issues and pull requests.  Want to be more involved, join us:

* Mailing List: `container-tools@redhat.com <https://www.redhat.com/mailman/listinfo/container-tools>`_
* IRC: #atomic on `freenode <https://freenode.net/>`_
* Meeting: every Wednesday at 1230 UTC in a Bluejean `Video Conference <https://bluejeans.com/381583203>`_.  Alternately, a local `phone access number <https://www.intercallonline.com/listNumbersByCode.action?confCode=8464006194>`_ may be available.

**Note:** These meetings, mailing lists, and irc channels may include discussion of other Project Atomic components.

Documentation is written using `reStructuredText <http://docutils.sourceforge.net/docs/user/rst/quickref.html>`_. An `online reStructuredText editor <http://rst.ninjs.org>`_ is available.
