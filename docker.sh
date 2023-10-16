#curl -fsSL https://get.docker.com -o get-docker.sh
#chmod +x get-docker.sh; ./get-docker.sh
sudo apt install add-apt-repository docker-compose-plugin -y
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go -y
go get github.com/jesseduffield/lazydocker
