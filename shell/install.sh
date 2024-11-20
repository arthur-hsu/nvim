#!/usr/bin/sh
lxterminal_config_folder=~/.config/lxterminal

# 检查文件夹是否存在
if [ ! -d "$lxterminal_config_folder" ]; then
    # 如果不存在，则创建文件夹
    mkdir -p "$lxterminal_config_folder"
fi
cp ./sh_libs/lxterminal.conf ~/.config/lxterminal/lxterminal.conf
dconf load /org/gnome/terminal/legacy/profiles:/ < ./sh_libs/gnome-terminal.conf

printf "Enter password: "
stty -echo
read user_password
stty echo

if [ "$#" -gt 0 ]; then
    # 如果有参数，则执行相应的操作，这里是一个示例函数
    echo "Install deskpi"
    sudo ./sh_libs/deskpi.sh
fi

debian_version=$(cat /etc/debian_version)
echo "debian_version: $debian_version"
case "$debian_version" in
    12*)
        ver=$(python3 -V)
        version=$(echo "$ver" | awk '{ match($0, /[0-9]+\.[0-9]+/); print substr($0, RSTART, RLENGTH) }')
        sudo mv /usr/lib/python"$version"/EXTERNALLY-MANAGED /usr/lib/python"$version"/EXTERNALLY-MANAGED.bk
        ;;
esac



./sh_libs/setup_nvim.sh
./nvim_installer.sh "$user_password"

./sh_libs/setup_zsh.sh
./sh_libs/pyenv_installer.sh
sudo apt-get install -y expect
chmod +x change_shell.exp ; ./change_shell.exp "$user_password"

# greetings and require rebooting system to take effect.
echo "System will reboot in 3 seconds to take effect." 
sudo sync
sleep 3 
sudo reboot



