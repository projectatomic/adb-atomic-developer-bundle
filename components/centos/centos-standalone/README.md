The Vagrantfile here assumes that you have a very minimal CentOS Vagrant box. As a result, when it launches it provisions it with a docker installation. However, it does not "support" the "docker provider" from Vagrant and expects you to more manually interact with docker on the VM. If you were expecting the Vagrant Docker Provider model, take a look in centos-with-docker.

