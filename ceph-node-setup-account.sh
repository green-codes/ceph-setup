
# add user and config access
if [[ ! `id -u ceph 2>/dev/null` ]]; then sudo useradd -d /home/ceph -s /bin/bash -m ceph; fi
sudo usermod --password $(echo ceph | openssl passwd -1 -stdin) ceph
sudo usermod -aG sudo ceph
echo 'ceph ALL = (root) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/ceph
sudo chmod 0440 /etc/sudoers.d/ceph
