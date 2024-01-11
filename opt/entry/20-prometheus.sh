#!/bin/bash

mkdir -p /data/prometheus
chown prometheus: /data/prometheus
cp /opt/qnib/prometheus/prometheus.yml /etc/
if [[ "X${STORAGE_ADAPTER_HOST}" != "X" ]];then
  sed -i'' -e "s;#\- url:.*\/write\";- url: \"http://${STORAGE_ADAPTER_HOST}:${STORAGE_ADAPTER_PORT}/write\";" \
           -e "s;#\- url:.*\/read\";- url: \"http://${STORAGE_ADAPTER_HOST}:${STORAGE_ADAPTER_PORT}/read\";" /etc/prometheus.yml
fi

