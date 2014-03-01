
# Based on http://docs.docker.io/en/latest/installation/ubuntulinux/#ubuntu-linux

# Optional AUFS filesystem support
sudo apt-get update -y
sudo apt-get install linux-image-extra-`uname -r` -y

# INSTALL DOCKER
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update -y
sudo apt-get install lxc-docker -y

# Hbase-related
sudo echo "ulimit -n 65535" >> /etc/default/docker
