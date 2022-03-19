# Documentation for monitoring of servers on Elastic stack(ELK)

This documentation highlights how to configure syslog to send messages to logstash and elasticsearch

## Requirements

- Ensure port 5000 is open for incoming and outgoing traffic on your firewall
- You have and instances of Elasticsearch, Kibana and Logstash running that you can remotely connect to


### Set up rsyslog to send logs to elk

Such logs include the basic system logs for any linux system e.g ssh logs ,cron logs ,systemd logs, ufw logs etc.

1. Check if rsyslog is installed

    ```bash
    rsyslogd -v
    ```

    In case it is not installed, you can install it by running the following command

    ```bash
    apt-get install rsyslog -y
    ```


2. Edit the configuration file of the syslog daemon on the client.
   
    ```bash
    sudo nano /etc/rsyslog.d/50-default.conf
    ```
   

    Above the line “#First some standard log files. Log by facility” we’ll add the following:
      ```bash
      *.*                         @@<ip-of-logstash-server>:5000
      ```

    *.* indicates to forward all messages. @@  instructs the rsyslog utility to transmit data through TCP connections.

    *5000* is the our chosen port on the logstash server for incoming syslog messages via tcp

3. Save the file and restart the syslog daemon (called “rsyslogd”) so that it picks up the config file changes.
    ```bash
    sudo systemctl restart rsyslog.service
    ```

### Set up Mysql to send logs to elk

1. Enable mysql logging (by default it is set to false)

    ```bash
    mysql -u root -p
    SET GLOBAL general_log_file='/var/log/mysql/mysql.log';
    SET GLOBAL general_log = 1;
    SET GLOBAL slow_query_log_file='/var/log/mysql/mysql-slow.log';
    SET GLOBAL slow_query_log = 1;
    exit;
    ```

