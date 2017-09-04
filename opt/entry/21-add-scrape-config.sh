#!/bin/bash

## TODO: Rewrite in GOLANG

for CFG in $(echo ${PROMETHEUS_STATIC_SCRAPE_LIST} |sed -e 's/,/ /g');do
  NAME=$(echo ${CFG} |/usr/bin/awk -F: '{print $1}')
  HOST=$(echo ${CFG} |/usr/bin/awk -F: '{print $2}')
  PORT=$(echo ${CFG} |/usr/bin/awk -F: '{print $3}')
  PATH=$(echo ${CFG} |/usr/bin/awk -F: '{print $4}')
  echo """  - job_name: '${NAME}'
    metrics_path: ${PATH}
    scheme: http
    static_configs:
      - targets: ['${HOST}:${PORT}']
""" >> /etc/prometheus.yml
  echo ">> Added static scrape config: ${CFG}"
done
