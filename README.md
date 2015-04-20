#CentOS Vagrant box with Docker runtime.
##Building the Vagrant box in CBS(CentOS build system)
* Get access for building images in CBS. Refer http://wiki.centos.org/HowTos/CommunityBuildSystem
* Checkout/git clone this repository
* Run the ```do_vagrant_cbs.sh```

```Here is the koji scratch build I did : http://cbs.centos.org/koji/taskinfo?taskID=10480```

##Running the Vagrant box
I used Fedora 21 and libvirt backend to run the vagrant box. 
##Setting up Vagrant on Fedora 21
To install Vagrant on Fedora 21

```yum/dnf install -y vagrant-libvirt vagrant```
##Running the Vagrant box on Fedora21 with Vagrant and libvirt
``` 
    mkdir centos-vagrant/
    cd centos-vagrant
    wget http://cbs.centos.org/kojifiles/work/tasks/480/10480/centos-7-container-scratch-1-1.x86_64.rhevm.ova
    vagrant box add centos7-docker centos-7-container-scratch-1-1.x86_64.rhevm.ova
    vagrant init centos7-docker
    vagrant up
    vagrant ssh
```
`vagrant ssh` should take you inside of the Vagrant box

###To destroy the Vagrant box
```vagrant destroy```
##Running docker inside the Vagrant box
Inside the vagrant box, you should be run docker containers
Example: (following commands should be run inside the Vagrant box)
```
docker pull centos
docker run -t -i centos /bin/bash
```
``Note``
I am in the process of uploading the image to https://atlas.hashicorp.com/
