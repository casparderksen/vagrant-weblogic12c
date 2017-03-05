ABOUT

This Vagrantfile provisions a basebox with a Weblogic 12c installation.
The following is installed:
- Weblogic 12c AdminServer
- A domain with name 'mydomain'
- Standalone managed servers 'server1' and 'server2'
- Upstart scripts for nodemanager, adminserver, server1, server2

VAGRANT BASEBOX

The Vagrantfile assumes a minimal basebox with namne 'centos-6.7-x86_64'.
Add this box to vagrant, or change to another RHEL compatible box.

EXTERNAL DEPENDENCIES

Download and add the following binaries:

	jdk/jdk-8u121-linux-x64.rpm
	maven/apache-maven-3.3.9-bin.tar.gz
	weblogic/fmw_12.2.1.2.0_wls_quick.jar
