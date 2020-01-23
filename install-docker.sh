#!/usr/bin/env bash

sudo cp binaries/* /usr/bin/ && sudo dockerd &
sudo chmod +x /usr/local/bin/docker-compose

docker --version
docker-compose --version
