==================================================
Using the Cockpit with the Atomic Developer Bundle
==================================================

`Cockpit`_ makes it easy to administer your GNU/Linux servers via a
web browser.  It can manage system resources and has special functionality
built in for managing docker containers.  Specifically for containers,
it can:

* Display a list of images
* Display a list of containers (started and stopped)
* Start and stop containers
* Pull and delete images

.._Cockpit: http://cockpit-project.org/

----------------------------
Accessing Cockpit in the ADB
----------------------------

These instructions are written assuming you are at a command prompt on
the host you are running the ADB on.

1. Start the ADB

2. Log into the ADB

   ``$ vagrant ssh``

3. Start cockpit

   ``$ sudo systemctl start cockpit``

4. Log out of the ADB

   ``$ exit``

5. Determine the IP Address of the ADB

   ``$ vagrant service-manager box ip``

6. Open cockpit in your web browser using the IP address above:
  
   ``http://<IP Address>:9090/``
   
   You may need to accept a TLS certificate as cockpit generates a 
   self-signed SSL certificate.

7. You may now use cockpit on the ADB.  Two users are available by
   default. The username for a standard user is ``vagrant`` the password
   is ``vagrant``.  The root user has a password of ``vagrant``.
