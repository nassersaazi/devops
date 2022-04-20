## Common linux sysadmin/devops commands

`rm -r directory1` - deletes directory1 and its contents from file system <br>

`ls ~/.ssh` - list your ssh keys<br> 

`cat file1` - display contents of file1 in term <br>

`echo -n "" > /path/to/file.txt` - delete contents of file.txt without deleting the file<br>

`sudo du -xh /var/log/* |grep '^\S*[0-9\.]\+G'|sort -rn` - check a folder's disk usage<br>

`echo "$(tail -n 50 /home/pi/Documents/test)" > /home/pi/Documents/test` - truncate file ,leaving the last 50 lines<br>
 
`find / -type f -size +1024k` - find all files of size 1024k and above<br>

`du -h /var/log` - check disk usage for /var/log folder<br>

`tail -n 5 /path/to/file/` - reads the last 5 lines of a file<br>

`tcpdump -A -i any dst port 5000` - check messages getting through port 5000<br>

`shopt -s histappend` - allows multiple sessions to write to history at the same time<br>

`!!` - repeats the most recent command<br>

`rsync -a -P -e "ssh -p SSH-PORT" local-file.zip user@remote-server:/remote-directory/` - transfer file to remote server via ssh

`ctrl + r` - does a reverse search of terminal history<br>

`ctrl + _` - undo<br>

`synclient TouchpadOff=1` - disable the touchpad<br>

`synclient TouchpadOff=0` - re-enable the touchpad<br>

`curl ifconfig.me` - find ip address of host machine<br>

`find . -name thisfile.txt` - find a file in Linux called thisfile.txt, it will look for it in current and sub-directories.<br>

`find /home -name *.jpg` - Look for all .jpg files in the /home and directories below it<br>

`*/5 * * * * root    /usr/local/nagios/sbin/nsca_check_disk 2>&1 | /usr/bin/logger -t nsca_check_disk` - send cron job output to syslog<br>
`find . -type f -empty` - Look for an empty file inside the current directory.<br>

` sudo ufw status numbered` - check ufw status in numbered form (makes it easy to delete with numbers.<br>

`find /home -user randomperson-mtime 6 -iname ".db"` - Look for all .db files (ignoring text case) that have been changed in the preceding 6 days by a user called randomperson.<br>

`bash cheatsheet` <br>

`curl -X POST -d 'json={"foo":"bar"}' http://URL/example.cgi` - post data defined in json to a given URL
<br>

`ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'` or `curl -4 icanhazip.com` - get a server's IP addresses from bash<br>

`grep -r "string to be searched"  /path/to/dir` - search particular string in directory<br>

`nslookup server1` - get ip address for server1<br>

`systemctl reload service1` - reload service1 (for example: nginx) without dropping connections after making configuration changes<br>

`docker ps --format "table {{.Ports}}\t{{.Names}}"` - docker ps with port and name filters<br>

`docker rmi $(docker images --filter "dangling=true" -q --no-trunc)` - remove dangling images<br>

`docker logs --since=2m <container_id> ` - check docker logs for container since last 2 minutes<br> 

`docker exec <nginx-proxy-container-id> cat /etc/nginx/conf.d/default.conf`

`openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout example.key -out example.crt -subj "/CN=example.com" -addext "subjectAltName=DNS:example.com,DNS:www.example.net,IP:10.0.0.1"` - generate self signed certificate using openssl<br>

`cat /proc/sys/vm/swappiness` - check system swapiness setting<br>

`df -h | tee disk_usage.txt` - write df command output to disk_usage.txt<br>
```
Check space: # free -m 
Disable swap: # swapoff -a 

Wait approx 30 sec 
(use free -m to see the amount of swap used/available decrease over time)


Enable swap: # swapon -a 
```

`sudo sysctl vm.swappiness=x` - where x is the swap value you wish to set <br>

![title](./bash.png)

`curl -sSL https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info | tic -x -` - run this when you get error "'alacritty': unknown terminal type"
