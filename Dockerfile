ARG DOCKER_REGISTRY=docker.io
FROM alpine:3.19 AS down
ARG PROM_URL=https://github.com/prometheus/prometheus/releases/download
ARG PROM_VER=2.48.1
ARG PROM_ARCH=linux-amd64
ARG TARGETARCH
ARG GONJA_VER=0.0.3
WORKDIR /opt/
RUN wget -qO- https://gitlab.com/qnib-golang/gonja-cli/-/releases/v${GONJA_VER}/downloads/gonja-cli_${GONJA_VER}_linux_${TARGETARCH}.tar.gz  |tar xfz - --strip-components=0
WORKDIR /opt/prometheus
RUN wget -qO- ${PROM_URL}/v${PROM_VER}/prometheus-${PROM_VER}.linux-${TARGETARCH}.tar.gz |tar xfz - --strip-components=1

FROM ${DOCKER_REGISTRY}/qnib/alplain-init:3.19.0
COPY --from=down /opt/gonja-cli /usr/bin/
COPY --from=down /opt/prometheus /opt/prometheus
COPY opt/entry/*.sh /opt/entry/
COPY opt/qnib/gonja/prometheus.yml.tpl /opt/qnib/gonja/prometheus.yml.tpl
COPY opt/qnib/prometheus/start.sh /opt/qnib/prometheus/
RUN adduser -s /sbin/nologin -D prometheus
ENV ENTRY_USER=prometheus
ENV PROM_SCRAPE_INTERVAL=5s
ENV PROM_EVAL_INTERVAL=5s
VOLUME ["/data/prometheus"]
WORKDIR /data/prometheus
CMD ["/opt/qnib/prometheus/start.sh"]
