Vagrantfile to setup  OpenShift Enterprise
==========================================

This Vagrantfile sets up the CDK for development with OpenShift. This Vagrantfile provisions an instance of `OpenShift Enterprise <https://www.openshift.com/enterprise/whats-new.html>`_.

**Note:** This Vagrantfile expects an external type virtual switch for HyperV. Please add a new external type virtual network switch to the HyperV set up if you do not have it.


QuickStart
----------

1. Get latest CDK box (Using Developer Subscription).

2. Create a directory for the Vagrant box

  ``$ mkdir directory && cd directory``

3. Download this Vagrantfile.

4. Start the Vagrant box

  ``$ vagrant up``
  
  **Note:** HyperV assigns a DHCP IP address to the CDK Vagrant box. The required IP and login information will be displayed at the end of the `vagrant up` process.

5. Proceed with using the CDK.

  If you plan to use OpenShift from the host, you may wish to download ``oc`` for your platform from an `OpenShift Enterprise Release <https://access.redhat.com/downloads/content/290>`_.

  You may wish to verify that OpenShift is set up using the ``oc`` CLI as follows:

  1. Login to OpenShift using *oc*

    ``$ oc login <ip>:<port>``

    Defaults:
      * The default configured users are (username/password):
          * openshift-dev/devel
          * admin/admin
      * Use the IP address from out put of `vagrant up`.
      * The default port is 8443.

  2. Create a `test` project to OpenShift using *oc* 

    ``$ oc new-project test``

  3. Check OpenShift status using *oc*

    ``$ oc status``

  4. Check available templates

    ``$ oc get templates -n openshift``

  5. Deploy an application using available templates

    ``$ oc new-app nodejs-example``

  6. Get route information of different deployed apps

    ``$ oc get routes``
