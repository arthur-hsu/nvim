
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
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
echo 'alias fd="fdfind"' | tee -a ~/.zshrc
echo 'alias top="bpytop"' | tee -a ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo)/g' ~/.zshrc
sed -i  's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
cp .p10k.zsh ~
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' | tee -a ~/.zshrc
chsh -s $(which zsh)
