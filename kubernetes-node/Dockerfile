FROM registry.fedoraproject.org/fedora:rawhide

ENV NAME=kubernetes-node VERSION=0 RELEASE=0 ARCH=x86_64
LABEL bzcomponent="$NAME" \
        name="$FGC/$NAME" \
        version="$VERSION" \
        release="$RELEASE.$DISTTAG" \
        architecture="$ARCH" \
        maintainer="Jason Brooks <jbrooks@redhat.com>"

RUN dnf -y --setopt=tsflags=nodocs update && dnf clean all
RUN dnf install -y --setopt=tsflags=nodocs \
https://kojipkgs.fedoraproject.org//work/tasks/720/23740720/kubernetes-node-1.9.0-1.fc28.x86_64.rpm \
https://kojipkgs.fedoraproject.org//work/tasks/720/23740720/kubernetes-client-1.9.0-1.fc28.x86_64.rpm \
findutils && dnf clean all
