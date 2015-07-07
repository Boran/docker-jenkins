boran-docker-jenkins
====================

Jenkins container based on Ubuntu 14.04

 * Pull the latest version of jenkins from pkg.jenkins-ci.org
 * Expose /var/lib/jenkins and /var/log/jenkins as volumes
 * set JENKINS_HOME /var/lib/jenkins
 * allow a bash command line access
 
 See also containers such as [https://github.com/Boran/docker-cibuild] and  [https://github.com/Boran/drupal-ci] designed to be controlled from jenkins.

TODO
- Install some standard plugins
- Enable some standard plugins
- Document: creating the .ssh trust in /home/builder. Add build/test automation into /home/builder, calling that from jenkins.
- Could ldap configuration be automated?

Creating:
docker build -t . boran/jenkins
