#!/bin/bash

source /etc/profile

nohup /data/bdata/kafka/bin/zookeeper-server-start.sh /data/bdata/kafka/config/zookeeper.properties > /data/bdata/nohups/zoo/stdout.log 2>&1 &

nohup /data/bdata/kafka/bin/kafka-server-start.sh /data/bdata/kafka/config/server.properties > /data/bdata/nohups/kafka/stdout.log 2>&1 &

nohup /data/bdata/storm/bin/storm nimbus > /data/bdata/nohups/storm/stdout.log 2>&1 &
nohup /data/bdata/storm/bin/storm ui > /data/bdata/nohups/storm/stdout.log 2>&1 &