2. Install [filebeat service](#set-up-filebeat-service) and configure mysql module on database server


### Set up filebeat service

1. Install filebeat

   ```bash
   curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-oss-7.15.1-amd64.deb
   sudo dpkg -i filebeat-oss-7.15.1-amd64.deb
   ```

2. Configure the inputs

   ```bash
   vim /etc/filebeat/filebeat.yml
   ```

3. Configure modules(optional)
   
   ```bash
   sudo filebeat modules list
   sudo filebeat modules enable <module name>
   sudo filebeat modules disable <module name>
   ```
   
   Additional configuration can be done on module files in the folder `/etc/filebeat/modules.d`

4. Configure output to logstash

   ```bash
   ## Comment out elasticsearch output
   #output.elasticsearch:
   #  hosts: ["localhost:9200"]
   output.logstash:
     hosts: ["your-logstash-host:your-ssl-port"]
     loadbalance: true
     ssl.enabled: true
   ```

5. Validate configuration by running filebeat in terminal

   ```bash
   sudo filebeat -e -c /etc/filebeat/filebeat.yml
   ```

6. Start filebeat

   ```bash
   sudo systemctl enable filebeat
   sudo systemctl start filebeat
   ``` 
      
   

### Set up Apache to send logs to elk

The rsyslog [text file input module (imfile)](https://www.rsyslog.com/doc/v8-stable/configuration/modules/imfile.html), provides the ability to convert any standard text file into a syslog message. This module can read a log file line by line while passing each read line to rsyslog engine rules, which then applies filter conditions and selects which actions needs to be carried out. Empty lines are not processed, as they would result in empty syslog records. They are simply ignored.
We can send Apache logs to the logstash server by piping them through rsyslog as follows:


1. Become root

    ```bash
    sudo su -
    ```

2. Add the following content to `/etc/rsyslog.conf` in the `#### MODULES ####` section
   
    ```bash
    module(load="imfile" PollingInterval="10" )
    input(type="imfile"
      File="/var/log/apache2/access.log"
      Tag="http_access:"
      Severity="info"
      Facility="local6")

    input(type="imfile"
      File="/var/log/apache2/error.log"
      Tag="http_error"
      Severity="error"
      Facility="local7")
    ```
3. Save the file and restart the syslog daemon (called “rsyslogd”) so that it picks up the config file changes.
    ```bash
    sudo systemctl restart rsyslog.service
    ```
  

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
    Prometheus collects metrics from targets by scraping metrics HTTP endpoints. Since Prometheus exposes data in the same manner about itself, it can also scrape and monitor its own health.

    While a Prometheus server that collects only data about itself is not very useful, it is a good starting example. Save the following basic Prometheus configuration as a file named `prometheus.yml`:

    ```bash
    global:
      scrape_interval:     15s # By default, scrape targets every 15 seconds.

      # Attach these labels to any time series or alerts when communicating with
      # external systems (federation, remote storage, Alertmanager).
      external_labels:
        monitor: 'codelab-monitor'

    # A scrape configuration containing exactly one endpoint to scrape:
    # Here it's Prometheus itself.
    scrape_configs:
      # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
      - job_name: 'prometheus'

        # Override the global default and scrape targets from this job every 5 seconds.
        scrape_interval: 5s

        static_configs:
          - targets: ['localhost:9090']
    ```

4. Configure alert manager
    
    ```
    mkdir alertmanager
    cd alertmanager
    vim config.yml
    ```

    Add alertmanager configuration settings to the config.yml file . Follow the steps [here](https://prometheus.io/docs/alerting/latest/configuration/)

5. Configure alerting rules

    ```bash
    cd ../prometheus
    vim alert.rules
    ```

    Add alerting rules to the alert.rules file appropriately. 

    An example rules file with an alert would be:

    ```bash
    groups:
    - name: example
    rules:
    - alert: HighRequestLatency
        expr: job:request_latency_seconds:mean5m{job="myjob"} > 0.5
        for: 10m
        labels:
        severity: page
        annotations:
        summary: High request latency
    ```

    The optional `for` clause causes Prometheus to wait for a certain duration between first encountering a new expression output vector element and counting an alert as firing for this element. In this case, Prometheus will check that the alert continues to be active during each evaluation for 10 minutes before firing the alert. Elements that are active, but not firing yet, are in the pending state.<br>

    The `labels` clause allows specifying a set of additional labels to be attached to the alert. Any existing conflicting labels will be overwritten. The label values can be templated.<br>

    The `annotations` clause specifies a set of informational labels that can be used to store longer additional information such as alert descriptions or runbook links. The annotation values can be templated.<br>


### Set up node exporter service

1. Become root
   *  `sudo su -`

2. Edit the docker-compose.yml appropriately
        
   *  `vim docker-compose.yml`

        ```
        node-exporter:
            image: prom/node-exporter:v0.17.0
            container_name: node-exporter_container
            ports:
                - "9100:9100"
            volumes:
                - ./proc:/host/proc:ro
                - ./sys:/host/sys:ro
                - ./rootfs:/rootfs:ro
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

    ```bash
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

2. The Prometheus Node Exporter is a single static binary that you can install via tarball. Once you've downloaded it from the Prometheus [downloads page](https://prometheus.io/download#node_exporter) move the node exporter binary to /usr/local/bin 
    
    ```bash
    wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
    tar xvfz node_exporter-1.3.1.linux-amd64.tar.gz
    sudo mv node_exporter-1.3.1-amd64/node_exporter /usr/local/bin/
    ```

3. Create a node_exporter user to run the node exporter service

    ```bash
    sudo useradd -rs /bin/false node_exporter
    ```

4. Create a node_exporter service file under systemd.

    ```bash
    sudo tee /etc/systemd/system/node_exporter.service<<EOF
    [Unit]
    Description=Node Exporter
    After=network.target
    
    [Service]
    User=node_exporter
    Group=node_exporter
    Type=simple
    ExecStart=/usr/local/bin/node_exporter
    
    [Install]
    WantedBy=multi-user.target
    EOF
    ```

5. Reload the system daemon and start the node exporter service.

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl start node_exporter
    sudo systemctl enable node_exporter
    ```

6. Check the status of node exporter if it is running in active state.

    ```bash
    sudo systemctl status node_exporter
    ```

7. Check the status of node exporter if it is running in active state.

    ```bash
    sudo systemctl status node_exporter
    ```
   
   You can see all the server metrics or node metrics from the following link.

    ```bash
    http://<Node-IP>:9100/metrics
    ```
8. Edit the `prometheus.yml` file on the prometheus server to add the new server to the list of node exporter targets
    
    **Remember to replace `targets` with your own server ips**

    ```bash
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

## Setting up mysql exporter on database server to be scraped by prometheus

1. Become root
   
   ```bash
   sudo su -
   ```

2. Create a dedicated Prometheus user and group
   
   ```bash
   sudo groupadd --system prometheus
   sudo useradd -s /sbin/nologin --system -g prometheus prometheus
   ```

   This user will manage the exporter service.

3. Download and install Prometheus MySQL exporter

   This should be done on MySQL / MariaDB servers, both slaves and master servers. You may need to check [Prometheus MySQL exporter releases page](https://github.com/prometheus/mysqld_exporter/releases) for the latest release, then export the latest version  to **VER** variable as shown below:
   
   ```bash
   curl -s https://api.github.com/repos/prometheus/mysqld_exporter/releases/latest   | grep browser_download_url | grep linux-amd64 |  cut -d '"' -f 4 | wget -qi -
   ```
4. Move the mysqld exporter binary to /usr/local/bin

   ```bash
   tar xvf mysqld_exporter-*.linux-amd64.tar.gz
   sudo mv mysqld_exporter-*.linux-amd64/mysqld_exporter /usr/local/bin
   ```

5. Create Prometheus exporter database user with the required grants.

   ```bash
   mysql -u root -p
   ```

   ```bash
   CREATE USER 'mysqld_exporter'@'localhost' IDENTIFIED BY 'StrongPassword' WITH MAX_USER_CONNECTIONS 2;
   GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'mysqld_exporter'@'localhost';
   FLUSH PRIVILEGES;
   EXIT
   ```
   
   ** Remember to replace 'StrongPassword' with an appropriately strong password **

   If you have a Master-Slave database architecture, create user on the master servers only.

   **WITH MAX_USER_CONNECTIONS 2** is used to set a max connection limit for the user to avoid overloading the server with monitoring scrapes under heavy load.

6. Create database credentials file

   ```bash
   sudo tee /etc/.mysqld_exporter.cnf<<EOF
   [client]
   user=mysqld_exporter
   password=StrongPassword
   EOF
   ```

7. Set ownership permissions:

   ```bash
   sudo chown root:prometheus /etc/.mysqld_exporter.cnf`
   ```

8. Create a mysqld_exporter service file under systemd
  
   ```bash
   sudo tee /etc/systemd/system/mysql_exporter.service<<EOF
   [Unit]
   Description=Prometheus MySQL Exporter
   After=network.target

   [Service]
   User=prometheus
   Group=prometheus
   Type=simple
   Restart=always
   ExecStart=/usr/local/bin/mysqld_exporter 
   --config.my-cnf /etc/.mysqld_exporter.cnf 
   --collect.global_status 
   --collect.info_schema.innodb_metrics 
   --collect.auto_increment.columns 
   --collect.info_schema.processlist 
   --collect.binlog_size 
   --collect.info_schema.tablestats 
   --collect.global_variables 
   --collect.info_schema.query_response_time 
   --collect.info_schema.userstats 
   --collect.info_schema.tables 
   --collect.perf_schema.tablelocks 
   --collect.perf_schema.file_events 
   --collect.perf_schema.eventswaits 
   --collect.perf_schema.indexiowaits 
   --collect.perf_schema.tableiowaits 
   --collect.slave_status 

   [Install]
   WantedBy=multi-user.target
   EOF
   ```
   
   If your server has a public and private network, you may need to replace **0.0.0.0:9104** with private IP, e.g. **192.168.4.5:9104**

9. Reload the system daemon and start the mysql_exporter service.

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl start mysql_exporter
    sudo systemctl enable mysql_exporter
    ```

10. Check the status of mysql exporter if it is running in active state.

    ```bash
    sudo systemctl status mysql_exporter
    ```

   You can see all the metrics from the following link.

    ```bash
    http://<Mysql-IP>:9104/metrics
    ```
11. Edit the `prometheus.yml` file on the prometheus server to add the new server to the list of mysql exporter targets

    **Remember to replace `targets` with your own server ips**

    ```bash
    scrape_configs:
    # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
    - job_name: 'mysql'

        # metrics_path defaults to '/metrics'
        # scheme defaults to 'http'.


## Resources

https://github.com/prometheus/node_exporter/tree/master/examples/systemd 

https://docs.vmware.com/en/Management-Packs-for-vRealize-Operations-Manager/1.5.2/kubernetes-solution/GUID-A1B68BE5-EF38-48E1-AA80-FD71E6F19989.html 

https://github.com/prometheus/node_exporter/blob/master/examples/systemd/node_exporter.service 

https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/

https://prometheus.io/docs/prometheus/latest/getting_started/

