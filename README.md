# About

This Vagrantfile provisions a basebox with a Weblogic 12c installation.
The following is installed:
- Java JDK8
- Weblogic 12c AdminServer
- A domain with name 'mydomain'
- Standalone managed servers 'server1' and 'server2'
- Upstart scripts for nodemanager, adminserver, server1, server2
- Apache Maven
- Apache Maven Weblogic plugin

# Vagrant basebox

The Vagrantfile assumes a minimal basebox with name 'centos-6.7-x86_64'.
Add this box to vagrant, or change to another RHEL compatible box.

# Weblogic Maven plugin

To test the weblogic-maven plugin as user oracle:

    mvn help:describe -DgroupId=com.oracle.weblogic -DartifactId=weblogic-maven-plugin -Dversion=12.2.1-2-0

Configure Maven to install artifacts to a repository manager, or simply
copy the contents of the .m2 directory to your own local repository. 

# External dependencies

Download and add the following binaries:

- jdk/jdk-8u121-linux-x64.rpm
- maven/apache-maven-3.3.9-bin.tar.gz
- weblogic/fmw_12.2.1.2.0_wls_quick.jar

# References

- https://docs.oracle.com/middleware/1221/wls/WLPRG/maven.htm#WLPRG585
