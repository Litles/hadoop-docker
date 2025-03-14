#!/bin/bash
# 1.initialize the cluster
if [ -e /init.sh ]; then
  sleep 5;
  /bin/bash /init.sh;
  mv /init.sh /init.done;
fi

# 2.kick off the cluster
sleep 10
if [ -e /init.done ]; then
  HOST=node-master;
  ssh root@$HOST "/bin/bash /start.sh";
  sleep 15;
  ssh root@$HOST "/bin/bash /jps.sh";
fi

# 3.keep this admin node alive
/usr/sbin/sshd -D
