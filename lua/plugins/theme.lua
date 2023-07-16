return {
  {
    "nvimdev/zephyr-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme zephyr]])
    end,
  },
}
