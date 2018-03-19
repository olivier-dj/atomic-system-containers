export PATH=/host/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/host/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=/host/usr/local/cuda-9.0/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

mkdir -p /etc/nvidia-container-runtime
mv -f /usr/bin/config.toml /etc/nvidia-container-runtime/config.toml

ln -sf /host/usr/lib64/libcuda.so.1 /host/usr/local/cuda-9.0/lib64/libcuda.so.1
ln -sf /host/usr/lib64/libnvidia-fatbinaryloader.so.384.111 /host/usr/local/cuda-9.0/lib64/libnvidia-fatbinaryloader.so.384.111
ln -sf /host/usr/lib64/libnvidia-ml.so.1 /host/usr/local/cuda-9.0/lib64/libnvidia-ml.so.1