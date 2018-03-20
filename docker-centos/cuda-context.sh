export PATH=/host/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/host/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

mkdir -p /etc/nvidia-container-runtime
mv -f /usr/bin/config.toml /etc/nvidia-container-runtime/config.toml
