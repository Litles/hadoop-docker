FROM python:3.12
#FROM ubuntu:22.04

USER root

# --------------------------------------------------------
# Cluster Network (SSH)
# --------------------------------------------------------
# 1.Set root password (otherwise no pwd by default)
RUN echo 'root:123456' | chpasswd

# 2.Install SSH application
RUN apt-get update
#RUN apt-get remove -y openssh-client openssh-server
RUN apt-get install -y ssh sshpass vim
RUN chown root:root /
RUN mkdir -p /var/run/sshd
RUN mkdir -p /run/sshd
RUN chmod 0755 /var/run/sshd
RUN chmod 0755 /run/sshd
#RUN sed -i 's/\/var//' /usr/lib/tmpfiles.d/sshd.conf

# 3.Authentication (password and pubkey)
RUN sed -i 's/#UsePAM/UsePAM/' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config
RUN sed -i 's/PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# 4.Something maybe effective
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# --------------------------------------------------------
# JAVA
# --------------------------------------------------------
#RUN apt-get update
# --- Method 1 ---
#RUN apt install -y software-properties-common
#RUN add-apt-repository ppa:openjdk-r/ppa
#RUN apt update
#RUN apt install -y openjdk-11-jdk
#ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
# --- Method 2 ---
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
RUN echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt-get update
RUN apt-get install -y temurin-11-jdk
ENV JAVA_HOME=/usr/lib/jvm/temurin-11-jdk-amd64

# --------------------------------------------------------
# HADOOP
# --------------------------------------------------------
ENV HADOOP_VERSION=3.3.6
ENV HADOOP_PACKAGE=hadoop-$HADOOP_VERSION
#ENV HADOOP_URL=https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-$HADOOP_VERSION/$HADOOP_PACKAGE.tar.gz
#ENV HADOOP_URL=https://downloads.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/$HADOOP_PACKAGE.tar.gz
COPY files/$HADOOP_PACKAGE.tar.gz /tmp/$HADOOP_PACKAGE.tar.gz
ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
#RUN set -x \
#    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
#    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
#    && rm -f /tmp/hadoop*
RUN tar -xvf /tmp/$HADOOP_PACKAGE.tar.gz -C /opt/ \
    && rm -f /tmp/hadoop*
ENV HADOOP_DATA=/hadoop-data
ENV HADOOP_LOG_DIR=$HADOOP_DATA/logs
ENV HADOOP_PID_DIR=$HADOOP_DATA/pid
RUN mkdir -p $HADOOP_DATA
RUN mkdir -p $HADOOP_LOG_DIR
RUN mkdir -p $HADOOP_PID_DIR

# Other files
COPY files/core-site.xml $HADOOP_CONF_DIR/core-site.xml
COPY files/hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY files/mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml
COPY files/yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml
COPY files/hadoop-env.sh $HADOOP_CONF_DIR/hadoop-env.sh
COPY files/capacity-scheduler.xml $HADOOP_CONF_DIR/capacity-scheduler.xml

# --------------------------------------------------------
# Add Environment Variable Permanently
# --------------------------------------------------------
RUN echo "export JAVA_HOME=$JAVA_HOME" >> /etc/profile
RUN echo "export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> /etc/profile
RUN echo "export HADOOP_HOME=$HADOOP_HOME" >> /etc/profile
RUN echo "export HADOOP_CONF_DIR=$HADOOP_CONF_DIR" >> /etc/profile
RUN echo "export HADOOP_DATA=$HADOOP_DATA" >> /etc/profile
RUN echo "export HADOOP_LOG_DIR=$HADOOP_LOG_DIR" >> /etc/profile
RUN echo "export HADOOP_PID_DIR=$HADOOP_PID_DIR" >> /etc/profile
RUN echo "export PATH=\$PATH:\$JAVA_HOME/bin:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" >> /etc/profile

#EXPOSE 22
