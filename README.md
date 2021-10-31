# devops
A few devops concepts I learn

## Resources

[Difference between git log and git reflog](https://stackoverflow.com/questions/17857723/whats-the-difference-between-git-reflog-and-log)<br>

[How to write a good commit message git](https://chris.beams.io/posts/git-commit/)<br>

[Awesome Prometheus Resources](https://github.com/roaldnefs/awesome-prometheus)<br>

[Linux Interview Questions and Answers](https://www.youtube.com/watch?v=p3tvtXOg5rg)<br>

[How to change default SSH port](https://www.ubuntu18.com/ubuntu-change-ssh-port/)<br>

[Installing elk stack on Ubuntu >= 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elastic-stack-on-ubuntu-18-04) 
<br>

[Securing Nginx with Let's Encrypt on Ubuntu >= 18.04](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04)
<br>

[How to Transfer Files with Rsync over SSH](https://linuxize.com/post/how-to-transfer-files-with-rsync-over-ssh/)<br>

[How To Secure Apache with Let's Encrypt on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04)<br>

[Installing Nginx on Ubuntu >= 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04)
<br>

[How To Install and Use Docker on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)
<br>

[Getting started with Postgre using Docker compose](https://medium.com/analytics-vidhya/getting-started-with-postgresql-using-docker-compose-34d6b808c47c)<br>

[The easiest way to delete a block in a file using Vim/Vi](https://thecodingbot.com/the-easiest-way-to-delete-a-block-in-a-file-using-vim-vi)<br>

[A practical guide to logstash](https://coralogix.com/blog/a-practical-guide-to-logstash-syslog-deep-dive/)

[HackerRank Interview Preparation Kit](https://www.hackerrank.com/interview/interview-preparation-kit)<br>

 ## Commands

`rm -r directory1` - deletes directory1 and its contents from file system <br>

`cat file1` - display contents of file1 in term <br>

`echo -n "" > /path/to/file.txt` - delete contents of file.txt without deleting the file

`sudo du -xh /var/log/* |grep '^\S*[0-9\.]\+G'|sort -rn` - check a folder's disk usage

`echo "$(tail -n 50 /home/pi/Documents/test)" > /home/pi/Documents/test` - truncate file ,leaving the last 50 lines
 
`find / -type f -size +1024k` - find all files of size 1024k and above

`du -h /var/log` - check disk usage for /var/log folder

`tail -n 5 /path/to/file/` - reads the last 5 lines of a file<br>

`tcpdump -A -i any dst port 5000` - check messages getting through port 5000

`shopt -s histappend` - allows multiple sessions to write to history at the same time<br>

`!!` - repeats the most recent command<br>

`ctrl + r` - does a reverse search of terminal history<br>

`ctrl + _` - undo<br>

`curl ifconfig.me` - find ip address of host machine<br>

`bash cheatsheet` <br>

`curl -X POST -d 'json={"foo":"bar"}' http://URL/example.cgi` - post data defined in json to a given URL
<br>

`ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'` or `curl -4 icanhazip.com` - get a server's IP addresses from bash<br>

`nslookup server1` - get ip address for server1<br>

`systemctl start service1` - start service1<br>

`systemctl restart service1` - restart service1<br>

`systemctl reload service1` - reload service1 (for example: nginx) without dropping connections after making configuration changes<br>

`systemctl enable service1` - automatically start 'service1' whenever the server boots up. Use `systemctl disable service1` to disable this behavior<br>

`systemctl stop service1` - stop service1 <br>

`docker ps --format "table {{.Ports}}\t{{.Names}}"` - docker ps with port and name filters<br>

`docker rmi $(docker images --filter "dangling=true" -q --no-trunc)` - remove dangling images<br>

`docker logs --since=2m <container_id> ` - check docker logs for container since last 2 minutes<br> 

`docker exec <nginx-proxy-container-id> cat /etc/nginx/conf.d/default.conf`

`openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout example.key -out example.crt -subj "/CN=example.com" -addext "subjectAltName=DNS:example.com,DNS:www.example.net,IP:10.0.0.1"` - generate self signed certificate using openssl<br>

`cat /proc/sys/vm/swappiness` - check system swapiness setting<br>

`Check space: # free -m 
Disable swap: # swapoff -a 

Wait approx 30 sec 
(use free -m to see the amount of swap used/available decrease over time)

Enable swap: # swapon -a `

`sudo sysctl vm.swappiness=x` - where x is the swap value you wish to set <br>

![title](./bash.png)



### Git commands

`git reset --hard HEAD~1` - gets you back by one commit from the latest

`git add -p` - always use this command instead of `git add .` 


