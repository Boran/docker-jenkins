# docker container for jenkins
# Ubuntu 14.04 +jenkins + plugins
#
FROM             ubuntu:14.04
MAINTAINER       Sean Boran <sean_at_boran.com>
ENV REFRESHED_AT 2015-03-04

# Install Dependancies
ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get -qqy update && \
    apt-get -y install wget git curl git-core openjdk-7-jre-headless
# todo: dont need openssh-server ?

# Install Jenkins and clean up
RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list && \
    wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - && \
    apt-get update && \
    apt-get install -y jenkins && \
    apt-get clean -y 

# Need SSH agent, for automated remote work
RUN mkdir /var/run/sshd && \
    echo " ForwardAgent yes" >> /etc/ssh/ssh_config && \
    echo " IdentityFile /var/lib/jenkins/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
    echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# Expose data to containers
VOLUME /var/lib/jenkins
VOLUME /var/log/jenkins
ENV JENKINS_HOME /var/lib/jenkins

WORKDIR /var/lib/jenkins

ADD ./start.sh /start.sh
RUN chmod 755 /start.sh 
EXPOSE 8080
CMD ["/bin/bash", "/start.sh"]
