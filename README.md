#Atomic Developer Bundle (ADB)

##Purpose and Goal

To provide a ready to use development environment for developers creating container-based applications.  This environment will support a developer in packaging their application service components into containers and defining the entire application for ease of installation and testing.  While the environment can be used from the beginning of the development process, it is expected that most users will have their core code working prior to starting the containerization process.  You may find reading the original project [motivation](docs/motivation.md) useful.

Ultimately, the project expects to deliver a virtual machine that supports:

* **Providing docker support to unsupported platforms (i.e. Microsoft Windows, Mac OS X, etc.)**
* Enabling host-based development tools such as Eclipse to access the build environments inside the ADB
* **Kubernetes orchestration for local testing of applications**
* Platform as a Service (PAAS) local testing and remote integration for [OpenShift](https://github.com/openshift).
* Enabling a workflow for define once, run anywhere that allows configuration for Openshift to be resused for Kubernetes
* **Application definition using the [Nulecule](https://github.com/projectatomic/nulecule) specification**
* The [Nulecule DevAssistant](https://github.com/devassistant/dap-nulecule) to make defining applications easier by providing a scaffold
* Application definition enablement using the [Atomic App](https://github.com/projectatomic/atomicapp) Nulecule reference implementation
* [atomicapp-builder](https://github.com/bkabrda/atomicapp-builder) to drive atomicapp builds within the ADB
* This ability to push applications into the [CentOS Community Container Pipeline](http://wiki.centos.org/ContainerPipeline) via a pull request to the [CentOS Community Container Pipeline index](https://github.com/kbsingh/cccp-index)
* Supporting multi-node local testing and building using solutions like [Oh-my-vagrant](https://github.com/purpleidea/oh-my-vagrant)

**Note: The most recent release is Beta 2.  Bolded items above have been started or are working in this beta.**

Boxes are built using the CentOS powered [Community Build System](http://cbs.centos.org/koji/).  Boxes are delivered via Hashicorp's [Atlas](https://atlas.hashicorp.com/atomicapp/boxes/dev).  While Project Atomic already provides vagrant boxes for CentOS and Fedora, we can not reuse these as we have specific build requirements not enabled by default.

##Documentation

* [Architecture and Roadmap](docs/architecture.rst)
* [Building the Vagrant box](docs/build.rst)
* [Quickstart to the Atomic App vagrant box](docs/quickstart.rst)
* [Running atomicapp](docs/runningatomicapp.rst)
* [Update the box](docs/updating-thebox.rst)

##How to contribute?

* You are welcome to raise issues, send pull requests.

###Contribute to documentation

* Documentations is in [reStructuredText](http://docutils.sourceforge.net/rst.html) as it integrates well with [readthedocs](https://readthedocs.org) project.
* Here is an [online reStructuredText editor](http://rst.ninjs.org) for reference.

##Communication channels

* IRC: #nulecule (On Freenode)
* Mailing List: [container-tools@redhat.com](https://www.redhat.com/mailman/listinfo/container-tools)
