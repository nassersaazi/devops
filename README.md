# devops
A few devops concepts I learn

## Resources

[Open source projects to contribute to](https://awesomeopensource.com/)

[How to fix dual boot problems](https://www.youtube.com/watch?v=gEB6JEYZekE)

[Use Logstash pipelines for parsing](https://www.elastic.co/guide/en/logstash/6.8/logstash-config-for-filebeat-modules.html)

[Difference between git log and git reflog](https://stackoverflow.com/questions/17857723/whats-the-difference-between-git-reflog-and-log)<br>

[How to write a good commit message git](https://chris.beams.io/posts/git-commit/)<br>

[Understanding the Git workflow](https://sandofsky.com/workflow/git-workflow/)

[Pro Git](https://git-scm.com/book/en/v2)

[Generating SSH keys for git](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)<br>

[Contribute to open source](https://www.youtube.com/watch?v=vSdSFxIKy5w&list=PLseEp7p6EwiZgLPknY4ITJxfoo75wqxph&index=5)<br>

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

[Install php8 for Apache and Nginx on Ubuntu](https://www.linode.com/docs/guides/install-php-8-for-apache-and-nginx-on-ubuntu/)<br>

[Import and export mariaDB database](https://www.digitalocean.com/community/tutorials/how-to-import-and-export-databases-in-mysql-or-mariadb)<br>

[How To Install and Use Docker on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)
<br>

[Getting started with Postgre using Docker compose](https://medium.com/analytics-vidhya/getting-started-with-postgresql-using-docker-compose-34d6b808c47c)<br>

[All about file permissions](https://www.linode.com/docs/guides/modify-file-permissions-with-chmod/)<br>

[More on file permissions](https://kb.iu.edu/d/abdb)<br>

[The easiest way to delete a block in a file using Vim/Vi](https://thecodingbot.com/the-easiest-way-to-delete-a-block-in-a-file-using-vim-vi)<br>

[A practical guide to logstash](https://coralogix.com/blog/a-practical-guide-to-logstash-syslog-deep-dive/)<br>


[HackerRank Interview Preparation Kit](https://www.hackerrank.com/interview/interview-preparation-kit)<br>

[Installing MariaDB on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-ubuntu-20-04)<br>

 ## Commands

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

`find . -type f -empty` - Look for an empty file inside the current directory.<br>

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

### About Git

`git reset --hard HEAD~1` - gets you back by one commit from the latest

`git remote add upstream repo.git` - add an upstream of the original in case you have forked a repo

# Sync your fork
```
git fetch upstream
git checkout master
git merge upstream/master
```
`git add -p` - always use this command instead of `git add .`

`git checkout -b ＜new-branch＞` - create and switch to new branch<br>

`git config --global credential.helper cache` - configure credential caching

`git config --global --unset credential.helper cache` - clear the access token from the local computer<br>

`git branch -vv` - check branch tracking activity<br>

`git push -u origin branch-name` - set upstream remote branch 

