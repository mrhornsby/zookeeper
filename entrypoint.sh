#!/bin/bash

MYID=${1-1}

shift 1

OTHER_NODES=$@

PREFIX=${PREFIX-zk-}

echo "Starting zookeeper with myid=$MYID"

echo $MYID > /var/opt/zookeeper/myid

echo "server.$MYID=$PREFIX$MYID:2888:3888;2181" > conf/zoo.dynamic.cfg

for i in $OTHER_NODES; do
	echo "server.$i=$PREFIX$i:2888:3888;2181" >> conf/zoo.dynamic.cfg
done

exec /opt/zookeeper/bin/zkServer.sh start-foreground
