#! /bin/bash
sudo yum install git -y
if [ $? -ne 0 ]; then
  echo "git not installed"
  exit 1
fi
mkdir /tmp/sentry
cd /tmp/sentry
git clone https://github.com/AshutoshJha786/onpremise.git
if [ $? -ne 0 ]; then
  echo "repository not cloned"
   exit 1
fi
cd onpremise
#sudo yum install docker -y
#sudo service docker start
sh docker_install.sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
export SKIP_USER_PROMPT=1
./install.sh
if [ $? -ne 0 ]; then
 echo "script failed"
 exit 1
fi
sudo docker-compose up -d
