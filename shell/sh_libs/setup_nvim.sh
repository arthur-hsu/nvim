#!/usr/bin/sh

git config --global credential.helper store
git config --global pull.rebase true
git config --global user.name "$USER"
git config --global user.email "$(hostname)"

rm -r ~/Bookshelf ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

mkdir -p nvim_deb

sudo apt-get update

sudo apt-get update
sudo apt-get install nodejs -y
sudo apt-get install npm -y

sudo npm install -g neovim yarn

sudo apt-get install -y ninja-build gettext cmake unzip curl bpytop python3-pip
sudo apt install -y ripgrep fd-find bat tldr xclip python3-venv

ver=$(python3 -V)
version=$(echo "$ver" | awk '{ match($0, /[0-9]+\.[0-9]+/); print substr($0, RSTART, RLENGTH) }')
sudo mv /usr/lib/python"$version"/EXTERNALLY-MANAGED /usr/lib/python"$version"/EXTERNALLY-MANAGED.bk

pip3 install neovim

curl -fsSL https://deno.land/install.sh | sh


