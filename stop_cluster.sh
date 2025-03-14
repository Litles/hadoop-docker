#!/bin/bash

# Stop Hadoop cluster
docker-compose -f ./docker-compose.yml stop
echo "All services stoped"
