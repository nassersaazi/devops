# Documentation for monitoring of servers on Elastic stack(ELK)

This documentation highlights how to configure syslog to send messages to logstash and elasticsearch

## Requirements

- Ensure port 5000 is open for incoming and outgoing traffic on your firewall



## Configuration

 Edit the configuration file of the syslog daemon on the client.
   
   ```bash
   sudo nano /etc/rsyslog.d/50-default.conf
   ```
   

 Above the line “#First some standard log files. Log by facility” we’ll add the following:
   ```bash
   *.*                         @@monitor-dar:5000
   ```

 *.* indicates to forward all messages. @@  instructs the rsyslog utility to transmit data through TCP connections.

 Save the file and restart the syslog daemon (called “rsyslogd”) so that it picks up the config file changes.
   ```bash
   sudo systemctl restart rsyslog.service
   ```
