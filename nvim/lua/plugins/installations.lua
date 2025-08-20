local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
	print('Installing lazy.nvim....')
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
	{
		{
			"andweeb/presence.nvim",
			config = function()
				require("presence").setup({
					-- General options
					auto_update         = true,                  -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
					neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
					main_image          = "neovim",              -- Main image display (either "neovim" or "file")
					debounce_timeout    = 10,                    -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
					enable_line_number  = false,                 -- Displays the current line number instead of the current project
					blacklist           = {},                    -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
					file_assets         = {},                    -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
					show_time           = true,                  -- Show the timer

					-- Rich Presence text options
					editing_text        = "Editing %s",   -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
					file_explorer_text  = "Browsing %s",  -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
					plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
					reading_text        = "Reading %s",   -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
					workspace_text      = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
					line_number_text    = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
				})
			end
		},

		--Colors
		{
			'navarasu/onedark.nvim',
			lazy = false,
			priority = 1000,
			config = function()
				--colorscheme
				require('onedark').setup({
					style = 'cool',
				})
				require('onedark').load()
			end
		},
		--IDE
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				local dap, dapui = require("dap"), require("dapui")
				dap.adapters.codelldb = {
					type = "executable",
					command = "/home/bkerz/Downloads/codelldb/extension/adapter/codelldb",
				}
				dap.adapters.gdb = {
					type = "executable",
					command = "gdb",
					args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
				}
				dap.adapters.godot = {
					type = "executable",
					port = 6006,
				}
				dap.configurations.zig = { {
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input('Name of the executable: ', vim.fn.getcwd() .. '/zig-out/bin', 'file')
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
				}
				-- {
				-- 	name = "Select and attach to process",
				-- 	type = "gdb",
				-- 	request = "attach",
				-- 	program = function()
				-- 		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				-- 	end,
				-- 	pid = function()
				-- 		local name = vim.fn.input('Executable name (filter): ')
				-- 		return require("dap.utils").pick_process({ filter = name })
				-- 	end,
				-- 	cwd = '${workspaceFolder}'
				-- },
				-- {
				-- 	name = 'Attach to gdbserver :1234',
				-- 	type = 'gdb',
				-- 	request = 'attach',
				-- 	target = 'localhost:1234',
				-- 	program = function()
				-- 		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				-- 	end,
				-- 	cwd = '${workspaceFolder}'
				-- } }
				--
				-- dap.adapters.lldb = {
				-- 	type = 'executable',
				-- 	command = 'lldb',
				-- 	name = "lldb"
				-- }
				-- dap.adapters.codelldb = {
				-- 	type = 'server',
				-- 	port = "${port}",
				-- 	executable = {
				-- 		command = 'codelldb',
				-- 		args = { "--port", "${port}" },
				-- 	}
				-- }
				--
				-- -- dap.adapters.gdb = {
				-- -- 	type = "executable",
				-- -- 	command = "gdb",
				-- -- 	args = { "--interpreter=dap" },
				-- -- }
				-- dap.configurations.zig = {
				-- 	{
				-- 		name = "Launch Zig Program",
				-- 		type = "lldb",
				-- 		request = "launch",
				-- 		-- program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
				-- 		program = function()
				-- 			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				-- 		end,
				-- 		cwd = '${workspaceFolder}',
				-- 		stopOnEntry = false,
				-- 		args = {},
				-- 	}
				-- }
				-- dap.configurations.zig = {
				-- 	{
				-- 		name = "Launch Zig Program",
				-- 		type = "gdb",
				-- 		request = "launch",
				-- 		program = function()
				-- 			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				-- 		end,
				-- 		cwd = "${workspaceFolder}",
				-- 		stopAtEntry = true,  -- Stop at program entry
				-- 	}
				-- }
				-- dap.configurations.zig = {
				-- 	{
				-- 		name = "Launch file",
				-- 		type = "codelldb",
				-- 		request = "launch",
				-- 		program = "${workspaceFolder}/zig-out/bin/main",
				-- 		cwd = "${workspaceFolder}",
				-- 		stopOnEntry = false,
				-- 		args = {},
				-- 	},
				-- }
				-- dap.configurations.gdscript = {
				-- 	{
				-- 		type = "godot",
				-- 		request = "launch",
				-- 		name = "Launch scene",
				-- 		project = "${workspaceFolder}",
				-- 		scene = "${workspaceFolder}/addons/gut/GutScene.tscn",
				-- 		launch_scene = true,
				-- 	}
				-- }
				dapui.setup()
				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end
			end,
			dependencies = { "nvim-neotest/nvim-nio",
				{
					'mfussenegger/nvim-dap',
				},

			}
		},
		{
			"akinsho/toggleterm.nvim",
			config = function()
				require("toggleterm").setup()
			end

		},
		{
			"tpope/vim-fugitive"
		},
		{
			'numToStr/Comment.nvim',
			config = function()
				require('Comment').setup {
					pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
					mappings = false
				}
			end
		},
		-- { 'vim-airline/vim-airline' },
		-- { 'vim-airline/vim-airline-themes' },
		{
			'nvim-telescope/telescope.nvim',
			tag = '0.1.5',
			lazy = false,
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = function()
				require("plugins.telescope")
			end
		},
		{ 'tpope/vim-surround',       lazy = true },
		{
			'windwp/nvim-autopairs',
			config = function()
				require("nvim-autopairs").setup()
			end
		},
		{
			"nvim-tree/nvim-tree.lua",
			version = "*",
			lazy = false,
			dependencies = {
				"nvim-tree/nvim-web-devicons",
				commit = "313d9e7193354c5de7cdb1724f9e2d3f442780b0" -- this is temporal while wating for PR to fix weird errors
			},
			config = function()
				require("plugins.nvim-tree")
			end,
		},
		{ 'simrat39/rust-tools.nvim', ft = "rs" },
		{
			'nvim-treesitter/nvim-treesitter',
			dependencies = {
				'JoosepAlviste/nvim-ts-context-commentstring',
				config = function()
					require("plugins.ts-context-commentstring")
				end
			},
			config = function()
				require("plugins.treesitter")
			end
		},
		{ 'virchau13/tree-sitter-astro', ft = "astro" },
		{
			"windwp/nvim-ts-autotag",
			ft = {
				'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
				'rescript',
				'xml',
				'php',
				'markdown',
				'astro', 'glimmer', 'handlebars', 'hbs'
			},
		},
		{ 'lambdalisue/suda.vim',        lazy = true },
		{
			'lewis6991/gitsigns.nvim',
			config = function()
				require("gitsigns").setup()
			end
		},
		{
			"NeogitOrg/neogit",
			dependencies = {
				"nvim-lua/plenary.nvim", -- required
				"sindrets/diffview.nvim", -- optional - Diff integration

				-- Only one of these is needed.
				"nvim-telescope/telescope.nvim", -- optional
			},
			config = true
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local harpoon = require("harpoon")

				-- REQUIRED
				harpoon:setup()
				-- REQUIRED

				vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
				vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

				vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
				vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
				vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
				vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

				-- Toggle previous & next buffers stored within Harpoon list
				vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
				vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
			end


		},
		--Godot
		{
			'habamax/vim-godot',
			ft = "gdscript"
		},
		{
			dir = "~/.config/nvim/lua/plugins/mylspconfig/",
			name = "mylspconfig",
			config = function()
				require("plugins.mylspconfig").setup()
			end,
			dependencies = {
				require("plugins.colorful"),
				require("plugins.blink"),
			},
		},
		{
			'aaronik/treewalker.nvim',

			-- The following options are the defaults.
			-- Treewalker aims for sane defaults, so these are each individually optional,
			-- and setup() does not need to be called, so the whole opts block is optional as well.
			opts = {
				-- Whether to briefly highlight the node after jumping to it
				highlight = true,

				-- How long should above highlight last (in ms)
				highlight_duration = 250,

				-- The color of the above highlight. Must be a valid vim highlight group.
				-- (see :h highlight-group for options)
				highlight_group = 'CursorLine',

				-- Whether the plugin adds movements to the jumplist -- true | false | 'left'
				--  true: All movements more than 1 line are added to the jumplist. This is the default,
				--        and is meant to cover most use cases. It's modeled on how { and } natively add
				--        to the jumplist.
				--  false: Treewalker does not add to the jumplist at all
				--  "left": Treewalker only adds :Treewalker Left to the jumplist. This is usually the most
				--          likely one to be confusing, so it has its own mode.
				jumplist = true,
			}
		},
		{
			'nvim-telescope/telescope-project.nvim',
			dependencies = {
				'nvim-telescope/telescope.nvim',
			},
		},
		{
			dir = "~/.config/nvim/lua/plugins/search-replace/",
			name = "search-replace",
			config = function()
				require("plugins.search-replace").setup()
			end,
		},
	})
