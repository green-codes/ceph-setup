
# keys and apt sources
wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -
echo deb https://download.ceph.com/debian-nautilus/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list

# install ceph-deploy
sudo apt update
sudo apt install ceph-deploy

# firewall
sudo ufw allow 6789/tcp
sudo ufw allow 6800:7300/tcp

# ceph user
source ceph-node-setup-account.sh
