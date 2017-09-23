# Introduction

This is a [Zookeeper](https://zookeeper.apache.org) image based on the 3.5 branch (currently in alpha) that allows you to automatically configure the *myid* and *zoo.cfg* files to create standalone nodes or clusters.

# Installation

Pull the image from [docker registry](https://hub.docker.com/r/mrhornsby/zookeeper/):

> docker pull mrhornsby/zookeeper:latest

Alternatively you can build the image locally:

> git clone https://github.com/mrhornsby/zookeeper.git
> cd zookeeper
> docker build --tag="&lt;your_tag_here&gt;"

# Quick start

To start a single standalone zookeeper node run the following:

> docker run --volume=/var/opt/zookeeper -p 2181:2181 -h zk-1 mrhornsby/zookeeper:latest

(**Note:** This will create a new data volume, suitable for a test, but you probably want to mount a host directory or a named volume)

To start a cluster of three zookeeper nodes in an ensemble use the included [docker-compose.yml](docker-compose.yml):

> docker-compose up

(**Note:** This will create 3 containers, *zk-1*, *zk-2* and *zk-3*, each with a dedicated named volume to store their zookeeper data and a user bridge network, name *zk*, enabling the zookeeper nodes to refer to each other by hostname)

# Configuration

The image only has a small set of configuration parameters.

With no arguments the image creates a single zookeeper node with *myid* set to 1.

With a single argument the image creates a single zookeeper node with *myid* set to the first argument.

With more than one argument the script creates a single zookeeper node with *myid* set to the first argument and *zoo.conf* configured to have each of the other nodes listed e.g.

> docker run --volume=/var/opt/zookeeper -p 2181:2181 mrhornsby/zookeeper:latest 1 3 4 7

would result in this server, *zk-1*, having a config pointing to servers named *zk-3*, *zk-4*, *zk-7*.

The name of the nodes can be varied by modifying the *PREFIX* environment variable, which defaults to *zk-*.
