local leet_arg = "leet"
return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    -- event = "VeryLazy",
    lazy = leet_arg ~= vim.fn.argv(0, -1),
    cmd = "Leet",
    dependencies = {
        -- include a picker of your choice, see picker section for more details
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        -- configuration goes here
        arg = "leet",
        lang = "python3",
        cn = {
            enabled = false, ---@type boolean
            translator = true, ---@type boolean
            translate_problems = true, ---@type boolean
        },
        plugins = {
            non_standalone = true,
        },

        injector = { ---@type table<lc.lang, lc.inject>
            ["python3"] = {
                imports = function(default_imports)
                    vim.list_extend(default_imports, { "from .leetcode import *" })
                    return default_imports
                end,
                after = { "" },
            },
            ["cpp"] = {
                imports = function()
                    -- return a different list to omit default imports
                    return { "#include <bits/stdc++.h>", "using namespace std;" }
                end,
                after = "int main() {}",
            },
        },
    },
}
