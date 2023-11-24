#!/usr/bin/sh

printf "Enter password: "
stty -echo
read user_password
stty echo

./setup_nvim.sh
./setup_zsh.sh
sudo apt-get install -y expect
chmod +x change_shell.exp ; ./change_shell.exp "$user_password"
zsh
