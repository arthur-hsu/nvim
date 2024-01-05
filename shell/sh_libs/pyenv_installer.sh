#!/usr/bin/bash
curl https://pyenv.run | bash
pyenv update
cat <<'EOF' | tee -a ~/.zshrc
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
source $(pyenv root)/completions/pyenv.zsh
EOF
