# This code may be executed at each docker daemon start. It is not a
# problem as long as it give the user a way to regenerate the docs and
# install files

mkdir -p /etc/nvidia-container-runtime
mv -f /usr/bin/config.toml /etc/nvidia-container-runtime/config.toml

wget URL_TMP -N --directory-prefix=/host/home/fedora
cat /usr/bin/README.txt > /host/home/fedora/README.txt