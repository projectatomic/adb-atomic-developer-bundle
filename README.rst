.. contents::
   :local:
   :depth: 2
   :backlinks: none

What is the Atomic Developer Bundle (ADB)?
==========================================

The Atomic Developer Bundle (ADB) is a prepackaged development
environment filled with production-grade, pre-configured tools, that makes
container developers' lives easier.  The ADB supports the development
of multi-container applications against different technologies and
orchestrators while providing a path that promotes best practices.

As a container developer, you want to use the ADB for these reasons:

* **Pre-Configured**: You don't have to spend time building an environment
  and fighting configuration battles.
* **Multiple Environment Support**: The ADB works on Windows, Linux and Mac
  OS X. The ADB supports several orchestrators (OpenShift, Kubernetes,
  Mesos, and plain Docker). The ADB is language independent and supports
  multiple developer models (IDE, CLI, SSH containment).
* **Production-Grade**: The components of the ADB are configured to behave
  just as they will in production. Containers promise seamless delivery,
  but only if you test them in the right environment. This is that
  environment.
* **Self-Contained**: The ADB is ready to go once installed. It comes
  prepackaged with the most common components ready, in case they
  are needed.
* **Open Source**: The ADB leverages existing tools and technologies wherever possible to avoid pushing a developer into an environment that won't be supportable in production or that is tied to a single vendor.
  This also means it benefits from the stability of existing projects
  instead of reinventing the wheel.

The ADB is a virtual machine that is executed with Vagrant and some Vagrant plugins.

When would the ADB typically be used?
===============================================================

A developer begins using the ADB, in most cases, once they have a
working application that has been decomposed into micro-services.
They then follow this general outline of steps:

1. Consider ways to divide your application into its component services or micro-services. For standard pieces, such as web servers, consider using pre-built containers from trusted sources. For truly unique pieces, build a custom container.
2. Confirm the application works in the ADB by manually launching the
   application's container components or by using the instance of
   OpenShift in the container to launch the application.
3. Build a Nulecule description of the application or complete the
   OpenShift application configuration.
4. Test the application.

The `Container Best Practices`_ document in this project may also be of interest.

.. _Container Best Practices: http://docs.projectatomic.io/container-best-practices/

What is the Typical Usage Pattern?
==================================

The ADB supports three basic modes of usage.  The modes vary by how much
they rely on tools on the developer's workstation.  From most to least
reliant, they are:

* Host-based IDE Mode

  This mode uses the ADB as a server resource for host-based IDE tools.
  In this mode, the user will run ``eclipse`` or other IDE tools that will
  access the resources of the ADB.

* Host-based CLI Mode

  This mode uses the ADB as a server resource for host-based CLI tools.
  In this mode, the user will run ``docker`` and other CLI tools on their
  workstation and the result will be containers executed inside of
  the ADB.

* SSH Mode

  This mode uses the ADB as a Linux virtual machine.  The user will
  use the ``ssh`` command to log into the ADB and will directly execute
  ``docker`` and other commands from the command line.  This is similar
  to having installed a Linux virtual machine and then installing and
  configuring all of the software the ADB ships with.

More information about `using the ADB`_ is available.

.. _using the ADB: docs/using.rst

What does it Utilize?
=====================

The ADB is built on top of `CentOS 7`_ and contains the following:

* `Docker`_: container runtime and packaging
* `Atomic CLI`_: container usage assistance
* `Kubernetes`_: container orchestration
* `OpenShift Origin`_: a next generation PaaS for docker containers.
* `openshift2nulecule`_: a tool that creates a Nulecule application from an existing OpenShift project.

The ADB supports `Atomic App`_, an implementation of the multi-container
application specification `nulecule`_, for multi-container applications.

You need to use the customized Vagrantfiles provided in the ADB project to set up the above mentioned environments. For further details refer to the Installation steps in the next section.

.. _CentOS 7: https://www.centos.org/
.. _Docker: https://www.docker.com/
.. _Atomic CLI: https://github.com/projectatomic/atomic/
.. _Kubernetes: http://kubernetes.io/
.. _OpenShift Origin: http://www.openshift.org/
.. _Atomic App: https://github.com/projectatomic/atomicapp/
.. _nulecule: https://github.com/projectatomic/nulecule/
.. _openshift2nulecule: https://github.com/projectatomic/openshift2nulecule/

How do I Install and Run the ADB?
===========================================================

Below is a quick installation guide using the most common options.
Detailed `installation instructions`_ are available.

1. `Install VirtualBox`_ for your operating system.

