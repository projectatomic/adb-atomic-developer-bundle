#Motivation
Many people are considering using containers as a method of distributing applications. If you search the internet there is a lot of content similar to developing "hello world" but not much with regards to "enterprise container development." How is this different? Well, when developing with containers, many of the rules about application architecture, while not "different," are certainly more strictly enforced. For example, "decomposition of applications in to services." In a traditional application environment, on a virtual machine, for example, nothing really enforces that the services are actually independent until, during scale-out, you find out the hard way (unless you did really good testing). With containers, you find out immediately because the service isolation is enforced at any scale. 

With this project, we are hoping to gather recommendations, architectural justifications, approaches, etc. that support development with containers after you have graduated from playing with containers and are truly looking to deliver enterprise-class applications.

The project also provides tools to simplify re-architecting applications to leverage containers and the development of new applications based on containers. 

The project specifically focuses on providing tools and documentation based on Fedora, RHEL, and CentOS, but much of the content should be equally applicable to other enterprise operating systems.

#Approach
The project has chosen Vagrant as a semi-universal way of describing development environments and, in related projects, made sure that Vagrant works well on the three target platforms (Fedora, RHEL, and CentOS). 

In order to support this endeavor, the OS communities have started to make official "Vagrant boxes" available for both the main-line OS and the Atomic variants that are pre-configured to support container development.  

 - Fedora: http://fedoraproject.org/wiki/Changes/Vagrant_Box_Atomic
 - CentOS: TBD
 - RHEL: TBD

The project has provided [Vagrantfiles](http://docs.vagrantup.com/v2/vagrantfile/index.html) to setup both regular instances of the OSs as well as a "docker host" leveraging the [Vagrant Docker Provider](http://docs.vagrantup.com/v2/docker/index.html).

The project has also been working with Aaron's https://github.com/aweiteka/UATFramework which is an "implementation" of [Behave](http://pythonhosted.org/behave/) framework which can work across machines to provides tests. However, that work hasn't been integrated here yet and, currently, the only tests are some shell scripts. 

#Next
Let us know what else you think would be helpful.
