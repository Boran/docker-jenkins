boran-docker-jenkins
====================

Jenkins container based on Ubuntu 14.04

 * Pull the latest version of jenkins from pkg.jenkins-ci.org
 * Install some standard plugins
 * Expose /var/lib/jenkins and /var/log/jenkins as volumes
 * set JENKINS_HOME /var/lib/jenkins
 * allow a bash command line access


TODO, document stuff such as
- creating the .ssh trust in /home/builder
- add build/test automation into /home/builder, calling that from jenkins.

