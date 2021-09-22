# How to scale Prometheus to monitor multiple servers

  This documentation highlights how to set up prometheus, cadvisor,alertmanager, grafana and node exporter for monitoring multiple servers.

  The approach here is to install prometheus and grafana on one server and install instances of node exporter on all other servers where monitoring is required .Prometheus can then scrape the node exporter metrics from the respective servers so that they are accessible on the grafana dashboard .We also use nginx-proxy as the proxy server and letsencrypt for ssl encryption

## Requirements

- a virtual machine/server with docker hosting environment
- open ports 80/443 and 9100 for incoming and outgoing traffic on your firewall
- a dedicated domain for your services

## Notes
    
   This HOWTO uses example.org as the domain name and virtualhost.example.org as the Full Qualified Domain Name(FQDN)
    
   **Please, remember to replace all occurence of example.org domain name, or part of it, with the organisation domain name in the docker-compose  files and also virtualhost.example.org with the FQDN of your preferred virtual host.**
    
   This HOWTO assumes you have already set up nginx proxy and letsencrypt services
    

### Set up prometheus ,alertmanager and cadvisor services

1. Become root
   *  `sudo su -`

2. Create docker compose file
   *  `vim docker-compose.yml`

        ```
        version: '3.4'

        volumes:
            prometheus_data:
            grafana_data:
            certs:
            conf:
            vhost:
            dhparam:
            nginx-html:
            nginx-vhost:
            nginx-conf:

        networks:
        default:
            external:
            name: nginx-proxy

        services:
            prometheus:
                image: prom/prometheus:v2.7.1
                container_name: prometheus_container
                volumes:
                    - ./prometheus:/etc/prometheus:rw
                    - prometheus_data:/prometheus:rw
                command:
                    - '--config.file=/etc/prometheus/prometheus.yml'
                    - '--storage.tsdb.path=/prometheus'
                    - '--web.console.libraries=/usr/share/prometheus/console_libraries'
                    - '--web.console.templates=/usr/share/prometheus/consoles'
                expose:
                    - "9090"
                links:
                    - cadvisor:cadvisor
                    - alertmanager:alertmanager
                depends_on:
                    - cadvisor
                restart: unless-stopped
                environment:
                    - VIRTUAL_HOST=virtualhost.example.org
                    - VIRTUAL_PORT=9090
                    - LETSENCRYPT_HOST=virtualhost.example.org
                    - LETSENCRYPT_EMAIL=email.example.org

            alertmanager:
                image: prom/alertmanager:v0.16.0
                container_name: alertmanager_container
                expose:
                    - "9093"
                volumes:
                    - ./alertmanager/:/etc/alertmanager/
                networks:
                    - default
                restart: unless-stopped
                command:
                    - '--config.file=/etc/alertmanager/config.yml'
                    - '--storage.path=/alertmanager'
                    - '--web.external-url=https://virtualhost.example.org/'
                environment:
                    - VIRTUAL_HOST=virtualhost.example.org
                    - VIRTUAL_PORT=9093
                    - LETSENCRYPT_HOST=virtualhost.example.org
                    - LETSENCRYPT_EMAIL=email.example.org

            cadvisor:
                image: google/cadvisor:v0.32.0
                container_name: cadvisor_container
                volumes:
                    - /:/rootfs:ro
                    - /var/run:/var/run:rw
                    - /sys:/sys:ro
                    - /var/lib/docker/:/var/lib/docker:ro
                ports:
                    - 8080:8080

                restart: unless-stopped 
                ```

3. Configure prometheus
    
    ```
    mkdir prometheus
    cd prometheus
    vim prometheus.yml
    ```

    Add prometheus configuration settings to the prometheus.yml file .Refer to the documentation [here](https://prometheus.io/docs/prometheus/latest/getting_started/) 

4. Configure alert manager
    
    ```
    mkdir alertmanager
    cd alertmanager
    vim config.yml
    ```

    Add alertmanager configuration settings to the config.yml file .Refer to the documentation [here](https://prometheus.io/docs/alerting/latest/configuration/)

5. Configure alerting rules

    ```
    cd ../prometheus
    vim alert.rules
    ```

    Add alerting rules to the alert.rules file appropriately. Refer to the documentation [here](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/)


### Set up node exporter service

1. Become root
   *  `sudo su -`

2. Edit the docker-compose.yml appropriately
        
   *  `vim docker-compose.yml`

        ```
        node-exporter:
        image: prom/node-exporter:v0.17.0
        container_name: node-exporter_container
        volumes:
            - /proc:/host/proc:ro
            - /sys:/host/sys:ro
            - /:/rootfs:ro
        command:
            - '--path.procfs=/host/proc'
            - '--path.sysfs=/host/sys'
            - --collector.filesystem.ignored-mount-points
            - "^/(sys|proc|dev|host|etc|rootfs/var/lib/docker/containers|rootfs/var/lib/docker/overlay2|rootfs/run/docker/netns|rootfs/var/lib/docker/aufs)($$|/)"
        expose:
            - "9100"

        restart: unless-stopped
        ```

### Set up grafana service
    
1. Become root
    *  `sudo su -`

2. Edit the docker-compose.yml appropriately
        
    *  `vim docker-compose.yml`

        ```
        grafana:
        image: grafana/grafana:5.4.5
        container_name: grafana_container
        depends_on:
            - prometheus
        user: "$UID:$GID"
        expose:
            - "3000"

        volumes:
            - ./grafana_data:/var/lib/grafana:rw
            - ./grafana/provisioning/:/etc/grafana/provisioning/
        environment:
            - VIRTUAL_HOST=virtualhost.example.org
            - VIRTUAL_PORT=3000
            - LETSENCRYPT_HOST=virtualhost.example.org
            - LETSENCRYPT_EMAIL=email.example.org
        restart: unless-stopped
        ```
    
### Start up all the services
1. Become root
   * `sudo su -`

2. Run `docker-compose up`

3. Navigate to `https://virtualhost.example.org` to access the services


## Setting up node exporter instances on other servers to be scraped by prometheus

### CASE 1 : docker is installed on the server, so we run node exporter service as a docker container

1. Follow the steps at [Set up node exporter service](#set-up-node-exporter-service)

2. Open port 9100 for incoming and outgoing traffic through the server firewall

3. Edit the `prometheus.yml` file on the prometheus server to add the new server to the list of node exporter targets
    
    **Remember to replace `targets` with your own server ips**

    ```
    scrape_configs:
    # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
    - job_name: 'node'

        # metrics_path defaults to '/metrics'
        # scheme defaults to 'http'.

        static_configs:
        - targets: ['ip.of.server.1:9100']
        - targets: ['ip.of.server.2:9100']
        - targets: ['ip.of.server.3:9100']
    ```


### CASE 2 : we install node exporter directly on the server

1. Become root
   * `sudo su -`

2. Follow the steps [here](https://prometheus.io/docs/guides/node-exporter/)

3. Edit the `prometheus.yml` file on the prometheus server to add the new server to the list of node exporter targets
    
    **Remember to replace `targets` with your own server ips**

    ```
    scrape_configs:
    # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
    - job_name: 'node'

        # metrics_path defaults to '/metrics'
        # scheme defaults to 'http'.

        static_configs:
        - targets: ['ip.of.server.1:9100']
        - targets: ['ip.of.server.2:9100']
        - targets: ['ip.of.server.3:9100']
    ```










