#!/bin/bash

iface=lo`uname | sed -n s/Darwin/0/p`
localip=`ip addr show eth0 | grep 'inet ' | cut -d/ -f1 | awk '{print $2}'`
cat > ${HBASE_ROOT}/conf/hbase-site.xml <<EOF
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>file:///$HBASE_DATA</value>
  </property>
  <property>
    <name>hbase.zookeeper.quorum</name>
    <value>$localip</value>
  </property>
  <property>
    <name>hbase.zookeeper.property.dataDir</name>
    <value>/data/zookeeper</value>
  </property>
  <property>
    <name>hbase.zookeeper.dns.interface</name>
    <value>$iface</value>
  </property>
  <property>
    <name>hbase.regionserver.dns.interface</name>
    <value>$iface</value>
  </property>
  <property>
    <name>hbase.master.ipc.address</name>
    <value>$localip</value>
  </property>
  <property>
    <name>hbase.regionserver.ipc.address</name>
    <value>$localip</value>
  </property>
  <property>
    <name>hbase.master.dns.interface</name>
    <value>$iface</value>
  </property>
</configuration>
EOF

echo "export HBASE_MANAGES_ZK=true" >> ${HBASE_ROOT}/conf/hbase-env.sh
