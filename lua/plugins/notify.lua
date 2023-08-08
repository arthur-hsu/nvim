local M ={
    "rcarriga/nvim-notify",
    event="VeryLazy",
}


function M.config()
    require("notify").setup({
        --background_colour = "NotifyBackground",
        --fps = 60,
        --icons = {
            --DEBUG = "",
            --ERROR = "",
            --INFO = "",
            --TRACE = "✎",
            --WARN = ""
        --},
        --level = 2,
        --minimum_width = 50,
        --render = "default",
        --stages = "fade_in_slide_out",
        timeout = 1000,
      t --top_down = true
    })
end
return M

