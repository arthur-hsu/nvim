#!/usr/bin/sh
# cp ./sh_libs/lxterminal.conf ~/.config/lxterminal/lxterminal.conf
printf "Enter password: "
stty -echo
read user_password
stty echo
./sh_libs/setup_nvim.sh "$user_password"
./sh_libs/setup_zsh.sh
sudo apt-get install -y expect
chmod +x change_shell.exp ; ./change_shell.exp "$user_password"
zsh
