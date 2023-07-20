# lazy_nvim
## Terminal字體設定
![image](https://github.com/aaa890177/nvim/assets/127286236/d813b1f6-4bf4-4355-991d-d02bd6061970)

下載連結: https://www.nerdfonts.com/font-downloads

下載完後安裝字體
  
Terminal字體換成帶有`NERD`的
  
比如 `JetBrainsMono Nerd font`

- Dependency
  `Nert font`, 
  `nodejs`, 
  `git`, 
  `pip install neovim`, 
  `npm install neovim`


- Ubuntu-mate Terminal color
```
dconf load /org/mate/terminal/ < mate-terminal-profile.bckp
```
and switch profile to ubuntu

- Set up
```shell
sudo apt install snapd curl git python3-pip software-properties-common
sudo snap install core
sudo snap install snap-store
sudo snap install nvim --classic
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
pip3 install pynvim neovim
npm install neovim
```

- On windows
```shell
cd
git clone https://github.com/aaa890177/lazy_nvim.git AppData/Local/nvim
```

- On linux
```shell
cd
git clone https://github.com/aaa890177/lazy_nvim.git .config/nvim
cd .config/nvim
sudo cp -r JetBrainsMono /usr/share/fonts
```
