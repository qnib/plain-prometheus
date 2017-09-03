#!/bin/bash

mkdir -p /data/prometheus
chown prometheus: /data/prometheus
cp /opt/qnib/prometheus/prometheus.yml /etc/
