FROM hadoop-base:3.3.6

USER root

# --------------------------------------------------------
# Hive
# --------------------------------------------------------
ENV HIVE_VERSION=2.3.10
ENV HIVE_PACKAGE=apache-hive-$HIVE_VERSION-bin
#ENV HIVE_URL=https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/$HIVE_PACKAGE.tar.gz
#ENV HIVE_URL=https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-$HIVE_VERSION/$HIVE_PACKAGE.tar.gz
COPY files-Hive/$HIVE_PACKAGE.tar.gz /tmp/
ENV HIVE_HOME=/opt/hive-$HIVE_VERSION
#RUN set -x \
#    && curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
#    && tar -xvf /tmp/hive.tar.gz -C /opt/ \
#    && mv /opt/$HIVE_PACKAGE $HIVE_HOME \
#    && rm -f /tmp/hive*
RUN tar -xvf /tmp/$HIVE_PACKAGE.tar.gz -C /opt/ \
    && mv /opt/$HIVE_PACKAGE $HIVE_HOME \
    && rm -f /tmp/apache-hive*

# Other files
RUN mv $HIVE_HOME/conf/hive-default.xml.template $HIVE_HOME/conf/hive-default.xml
COPY files-Hive/hive-site.xml $HIVE_HOME/conf/
COPY files-Hive/mysql-connector-*.jar $HIVE_HOME/lib/
RUN rm -f $HIVE_HOME/lib/log4j-slf4j-impl-*.jar

# Environment variables
RUN echo "export HIVE_HOME=$HIVE_HOME" >> /etc/profile
RUN echo "export PATH=\$PATH:\$HIVE_HOME/bin" >> /etc/profile

# --------------------------------------------------------
# Spark
# --------------------------------------------------------
ENV SPARK_VERSION=3.5.5
#ENV SPARK_PACKAGE=spark-$SPARK_VERSION-bin-without-hadoop
ENV SPARK_PACKAGE=spark-$SPARK_VERSION-bin-hadoop3
#ENV SPARK_URL=https://dlcdn.apache.org/spark/spark-$SPARK_VERSION/$SPARK_PACKAGE.tgz
#ENV SPARK_URL=https://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-$SPARK_VERSION/$SPARK_PACKAGE.tgz
COPY files-Spark/$SPARK_PACKAGE.gz /tmp/
ENV SPARK_HOME=/opt/spark-$SPARK_VERSION
#RUN set -x \
#    && curl -fSL "$SPARK_URL" -o /tmp/spark.tar.gz \
#    && tar -xvf /tmp/spark.tar.gz -C /opt/ \
#    && mv /opt/$SPARK_PACKAGE $SPARK_HOME \
#    && rm -f /tmp/spark*
RUN tar -xvf /tmp/$SPARK_PACKAGE.gz -C /opt/ \
    && mv /opt/$SPARK_PACKAGE $SPARK_HOME \
    && rm -f /tmp/spark*

# Other files
COPY files-Spark/spark-defaults.conf $SPARK_HOME/conf/
COPY files-Spark/spark-env.sh $SPARK_HOME/conf/
COPY files-Spark/mysql-connector-*.jar $SPARK_HOME/jars/
COPY files-Hive/hive-site.xml $SPARK_HOME/conf/
RUN cp -f $SPARK_HOME/yarn/spark*.jar $HADOOP_HOME/share/hadoop/yarn/lib/

# Environment variables
RUN echo "export SPARK_HOME=$SPARK_HOME" >> /etc/profile
RUN echo "export PATH=\$PATH:\$SPARK_HOME/bin" >> /etc/profile
RUN echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$HADOOP_HOME/lib/native" >> /etc/profile

# --------------------------------------------------------
# Zeppelin
# --------------------------------------------------------
ENV ZEPPELIN_VERSION=0.12.0
ENV ZEPPELIN_PACKAGE=zeppelin-$ZEPPELIN_VERSION-bin-all
#ENV ZEPPELIN_URL=https://dlcdn.apache.org/zeppelin/zeppelin-$ZEPPELIN_VERSION/$ZEPPELIN_PACKAGE.tgz
COPY files-Zeppelin/$ZEPPELIN_PACKAGE.gz /tmp/
ENV ZEPPELIN_HOME=/opt/zeppelin-$ZEPPELIN_VERSION
#RUN set -x \
#    && curl -fSL "$SPARK_URL" -o /tmp/zeppelin.tar.gz \
#    && tar -xvf /tmp/zeppelin.tar.gz -C /opt/ \
#    && mv /opt/$SPARK_PACKAGE $SPARK_HOME \
#    && rm -f /tmp/zeppelin*
RUN tar -xvf /tmp/$ZEPPELIN_PACKAGE.gz -C /opt/ \
    && mv /opt/$ZEPPELIN_PACKAGE $ZEPPELIN_HOME \
    && rm -f /tmp/zeppelin*

# Environment variables
RUN echo "export ZEPPELIN_HOME=$ZEPPELIN_HOME" >> /etc/profile

# Other files
COPY files-Zeppelin/zeppelin-site.xml $ZEPPELIN_HOME/conf/
COPY files-Zeppelin/mysql-connector-*.jar $ZEPPELIN_HOME/lib/
RUN rm -f $ZEPPELIN_HOME/lib/slf4j-reload4j-*.jar


# --------------------- Container Service ----------------------------
ADD init.sh /init.sh
ADD start.sh /start.sh
ADD jps.sh /jps.sh
RUN chmod a+x /init.sh /start.sh /jps.sh

#EXPOSE 8042
#EXPOSE 9870 9868 8088 19888 8188

CMD ["/usr/sbin/sshd", "-D"]
