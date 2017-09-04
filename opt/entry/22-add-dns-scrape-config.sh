#!/bin/bash

## TODO: Rewrite in GOLANG

for CFG in $(echo ${PROMETHEUS_DNS_SCRAPE_LIST} |sed -e 's/,/ /g');do
  NAME=$(echo ${CFG} |/usr/bin/awk -F: '{print $1}')
  SERVICE=$(echo ${CFG} |/usr/bin/awk -F: '{print $2}')
  PORT=$(echo ${CFG} |/usr/bin/awk -F: '{print $3}')
  PATH=$(echo ${CFG} |/usr/bin/awk -F: '{print $4}')
  echo """  - job_name: '${NAME}'
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
