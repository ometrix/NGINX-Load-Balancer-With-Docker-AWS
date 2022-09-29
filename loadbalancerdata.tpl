#! /bin/bash -xe

exec > >(tee /var/log/userdata.log|logger -t userdata -s 2>/dev/console) 2>&1

sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ubuntu
sudo apt-get install libwww-perl git -y

cd /home/ubuntu

# git clone https://github.com/ometrix/NGINX-Load-Balancer-With-Docker-AWS.git

docker run -v /home/ubuntu/NGINX-Load-Balancer-With-Docker-AWS/default.conf:/etc/nginx/conf.d/default.conf -p 80:80 -d nginx