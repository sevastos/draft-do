FROM sevas/hbase
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get install git-core -y

# Download OpenTSDB
RUN git clone git://github.com/OpenTSDB/opentsdb.git
RUN cd opentsdb 

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
RUN ./build.sh debian

# Create OpenTSDB tables on HBase
# On Production: COMPRESSION=lzo
RUN env COMPRESSION=NONE HBASE_HOME=/opt/hbase ./src/create_table.sh

##############

# Config
RUN mkdir -p /opt/opentsdb /tmp/opentsdb
ADD ./opentsdb.conf /opt/opentsdb/opentsdb.conf

# Install
RUN dpkg -i ./build/opentsdb-2.0.0/opentsdb-2.0.0_all.deb

EXPOSE 4242


