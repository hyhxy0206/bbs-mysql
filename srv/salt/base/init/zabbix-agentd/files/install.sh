#! /bin/bash

cd /usr/src
tar xf zabbix-5.4.4.tar.gz

cd zabbix-5.4.4
./configure --enable-agent && make install
