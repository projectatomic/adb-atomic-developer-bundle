#Vagrant box for atomicapp

##Purpose

To provide ready to use  development environment for [Atomicapp](https://github.com/projectatomic/atomicapp) and [Nulecule](https://github.com/projectatomic/atomicapp).

`Here is more about the obective and purpose of creating the Vagrant based development environment:`

* The vagrant box should have all the tools and library required for developing [Nulecule](https://github.com/projectatomic/atomicapp) based atomicapps.
    * E.g. We have plan to add tools like [atomicapp-builder](https://github.com/bkabrda/atomicapp-builder) and [Nulecule DEV assistant](https://github.com/devassistant/dap-nulecule). Check [here for details](https://github.com/LalatenduMohanty/centos7-container-app-vagrant-box/labels/enhancement)
* This box will be complimentary to [CentOS CentOS Community Container Pipeline](http://wiki.centos.org/ContainerPipeline).
    * That would help developers test the Nulecule based atomicapp locally on the vagrant box/boxes before sending the pull request to the [CentOS Community Container Pipeline index](https://github.com/kbsingh/cccp-index)
* The base Vagrant box will contain the developr environments of the atomicapp providers as required e.g.  [OpenShift](https://github.com/openshift).
    * We are working on integrating OpenShift Vagrant box for developers with this.
* The idea is to create base boxes using distributions build system and then use solution like [Oh-my-vagrant](https://github.com/purpleidea/oh-my-vagrant) for multibox dev environment.
    * As of now we are building the base boxes through [CBS](http://cbs.centos.org/koji/).
* This project will inherit from [projectatomic/adb-atomic-developer-bundle](https://github.com/projectatomic/adb-atomic-developer-bundle/) and will consolidate the work already done.

*Note:*
*Project Atomic already provides Vgarant boxes for CentOS and Fedora, but we can not reuse those as we need an environment which can be modified by the developers.*

##Documentation

* [Building the Vagrant box](docs/build.rst)
* [Quickstart](docs/quickstart.rst)
* [Running atomicapp](docs/runningatomicapp.rst)
* [Whats inside the Vagrant box](docs/whatsinside.rst)

##How to contribute?

You are welcome to raise issues, send pull requests.

###Communication channels

* IRC: #nulecule (On Freenode)
* Mailing List: [container-tools@redhat.com](https://www.redhat.com/mailman/listinfo/container-tools)
