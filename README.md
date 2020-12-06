# rpi-grafana

The purpose of this repo is to set up a Docker environment on a raspberry pi to monitor metrics using InfluxDB, Prometheus, Grafana, and `unifi-poller`.

YMMV!

## Initial Setup

* Add a read-only user through the Unifi UI
* Create the grafana data directory:
    `mkdir -m 777 -p grafana/data`
* Create the docker volumes:
    `docker volume create influx-data && docker volume create grafana-data`
* Create `.env` with `UNIFI_USERNAME`, `UNIFI_PASSWORD`, and `UNIFI_URL` as appropriate

## Grafana

Add the data sources:

    - InfluxDB - unifi : http://influx:8086
    - Prometheus : http://prometheus:9090

Install the following dashboards:

* 10419
* 10418 -- Client Insights
* 10414
* 10415
* 10416 -- USG Insights
* 10417
