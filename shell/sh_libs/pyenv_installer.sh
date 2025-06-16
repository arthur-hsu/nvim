#!/usr/bin/env bash
curl https://pyenv.run | bash
pyenv update
cat <<'EOF' | tee -a ~/.zshrc
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
source $(pyenv root)/completions/pyenv.zsh
EOF

# # Check if ~/.zprofile exists. If not, create it.
# if [ ! -f ~/.zprofile ]; then
#     touch ~/.zprofile
# fi
#
# # Append/Update PATH and pyenv init command to ~/.zprofile
# cat <<'EOF' | tee -a ~/.zprofile
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init --path)"
# EOF
