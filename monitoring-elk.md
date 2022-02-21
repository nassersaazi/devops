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
  
