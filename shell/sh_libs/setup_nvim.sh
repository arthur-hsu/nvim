#!/usr/bin/sh

git config --global credential.helper store
git config --global pull.rebase true
git config --global user.name "$USER"
git config --global user.email "$(hostname)"

rm -r ~/Bookshelf ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

mkdir -p nvim_deb

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
cd ~/Documents                                                                                                                                                         && \
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg                                          && \
NODE_MAJOR=18                                                                                                                                                          && \
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list && \
cd - || exit

sudo apt-get update
sudo apt-get install nodejs -y
sudo apt-get install npm -y
cd ~/Documents/ &&\
    npm install neovim
cd - || exit

sudo apt-get install -y ninja-build gettext cmake unzip curl bpytop python3-pip
sudo apt install -y ripgrep fd-find bat tldr xclip python3-venv

pip3 install neovim





