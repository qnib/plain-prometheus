global:
 scrape_interval: {{ PROM_SCRAPE_INTERVAL }}
 evaluation_interval: {{ PROM_EVAL_INTERVAL }}

{% if PROM_REMOTE_WRITE_URL %}remote_write:
  - url: "{{ PROM_REMOTE_WRITE_URL }}"{% endif %}

scrape_configs:
  {% for X in PROMETHEUS_STATIC_SCRAPE_LIST|split(",") %}- job_name: '{{ X|split(":")|first }}'
    static_configs:
      - targets: ['{{ X|split(":")|slice("1:3")|join(":") }}']
  {% endfor %}