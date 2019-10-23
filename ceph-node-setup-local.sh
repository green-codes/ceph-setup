
# install NTP
sudo apt-get update
sudo apt-get install ntp

# firewall
sudo ufw allow 6789/tcp
sudo ufw allow 6800:7300/tcp
