FROM centos

LABEL maintainer.creator="Olivier De Jonckère <olivier.dejonckere@cloudandheat.com>" \
      name="docker-centos" \
      version="0.1" \
      atomic.type="system" \
      architecture="x86_64"

ARG NVIDIA_VERSION=390.59

RUN yum install -y yum-utils wget \
    device-mapper-persistent-data \
    lvm2 \
    perl-Getopt-Long \
    xfsprogs \
    && wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-17.03.2.ce-1.el7.centos.x86_64.rpm \
    && wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch.rpm \
    && yum install -y docker-ce-17.03.2.ce-1.el7.centos.x86_64.rpm docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch.rpm \
    && rm *.rpm \
    && yum-config-manager \
    --add-repo \
    https://nvidia.github.io/nvidia-docker/centos7/x86_64/nvidia-docker.repo \
    && yum install -y nvidia-docker2-2.0.3-1.docker17.03.2.ce.noarch nvidia-container-runtime-2.0.0-1.docker17.03.2.x86_64 \
    && rm /etc/docker/daemon.json \
    && mkdir -p /exports/hostfs/etc/docker \
    && yum clean all

ADD init.sh /usr/bin
ADD nvidia-context.sh /usr/bin
ADD config.toml /usr/bin
ADD README.txt /usr/bin

ENV DRIVER_URL http://us.download.nvidia.com/XFree86/Linux-x86_64/${NVIDIA_VERSION}/NVIDIA-Linux-x86_64-${NVIDIA_VERSION}.run

# Just check if the version exists, do not allow dummy system container versions
RUN wget -S --spider ${DRIVER_URL}  2>&1 | grep 'HTTP/1.1 200 OK'

RUN sed -i -e "s|URL_TMP|${DRIVER_URL}|g" /usr/bin/nvidia-context.sh && \
    sed -i -e "s/VERSION/${NVIDIA_VERSION}/g" /usr/bin/README.txt


# system container
COPY service.template tmpfiles.template config.json.template /exports/

RUN ln -s /host/usr/lib64/libEGL_nvidia.so.0 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-cfg.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-fbc.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-ml.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libEGL_nvidia.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-compiler.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-fbc.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-ml.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libGLESv1_CM_nvidia.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-eglcore.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-glcore.so.${NVIDIA_VERSION}   /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-opencl.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libGLESv1_CM_nvidia.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-egl-wayland.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-glsi.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-opencl.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libGLESv2_nvidia.so.2 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-egl-wayland.so.1.0.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-gtk2.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-ptxjitcompiler.so /usr/lib64/ && \
    ln -s /host/usr/lib64/libGLESv2_nvidia.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-encode.so /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-gtk3.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-ptxjitcompiler.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libGLX_nvidia.so.0 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-encode.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-ifr.so /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-ptxjitcompiler.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libGLX_nvidia.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-encode.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-ifr.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-tls.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvcuvid.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvcuvid.so /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvcuvid.so.${NVIDIA_VERSION} /usr/lib64/ && \
    mkdir -p /usr/lib64/tls && \
    ln -s /host/usr/lib64/tls/libnvidia-tls.so.${NVIDIA_VERSION} /usr/lib64/tls/ && \
    ln -s /host/usr/lib64/libnvidia-cfg.so /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-fatbinaryloader.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-ifr.so.${NVIDIA_VERSION} /usr/lib64/ && \
    ln -s /host/usr/lib64/libvdpau_nvidia.so /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-cfg.so.1 /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-fbc.so /usr/lib64/ && \
    ln -s /host/usr/lib64/libnvidia-ml.so /usr/lib64/ && \
    ln -s /host/usr/lib64/libcuda.so /usr/lib64/libcuda.so && \
    ln -s /host/usr/lib64/libcuda.so.1 /usr/lib64/libcuda.so.1 && \
    ln -s /host/usr/lib64/libcuda.so.${NVIDIA_VERSION} /usr/lib64/

RUN ln -s /host/usr/lib/libEGL_nvidia.so.0 /usr/lib/ && \
    ln -s /host/usr/lib/libEGL_nvidia.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libGLESv1_CM_nvidia.so.1 /usr/lib/ && \
    ln -s /host/usr/lib/libGLESv1_CM_nvidia.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libGLESv2_nvidia.so.2 /usr/lib/ && \
    ln -s /host/usr/lib/libGLESv2_nvidia.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libGLX_nvidia.so.0 /usr/lib/ && \
    ln -s /host/usr/lib/libGLX_nvidia.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-compiler.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-eglcore.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-encode.so /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-encode.so.1 /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-encode.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-fatbinaryloader.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-fbc.so /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-fbc.so.1 /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-fbc.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-glcore.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-glsi.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-ifr.so /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-ifr.so.1 /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-ifr.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-ml.so /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-ml.so.1 /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-ml.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-opencl.so.1 /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-opencl.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-ptxjitcompiler.so /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-ptxjitcompiler.so.1 /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-ptxjitcompiler.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvidia-tls.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libvdpau_nvidia.so /usr/lib/ && \
    ln -s /host/usr/lib/libcuda.so /usr/lib/ && \
    ln -s /host/usr/lib/libcuda.so.1 /usr/lib/ && \
    ln -s /host/usr/lib/libcuda.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvcuvid.so /usr/lib/ && \
    ln -s /host/usr/lib/libnvcuvid.so.${NVIDIA_VERSION} /usr/lib/ && \
    ln -s /host/usr/lib/libnvcuvid.so.1 /usr/lib/

RUN ln -s /host/usr/bin/nvidia-smi /usr/bin/ && \
    ln -s /host/usr/bin/nvidia-debugdump /usr/bin/ && \
    ln -s /host/usr/bin/nvidia-persistenced /usr/bin/ && \
    ln -s /host/usr/bin/nvidia-cuda-mps-control /usr/bin/ && \
    ln -s /host/usr/bin/nvidia-cuda-mps-server /usr/bin/

# Copy /etc/oci-umount.conf over if it exists
RUN (test -e /etc/oci-umount.conf && cp /etc/oci-umount.conf /exports/hostfs/etc) || true

CMD ["/usr/bin/init.sh"]
