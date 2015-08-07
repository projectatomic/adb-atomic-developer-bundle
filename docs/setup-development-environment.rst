=========================================
Development environment for packaging apps using Atomicapp
=========================================

<work in progress>

This guide should serve as a "Getting started guide" for developers who wants to package applications with Nulecule and Atomicapp on the Vagrant box.

It would have information about what tools to use and where to get these tools. Also how to setup these. Because the Vagrant box might not have all the required tools by default.


--------------------
Automated method
--------------------
<TBD> May be using a Vagrantfile.

--------------------
Manual Method
--------------------

::

  #Install the EPEL repo, as atomicapp is available in EPEL
  $ curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

  $ sudo yum localinstall epel-release-latest-7.noarch.rpm 

  $ sudo yum install atomicapp --enablerepo=epel-testing

  TBD <rest of the steps will follow>
