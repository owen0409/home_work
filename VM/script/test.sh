#docker install
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
service docker start
sleep 10
#sudo docker run  --rm --name nginx -d -p 80:80 nginx:latest

#nginx and health
echo \
"FROM nginx
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=5s --timeout=3s CMD curl -fs http://localhost/ || exit 1" > /root/Dockerfile
cd ~ && docker build -t nginx:v1 -f /root/Dockerfile . > build.log
docker run -d --name nginx -p 80:80 nginx:v1 > start.log


#monitor_docker
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
docker run -d -p 9104:9104 -v /sys/fs/cgroup:/cgroup -v /var/run/docker.sock:/var/run/docker.sock prom/container-exporter
docker run  -d -p 9090:9090 -v /root/prometheus.yml:/etc/prometheus/prometheus.yml --name prometheus prom/prometheus --config.file=/etc/prometheus/prometheus.yml
docker run -d -p 3000:3000 --name grafana grafana/grafana:6.5.0
