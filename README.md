#Atomic Developer Bundle

Short form Adb

##Purpose

To provide ready to use  development environment for [Atomic App](https://github.com/projectatomic/atomicapp) and [Nulecule](https://github.com/projectatomic/atomicapp).

`Here is more about the obective and purpose of creating the Vagrant based development environment:`

* The vagrant box should have all the tools and library required for developing [Nulecule](https://github.com/projectatomic/atomicapp) based Atomic Apps.
    * E.g. We have plan to add tools like [atomicapp-builder](https://github.com/bkabrda/atomicapp-builder) and [Nulecule DevAssistant](https://github.com/devassistant/dap-nulecule).
* This box will be complimentary to [CentOS Community Container Pipeline](http://wiki.centos.org/ContainerPipeline).
    * That would help developers test the Atomic App locally on the vagrant box/boxes before sending the pull request to the [CentOS Community Container Pipeline index](https://github.com/kbsingh/cccp-index)
* The base Vagrant box will contain the Atomic App providers e.g.  [OpenShift](https://github.com/openshift).
    * We are working on integrating OpenShift Vagrant box for developers with this.
    * The idea is , developers should be able to use OpenShift for deploying the application and then reuse the config files for developing Nulecule Specification for an application.
    * Or an atomic application based on the nulecule specification with OpenShift provider should be able to deploy on it. 
* The idea is to create base boxes using distributions build system and then use solution like [Oh-my-vagrant](https://github.com/purpleidea/oh-my-vagrant) for multibox dev environment.
    * As of now we are building the base boxes through [CBS](http://cbs.centos.org/koji/).

*Note:*
*Project Atomic already provides Vgarant boxes for CentOS and Fedora, but we can not reuse those as we need an environment which can be modified by the developers.*

##Documentation

* [Building the Vagrant box](docs/build.rst)
* [Quickstart to the Atomic App vagrant box](docs/quickstart.rst)
* [Running atomicapp](docs/runningatomicapp.rst)
* [Whats inside the Vagrant box](docs/whatsinside.rst)

##How to contribute?

* You are welcome to raise issues, send pull requests.

###Contribute to documentation

* Documentations are in [reStructuredText](http://docutils.sourceforge.net/rst.html) as it integrates well with [readthedocs](https://readthedocs.org) project.
* Here is an [online reStructuredText editor](http://rst.ninjs.org) for reference.

##Communication channels

* IRC: #nulecule (On Freenode)
* Mailing List: [container-tools@redhat.com](https://www.redhat.com/mailman/listinfo/container-tools)
