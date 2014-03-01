FROM sevas/java7
ENV HBASE_VERSION 0.94.17

RUN apt-get update -y

#RUN apt-get install zookeeper zookeperd gnuplot -y
#RUN service zookeeper restart

RUN wget -O - -o /dev/null http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION.tar.gz | tar xz
#RUN tar xzf hbase-$HBASE_VERSION.tar.gz
RUN mkdir -p /opt && mv hbase-$HBASE_VERSION /opt/hbase

# Data will go here (see hbase-site.xml)
ENV HBASE_DATA /data/hbase
RUN mkdir -p $HBASE_DATA /opt/hbase/logs

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV HBASE_ROOT /opt/hbase
ENV HBASE_SERVER /opt/hbase/bin/hbase

ADD ./hbase-conf.sh /opt/hbase/hbase-conf.sh
#ADD ./zoo.cfg /opt/hbase/conf/zoo.cfg
#ADD hbase-server /opt/hbase-server
RUN sh /opt/hbase/hbase-conf.sh

# Zookeeper
EXPOSE 2181
# Thrift API
EXPOSE 9090
# Thrift Web UI
EXPOSE 9095
# HBase Master API port
EXPOSE 60000
# HBase Master web UI at :60010/master-status;  ZK at :60010/zk.jsp
EXPOSE 60010
# Region server API port
EXPOSE 60020
# HBase Region server web UI at :60030/rs-status
EXPOSE 60030

CMD ["/opt/hbase/bin/start-hbase.sh"]
