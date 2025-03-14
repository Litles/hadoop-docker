#!/bin/bash

# Start Hadoop cluster
docker-compose -f ./docker-compose.yml start
echo "All services started"
