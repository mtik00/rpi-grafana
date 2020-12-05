# Unifi Setup

* Add a read-only user
* Store the login credentials in unifi-poller/unifi-poller.conf in `[unifi.defaults]`

# Docker setup

    mkdir -m 777 -p grafana/data

## Volumes

    docker volume create influx-data
    docker volume create grafana-data

# Grafana

Add the data sources:

    - InfluxDB - unifi : http://influx:8086
    - Prometheus : http://prometheus:9090

Install the following dashboards:

* 10419
* 10418
* 10414
* 10415
* 10416
* 10417
