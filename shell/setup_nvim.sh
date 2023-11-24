#!/usr/bin/sh
git config --global credential.helper store
git config --global user.name "$USER"
git config --global user.email "$(hostname)"
git config --global pull.rebase true

rm -r ~/Bookshelf

sudo cp -r ../JetBrainsMono /usr/share/fonts
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

cd ~/.config/nvim/shell/
system_=$(uname -m)

if [ "$system_" = 'aarch64' ]; then
    system_='arm64'
elif [ "$system_" = 'x86_64' ]; then
    system_='amd64'
fi

# 获取具体的版本号（这里假设版本号在文件名中）
version=$(ls | grep 'neovim_[0-9]*-[0-9]_'$system_'.deb' | sed -n 's/.*neovim_\([0-9]*-[0-9]\)_'$system_'.deb/\1/p' | tail -n 1)
# echo $version
if [ -n "$version" ]; then
    # 拼接正确的文件名
    deb_file="neovim_${version}_$system_.deb"
    # 尝试安装对应的 .deb 文件
    sudo dpkg -i "$deb_file"
else
    echo "No matching .deb package found for the current system architecture: $system_"
    echo "Build neovim"
    sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip checkinstall
    git clone -b stable http://github.com/neovim/neovim --depth=1 /tmp/neovim;
    cd /tmp/neovim
    make CMAKE_BUILD_TYPE=Release
    echo -e "\r\n" | sudo checkinstall
    version=$(ls | grep 'neovim_[0-9]*-[0-9]_'$system_'.deb' | sed -n 's/.*neovim_\([0-9]*-[0-9]\)_'$system_'.deb/\1/p')
    deb_file="neovim_${version}_$system_.deb"
    sudo dpkg -i "$deb_file"
    cp $deb_file ~/.config/nvim/shell/
    echo "Install finish"
fi


sudo pip3 install neovim
cd ~/Documents/ &&\
    sudo npm install neovim
