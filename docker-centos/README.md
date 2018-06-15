#### Upgrade the system
    sudo su
    rpm-ostree upgrade && \
    systemctl reboot
#### Blacklist nouveau
    sudo su
    echo "blacklist nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf && \
    echo "options nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf && \
    rpm-ostree initramfs --arg=rd.driver.blacklist=nouveau --enable && \
    systemctl reboot
#### Install Nvidia dependency (DKMS as well to make nvidia happy)
    sudo su
    rpm-ostree install pciutils wget dkms perl-Getopt-Long elfutils-libelf-devel mesa-libGLU-devel freeglut-devel libXi-devel libXmu-devel
#### Install the Kernel-devel
    curl -LO https://kojipkgs.fedoraproject.org//packages/kernel/4.16.11/300.fc28/x86_64/kernel-devel-4.16.11-300.fc28.x86_64.rpm && \
    rpm-ostree install kernel-devel-4.16.11-300.fc28.x86_64.rpm && \
    rm kernel-devel-4.16.11-300.fc28.x86_64.rpm && \
    systemctl reboot
    # Or directly with ostree if you feel lucky, kernel-devel-$(uname -r) doesn't work 
    rpm-ostree install kernel-devel
#### Verify kernel-devel compatibility
    ll /usr/lib/modules/$(uname -r)/build
#### Selinux  
    sudo su
    setenforce 0 && \
    sed -i -e 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config  
#### Install the system container, it download as well the nvidia driver (check /home/fedora)
    systemctl stop docker && systemctl disable docker && \
    atomic install --system --system-package no --storage ostree --name docker $REGISTRY/centos-docker-ce-nvidia:17.03-390.59 && \
    service docker restart && \
#### Install (savagely) the Nvidia driver
    ostree admin unlock --hotfix && \
    chmod u+x NVIDIA-Linux-x86_64-390.59.run && \
    ./NVIDIA-Linux-x86_64-390.59.run --dkms --no-drm -s
#### Verify operations
    nvidia-smi && \
    docker version && \
    docker run --rm nvidia/cuda nvidia-smi
