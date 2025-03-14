#!/bin/bash

# Remove Hadoop cluster
docker-compose -f ./docker-compose.yml down
sudo docker rmi hadoop-node-admin:latest
sudo docker rmi hadoop-node-master:latest
sudo docker rmi hadoop-node-mysql:latest
sudo docker rmi hadoop-node-worker1:latest
sudo docker rmi hadoop-node-worker2:latest
sudo docker rmi hadoop-node-worker3:latest
#sudo docker rmi hadoop-base:3.3.6
echo "All images removed"
