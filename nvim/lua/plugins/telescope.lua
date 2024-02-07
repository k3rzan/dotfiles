local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--vim.cmd([[
--function!   QuickFixOpenAll()
--if empty(getqflist())
--return
--endif
--let s:prev_val = ""
--for d in getqflist()
--let s:curr_val = bufname(d.bufnr)
--if (s:curr_val != s:prev_val)
--exec "edit " . s:curr_val
--endif
--let s:prev_val = s:curr_val
--endfor
--endfunction
--]])
--vim.api.nvim_set_keymap('n', '<leader>ka' , ':call QuickFixOpenAll()<CR>', { noremap=true, silent=false })

-- custom function for getting neovim config files
local M = {}

M.find_config_files = function()
	require('telescope.builtin').find_files({
		prompt_title = "< VimRC >",
		cwd = "~/.config/nvim/",
	})
end

-- mappings for telescope

local actions = require('telescope.actions')
require('telescope').setup {
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
				["<C-o>"] = function(prompt_bufnr)
					require("telescope.actions").select_tab(prompt_bufnr)
					require("telescope.builtin").resume()
				end,

			},
			n = {
				["<leader>q"] = actions.close,
				["<leader>v"] = M.find_config_files,
			},
		}
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	}
}
