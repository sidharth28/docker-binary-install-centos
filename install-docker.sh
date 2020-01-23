#!/usr/bin/env bash

curl -O https://download.docker.com/linux/static/stable/x86_64/docker-19.03.5.tgz
sudo mv docker-19.03.5.tgz ./binaries/docker-19.03.5.tgz
tar xvf ./binaries/docker-19.03.5.tgz
sudo rm -f ./binaries/docker-19.03.5.tgz

curl -O https://github.com/docker/compose/releases/download/1.25.1/docker-compose-$(uname -s)-$(uname -m) -kL
sudo mv docker-compose-$(uname -s)-$(uname -m) ./binaries/docker-compose-$(uname -s)-$(uname -m)

sudo cp binaries/* /usr/bin/ && sudo dockerd &
sudo chmod +x /usr/local/bin/docker-compose

echo "docker installation complete"
docker --version
docker-compose --version

echo "creating docker group"
sudo groupadd docker

echo "adding the current user to docker group"
sudo usermod -aG docker $USER

echo "reactivating docker group"
newgrp docker

echo "activating docker as service"
sudo systemctl enable docker

echo "completed"
