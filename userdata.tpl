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
sudo apt install libwww-perl -y

IP=$(curl checkip.amazonaws.com)

cd /home/ubuntu

touch index.html

echo '<h1>Hello i am the server with ip '$IP'</h1>' > index.html

docker run -v /home/ubuntu/index.html:/usr/share/nginx/html/index.html -p 80:80 -d nginx