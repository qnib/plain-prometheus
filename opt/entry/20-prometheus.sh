#!/bin/bash

mkdir -p /data/prometheus
chown prometheus: /data/prometheus

gonja-cli /opt/qnib/gonja/prometheus.yml.tpl /etc/prometheus.yml