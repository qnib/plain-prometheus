#!/bin/bash

## TODO: Rewrite in GOLANG

for CFG in $(echo ${PROMETHEUS_DNS_SCRAPE_LIST} |sed -e 's/,/ /g');do
  NAME=$(echo ${CFG} |/usr/bin/awk -F: '{print $1}')
  SERVICE=$(echo ${CFG} |/usr/bin/awk -F: '{print $2}')
  PORT=$(echo ${CFG} |/usr/bin/awk -F: '{print $3}')
  PATH=$(echo ${CFG} |/usr/bin/awk -F: '{print $4}')
  SCRAPE_INTERVAL=$(echo ${CFG} |/usr/bin/awk -F: '{print $5}')
  if [[ "X${SCRAPE_INTERVAL}" != "X" ]];then
    SCRAPE_INTERVAL=5s
  fi
  echo """  - job_name: '${NAME}'
    metrics_path: ${PATH}
    scrape_interval: ${SCRAPE_INTERVAL}
    scheme: http
    dns_sd_configs:
    - names:
      - '${SERVICE}'
      type: 'A'
      port: ${PORT}
""" >> /etc/prometheus.yml
  echo ">> Added DNS scrape config: ${CFG}"
done
