FROM sevas/hbase:0.94.17
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
RUN sh /working/opentsdb/build.sh debian

# Create OpenTSDB tables on HBase
# On Production: COMPRESSION=lzo
# Hardcoded dist-mode
RUN /opt/hbase/bin/start-hbase.sh && COMPRESSION=NONE /working/opentsdb/src/create_table.sh

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
ADD ./opentsdb.conf /opt/opentsdb/opentsdb.conf
RUN cat /opt/opentsdb/opentsdb.conf >> /etc/opentsdb/opentsdb.conf

# Install
RUN dpkg -i /working/opentsdb/build/opentsdb-2.0.0/opentsdb-2.0.0_all.deb

# Cleanup
RUN rm -rf /working

RUN sh /opt/hbase/bin/start-hbase.sh && service opentsdb start

EXPOSE 4242
