# docker container for jenkins
# Ubuntu 14.04 +jenkins + plugins
#
FROM             ubuntu:14.04
MAINTAINER       Sean Boran <sean_at_boran.com>
ENV REFRESHED_AT 2014-12-15

# Install Depends
ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get -qqy update && \
    apt-get -y install wget git curl git-core openjdk-7-jre-headless
# todo: dont need openssh-server ?

# Install Jenkins and Clean up
RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list && \
    wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - && \
    apt-get update && \
    apt-get install -y jenkins && \
    apt-get clean -y && \
    rm /bin/sh && ln -s /bin/bash /bin/sh

# Need SSH: todo, review security
RUN mkdir /var/run/sshd && \
    echo " ForwardAgent yes" >> /etc/ssh/ssh_config && \
    echo " IdentityFile /var/lib/jenkins/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
    echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# Expose volume and set jenkins-y things
VOLUME /var/lib/jenkins
ENV JENKINS_HOME /var/lib/jenkins

EXPOSE 8080

ADD ./start.sh /start.sh
RUN chmod 755 /start.sh 

CMD ["/bin/bash", "/start.sh"]


