Vagrantfile: OpenShift setup in ADB Vagrant box
===============================================

This Vagrantfile:

* Sets up the ADB for development with OpenShift
* Sets up private networking that is used to expose various services to the host
* Provisions an instance of `OpenShift Origin <http://www.openshift.org//>`_

If you are interested in the process used in the Vagrantfile to setup OpenShift, please read the comments at the top of the file.

The Vagrantfile changes after ADB 1.6.0 are not backward compatible. So if you are using ADB prior to 1.7.0, you can find the old `Vagrantfile here <https://github.com/projectatomic/adb-atomic-developer-bundle/blob/v1.6.0/components/centos/centos-openshift-setup/Vagrantfile>`_.

QuickStart
----------

1. Get the latest ADB box and add it to vagrant as per the `Installing the Atomic Developer Bundle <https://github.com/projectatomic/adb-atomic-developer-bundle/blob/master/docs/installing.rst>`_ documentation.

2. Create a directory for the Vagrant Box

   ``$ mkdir directory && cd directory``

3. Download the Vagrantfile

   ``$ curl -sL https://raw.githubusercontent.com/projectatomic/adb-atomic-developer-bundle/master/components/centos/centos-openshift-setup/Vagrantfile > Vagrantfile``

   **Note:**

* The ADB OpenShift Vagrant Box IP defaults to ``10.1.2.2``. If you want a
  different IP then change the ``PUBLIC_ADDRESS`` variable in the Vagrantfile.
* If you want to use the latest OpenShift Origin image, then you need to change
  the ``IMAGE_TAG`` variable in the Vagrantfile, to ``latest``. Alternatively,
  you can specify the value based on the `OpenShift Origin version`_ you need,
  for the variable. For instance, ``IMAGE_TAG="v1.2.1"``

.. _OpenShift Origin version: https://hub.docker.com/r/openshift/origin/tags/

4. Start the Vagrant Box

   ``$ vagrant up``

5. Proceed with using the ADB as per `Using the Atomic Developer Bundle <../../../docs/using.rst>`_ documentation.

   If you plan to use OpenShift from the host, you may wish to download ``oc`` for your platform from an `OpenShift Origin Release <https://github.com/openshift/origin/releases>`_.

   You may wish to verify that OpenShift is setup using the ``oc`` CLI as follows:

   1. Check OpenShift status using ``oc``

      ``$ oc status``

   2. Check available templates

      ``$ oc get templates -n openshift``

   3. Deploy an application using available templates

      ``$ oc new-app nodejs-example``

   4. Get route information of different deployed apps

      ``$ oc get routes``
