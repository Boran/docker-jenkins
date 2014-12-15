#!/bin/bash
#  based on torkale/jenkins and niaquinto/jenkins
set -e

PLUGINS_ENDPOINT=http://updates.jenkins-ci.org/latest/
DATA=/var/lib/jenkins

# Only need this the first time
mkdir -p $DATA/plugins

# Here is where we download the plugins if not already done so
if find $DATA/plugins -maxdepth 0 -empty | read v; then
#    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/hipchat.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/greenballs.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/credentials.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ssh-credentials.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ssh-agent.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/git-client.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/git.hpi)
#    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/github.hpi)
#    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/github-api.hpi)
#    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/ghprb.hpi)
#    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/github-oauth.hpi)
#    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/scm-api.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/postbuild-task.hpi)
    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/bitbucket.hpi)
#    (cd $DATA/plugins && wget --no-check-certificate $PLUGINS_ENDPOINT/gradle.hpi)
fi

# Set correct permissions
chown -R jenkins $DATA

# Finally, run jenkins and stay in the foregound:
exec su jenkins -c "java -jar /usr/share/jenkins/jenkins.war"

