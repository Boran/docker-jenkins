#!/bin/bash
#
#  based on torkale/jenkins and niaquinto/jenkins
#set -e

echo "---------- /start.sh image=boran/jenkins REFRESHED_AT=$REFRESHED_AT -----------"

PLUGINS_ENDPOINT=http://updates.jenkins-ci.org/latest/
DATA=/var/lib/jenkins
wget="wget --no-check-certificate --no-verbose"

mkdir -p $DATA/plugins 2>/dev/null

# Here is where we download the plugins if not already done so
if find $DATA/plugins -maxdepth 0 -empty | read v; then
  echo "Download plugins to $DATA/plugins"
  cd $DATA/plugins
    $wget $PLUGINS_ENDPOINT/hipchat.hpi
    $wget $PLUGINS_ENDPOINT/greenballs.hpi
    $wget $PLUGINS_ENDPOINT/credentials.hpi
    $wget $PLUGINS_ENDPOINT/ssh-credentials.hpi
    $wget $PLUGINS_ENDPOINT/ssh-agent.hpi
    $wget $PLUGINS_ENDPOINT/git-client.hpi
    $wget $PLUGINS_ENDPOINT/git.hpi
    $wget $PLUGINS_ENDPOINT/github.hpi
    $wget $PLUGINS_ENDPOINT/github-api.hpi
    $wget $PLUGINS_ENDPOINT/ghprb.hpi
    $wget $PLUGINS_ENDPOINT/github-oauth.hpi
    $wget $PLUGINS_ENDPOINT/scm-api.hpi
    $wget $PLUGINS_ENDPOINT/postbuild-task.hpi
    $wget $PLUGINS_ENDPOINT/bitbucket.hpi
    $wget $PLUGINS_ENDPOINT/gradle.hpi
fi

# Set correct permissions
chown -R jenkins $DATA

echo "---------- /start.sh : run jenkins"
# Finally, run jenkins and stay in the foregound:
exec su jenkins -c "java -jar /usr/share/jenkins/jenkins.war"

