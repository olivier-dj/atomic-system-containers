FROM centos

LABEL maintainer="Giuseppe Scrivano <gscrivan@redhat.com>" \
      name="docker-centos" \
      version="0.1" \
      atomic.type="system" \
      architecture="x86_64"

RUN yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2 \
    xfsprogs \
    && yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo \
    && yum-config-manager \
    --add-repo \ 
    https://nvidia.github.io/nvidia-docker/centos7/x86_64/nvidia-docker.repo \
    && wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-17.03.2.ce-1.el7.centos.x86_64.rpm \
    && wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch.rpm \
    && yum install -y docker-ce-17.03.2.ce-1.el7.centos.x86_64.rpm docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch.rpm \
    && rm *.rpm \
    && yum install -y nvidia-docker2-2.0.3-1.docker17.03.2.ce.noarch nvidia-container-runtime-2.0.0-1.docker17.03.2.x86_64\
    && rm /etc/docker/daemon.json \
    && mkdir -p /exports/hostfs/etc/docker \
    && yum clean all


ADD init.sh /usr/bin

# system container
COPY service.template tmpfiles.template config.json.template /exports/
# Copy /etc/oci-umount.conf over if it exists
RUN (test -e /etc/oci-umount.conf && cp /etc/oci-umount.conf /exports/hostfs/etc) || true

CMD ["/usr/bin/init.sh"]
