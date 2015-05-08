#CentOS Vagrant box with container tools.
##Building the Vagrant box in CBS(CentOS build system)
* Get access for building images in CBS. Refer http://wiki.centos.org/HowTos/CommunityBuildSystem
* Checkout/git clone this repository
* Run the ```do_vagrant_cbs.sh```

```Here is the koji scratch build I did : http://cbs.centos.org/koji/taskinfo?taskID=13073```

##Running the Vagrant box
I used Fedora 21 and libvirt backend to run the vagrant box. 
##Setting up Vagrant on Fedora 21
To install Vagrant on Fedora 21
```yum/dnf install -y vagrant-libvirt vagrant```
##Running the Vagrant box on Fedora21 with Vagrant and libvirt

I have also uploaded the images in https://atlas.hashicorp.com/lalatendum/boxes/centos7-docker

`Step-1` : Initialising a new Vagrant environment by creating a Vagrantfile
``` 
    wget http://cbs.centos.org/kojifiles/work/tasks/3074/13074/centos-7-container-scratch-1-1.x86_64.rhevm.ova
    vagrant box add centos7-docker centos-7-container-scratch-1-1.x86_64.rhevm.ova
    vagrant init centos7-docker
```
Or
```
    vagrant init lalatendum/nulecule-dev
```
`Step-2` : To start the vagrant image and ssh in to it, please run following command
```
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

##What does this vagrant box contains?
* docker
* @development
* deltarpm
* rsync
* git
* kubernetes
* etcd
* flannel
* bash-completion
* man-pages
* atomic

##Future roadmap

`You are welcome to send pull requests too.`
