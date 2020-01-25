#!/usr/bin/env bash

curl -O https://download.docker.com/linux/static/stable/x86_64/docker-19.03.5.tgz
sudo mv docker-19.03.5.tgz ./binaries/docker-19.03.5.tgz
tar xvf ./binaries/docker-19.03.5.tgz
sudo rm -f ./binaries/docker-19.03.5.tgz

curl -O https://github.com/docker/compose/releases/download/1.25.1/docker-compose-$(uname -s)-$(uname -m) -kL
sudo mv docker-compose-$(uname -s)-$(uname -m) ./binaries/docker-compose-$(uname -s)-$(uname -m)

sudo cp binaries/* /usr/bin/
sudo chmod +x /usr/local/bin/docker-compose


echo "docker installation complete adding to systemctl"
docker --version
docker-compose --version


sudo mkdir -p /etc/systemd/system/docker.service.d

cat > /etc/systemd/system/docker.service <<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target docker.socket firewalld.service
Wants=network-online.target
Requires=docker.socket
[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd -H fd://
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=1048576
# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNPROC=infinity
LimitCORE=infinity
# Uncomment TasksMax if your systemd version supports it.
# Only systemd 226 and above support this version.
#TasksMax=infinity
TimeoutStartSec=0
# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes
# kill only the docker process, not all processes in the cgroup
KillMode=process
# restart the docker process if it exits prematurely
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s
[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/docker.socket <<EOF
[Unit]
Description=Docker Socket for the API
PartOf=docker.service
[Socket]
# If /var/run is not implemented as a symlink to /run, you may need to
# specify ListenStream=/var/run/docker.sock instead.
ListenStream=/run/docker.sock
SocketMode=0660
SocketUser=root
SocketGroup=docker
[Install]
WantedBy=sockets.target
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker

echo "creating docker group"
sudo groupadd docker

echo "adding the current user to docker group"
sudo usermod -aG docker $USER

echo "reactivating docker group"
newgrp docker

echo "activating docker as service"
sudo systemctl enable docker

echo "docker setup completed"
