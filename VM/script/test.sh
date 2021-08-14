yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
service docker start
#sudo docker run  --rm --name nginx -d -p 80:80 nginx:latest

#nginx and health
echo \
"FROM nginx
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=5s --timeout=3s \
  CMD curl -fs http://localhost/ || exit 1" > ~/Dockerfile

docker build -t nginx:v1 .
docker run -d --name nginx -p 80:80 nginx:v1


# sudo su -
# mkdir monitor && cd monitor
# echo "#!/bin/bash" >> monitor_docker.sh
# echo "date >> /root/monitor/monitor.log" >> monitor_docker.sh
# echo "docker stats --no-stream >> /root/monitor/monitor.log" >> monitor_docker.sh
# chmod 755 monitor_docker.sh
#
# echo "#!/bin/bash" >> schedule_monitor.sh
# echo "for((i=1;i<=10;i++));do" >> schedule_monitor.sh
# echo "/root/monitor/monitor_docker.sh 2>/dev/null &" >> schedule_monitor.sh
# echo "sleep 10" >> schedule_monitor.sh
# echo "done" >> schedule_monitor.sh
# chmod 755 schedule_monitor.sh
#
# echo "* * * * * /root/monitor/schedule_monitor.sh" >> /var/spool/cron/root

#monitor_docker
docker run -d -p 9104:9104 -v /sys/fs/cgroup:/cgroup -v /var/run/docker.sock:/var/run/docker.sock prom/container-exporter

docker run  -d -p 9090:9090 -v /root/prometheus.yml:/etc/prometheus/prometheus.yml --name prometheus prom/prometheus --config.file=/etc/prometheus/prometheus.yml

echo \
"global:
  scrape_interval:     10s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 10s # Evaluate rules every 15 seconds. The default is every 1 minute.
  external_labels:
      monitor: 'codelab-monitor'
rule_files:
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'docker'
    static_configs:
      - targets: ['localhost:9104']" > /root/prometheus.yml

docker run -d -p 3000:3000 --name grafana grafana/grafana:6.5.0
