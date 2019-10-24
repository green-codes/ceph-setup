
# install NTP and python
sudo apt-get update
sudo apt-get install ntp python-minimal

# firewall
sudo ufw allow 6789/tcp
sudo ufw allow 6800:7300/tcp
