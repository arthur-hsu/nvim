# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
chmod +x get-docker.sh; ./get-docker.sh
rm get-docker.sh

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER                   # to add myself to docker group
sudo chgrp docker /usr/local/bin/docker-compose # to give docker-compose to docker group,
sudo chmod 750 /usr/local/bin/docker-compose    # to allow docker group users to execute install
echo "alias d='docker'" |tee -a ~/.zshrc
echo "alias dc='docker-compose'"| tee -a ~/.zshrc
echo "alias drmall='docker stop $(docker ps -q) ; docker rm $(docker ps -a -q); docker rmi -f $(docker images -q)'"| tee -a ~/.zshrc
