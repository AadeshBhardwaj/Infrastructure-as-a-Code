#!/bin/bash
sudo apt update
sudo wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt install -y mongodb-org=4.4.11 mongodb-org-server=4.4.11 mongodb-org-shell=4.4.11 mongodb-org-mongos=4.4.11 mongodb-org-tools=4.4.11