2. `Install Vagrant`_ for your operating system.

3. Install the `vagrant-service-manager`_ Vagrant plugin:

   ``vagrant plugin install vagrant-service-manager``

4. Download the customized Vagrantfiles provided by the ADB project. These Vagrantfiles will download the ADB and automatically set up provider specific container development environments. They are listed below and more details are available in the `Using Custom Vagrantfiles for Specific Use Cases`_ section of the `Using the Atomic Developer Bundle`_ document and the `Installation document`_.

   To download the ADB and set up provider specific container development environment:

   1. Create a directory for the Vagrant box

      ``$ mkdir directory && cd directory``
   
   2. Download any of the following vagrantfiles, based on your requirements, to download the ADB and use it with host-based tools or via ``vagrant ssh``.
 
      * For `Docker Vagrantfile`_ use::

        $ curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-docker-base-setup/Vagrantfile > Vagrantfile
        
      * For `Kubernetes Vagrantfile`_ use::

        $ curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-k8s-singlenode-setup/Vagrantfile > Vagrantfile

      * For `OpenShift Origin Vagrantfile`_ use::

        $ curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-openshift-setup/Vagrantfile > Vagrantfile

      * For `Apache Mesos Marathon Vagrantfile`_ use::

        $ curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-mesos-marathon-singlenode-setup/Vagrantfile > Vagrantfile

.. _Using Custom Vagrantfiles for Specific Use Cases: https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/docs/using.rst#using-custom-vagrantfiles-for-specific-use-cases
.. _Using the Atomic Developer Bundle: using.rst
.. _Installation document: https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/docs/installing.rst
.. _Docker Vagrantfile: https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/components/centos/centos-docker-base-setup/Vagrantfile
.. _Kubernetes Vagrantfile: https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/components/centos/centos-k8s-singlenode-setup/Vagrantfile
.. _OpenShift Origin Vagrantfile: https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/components/centos/centos-openshift-setup/Vagrantfile
.. _Apache Mesos Marathon Vagrantfile: https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/components/centos/centos-mesos-marathon-singlenode-setup/Vagrantfile

5. Start the ADB

   ``vagrant up``

This will download the ADB and set it up to work with the provider of choice for use with host-based tools or via ``vagrant ssh``.
You may wish to review the `Using the Atomic Developer Bundle`_ documentation before starting the ADB, especially if you are using host-based tools.

.. _installation instructions: docs/installing.rst
.. _Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
.. _Install Vagrant: https://docs.vagrantup.com/v2/installation/index.html
.. _vagrant-service-manager: https://github.com/projectatomic/vagrant-service-manager
.. _Using the Atomic Developer Bundle: using.rst

What is full feature set?
=========================

Today the box provides the following:

* Docker support to unsupported platforms (i.e. Microsoft
  Windows, Mac OS X, etc.)
* Kubernetes orchestration for local testing of applications
* Application definition using the Nulecule specification

Additional goals, objectives and work in progress can be found in the `architecture and roadmap`_ document and on the Project Atomic `trello board`_.

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

  * `Using Cockpit with the ADB`_

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

We welcome new ideas, suggestions, issues and pull requests. Want to be more involved, join us:

* Mailing List: `container-tools@redhat.com`_
* IRC: #atomic and #nulecule on `freenode`_
* Weekly Standup/Review/Planning Meeting: Every Monday at 1300 UTC in #nulecule (`freenode`_) for 0.5 hour. An agenda for this meeting is maintained at https://titanpad.com/adbmeeting

Documentation is written using `reStructuredText`_. An `online
reStructuredText editor`_ is available.

On the web:
==========

* Using OpenShift in the ADB : http://www.projectatomic.io/blog/2016/05/App-Development-on-OpenShift-using-ADB
* Using Kubernetes in the ADB: http://www.projectatomic.io/blog/2016/04/k8s-adb-usage/
* Introduction to the ADB from DevConf.cz 2016: https://www.youtube.com/watch?v=jxFw6qnGaRk
* OpenShift in the ADB Quickstart (video): https://www.youtube.com/watch?v=H58prwM3IbE

.. _container-tools@redhat.com: https://www.redhat.com/mailman/listinfo/container-tools
.. _freenode: https://freenode.net/
.. _Video Conference: https://bluejeans.com/381583203
.. _phone access number: https://www.intercallonline.com/listNumbersByCode.action?confCode=8464006194
.. _reStructuredText: http://docutils.sourceforge.net/docs/user/rst/quickref.html
.. _online reStructuredText editor: http://rst.ninjs.org
