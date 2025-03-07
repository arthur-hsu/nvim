
local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local conf         = require("telescope.config").values
local actions      = require "telescope.actions"
local action_state = require "telescope.actions.state"


-- to execute the function
-- colors()
-- vim.api.nvim_win_set_option(0, 'relativenumber', false)
local function printTable(tbl, indent)
	indent = indent or 0
	local indentStr = string.rep("  ", indent) -- 用來縮進輸出

	for k, v in pairs(tbl) do
		if type(v) == "table" then
			print(indentStr .. tostring(k) .. " = {")
			printTable(v, indent + 1) -- 遞迴列印子表
			print(indentStr .. "}")
		else
			print(indentStr .. tostring(k) .. " = " .. tostring(v))
		end
	end
end

local prompts = require("CopilotChat").prompts()

local options = {}
local target_names = { Commit = true, CommitStaged = true }

for key, value in pairs(prompts) do
	if target_names[key] then
		table.insert(options, key)
	end
end

local CommitChoice = function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Commit",
			finder = finders.new_table({
				results = options,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					local choice = selection[1]
                    local select = require('CopilotChat.select')

                    -- printTable(choice)
					if choice ~= nil then
                        local config = prompts[choice]
                        config.headless = false
						require("CopilotChat").ask(config.prompt, config)
					end
				end)
				return true
			end,
		})
		:find()
end

-- Snacks.input.input({
--     prompt = "Enter your name",
--     completion = true,
-- }, function (result)
--     vim.notify("Got response: " .. result)
-- end)

CommitChoice(require("telescope.themes").get_dropdown({}))
