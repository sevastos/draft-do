FROM sevas/hbase:0.94.17.2
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get install autoconf libtool gnuplot make gettext gettext-base git-core -y
# [DISABLED] Prerequisites LZO
#RUN apt-get install ant liblzo2-dev -y

# Download OpenTSDB
RUN mkdir -p /working
#RUN git clone -b next git://github.com/OpenTSDB/opentsdb.git /working/opentsdb
RUN git clone -b next_lastdp git://github.com/OpenTSDB/opentsdb.git /working/opentsdb

#############
# [1] Source
# Compile
#RUN ./build.sh && make install

# Create OpenTSDB tables on HBase
# On Production: COMPRESSION=lzo
#RUN env COMPRESSION=NONE HBASE_HOME=/opt/hbase ./src/create_table.sh

# Start TSD
#tsdtmp=${TMPDIR-'/tmp'}/tsd    # For best performance, make sure
#mkdir -p "$tsdtmp"             # your temporary directory uses tmpfs
#./build/tsdb tsd --port=4242 --staticroot=build/staticroot --cachedir="$tsdtmp"

#############
# [2] Package
WORKDIR /working/opentsdb
RUN . /etc/environment && bash /working/opentsdb/build.sh debian

# Create OpenTSDB tables on HBase
# On Production: COMPRESSION=lzo
# Hardcoded dist-mode
#RUN /opt/hbase/bin/start-hbase.sh && COMPRESSION=NONE /working/opentsdb/src/create_table.sh

#RUN service zookeeper restart
#RUN echo "status" > /opt/test_shell
#RUN echo "exit" >> /opt/test_shell
#RUN HBASE_CONF_DIR=/opt/hbase/conf /opt/hbase/bin/hbase shell /opt/test_shell

##RUN sh /opt/hbase/bin/hbase-daemon.sh --config /opt/hbase/conf stop master
##RUN sh /opt/hbase/bin/hbase-daemon.sh --config /opt/hbase/conf start master
##RUN sh /opt/hbase/bin/start-hbase.sh
##RUN sh /opt/hbase/bin/hbase status

#RUN COMPRESSION=NONE HBASE_HOME=/opt/hbase /working/opentsdb/src/create_table.sh

##############

# Config
RUN mkdir -p /opt/opentsdb /tmp/opentsdb
ADD ./opentsdb.conf /etc/opentsdb.conf
#RUN cat /etc/opentsdb.conf >> /etc/opentsdb/opentsdb.conf

# Install
RUN . /etc/environment && dpkg -i /working/opentsdb/build/opentsdb-2.0.0/opentsdb-2.0.0_all.deb

# Cleanup
WORKDIR /
RUN rm -rf /working

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV HBASE_VERSION 0.94.17
ENV HBASE_DATA /data/hbase
ENV HBASE_ROOT /opt/hbase
ENV HBASE_SERVER /opt/hbase/bin/hbase
ENV HBASE_CONF_DIR /opt/hbase/conf
ENV HBASE_HOME /opt/hbase

RUN . /etc/environment && bash -e /opt/hbase/bin/stop-hbase.sh && bash -e /opt/hbase/bin/start-hbase.sh && COMPRESSION=NONE bash -e /usr/share/opentsdb/bin/create_table.sh && . /etc/environment && service opentsdb start
#RUN COMPRESSION=NONE . /usr/share/opentsdb/bin/create_table.sh
#RUN . /etc/environment && . /opt/hbase/bin/stop-hbase.sh && . /opt/hbase/bin/start-hbase.sh && COMPRESSION=NONE bash -e /usr/share/opentsdb/bin/create_table.sh && service opentsdb start
#RUN . /etc/environment && . /opt/hbase/bin/stop-hbase.sh && . /opt/hbase/bin/start-hbase.sh && COMPRESSION=NONE bash -e /usr/share/opentsdb/bin/create_table.sh && . /etc/environment && service opentsdb restart
#/usr/share/opentsdb/bin/tsdb tsd
#RUN . /etc/environment && . /opt/hbase/bin/stop-hbase.sh && . /opt/hbase/bin/start-hbase.sh && service opentsdb start

VOLUME ["/data/hbase"]
RUN echo "Donee"

EXPOSE 4242
