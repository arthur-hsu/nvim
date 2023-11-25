#!/usr/bin/sh


git config --global credential.helper store
git config --global user.name "$USER"
git config --global user.email "$(hostname)"
git config --global pull.rebase true

rm -r ~/Bookshelf

sudo cp -r ./JetBrainsMono /usr/share/fonts
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
cd ~/Documents&&\
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg&&\
NODE_MAJOR=16&&\
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list&&\
sudo apt-get update&&\
sudo apt-get install nodejs -y


sudo apt-get install -y ninja-build gettext cmake unzip curl bpytop;
sudo apt install -y ripgrep fd-find bat tldr exa xclip


sudo pip3 install neovim
cd ~/Documents/ &&\
    sudo npm install neovim

user_password="$1"
./sh_libs/nvim_install.sh "$user_password"




