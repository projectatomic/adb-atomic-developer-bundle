====================================
Architecture and Roadmap for the ADB
====================================

The Atomic Developer Bundle is a constantly evolving platform.  As such, this document should be considered carefully relative to both what is shipping, what issues and pull requests are open, and the date of last revision.  This document begins with the architecture for what will become version 2.0 of the ADB.  The roadmap that follows is quite speculative.

The ADB is a stable CentOS Core installation with docker container and orchestration capability.  Many of the tools and features are provided by containers drawn from other sources.

The ADB is not built on CentOS Atomic Host because there is a need for a fully writeable system to support the use case where the developer uses ``ssh`` to access the box and does all work on the inside.

-----------------
Version 2.0 Goals
-----------------

* Enabling host-based development tools such as Eclipse to access the build environments inside the ADB
* Platform as a Service (PAAS) local testing and remote integration for OpenShift.
* Enabling a workflow for define once, run anywhere that allows configuration for Openshift to be reused for Kubernetes
* The Nulecule DevAssistant to make defining applications easier by providing a scaffold
* Application definition enablement using the Atomic App Nulecule reference implementation
* atomicapp-builder to drive atomicapp builds within the ADB

*Deliverables:* Vagrant boxes for libvirt and VirtualBox

These boxes contains the following components from the latest CentOS Core:
  * CentOS7 minimal install

    * @development
    * deltarpm
    * rsync
    * git
    * kubernetes
    * etcd
    * flannel
    * bash-completion
    * man-pages
    * nfs-utils
    * PyYAML
    * libyaml-devel
  * atomic - The `Atomic CLI <https://github.com/projectatomic/atomic>`_
  * docker-registry
  * docker - The docker daemon is configured to expose a TLS protected TCP port so that vagrant host based tools can access it
  * kubernetes
  * File Synchronization

    * Possibly via NFS for libvirt
    * Possibly via containerized extensions for VirtualBox
    * Designed to make sure code can move from the vagrant host to the ADB easily

Containers providing the following functionality:
  * OpenShift - A PAAS environment for source-to-image container execution in a devops pattern
  * `Atomic App <https://github.com/projectatomic/atomicapp>`_ - The `Nulecule <https://github.com/projectatomic/nulecule>`_ container application specification reference implementation
  * `atomic-reactor <https://github.com/projectatomic/atomic-reactor>`_ - a python based container builder
  * `DevAssistant <http://www.devassistant.org/>`_ - used to provide templates for `Dockerfiles <https://github.com/devassistant/dap-docker>`_ and `Nulecule Specification Files <https://github.com/devassistant/dap-nulecule>`_ - possibly using this container: https://github.com/devassistant/da-docker-nulecule - see `Issue #39 <https://github.com/projectatomic/adb-atomic-developer-bundle/issues/39>`_

Additional Containers pre-loaded for quicker access:
  * Latest Centos Base Image - see `Issue #25 <https://github.com/projectatomic/adb-atomic-developer-bundle/issues/25>`_

----------------------
Post Version 2.0 Ideas
----------------------

Beyond here be dragons and ideas which are not committed too.

* Access to the `CentOS Container Community Pipeline <https://wiki.centos.org/ContainerPipeline>`_ for easy testing
* The ability to do multi-node testing using multiple ADB VMs
* A build system inside the ADB to build/rebuild as needed based on code changes (Jenkins, etc.)
* Support for additional hypervisors
* Delivery to AWS and GCE to ease developer access in some use cases
