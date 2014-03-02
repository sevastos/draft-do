#VERSION 0.94.17.5

FROM sevas/java7:0.0.5

RUN echo "HBASE_VERSION=0.94.17" >> /etc/environment
RUN echo "export HBASE_VERSION" >> /etc/environment
RUN echo "HBASE_DATA=/data/hbase" >> /etc/environment
RUN echo "export HBASE_DATA" >> /etc/environment
RUN echo "HBASE_ROOT=/opt/hbase" >> /etc/environment
RUN echo "export HBASE_ROOT" >> /etc/environment
RUN echo "HBASE_SERVER=/opt/hbase/bin/hbase" >> /etc/environment
RUN echo "export HBASE_SERVER" >> /etc/environment
RUN echo "HBASE_CONF_DIR=/opt/hbase/conf" >> /etc/environment
RUN echo "export HBASE_CONF_DIR" >> /etc/environment
RUN echo "HBASE_HOME=/opt/hbase" >> /etc/environment
RUN echo "export HBASE_HOME" >> /etc/environment

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV HBASE_VERSION 0.94.17
ENV HBASE_DATA /data/hbase
ENV HBASE_ROOT /opt/hbase
ENV HBASE_SERVER /opt/hbase/bin/hbase
ENV HBASE_CONF_DIR /opt/hbase/conf
ENV HBASE_HOME /opt/hbase

RUN apt-get update -y
RUN apt-get install zookeeper zookeeperd gnuplot -y

RUN . /etc/environment && wget -O - -o /dev/null http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION.tar.gz | tar xz
RUN mkdir -p /opt && . /etc/environment && mv hbase-$HBASE_VERSION /opt/hbase

# Data will go here (see hbase-site.xml)
RUN . /etc/environment && mkdir -p $HBASE_DATA /opt/hbase/logs

ADD ./hbase-conf.sh /opt/hbase/hbase-conf.sh
#RUN mkdir -p /var/hadoop/pids
RUN echo "export HBASE_MANAGES_ZK=true" >> /opt/hbase/conf/hbase-env.sh
#RUN echo "export HBASE_PID_DIR=/var/hadoop/pids" >> /opt/hbase/conf/hbase-env.sh

#ADD ./zoo.cfg /opt/hbase/conf/zoo.cfg
#ADD hbase-server /opt/hbase-server
RUN . /etc/environment && sh /opt/hbase/hbase-conf.sh
RUN service zookeeper restart

RUN . /etc/environment && sh /opt/hbase/bin/start-hbase.sh

# Zookeeper
EXPOSE 2181
# Thrift API
EXPOSE 9090
# Thrift Web UI
EXPOSE 9095
# Root region (\)
EXPOSE 37105
# HBase Master API port
EXPOSE 60000
# HBase Master web UI at :60010/master-status;  ZK at :60010/zk.jsp
EXPOSE 60010
# Region server API port
EXPOSE 60020
# HBase Region server web UI at :60030/rs-status
EXPOSE 60030

CMD ["/opt/hbase/bin/start-hbase.sh"]
