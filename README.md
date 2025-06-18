# nvim
## Set up

```shell
git clone --depth=1 https://github.com/arthur-hsu/nvim.git ~/.config/nvim
cd .config/nvim/shell &&\
  chmod +x *.sh;./install.sh
```



---
## Terminal字體設定

下載連結: <https://www.nerdfonts.com/font-downloads>

下載完後安裝字體
  
Terminal字體換成帶有`NERD`的
  
比如 `JetBrainsMono Nerd font`


## Dependency
`Nert font`  
`nodejs`  
`git`  
`pip install neovim`  
`npm install neovim yarn`  




## Ubuntu


### Ubuntu-mate Terminal color
```shell
dconf load /org/mate/terminal/ < mate-terminal-profile.bckp
```
and switch profile to ubuntu




## windows

```sh
cd
git clone https://github.com/arthur-hsu/nvim.git AppData/Local/nvim
```
### setup
chocolatey install:<https://marcus116.blogspot.com/2019/02/chocolatey-windows-chocolatey.html>

```shell
choco install mingw ripgrep fd
```

### windows telescope
```
fb_actions.open = function(prompt_bufnr)
  local quiet = action_state.get_current_picker(prompt_bufnr).finder.quiet
  local selections = fb_utils.get_selected_files(prompt_bufnr, true)
  if vim.tbl_isempty(selections) then
    fb_utils.notify("actions.open", { msg = "No selection to be opened!", level = "INFO", quiet = quiet })
    return
  end

  local cmd = vim.fn.has "win32" == 1 and "start" or vim.fn.has "mac" == 1 and "open" or "xdg-open"
  if vim.fn.has "win32" == 1 then
      for _, selection in ipairs(selections) do
          vim.cmd(string.format('!start %s', selection:absolute()))
      end
  else
      for _, selection in ipairs(selections) do
        require("plenary.job")
          :new({
            command = cmd,
            args = { selection:absolute() },
          })
          :start()
      end
  end
  actions.close(prompt_bufnr)
end
```

