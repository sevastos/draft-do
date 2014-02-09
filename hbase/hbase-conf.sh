#!/bin/bash

iface=lo`uname | sed -n s/Darwin/0/p`
cat > conf/hbase-site.xml <<EOF
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>file:///$HBASE_DATA</value>
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
    <name>hbase.master.dns.interface</name>
    <value>$iface</value>
  </property>
</configuration>
EOF