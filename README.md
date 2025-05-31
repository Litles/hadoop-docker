# hadoop-docker
Deploying a Hadoop cluster for BigData ecosystem with Docker.

## Usage
For the first time use, build up images for the cluster and kick-off:

```shell
$ sudo bash setup_cluster.sh 
...
...
```

Otherwise, start the cluster directly:
```shell
$ sudo bash start_cluster.sh 
[+] Running 6/6
 ✔ Container node-worker3  Started                                                      0.6s 
 ✔ Container node-mysql    Started                                                      0.6s 
 ✔ Container node-worker1  Started                                                      0.6s 
 ✔ Container node-worker2  Started                                                      0.6s 
 ✔ Container node-master   Started                                                      0.2s 
 ✔ Container node-admin    Started                                                      0.2s 
All services started
```

```log
========= node-master =========
913 NodeManager
1298 JobHistoryServer
514 SecondaryNameNode
1635 ZeppelinServer
1411 HistoryServer
280 DataNode
139 NameNode
1869 Jps
781 ResourceManager
========= node-worker1 =========
176 NodeManager
339 Jps
44 DataNode
========= node-worker2 =========
348 Jps
44 DataNode
173 NodeManager
========= node-worker3 =========
339 Jps
44 DataNode
175 NodeManager
```
