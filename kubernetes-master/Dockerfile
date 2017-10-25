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
RUN dnf install -y \
https://kojipkgs.fedoraproject.org//packages/kubernetes/1.8.1/1.fc28/x86_64/kubernetes-master-1.8.1-1.fc28.x86_64.rpm \
https://kojipkgs.fedoraproject.org//packages/kubernetes/1.8.1/1.fc28/x86_64/kubernetes-client-1.8.1-1.fc28.x86_64.rpm \
findutils && dnf clean all
