#Approach
The project has chosen Vagrant as a semi-universal way of describing development environments and, in related projects, made sure that Vagrant works well on the three target platforms. 

In order to support this endeavor, the OS communities have started to make official "Vagrant boxes" available for both the main-line OS and the Atomic variants that are pre-configured to support container development.  

 - Fedora: http://fedoraproject.org/wiki/Changes/Vagrant_Box_Atomic
 - CentOS: TBD
 - RHEL: TBD

The project has provided [Vagrantfiles](http://docs.vagrantup.com/v2/vagrantfile/index.html) to setup both regular instances of the OSs as well as a "docker host" leveraging the [Vagrant Docker Provider](http://docs.vagrantup.com/v2/docker/index.html).

The project has also been working with Aaron's https://github.com/aweiteka/UATFramework which is an "implementation" of [Behave](http://pythonhosted.org/behave/) framework which can work across machines to provides tests. However, that work hasn't been integrated here yet and, currently, the only tests are some shell scripts. 

#How to Use
Describing how to use these components is both very easy and very difficult. Hopefully, this makes sense.

##Basics
 1. Install Vagrant: You should be able to get it from the repos for your Linux distro or from [vagrantup.com](http://www.vagrantup.com). In the case of CentOS as your host OS, a software collection is being worked on which will, likely, reside at [scl.o](https://www.softwarecollections.org/en/) (please watch for updates).
 2. Install libvirt/KVM or VirtualBox: Currently, we are actively expecting users to use one of those two virtualization providers. However, VMWare may work as well with some finagling.
 3. Clone the repo: git clone git@github.com:projectatomic/adb-atomic-developer-bundle.git
 4. Use the Vagrantfiles as a basis for your own projects.

##Additional Features
If you are planning to use RHEL or RHEL-Atomic as your host, you may be interested in the automatic registration features of the vagrant plugin "[vagrant-registration](https://github.com/projectatomic/adb-vagrant-registration)."

If you would like to use any of the atomic variants (e.g. fedora-atomic, centos-atomic, or rhel-atomic), you should install the [vagrant-atomic](https://github.com/projectatomic/vagrant-atomic) plugin which will "inform" vagrant of the special [VM Guest Type](http://docs.vagrantup.com/v2/plugins/guests.html) of atomic, which needs to be treated slightly differently from a normal Fedora/CentOS/RHEL

#Motivation
Many people are considering using containers as a method of distributing applications. If you search the internet there is a lot of content similar to developing "hello world" but not much with regards to "enterprise container development." How is this different? Well, when developing with containers, much of the rules about application architecture, while not "different," are certainly more strictly enforced. For example, "decomposition of applications in to services." In a traditional application environment, on a virtual machine, for example, nothing really enforces that the services are actually independent until, during scale-out, you find out the hard way (unless you did really good testing). With containers, you find out immediately because the service isolation is enforced at any scale. 

With this project, we are hoping to gather recommendations, architectural justifications, approaches, etc. that support development with containers after you have graduated from toying with containers and are truly looking to deliver enterprise-class applications.

The project also provides tools to simplify re-architecting applications to leverage containers and the development of new applications based on containers. 

The project specifically focuses on providing tools and documentation based on Fedora, RHEL, and CentOS, but much of the content should be equally applicable to other enterprise operating systems.

##Additional Resources
[Dockerfile Lint](https://github.com/redhataccess/dockerfile_lint):  The objective here is to design a set of recommended choices, implemented as rules, that can be run against a Dockerfile to show that it has "good quality.."

[Atomic Run Tool](https://github.com/projectatomic/atomic): A tool to allow docker images to carry both installation and runtime information directly with the image. 

#Next
Let us know what else you think would be helpful.
