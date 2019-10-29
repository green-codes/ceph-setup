# config password-less access
USER=`whoami`
echo "$USER ALL = (root) NOPASSWD:ALL" | sudo tee "/etc/sudoers.d/$USER"
sudo chmod 0440 "/etc/sudoers.d/$USER"
