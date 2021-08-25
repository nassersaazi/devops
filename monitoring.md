# Documentation for monitoring of servers

This documentation highlights how to set up prometheus and grafana for monitoring server activity

## Requirements

- a virtual machine/server with docker hosting environment
- open ports 80/443 for incoming and outgoing traffic on your firewall
- a dedicated domain for your services


## Installation

1. Write a docker compose yaml file with the following services
    - grafana(for displaying prometheus metrics)
    - prometheus (for pulling different metrics from the server(s))
    - nginx-proxy( the proxy server for routing traffic to respective services)
    - letsencrypt(for generating certificates for https)
    - cadvisor
    - alertmanager(for sending alerts to slack/gmail for any server process that require manual intervention)
    - node exporter(for collecting server metrics to be scraped by prometheus)
2. Configure virtual hosts for prometheus ,grafana and alertmanager in the environment variables.
3. Ensure all volumes and networks in the docker-compose.yaml file are well defined.
4. Run `docker-compose up` to start the services(Ensure your in the directory of the docker-compose.yaml file)
5. Connect to your services on your chosen domain via your browser
6. Log in to the grafana dashboard and add your prometheus service as a data source

## Configurations
- Create a folder `./prometheus`.
- Inside the folder,create two files i.e. `prometheus.yml` and `alertrules.yml`
- Add prometheus rules for server scraping in `prometheus.yml` and the alertmanager rules to the `alertrules.yml`.
- Create a folder `./alertmanager`.
- Inside the folder, create a file `config.yml` and add any notification channels you want to send alerts to.

## Docker images
- grafana : `grafana/grafana:5.4.5`
- prometheus : `prom/prometheus:v2.7.1` 
- nginx-proxy : `jwilder/nginx-proxy`
- letsencrypt : `jrcs/letsencrypt-nginx-proxy-companion`
- cadvisor : `google/cadvisor:v0.32.0`
- alertmanager : `prom/alertmanager:v0.16.0`
- node exporter : `prom/node-exporter:v0.17.0`

## Resources
- [How To Install and Use Docker on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)
- [Setting up alertmanager](https://grafana.com/blog/2020/02/25/step-by-step-guide-to-setting-up-prometheus-alertmanager-with-slack-pagerduty-and-gmail/)
- [Getting started with prometheus](https://prometheus.io/docs/prometheus/latest/getting_started/)
- [Configuring prometheus with grafana](https://www.scaleway.com/en/docs/configure-prometheus-monitoring-with-grafana/)


