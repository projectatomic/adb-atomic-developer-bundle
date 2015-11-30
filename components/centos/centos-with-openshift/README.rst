Openshift Vagrantfile
=====================

This vagrant file is use to set openshift environment to base adb vagrant box.
During setup below steps are executed.

- Create a private network and set IP *10.1.2.2*, if you want a different one
  then change **PUBLIC_ADDRESS** variable.
- Pull latest *openshift/origin* container from docker hub and tag it.
- Create required configuration file directories which openshift use and set
  SELinux flag to make sure it work with *Enforcing* mode.
- Run docker container using origin image with different run options to make
  sure required directory mounted and *host* network is used. Wait for around 15
  seconds to start it.
- Check if started as expected otherwise provide docker logs for origin.
- Make sure **oc and oadm** binaries are available to host system.
- Create docker registry to make sure when *oc build* run it upload local images
  to this registry.
- Configure router so that new-app will access from web using those routes.
- Get default templates and configure it.
- Create *test-admin user and test project* for experiment.
- Provide required configuration details for openshift web console and API
