yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
service docker start
sudo docker run  --rm --name nginx -d -p 80:80 nginx:latest

sudo su -
mkdir monitor && cd monitor
echo "#!/bin/bash" >> monitor_docker.sh
echo "date >> /root/monitor/monitor.log" >> monitor_docker.sh
echo "docker stats --no-stream >> /root/monitor/monitor.log" >> monitor_docker.sh
chmod 755 monitor_docker.sh

echo "#!/bin/bash" >> schedule_monitor.sh
echo "for((i=1;i<=10;i++));do" >> schedule_monitor.sh
echo "/root/monitor/monitor_docker.sh 2>/dev/null &" >> schedule_monitor.sh
echo "sleep 10" >> schedule_monitor.sh
echo "done" >> schedule_monitor.sh
chmod 755 schedule_monitor.sh

echo "* * * * * /root/monitor/schedule_monitor.sh" >> /var/spool/cron/root

# firewall-cmd --permanent --add-port=80/tcp
# firewall-cmd --reload
# firewall-cmd --list-all
