#CentOS Vagrant box with container tools.

This vagrant box is based on CentOS7. So it would have latest packages from CentOS7.

##Building the Vagrant box in CBS(CentOS build system)
* Get access for building images in CBS. Refer http://wiki.centos.org/HowTos/CommunityBuildSystem
* Checkout/git clone this repository
* Run the ```do_vagrant_cbs.sh```

```Here is the latest koji scratch build I did : http://cbs.centos.org/koji/taskinfo?taskID=13349```

##Running the Vagrant box
I used Fedora 21 and libvirt backend to run the vagrant box. 
##Setting up Vagrant on Fedora 21
To install Vagrant on Fedora 21
```yum/dnf install -y vagrant-libvirt vagrant```
##Running the Vagrant box on Fedora21 with Vagrant and libvirt

The image is available in https://atlas.hashicorp.com/atomicapp/boxes/dev

`Step-1` : Initialising a new Vagrant environment by creating a Vagrantfile
``` 
    wget http://cbs.centos.org/kojifiles/work/tasks/3350/13350/centos-7-container-scratch-1-1.x86_64.rhevm.ova
    vagrant box add centos7-docker centos-7-container-scratch-1-1.x86_64.rhevm.ova
    vagrant init centos7-docker
```
Or
```
    vagrant init atomicapp/dev
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

##Running atomic app inside the vagrant box
Login to the vagrant box using `vagrant ssh` command. 

Run ```kubectl get minions```

The outout should look like below
```
$kubectl get minions
NAME                LABELS              STATUS
127.0.0.1           <none>              Ready
```

Then follow the below link for running an example atomic application
Refer: https://registry.hub.docker.com/u/projectatomic/helloapache/

Atomicapp: https://github.com/projectatomic/atomicapp
Nulecule: https://github.com/projectatomic/nulecule
 
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
* docker-registry
* nfs-utils
* PyYAML
* libyaml-devel

##Future roadmap

`You are welcome to send pull requests too.`
