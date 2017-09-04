#!/bin/bash

## TODO: Rewrite in GOLANG

for CFG in ${PROMETHEUS_STATIC_SCRAPE_LIST};do
  NAME=$(echo ${CFG} |awk -F: '{print $1}')
  HOST=$(echo ${CFG} |awk -F: '{print $2}')
  PORT=$(echo ${CFG} |awk -F: '{print $3}')
  PATH=$(echo ${CFG} |awk -F: '{print $4}')
  echo """  - job_name: '${NAME}'
    scrape_interval: 5s
    scrape_timeout: 5s
    metrics_path: ${PATH}
    scheme: http
    static_configs:
      - targets: ['${HOST}:${PORT}']
""" >> /etc/prometheus.yml
  echo ">> Added static scrape config: ${CFG}"
done
