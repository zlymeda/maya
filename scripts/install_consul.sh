#!/bin/bash

set -e

CONSUL_VERSION="0.7.0"
CURDIR=`pwd`


# Remove if already present
# NOTE: this is install only script
echo "Cleaning old Consul installation if any"
sudo systemctl stop consul-server.service
sudo rm -rf consul.zip
sudo rm -rf /usr/bin/consul
sudo rm -rf /etc/consul.d/
sudo rm -rf /opt/consul/

echo "Fetching Consul ${CONSUL_VERSION} ..."

cd /tmp/

curl -sSL https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip

echo "Installing Consul ${CONSUL_VERSION} ..."
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul

# Location to hold consul's config files

sudo mkdir -p /etc/consul.d/bootstrap
sudo mkdir -p /etc/consul.d/server
sudo mkdir -p /etc/consul.d/client

sudo chmod a+w /etc/consul.d
sudo chmod a+w /etc/consul.d/bootstrap
sudo chmod a+w /etc/consul.d/server
sudo chmod a+w /etc/consul.d/client

# Location to store consul's persistent data between reboots

sudo mkdir -p /opt/consul/data
sudo chmod a+w /opt/consul/data

cd ${CURDIR}