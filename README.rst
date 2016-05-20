.. contents::
   :local:
   :depth: 2
   :backlinks: none

What is the Atomic Developer Bundle (ADB)?
==========================================

The Atomic Developer Bundle (ADB) is a prepackaged development
environment filled with production-grade pre-configured tools that makes
container developer's lives easier.  The ADB supports the development
of multi-container applications against different technologies and
orchestrators while providing a path that promotes best practices.

As a container developer, you want to use the ADB for these reasons:

* Pre-Configured: You don't have to spend time building an environment
  and fighting configuration battles
* Multiple Environment Support: The ADB works on Windows, Linux and Mac
  OS X.  The ADB supports several orchestrators (Open Shift, Kubernetes,
  Mesos, and plain Docker).  The ADB is language independent and supports
  multiple developer models (IDE, CLI, SSH containment).
* Production-Grade: The components of the ADB are configured to behave
  just as they will in production.  Containers promise seamless delivery,
  but only if you test them in the right environment.  This is that
  environment.
* Self-Contained: The ADB is ready to go once installed.  It comes
  prepackaged with the most common components ready, in case they
  are needed.
* Open Source: The ADB leverages existing tools and technologies where
  ever possible to avoid pushing a developer into an environment that
  won't be supportable in production or that is tied to a single vendor.
  This also means it benefits from the stability of existing projects
  instead of reinventing the wheel.

The ADB is a virtual machine that is executed with Vagrant and some
Vagrant plugins.

When would the Atomic Developer Bundle (ADB) typically be used?
===============================================================

A developer begins using the ADB, in most cases, once they have a
working application that has been decomposed into micro-services.
They then follow this general outline of steps:

1. Build a Dockerfile for each microservice that is not able to be used
   from another source.  In other words, build containers for the parts
   of the application that are unique and reuse for those that aren't
   (i.e. a database service)
2. Confirm the application works in the ADB by manually launching the
   application's container components or by using the instance of
   OpenShift in the container to launch the application
3. Build a Nulecule description of the application or complete the
   OpenShift application configuration
4. Test the application

The original `motivation`_ behind this project may also be of interest.

.. _motivation: docs/motivation.md

What is the Typical Usage Pattern?
==================================

The ADB supports three basic modes of usage.  The modes vary by how much
they rely on tools on the developers workstation.  From most to least
reliant, they are:

* Host-based IDE Mode

  This mode uses the ADB as a server resource for host-based IDE tools.
  In this mode, the user will run `eclipse` or other IDE tools that will
  access the resources of the ADB.

* Host-based CLI Mode

  This mode uses the ADB as a server resource for host-based CLI tools.
  In this mode, the user will run `docker` and other CLI tools on their
  workstation and the result will be containers executed inside of
  the ADB.

* SSH Mode

  This mode uses the ADB as a Linux virtual machine.  The user will
  use the `ssh` command to log into the ADB and will directly execute
  `docker` and other commands from the command line.  This is similar
  to having installed a Linux virtual machine and then installing and
  configuring all of the software the ADB ships with.

More information about `using the ADB`_ is available.

.. _using the ADB: docs/using.rst

What does it contain?
=====================

The ADB is built on top of `CentOS 7`_ and contains the following:

* `Docker`_: container runtime and packaging
* `Atomic CLI`_: container usage assistance
* `Kubernetes`_: container orchestration
* `OpenShift Origin`_: a next generation PaaS for docker containers.
* `openshift2nulecule`_: a tool that creates a Nulecule application from an existing OpenShift project

The ADB supports `Atomic App`_, an implementation of the multi-container
application specification, `nulecule`_ for multi-container applications.

.. _CentOS 7: https://www.centos.org/
.. _Docker: https://www.docker.com/
.. _Atomic CLI: https://github.com/projectatomic/atomic/
.. _Kubernetes: http://kubernetes.io/
.. _OpenShift Origin: http://www.openshift.org/
.. _Atomic App: https://github.com/projectatomic/atomicapp/
.. _nulecule: https://github.com/projectatomic/nulecule/
.. _openshift2nulecule: https://github.com/projectatomic/openshift2nulecule/

