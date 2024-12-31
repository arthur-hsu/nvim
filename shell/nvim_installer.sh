#!/usr/bin/sh

user_password="$1"
system_=$(uname -m)

if [ "$system_" = 'aarch64' ]; then
    system_='arm64'
elif [ "$system_" = 'x86_64' ]; then
    system_='amd64'
fi
sudo mkdir -p /usr/local/share/man/man1
mkdir -p ~/.config/nvim/shell/nvim_deb

cd ~/.config/nvim/shell/nvim_deb || exit
# 获取当前目录下所有 neovim deb 文件的列表
files=$(ls -1 neovim_v*_"$system_".deb 2>/dev/null)
if [ -n "$files" ]; then
    latest_file=$( echo "$files" | sort -V | tail -n 1 )
    latest_pkg=$(echo "$latest_file" | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+')
else
    latest_pkg=""
fi

if [ ! -d "/tmp/neovim" ]; then
    git clone -b stable http://github.com/neovim/neovim --depth=1 /tmp/neovim
fi
cd /tmp/neovim || exit
LastTag=$(git describe --tags "$(git rev-list --tags --max-count=1)")

echo "LastTag: $LastTag"

if [ "$LastTag" = "$latest_pkg" ]; then
    echo "Use current deb file"
    cd ~/.config/nvim/shell/nvim_deb || exit
    sudo dpkg -i "$latest_file"
else
    echo "No neovim deb files found in the current directory."
    cd /tmp/neovim || exit
    echo "$user_password" | sudo -S apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip checkinstall

    make CMAKE_BUILD_TYPE=Release
    sudo make install
    echo -e "\r\n" | echo "$user_password" | sudo -S checkinstall
    version=$(ls | grep 'neovim_[0-9]*-[0-9]_'$system_'.deb' | sed -n 's/.*neovim_\([0-9]*-[0-9]\)_'$system_'.deb/\1/p')
    deb_file="neovim_${version}_$system_.deb"
    # echo "$user_password" | sudo -S dpkg -i "$deb_file"
    tag=$(git describe --tags --match "v*" --abbrev=0)
    sudo chown 1000:1000 "$deb_file"
    mv "$deb_file" ~/.config/nvim/shell/nvim_deb/neovim_"$tag"_"$system_".deb 
    echo "Install finish"
    cd ~/.config/nvim/shell/nvim_deb || exit
    if [ -n "$latest_pkg" ]; then
        rm "$latest_file"
    fi
fi

