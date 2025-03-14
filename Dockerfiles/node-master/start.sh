#!/bin/bash
source /etc/profile

if [ -e /init.done ]; then
  # 1.Hadoop services
  # format namenode dir in the first run
  namedir=$HADOOP_DATA/hdsf/name
  #if [ ! -d $namedir ] || [ -z "$(ls -A $namedir)" ]; then
  if ! [ -e /format.done ]; then
    echo "Formatting namenode name directory: $namedir";
    echo 'Y' | hdfs namenode -format;
    touch /format.done;
  fi;
  # a) HDFS and YARN
  start-dfs.sh;
  start-yarn.sh;
  # b) MapReduce JobHistoryServer
  mapred --daemon start historyserver

  # 2.Hive Metastore
  if ! [ -e /init-Hive.done ]; then
    sleep 5;
    schematool -dbType mysql -initSchema
    hdfs dfs -mkdir -p /user/hive/warehouse
    hdfs dfs -chmod g+w /user/hive/warehouse
    hdfs dfs -mkdir -p /upload
    touch /init-Hive.done;
  fi;

  # 3.Spark HistoryServer
  if ! [ -e /init-Spark.done ]; then
    sleep 5;
    # Spark logs directory
    hdfs dfs -mkdir /spark-logs
    # Spark jars (upload to HDFS for acceleration)
    hdfs dfs -mkdir /spark-jars
    jar cv0f spark-libs.jar -C $SPARK_HOME/jars/ .
    hdfs dfs -put spark-libs.jar /spark-jars/
    #hdfs dfs –setrep -w 4 /spark-jars/spark-libs.jar
    rm -f spark-libs.jar
    touch /init-Spark.done;
  fi;
  $SPARK_HOME/sbin/start-history-server.sh

  # 4.Zeppelin Notebook
  $ZEPPELIN_HOME/bin/zeppelin-daemon.sh start
fi

