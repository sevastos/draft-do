FROM sevas/java7
ENV HBASE_VERSION 0.96.1.1

RUN apt-get update -y
RUN wget http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-hadoop2-bin.tar.gz
RUN tar xzf hbase-$HBASE_VERSION-hadoop2-bin.tar.gz
RUN mkdir -p /opt/hbase && mv hbase-$HBASE_VERSION-hadoop2 /opt/hbase

# Data will go here (see hbase-site.xml)
RUN mkdir -p /data/hbase /opt/hbase/logs

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV HBASE_SERVER /opt/hbase/bin/hbase

ADD hbase-server /opt/hbase-server


# Thrift API
EXPOSE 9090
# Thrift Web UI
EXPOSE 9095

CMD ["/opt/hbase-server"]
