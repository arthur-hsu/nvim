#!/usr/bin/sh
sudo apt update
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

sudo apt install -y zsh
# 安装 Oh My Zsh
echo 'y'| sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cat <<'EOF' | sudo tee -a ~/.zshrc
export EDITOR="nvim"

alias nv="nvim"
alias vim="nvim"
alias vi="nvim"
alias nvi="nvim"
alias nvimrc="cd ~/.config/nvim"
alias cat="batcat --style=plain"

alias fd="fdfind -i"
alias rg="rg --ignore-case"

alias eza="eza --icons"
alias tre="eza --long --tree --level=3 --ignore-glob='__pycache__'"
alias ls="eza -s type"
alias l="eza -s type -l --ignore-glob='__pycache__'"
alias ll="eza -all -l -s type --ignore-glob='__pycache__'"
alias top="bpytop"
alias d="docker"
alias dc="docker-compose"
alias minicom="minicom -O timestamp=extended"

tre() {
    # 基礎命令陣列
    local -a args=('eza' '--long' '--tree' '--level=3' '--ignore-glob=__pycache__')

    # 檢查第一個參數是否為 "-a" 或 "--all"
    if [[ "$1" != "-a" && "$1" != "--all" ]]; then
        # 如果不是，就加上簡化輸出的參數
        args+=(--no-permissions --no-filesize --no-user --no-time)
    fi

    # 執行組合好的命令，並傳遞所有原始參數
    "${args[@]}" "$@"
}

activate() {
    pyenv activate "$1"
    export pypath=$(pyenv which python)
}
ifip() {
    ifconfig | awk 'BEGIN { iface="" } /^[a-z]/ { iface=$1 } /inet / { print iface "\n" $0 "\n" }'
}

EOF

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

sed -i '/^plugins=(git)$/c\
plugins=(\
    git\
    git-auto-fetch\
    zsh-syntax-highlighting\
    zsh-autosuggestions\
    sudo\
    asdf\
    docker\
    docker-compose\
    fzf\
)' ~/.zshrc

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
# sed -i 's/# ENABLE_CORRECTION="true"/ENABLE_CORRECTION="true"/' ~/.zshrc # 啟用自动纠正命令
cp ~/.config/nvim/shell/sh_libs/.p10k.zsh ~

cat <<'EOF' | sudo tee -a ~/.zshrc
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/sbin
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
EOF
