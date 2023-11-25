#!/usr/bin/sh


user_password="$1"
system_=$(uname -m)

if [ "$system_" = 'aarch64' ]; then
    system_='arm64'
elif [ "$system_" = 'x86_64' ]; then
    system_='amd64'
fi

cd ~/.config/nvim/shell/nvim_deb
# 获取当前目录下所有 neovim deb 文件的列表
files=$(ls -1 neovim_v*_"$system_".deb 2>/dev/null)

if [ -n "$files" ]; then
    latest_file=$(echo "$files" | sort -V | tail -n 1)
    sudo dpkg -i "$latest_file"
else
    echo "No neovim deb files found in the current directory."
    sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip checkinstall
    git clone -b stable http://github.com/neovim/neovim --depth=1 /tmp/neovim
    cd /tmp/neovim
    # latest_tag=$(git describe --tags --match "v*" --abbrev=0)
    make CMAKE_BUILD_TYPE=Release
    echo -e "\r\n" | echo "$user_password" | sudo -S checkinstall
    version=$(ls | grep 'neovim_[0-9]*-[0-9]_'$system_'.deb' | sed -n 's/.*neovim_\([0-9]*-[0-9]\)_'$system_'.deb/\1/p')
    deb_file="neovim_${version}_$system_.deb"
    sudo dpkg -i "$deb_file"
    tag=$(git describe --tags --match "v*" --abbrev=0)
    mv "$deb_file" ~/.config/nvim/shell/nvim_deb/neovim_"$tag"_"$system_".deb 
    echo "Install finish"
fi

