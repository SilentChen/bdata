#!/bin/bash

# CMD_SOURCE=`source /etc/profile`
# 
# CMD_ZOOKEEPER=nohup /data/bdata/kafka/bin/zookeeper-server-start.sh /data/bdata/kafka/config/zookeeper.properties > /data/bdata/nohups/zoo/stdout.log 2>&1 &
# 
# CMD_KAFKA=nohup /data/bdata/kafka/bin/kafka-server-start.sh /data/bdata/kafka/config/server.properties > /data/bdata/nohups/kafka/stdout.log 2>&1 &
# 
# CMD_STORM_NIM=nohup /data/bdata/storm/bin/storm nimbus > /data/bdata/nohups/storm/stdout.log 2>&1 &
# 
# CMD_STORM_UI=nohup /data/bdata/storm/bin/storm ui > /data/bdata/nohups/storm/stdout.log 2>&1 &

function HELP()
{
cat << EOF
usage:
	 -start_all to star the bdata include zookeeper, kafka, storm
	 
	 -stop_all to stop the bdata indlude zookeeper, kafka, storm
	 
	 -start something, include zookeeper, kafka, storm
	 
	 -stop something, include zookeeper, kafka, storm
	 
	 -h/help, for looking for this	

EOF
}

function start_zookeeper()
{
	echo "starting zookeeper..."
	nohup /data/bdata/kafka/bin/zookeeper-server-start.sh /data/bdata/kafka/config/zookeeper.properties > /data/bdata/nohups/zoo/stdout.log 2>&1 &
}

function start_kafka()
{
	echo "starting kafka..."
	/data/bdata/kafka/bin/kafka-server-start.sh /data/bdata/kafka/config/server.properties > /data/bdata/nohups/kafka/stdout.log 2>&1 &
}

function start_storm()
{
	echo "starting storm..."
	/data/bdata/storm/bin/storm nimbus > /data/bdata/nohups/storm/stdout.log 2>&1 &
	/data/bdata/storm/bin/storm ui > /data/bdata/nohups/storm/stdout.log 2>&1 &
}

function start_all()
{
	start_zookeeper
	sleep 1
	start_kafka
	sleep 1
	start_storm
}

function stop()
{
	TARGET=$1
	echo "stoping $TARGET"
	ps -aux|grep $TARGET|grep -v grep|awk '{print $2}'|xargs kill -s 9
	sleep 1
}

case $1 in
"start_all")
	start_all
	;;
"stop_all")
	stop "storm"
	stop "kafka"
	#stop "zookeeper"
	;;
"start_storm")
	start_storm
	;;
"start_kafka")
	start_kafka
	;;
"start_zookeeper")
	start_zookeeper
	;;
"stop_storm")
	stop "storm"
	;;
"stop_kafka")
	stop "kafka"
	;;
"stop_zookeeper")
	stop "zookeeper"
	;;
"h|H|help|HELP|*")
	HELP
	;;
*)
	HELP
	;;
esac
