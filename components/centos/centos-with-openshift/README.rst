Openshift Vagrantfile
=====================

Why Vagrantfile?
----------------

We want to provide a seamless experience for Openshift developer/User. This
vagrant file take care of running and provissing Openshift Origin in a VM with a simple
execution of *vagrant up*. 

Following steps are executed as part of provisioning:

- Create a private network and set IP *10.1.2.2*, if you want a different one
  then change **PUBLIC_ADDRESS** variable.
- Pull latest *openshift/origin* container from docker hub and tag it.
- Create required configuration file directories which OpenShift use and set
  SELinux flag to make sure it work with *Enforcing* mode.
- Run docker container using origin image with different run options to make
  sure required directory is mounted and *host* network is used. It takes around
  15 seconds to start.
- Check if contanter has started as expected otherwise provide docker logs.
- Make sure **oc and oadm** binaries are available to host system.
- Create docker registry to make sure when *oc build* run, it upload local images
  to this registry.
- Configure router so that new-app will access from web using those routes.
- Get default templates and configure it.
- Create *test-admin user and test project* for experiment.
- Provide required configuration details for OpenShift web console and API

For More info about Openshift, please refer to `offical documents
<https://docs.openshift.org/latest/welcome/index.html>`_.

Quick Start
-----------

- Get latest adb box and add it to vagrant

  ::
  
    $ vagrant box add adb <path_of_download_box>

- Create a separate Directory for OpenShift experiment

  ::

    $ mkdir openshift && cd openshift

- Make a copy of this Vagrantfile to this directory

  ::

    $ curl https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-with-openshift/Vagrantfile > Vagrantfile

- Create VM using OpenShift Vagrantfile

  ::
    
    $ vagrant up

- SSH to VM

  ::

    $ vagrant ssh

- Check OpenShift status using *oc*

  ::

    $ oc status

- Check available templates

  ::

    $ oc get templates -n openshift

- Deploy a application using available templates

  ::
    
    $ oc new-app nodejs-example

- Get route information of different deployed apps

  ::

    $ oc get routes
