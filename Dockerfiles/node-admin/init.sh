#!/bin/bash
# 1.Add hosts
echo -e "192.168.3.170\tnode-master" >> /etc/hosts
echo -e "192.168.3.171\tnode-worker1" >> /etc/hosts
echo -e "192.168.3.172\tnode-worker2" >> /etc/hosts
echo -e "192.168.3.173\tnode-worker3" >> /etc/hosts

# 2.Connect and initialize all other nodes
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
# HOST can be IP or hostname
CUR_HOST=`(hostname)`
for HOST in localhost node-admin node-master node-worker1 node-worker2 node-worker3
do
  # a) add to known_host
  if [ -z "$(ssh-keygen -F $HOST)" ]; then
    ssh-keyscan -t rsa -H $HOST >> ~/.ssh/known_hosts
  fi;
  # b) push pubkey to the remote host
  #if ! [ "$HOST" == "$CUR_HOST" ]; then
  if ! [[ "$HOST" == "$CUR_HOST" || "$HOST" == "localhost" ]]; then
    echo "123456" > tmp.txt && sshpass -f tmp.txt ssh-copy-id root@$HOST;
  fi;
  # c) ssh the remote host and initialize it
  if ! [[ "$HOST" == "$CUR_HOST" || "$HOST" == "localhost" ]]; then
    ssh root@$HOST "/bin/bash /init.sh; mv /init.sh /init.done";
  fi;
done
rm -f tmp.txt
#chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
