return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("nvim-dap-virtual-text").setup({
				-- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
				display_callback = function(variable)
					local name = string.lower(variable.name)
					local value = string.lower(variable.value)
					if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
						return "*****"
					end

					if #variable.value > 15 then
						return " " .. string.sub(variable.value, 1, 15) .. "... "
					end

					return " " .. variable.value
				end,
			})
			vim.fn.sign_define("DapBreakpoint", { text = "🔵", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapConditionalBreakpoint", { text = "🟡", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })
			local dap = require("dap")
			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)
			-- keymaps
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		opts = {
			-- layouts = {
			-- 	{
			-- 		elements = {
			-- 			{ id = "console", size = 0.5 },
			-- 			{ id = "repl", size = 0.5 },
			-- 		},
			-- 		position = "left",
			-- 		size = 50,
			-- 	},
			-- 	{
			-- 		elements = {
			-- 			{ id = "scopes", size = 0.50 },
			-- 			{ id = "breakpoints", size = 0.20 },
			-- 			{ id = "stacks", size = 0.15 },
			-- 			{ id = "watches", size = 0.15 },
			-- 		},
			-- 		position = "bottom",
			-- 		size = 15,
			-- 	},
			-- },
		},
		config = function(opts)
			require("dapui").setup(opts)

			-- local listener = require("dap").listeners
			-- listener.after.event_initialized["dapui_config"] = function()
			-- 	require("dapui").open()
			-- end
			-- listener.before.event_terminated["dapui_config"] = function()
			-- 	require("dapui").close()
			-- end
			-- listener.before.event_exited["dapui_config"] = function()
			-- 	require("dapui").close()
			-- end
			vim.keymap.set("n", "<localleader>T", function()
				require("dapui").toggle()
			end, { desc = "Toggle DAP UI" })
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		lazy = true,
        event = "VeryLazy",
		dependencies = { "rcarriga/nvim-dap-ui" },
		config = function()
			-- local debugpyPythonPath = require("mason-registry").get_package("debugpy"):get_install_path()
			-- 	.. "/venv/bin/python3"
			local debugpyPythonPath = vim.fn.system("which python"):gsub("%s+$", "")
			print("Debugpy Python Path: " .. debugpyPythonPath)

			require("dap-python").setup(debugpyPythonPath, {})
		end,
	},
}
