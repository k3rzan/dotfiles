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
		{
			"mhartington/formatter.nvim",
			config = function()
				require("formatter").setup({
					filetype = {
						javascript = { require("formatter.filetypes.javascript").biome },
						javascriptreact = { require("formatter.filetypes.javascriptreact").biome },
						typescript = { require("formatter.filetypes.typescript").biome },
						typescriptreact = { require("formatter.filetypes.typescriptreact").biome },
					},
				})
			end,
		},
		--IDE
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				local dap, dapui = require("dap"), require("dapui")
				dap.adapters.godot = {
					type = "server",
					host = '127.0.0.1',
					port = 6006,
				}
				dap.configurations.gdscript = {
					{
						type = "godot",
						request = "launch",
						name = "Launch scene",
						project = "${workspaceFolder}",
						scene = "${workspaceFolder}/addons/gut/GutScene.tscn",
						launch_scene = true,
					}
				}
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
		{ 'virchau13/tree-sitter-astro',   ft = "astro" },
		{ 'christoomey/vim-tmux-navigator' },
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
		{ 'lambdalisue/suda.vim', lazy = true },
		{ 'mhinz/vim-signify', },
		{
			'ThePrimeagen/harpoon',
			config = function()
				require("plugins.harpoon")
			end
		},
		--Godot
		{
			'habamax/vim-godot',
			ft = "gdscript"
		},
		--Development
		{ 'simrat39/rust-tools.nvim', ft = { "rs" } },
		{
			'VonHeikemen/lsp-zero.nvim',
			branch = 'v2.x',
			lazy = true,
			config = function()
				-- This is where you modify the settings for lsp-zero
				-- Note: autocompletion settings will not take effect

				require('lsp-zero.settings').preset({})
			end
		},

		-- Autocompletion
		{
			'hrsh7th/nvim-cmp',
			event = 'InsertEnter',
			dependencies = {
				{ 'L3MON4D3/LuaSnip' },
			},
			config = function()
				-- Here is where you configure the autocompletion settings.
				-- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
				-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

				require('lsp-zero.cmp').extend()

				-- And you can configure cmp even more, if you want to.
				local cmp = require('cmp')
				-- local cmp_action = require('lsp-zero.cmp').action()

				--cmp.setup({
				--		mapping = {
				--			['<C-Space>'] = cmp.mapping.complete(),
				--			['<C-f>'] = cmp_action.luasnip_jump_forward(),
				--			['<C-b>'] = cmp_action.luasnip_jump_backward(),
				--		}
				--	})
				cmp.setup({})
			end
		},
		-- { 'williamboman/mason-lspconfig.nvim' },
		-- {
		-- 	'williamboman/mason.nvim',
		-- 	build = function()
		-- 		pcall(vim.cmd, 'MasonUpdate')
		-- 	end,
		-- },

		-- LSP
		{
			'neovim/nvim-lspconfig',
			cmd = 'LspInfo',
			event = { 'BufReadPre', 'BufNewFile' },
			dependencies = {
				{ 'hrsh7th/cmp-nvim-lsp' },
				{ 'hrsh7th/cmp-buffer' },
			},
			config = function()
				-- This is where all the LSP shenanigans will live

				local lspconfig = require('lspconfig')
				local lsp = require('lsp-zero')

				lsp.on_attach(function(client, bufnr)
					lsp.default_keymaps({ buffer = bufnr })
				end)

				-- (Optional) Configure lua language server for neovim
				lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
				lspconfig.gdscript.setup {
					flags = {
						debounce_text_changes = 150,
					}
				}
				lspconfig.biome.setup {}
				lspconfig.rust_analyzer.setup {}
				lspconfig.nil_ls.setup {}
				lspconfig.clangd.setup {}

				lsp.setup()
			end
		}

	})
