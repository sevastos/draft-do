FROM sevas/hbase
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get install autoconf libtool gnuplot make gettext gettext-base git-core -y
# [DISABLED] Prerequisites LZO
#RUN apt-get install ant liblzo2-dev -y

# Download OpenTSDB
RUN mkdir /inprogress
WORKDIR /inprogress
RUN git clone -b next git://github.com/OpenTSDB/opentsdb.git
WORKDIR /inprogress/opentsdb

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
RUN sh build.sh debian

# Create OpenTSDB tables on HBase
# On Production: COMPRESSION=lzo
RUN env COMPRESSION=NONE HBASE_HOME=/opt/hbase ./src/create_table.sh

##############

# Config
RUN mkdir -p /opt/opentsdb /tmp/opentsdb
ADD ./opentsdb.conf /opt/opentsdb/opentsdb.conf

# Install
RUN dpkg -i ./build/opentsdb-2.0.0/opentsdb-2.0.0_all.deb

# Cleanup
RUN rm -rf /inprogress

EXPOSE 4242


