return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    -- event = "VeryLazy",
    cmd = "Leet",
    dependencies = {
        -- include a picker of your choice, see picker section for more details
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        -- configuration goes here
        lang = "python3",
        cn = {
            enabled = true, ---@type boolean
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
                -- after = { "def test():", "    print('test')" },
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
