#!/usr/bin/env bash

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
sudo usermod -aG docker $USER

echo "activating docker as service"
sudo systemctl enable docker

echo "completed"
