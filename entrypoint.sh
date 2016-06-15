#!/bin/bash

if [ "$#" -gt 2 ]; then
    echo "Usage: $0 [myid] [node_count]"
    echo ""
    echo "myid - the id to give this zookeeper node"
    echo "node_count - the total number of nodes (used to build zoo.cfg)"
    exit 1
fi

MYID=${1-1}
NODES=$2
PREFIX=${PREFIX-zk-}

echo "Starting zookeeper with myid=$MYID"

echo $MYID > /var/opt/zookeeper/myid

cp conf/zoo.template.cfg
if [ -z "$NODES" ]; then
	echo "server.$MYID=localhost:2888:3888;2181" > conf/zoo.dynamic.cfg
else
	for i in $(seq 1 $2); do
		echo "server.$i=$PREFIX$i:2888:3888;2181" >> conf/zoo.dynamic.cfg
	done
fi

exec /opt/zookeeper/bin/zkServer.sh start-foreground
