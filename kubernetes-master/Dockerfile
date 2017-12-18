FROM registry.fedoraproject.org/fedora:rawhide

ENV NAME=kubernetes-master VERSION=0 RELEASE=0 ARCH=x86_64
LABEL bzcomponent="$NAME" \
        name="$FGC/$NAME" \
        version="$VERSION" \
        release="$RELEASE.$DISTTAG" \
        architecture="$ARCH" \
        maintainer="Jason Brooks <jbrooks@redhat.com>"

RUN dnf -y --setopt=tsflags=nodocs update && dnf clean all
RUN groupadd -g 994 kube && useradd -u 996 -g 994 kube
RUN dnf install -y --setopt=tsflags=nodocs \
kubernetes-master-1.9.1-1.fc28 \
kubernetes-client-1.9.1-1.fc28 \
findutils && dnf clean all
