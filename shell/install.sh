#!/usr/bin/sh
cp ./sh_libs/lxterminal.conf ~/.config/lxterminal/lxterminal.conf
printf "Enter password: "
stty -echo
read user_password
stty echo

if [ "$#" -gt 0 ]; then
    # 如果有参数，则执行相应的操作，这里是一个示例函数
    echo "Install deskpi"
    ./sh_libs/deskpi.sh
fi

debian_version=$(cat /etc/debian_version)
case "$debian_version" in
    12*)
        ver=$(python -V)
        version=$(echo "$ver" | awk '{ match($0, /[0-9]+\.[0-9]+/); print substr($0, RSTART, RLENGTH) }')
        sudo mv /usr/lib/python"$version"/EXTERNALLY-MANAGED /usr/lib/python"$version"/EXTERNALLY-MANAGED.bk
        ;;
esac


./sh_libs/setup_nvim.sh "$user_password"
./sh_libs/setup_zsh.sh
sudo apt-get install -y expect
chmod +x change_shell.exp ; ./change_shell.exp "$user_password"
# greetings and require rebooting system to take effect.
log_action_msg "System will reboot in 3 seconds to take effect." 
sudo sync
sleep 3 
sudo reboot



