Vagrantfile to setup  OpenShift Enterprise
==========================================

This Vagrantfile sets up the CDK for development with OpenShift.
This file also sets up private networking that will be used to expose various
services to the host.  This Vagrantfile also provisions an instance of
`OpenShift Enterprise <https://www.openshift.com/enterprise/whats-new.html>`_.

If you are interested in the process used in the Vagranfile to setup OpenShift,
please read the comments at the top of the file.

QuickStart
----------

1. Get latest CDK box (Using Developer Subscription). You can download the
   CDK and find further information about CDK `here <http://developers.redhat.com/products/cdk/overview/>`_.

2. Create a directory for the Vagrant Box

   ``$ mkdir directory && cd directory``

3. Download this Vagrantfile in the same directory.

4. Start the Vagrant Box

   ``$ vagrant up``

5. Proceed with using the CDK.

   If you plan to use OpenShift from the host, you may wish to download ``oc``
   for your platform from an `OpenShift Enterprise Release <https://access.redhat.com/downloads/content/290>`_.

   You may wish to verify that OpenShift is setup using the ``oc`` CLI as follows:

   1. Login to OpenShift using *oc*

      ``$ oc login <ip>:<port>``

      Defaults:

      * The default configured users are (username/password):

        * openshift-dev/devel
        * admin/admin
      * The default IP is 10.1.2.2
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
