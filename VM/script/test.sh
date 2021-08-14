yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
service docker start
sudo docker run  --rm --name nginx -d -p 80:80 nginx:latest

# firewall-cmd --permanent --add-port=80/tcp
# firewall-cmd --reload
# firewall-cmd --list-all
