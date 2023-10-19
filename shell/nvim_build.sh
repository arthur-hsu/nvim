sudo apt-get install -y ninja-build gettext cmake unzip curl bpytop;
sudo apt install -y ripgrep fd-find bat tldr exa xclip
git clone https://github.com/neovim/neovim --depth=1 /tmp/neovim;
cd /tmp/neovim;
git checkout stable;
make CMAKE_BUILD_TYPE=RelWithDebInfo;
sudo make install
