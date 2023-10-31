#!/usr/bin/sh
rm -r ~/Bookshelf
hostname=$(hostname)
git config --global credential.helper store
git config --global user.name arthur
git config --global user.email $hostname
git config --global pull.rebase false

sudo cp -r ../JetBrainsMono /usr/share/fonts
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
cd ~/Documents
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=16
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
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

# echo $system_
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
sudo npm install neovim

sudo apt install -y zsh
# 安装 Oh My Zsh
echo 'y'| sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo 'export EDITOR="nvim"'                     | tee -a ~/.zshrc
echo 'alias nv="nvim"'                          | tee -a ~/.zshrc
echo 'alias vim="nvim"'                         | tee -a ~/.zshrc
echo 'alias vi="nvim"'                          | tee -a ~/.zshrc
echo 'alias nvi="nvim"'                         | tee -a ~/.zshrc
echo 'alias nvimrc="cd ~/.config/nvim"'         | tee -a ~/.zshrc
echo 'alias cat="batcat"'                       | tee -a ~/.zshrc
echo 'alias exa="exa --icons"'                  | tee -a ~/.zshrc
echo 'alias tre="exa --long --tree --level=3"'  | tee -a ~/.zshrc
echo 'alias ls="exa -s type"'                   | tee -a ~/.zshrc
echo 'alias ll="exa -all -l"'                   | tee -a ~/.zshrc
echo 'alias d="docker"'                         | tee -a ~/.zshrc
echo 'alias fd="fdfind"'                        | tee -a ~/.zshrc
echo 'alias top="bpytop"'                       | tee -a ~/.zshrc

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo)/g' ~/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

cd ~/.config/nvim/shell/
cp .p10k.zsh ~
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' | tee -a ~/.zshrc
sudo apt-get install -y expect
chmod +x change_shell.exp ; ./change_shell.exp
zsh
