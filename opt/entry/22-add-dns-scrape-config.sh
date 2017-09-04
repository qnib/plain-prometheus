#!/bin/bash

## TODO: Rewrite in GOLANG

for CFG in ${PROMETHEUS_DNS_SCRAPE_LIST};do
  NAME=$(echo ${CFG} |awk -F: '{print $1}')
  SERVICE=$(echo ${CFG} |awk -F: '{print $2}')
  PORT=$(echo ${CFG} |awk -F: '{print $3}')
  PATH=$(echo ${CFG} |awk -F: '{print $4}')
  echo """  - job_name: '${NAME}'
    scrape_interval: 5s
    scrape_timeout: 5s
    metrics_path: ${PATH}
    scheme: http
    dns_sd_configs:
    - names:
      - '${SERVICE}'
      type: 'A'
      port: ${PORT}
""" >> /etc/prometheus.yml
  echo ">> Added DNS scrape config: ${CFG}"
done
