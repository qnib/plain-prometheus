#!/bin/bash


/opt/prometheus/prometheus --config.file=/etc/prometheus.yml --storage.tsdb.path=/data/prometheus --web.listen-address=0.0.0.0:9090