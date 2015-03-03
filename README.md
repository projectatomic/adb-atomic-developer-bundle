#How to Use
Describing how to use these components is both very easy and very difficult. Hopefully, this makes sense. For more details on the why and how of this project, see [Motivation](motivation.md)

##Basics
 1. Install Vagrant: You should be able to get it from the repos for your Linux distro or from [vagrantup.com](http://www.vagrantup.com). In the case of CentOS as your host OS, a software collection is being worked on which will, likely, reside at [scl.o](https://www.softwarecollections.org/en/) (please watch for updates).
 2. Install libvirt/KVM or VirtualBox: Currently, we are actively expecting users to use one of those two virtualization providers. However, VMWare may work as well with some finagling.
 3. Clone the repo: git clone git@github.com:projectatomic/adb-atomic-developer-bundle.git
 4. Use the Vagrantfiles as a basis for your own projects.

##Additional Features
If you are planning to use RHEL or RHEL-Atomic as your host, you may be interested in the automatic registration features of the vagrant plugin "[vagrant-registration](https://github.com/projectatomic/adb-vagrant-registration)."

If you would like to use any of the atomic variants (e.g. fedora-atomic, centos-atomic, or rhel-atomic), you should install the [vagrant-atomic](https://github.com/projectatomic/vagrant-atomic) plugin which will "inform" vagrant of the special [VM Guest Type](http://docs.vagrantup.com/v2/plugins/guests.html) of atomic, which needs to be treated slightly differently from a normal Fedora/CentOS/RHEL

##Additional Resources
[Dockerfile Lint](https://github.com/redhataccess/dockerfile_lint):  The objective here is to design a set of recommended choices, implemented as rules, that can be run against a Dockerfile to show that it has "good quality.."

[Atomic Run Tool](https://github.com/projectatomic/atomic): A tool to allow docker images to carry both installation and runtime information directly with the image. 

#Next
Let us know what else you think would be helpful.
