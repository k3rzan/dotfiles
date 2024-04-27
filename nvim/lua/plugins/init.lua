require("plugins.installations")

local replace_to_prompt = "with: "
local replace_from_global_prompt = "Replace all: "
local replace_from_line_prompt = "Replace in line: "

-- TODO: hightlight text that I'm going to replace as I type
-- TODO: replace as I type in the prompt

-- abstract replace logic in a function to reuse it for many cases
function build_replacer(from_prompt, to_prompt, replacer_callback)
	-- vim.ui.input is the method to use to get prompt text
	 vim.ui.input({prompt = from_prompt}, function(old_text)
	-- clear prompt
			vim.cmd "normal! :"
			vim.ui.input({prompt = to_prompt}, function(new_text)
				vim.cmd "normal! :"
				replacer_callback(old_text, new_text)
			end)
		end)
end
-- replace all ocurrences in a file
vim.api.nvim_create_user_command('ReplaceGlobal', function()
	build_replacer(replace_from_global_prompt, replace_to_prompt, function(old_text, new_text)
			vim.cmd([[%s/]] .. old_text .. [[/]] .. new_text .. [[/g]])
	end)
end, {})

-- replace all ocurrences in a line
vim.api.nvim_create_user_command('ReplaceInLine', function()
	build_replacer(replace_from_line_prompt, replace_to_prompt, function(old_text, new_text)
			vim.cmd([[.s/]] .. old_text .. [[/]] .. new_text .. [[/g]])
	end)
end, {})
