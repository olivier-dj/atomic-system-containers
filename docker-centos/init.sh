#!/bin/bash

# Ensure that new process maintain this SELinux label
PID=$$
LABEL=`tr -d '\000' < /proc/$PID/attr/current`
printf %s $LABEL > /proc/self/attr/exec

source /run/docker-bash-env

# set storage first
(
    . /etc/sysconfig/docker-storage
)


# Inhibit sd-notify for docker-containerd, we want to get the notification
# from the docker process
NOTIFY_SOCKET=/dev/null /usr/bin/docker-containerd \
    --listen unix:///run/containerd.sock \
    --shim /usr/bin/docker-containerd-shim-current \
    --start-timeout 2m &

while test \! -e /run/containerd.sock;
do
      sleep 0.1
done

sed -i 's#fd://#unix:///var/run/docker.sock#g' /etc/sysconfig/docker
. /etc/sysconfig/docker

exec /usr/bin/dockerd \
          $OPTIONS \
          $DOCKER_STORAGE_OPTIONS \
          $DOCKER_NETWORK_OPTIONS \
          $INSECURE_REGISTRY $ADD_REGISTRY \
          $BLOCK_REGISTRY
