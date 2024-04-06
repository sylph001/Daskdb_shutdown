#!/bin/bash

USERNAME=xz
HOST=172.17.0.1

NUM_OF_WRK=$1

SCRIPT ="docker service create --name daskdb_hdfs_swarm_worker --replicas 2 --network daskdb_hdfs_network daskdb_hdfs_worker dask-worker daskdb_hdfs_swarm_scheduler:8786"

echo "Username: $USERNAME"
echo "HOST: $HOST"

# Bring up Workers
echo "STARTING SCRIPT..."
echo "Bringing down workers..."
sshpass -f /function/pwd.txt ssh -o StrictHostKeyChecking=no ${USERNAME}@${HOST} "docker service scale daskdb_hdfs_swarm_worker=0 && docker service rm daskdb_hdfs_swarm_worker"
echo "Bringing down scheduler..."
sshpass -f /function/pwd.txt ssh -o StrictHostKeyChecking=no ${USERNAME}@${HOST} "docker service scale daskdb_hdfs_swarm_scheduler=0"
sleep 3
sshpass -f /function/pwd.txt ssh -o StrictHostKeyChecking=no ${USERNAME}@${HOST} "docker service rm daskdb_hdfs_swarm_scheduler"
echo "DONE EXECUTING SCRIPT"

