sudo apt install -y zsh
# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 将 Zsh 设置为默认 Shell
chsh -s $(which zsh)
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo 'export EDITOR="nvim"' |tee -a ~/.zshrc | tee -a ~/.zshrc
echo 'alias nv="nvim"' | tee -a ~/.zshrc
echo 'alias vim="nvim"' | tee -a ~/.zshrc
echo 'alias vi="nvim"' | tee -a ~/.zshrc
echo 'alias nvi="nvim"' | tee -a ~/.zshrc
echo 'alias nvimrc="cd ~/.config/nvim"' | tee -a ~/.zshrc
echo 'alias cat="batcat"' | tee -a ~/.zshrc
echo 'alias exa="exa --icons"' | tee -a ~/.zshrc
echo 'alias tre="exa --long --tree --level=3"' | tee -a ~/.zshrc
echo 'alias ls="exa -s type"' | tee -a ~/.zshrc
echo 'alias ll="exa -all -l"' | tee -a ~/.zshrc
echo 'alias d="docker"' | tee -a ~/.zshrc
echo 'alias dc="docker-compose"' | tee -a ~/.zshrc
echo 'alias drmall="#docker stop $(docker ps -a -q) ; #docker rm -f $(docker ps -a -q); docker rmi -f $(docker images -q)"' | tee -a ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo)/g' ~/.zshrc

original="ZSH_THEME=\".*\""
new="ZSH_THEME=\"powerlevel10k/powerlevel10k\""
# 检查.zshrc文件是否存在，如果存在则进行替换操作
if [ -f ~/.zshrc ]; then
    # 使用sed命令将ZSH_THEME更改为新值
    sed -i '' -E "s/$original/$new/" ~/.zshrc
    echo "ZSH_THEME updated to powerlevel10k/powerlevel10k in .zshrc"
else
    echo "File ~/.zshrc not found. Please make sure the file exists."
fi
