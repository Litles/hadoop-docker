#!/bin/bash
for HOST in node-master node-worker1 node-worker2 node-worker3
do
  echo "========= $HOST =========";
  ssh root@$HOST "jps";
done
