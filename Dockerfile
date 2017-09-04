ARG DOCKER_REGISTRY=docker.io
FROM ${DOCKER_REGISTRY}/qnib/alplain-init

ARG PROM_URL=https://github.com/prometheus/prometheus/releases/download
ARG PROM_VER=1.7.1
ARG PROM_ARCH=linux-amd64
LABEL prometheus.version=${PROM_VER}
RUN wget -qO- ${PROM_URL}/v${PROM_VER}/prometheus-${PROM_VER}.${PROM_ARCH}.tar.gz |tar xfz - -C /opt/ \
 && mv /opt/prometheus-${PROM_VER}.${PROM_ARCH}/ /opt/prometheus
COPY opt/qnib/prometheus/prometheus.yml /opt/qnib/prometheus/
COPY opt/entry/*.sh /opt/entry/
RUN adduser -s /sbin/nologin -D prometheus
CMD ENTRY_USER=prometheus
VOLUME ["/data/prometheus"]
CMD ["/opt/prometheus/prometheus","-config.file=/etc/prometheus.yml","-storage.local.path=/data/prometheus","-web.listen-address=0.0.0.0:9090"]
