# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = 'projectatomic/adb'

# The Docker registry from where we pull the OpenShift Docker image
DOCKER_REGISTRY="docker.io"

# The name of the OpenShift image available on dockerhub.
IMAGE_NAME="openshift/origin"
# Tag of the OpenShift image available on dockerhub.
IMAGE_TAG="v1.2.0"

# The top level domain for your VM and the created application routes
TLD = 'adb'

# The host name of the VM. Needs to have a different TLD due to Kubernetes issue
HOSTNAME = 'adb.vm'

# Host name for accessing OpenShift
OPENSHIFT_HOSTNAME = "openshift.#{TLD}"

REQUIRED_PLUGINS = %w(vagrant-service-manager vagrant-sshfs landrush)
errors = []

def message(name)
  "#{name} plugin is not installed, run `vagrant plugin install #{name}` to install it."
end
# Validate and collect error message if plugin is not installed
REQUIRED_PLUGINS.each { |plugin| errors << message(plugin) unless Vagrant.has_plugin?(plugin) }
unless errors.empty?
  msg = errors.size > 1 ? "Errors: \n* #{errors.join("\n* ")}" : "Error: #{errors.first}"
  fail Vagrant::Errors::VagrantError.new, msg
end

# The following steps are executed to provision OpenShift Origin:
# 1. Create a private network and set the Vagrant Box IP to *10.1.2.2*. If you want a different IP then change the **PUBLIC_ADDRESS** variable.
# 2. Pull latest the *openshift/origin* container from docker hub and tag it.
# 3. Provide required configuration details for OpenShift web console and API.
# For More info about Openshift, please refer to `offical documents
# <https://docs.openshift.org/latest/welcome/index.html>`_.

Vagrant.configure(2) do |config|
  # Use environment variable BOX or default 'projectatomic/adb'
  config.vm.box = (ENV.key?('BOX') ? (ENV['BOX'].empty? ? BOX_NAME : ENV['BOX']) : BOX_NAME)

  config.vm.hostname = HOSTNAME

  config.vm.provider "virtualbox" do |v, override|
    v.memory = 2048
    v.cpus   = 2
    v.customize ["modifyvm", :id, "--cpus", "2"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provider "libvirt" do |v, override|
    v.driver = "kvm"
    v.memory = 2048
    v.cpus   = 2
    v.suspend_mode = "managedsave"
  end

  config.vm.provider "openstack" do |os|
    # Specify OpenStack authentication information
    os.openstack_auth_url = ENV['OS_AUTH_URL']
    os.tenant_name = ENV['OS_TENANT_NAME']
    os.username = ENV['OS_USERNAME']
    os.password = ENV['OS_PASSWORD']

    # Specify instance information
    os.server_name = ENV['OS_INSTANCE']
    os.flavor = ENV['OS_FLAVOR']
    os.image = ENV['OS_IMAGE']
    os.floating_ip_pool = ENV['OS_FLOATING_IP_POOL']

    os.security_groups = ['default', ENV['OS_SECURITY_GROUP']]
    os.keypair_name = ENV['OS_KEYPAIR_NAME']
    config.ssh.private_key_path = ENV['OS_PRIVATE_KEYPATH']
    config.ssh.username = 'vagrant'
  end

  # Proxy Information from environment
  PROXY = (ENV['PROXY'] || '')
  PROXY_USER = (ENV['PROXY_USER'] || '')
  PROXY_PASSWORD = (ENV['PROXY_PASSWORD'] || '')

  # vagrant-sshfs
  config.vm.synced_folder '.', '/vagrant', disabled: true
  if Vagrant::Util::Platform.windows?
    target_path = ENV['USERPROFILE'].gsub(/\\/,'/').gsub(/[[:alpha:]]{1}:/){|s|'/' + s.downcase.sub(':', '')}
    config.vm.synced_folder ENV['USERPROFILE'], target_path, type: 'sshfs', sshfs_opts_append: '-o umask=000 -o uid=1000 -o gid=1000'
  else
    config.vm.synced_folder ENV['HOME'], ENV['HOME'], type: 'sshfs', sshfs_opts_append: '-o umask=000 -o uid=1000 -o gid=1000'
  end
  config.vm.provision "shell", inline: <<-SHELL
    sudo setsebool -P virt_sandbox_use_fusefs 1
  SHELL

  # landrush
  config.landrush.enabled = true
  config.landrush.tld = TLD
  config.landrush.host TLD, HOSTNAME
  config.landrush.guest_redirect_dns = false
  config.vm.provision :shell, inline: <<-SHELL
    sed -i.orig -e "s/^ip=.*/ip='#{OPENSHIFT_HOSTNAME}'/g" /opt/adb/openshift/openshift
    sed -i.orig -e "s/OPENSHIFT_SUBDOMAIN=.*/OPENSHIFT_SUBDOMAIN='#{TLD}'/g" /etc/sysconfig/openshift_option
  SHELL

  config.vm.provision "shell", run: "always", inline: <<-SHELL
    PROXY=#{PROXY} PROXY_USER=#{PROXY_USER} PROXY_PASSWORD=#{PROXY_PASSWORD} \
    DOCKER_REGISTRY=#{DOCKER_REGISTRY} IMAGE_TAG=#{IMAGE_TAG} IMAGE_NAME=#{IMAGE_NAME} /usr/bin/sccli openshift
  SHELL

  config.vm.provision "shell", run: "always", privileged: false, inline: <<-SHELL
    echo "You can now access OpenShift console on: https://#{OPENSHIFT_HOSTNAME}:8443/console"
    echo
    echo "Configured basic user: openshift-dev, Password: devel"
    echo
    echo "Configured cluster admin user: admin, Password: admin"
    echo
    echo "To download and install OC binary, run:"
    echo "vagrant service-manager install-cli openshift"
    echo
    echo "To use OpenShift CLI, run:"
    echo "$ oc login #{OPENSHIFT_HOSTNAME}:8443"
    echo
    echo "To browse the OpenShift API documentation, follow this link:"
    echo "http://openshift3swagger-claytondev.rhcloud.com"
    echo
    echo "Then enter this URL:"
    echo https://#{OPENSHIFT_HOSTNAME}:8443/swaggerapi/oapi/v1
    echo "."
  SHELL
end
