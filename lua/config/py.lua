local pylance_cmd =vim.fn.expand("~/.vscode/extensions/ms-python.vscode-pylance-*/dist/server.bundle.js")

local lspconfig = require('lspconfig')
local pylance = require('pylance')

pylance.setup()
lspconfig.pylance.setup({
  -- https://github.com/microsoft/pylance-release#settings-and-customization
  settings = {
    python = {
      analysis = {
        indexing = true,
        typeCheckingMode = 'basic',
      }
    }
  }
})



--local lspconfig = require('lspconfig')
--lspconfig.pylance.setup{
    --cmd = { pylance_cmd, "--stdio" },
    --on_attach = function(client, bufnr)
        -----
        ----- 自定义的一些设置
    --end
--}