How do I Install and Run the Atomic Developer Bundle (ADB)?
===========================================================

Below is a quick installation guide using the most common options.
Detailed `installation instructions`_ are available.

1. `Install VirtualBox`_ for your operating system.  Linux users may
   wish to use their distribution provided package.

   ``sudo dnf install VirtualBox``

2. `Install Vagrant`_ for your operating system.  Linux users may wish
   to use their distribution provided package.

   ``sudo dnf install vagrant``

3. Install the `vagrant-service-manager`_ Vagrant plugin:

   ``vagrant plugin install vagrant-service-manager``

4. Download the latest ADB from `atlas.hashicorp.com`_.  This can be
   done automatically by Vagrant:

   ``$ vagrant init projectatomic/adb``

5. Start the ADB

   ``$ sudo vagrant up``

6. If you will be using host based tools, setup your environment with `vagrant-service-manager`

   ``$sudo vagrant service-manager --help``

.. _installation instructions: docs/installing.rst
.. _Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
.. _Install Vagrant: https://docs.vagrantup.com/v2/installation/index.html
.. _vagrant-service-manager: https://github.com/projectatomic/vagrant-service-manager
.. _atlas.hashicorp.com: https://atlas.hashicorp.com/boxes/search

What is full feature set?
=========================

Today the box supports the following:

* Providing docker support to unsupported platforms (i.e. Microsoft
  Windows, Mac OS X, etc.)
* Kubernetes orchestration for local testing of applications
* Application definition using the Nulecule specification
* Additional goals, objectives and work in progress can be found in
  the `architecture and roadmap`_ document and on the Project Atomic
  `trello board`_

.. _architecture and roadmap: docs/architecture.rst
.. _trello board: https://trello.com/b/j1rEolFe/container-tools

What are the deliverables and how do I get it?
==============================================

The ADB is delivered as a Vagrant box for various (currently libvirt and
VirtualBox) providers.  The boxes are built using the CentOS powered
`Community Build System`_.  Boxes are delivered via `Hashicorp's
Atlas`_ and are available at `cloud.centos.org`_.  These boxes differ
from existing Vagrant boxes for CentOS as they have specific build
requirements that are not enabled in those boxes.

.. _Community Build System: https://wiki.centos.org/HowTos/CommunityBuildSystem
.. _Hashicorp's Atlas: https://atlas.hashicorp.com/boxes/search
.. _cloud.centos.org: http://cloud.centos.org/centos/7/vagrant/x86_64/images/

Documentation
=============

* `Installing the ADB`_
* `How to use the ADB`_
** `Using Cockpit with the ADB`_
* `Updating the ADB`_
* `Architecture and Roadmap`_
* `Building the Vagrant box`_ for Developers

.. _Installing the ADB: docs/installing.rst
.. _How to use the ADB: docs/using.rst
.. _Using Cockpit with the ADB: docs/cockpit.rst
.. _Updating the ADB: docs/updating.rst
.. _Architecture and Roadmap: docs/architecture.rst
.. _Building the Vagrant box: docs/building.rst

Interested in Contributing to this project?
===========================================

We welcome new ideas, suggestions, issues and pull requests.  Want to be more involved, join us:

* Mailing List: `container-tools@redhat.com`_
* IRC: #atomic and #nulecule on `freenode`_
* Weekly Standup/Review/Plannng Meeting: Every Monday at 1300 UTC in #nulecule (`freenode`_) for 0.5 hour.  An agenda for this meeting is maintained at https://titanpad.com/adbmeeting

Documentation is written using `reStructuredText`_. An `online
reStructuredText editor`_ is available.

.. _container-tools@redhat.com: https://www.redhat.com/mailman/listinfo/container-tools
.. _freenode: https://freenode.net/
.. _Video Conference: https://bluejeans.com/381583203
.. _phone access number: https://www.intercallonline.com/listNumbersByCode.action?confCode=8464006194
.. _reStructuredText: http://docutils.sourceforge.net/docs/user/rst/quickref.html
.. _online reStructuredText editor: http://rst.ninjs.org
