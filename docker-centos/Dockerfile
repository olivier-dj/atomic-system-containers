FROM centos

LABEL maintainer="Giuseppe Scrivano <gscrivan@redhat.com>" \
      name="docker-centos" \
      version="0.1" \
      atomic.type="system" \
      architecture="x86_64"

RUN yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2 \
    && yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo \
    && yum install -y docker-ce-17.09.0.ce \
    && mkdir -p /exports/hostfs/etc/docker \
    && yum clean all

ADD init.sh /usr/bin

# system container
COPY service.template tmpfiles.template config.json.template /exports/
# Copy /etc/oci-umount.conf over if it exists
RUN (test -e /etc/oci-umount.conf && cp /etc/oci-umount.conf /exports/hostfs/etc) || true

CMD ["/usr/bin/init.sh"]
