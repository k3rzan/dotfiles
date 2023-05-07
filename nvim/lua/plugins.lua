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

		--Colors
		{
			'navarasu/onedark.nvim',
			lazy = false,
			priority = 1000,
			config = function()
				--colorscheme
				require('onedark').setup({
					style = 'dark',
				})
				require('onedark').load()
			end
		},

		{ 'nvim-lua/plenary.nvim',           lazy = true },
		{ 'jose-elias-alvarez/null-ls.nvim', lazy = true },
		--IDE
		{
			'numToStr/Comment.nvim',
			config = function()
				require('Comment').setup {
					pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
					mappings = false
				}
			end
		},
		{ 'vim-airline/vim-airline' },
		{ 'vim-airline/vim-airline-themes' },
		{ 'nvim-telescope/telescope.nvim', tag = '0.1.1', lazy = true },
		{ 'tpope/vim-surround',            lazy = true },
		{ 'jiangmiao/auto-pairs' },
		{
			'scrooloose/nerdtree',
		},
		{ 'Yggdroot/indentLine' },
		{ 'simrat39/rust-tools.nvim', ft = "rs" },
		{
			'nvim-treesitter/nvim-treesitter',
			dependencies = {
				'JoosepAlviste/nvim-ts-context-commentstring',
			},
			config = function()
				require('nvim-treesitter.configs').setup {
					-- Install the parsers for the languages you want to comment in
					-- Here are the supported languages:
					ensure_installed = {
						'astro', 'css', 'html', 'javascript',
						'lua', 'tsx',
						'typescript', 'vim',
					},

					context_commentstring = {
						enable = true,
					},
				}
			end
		},
		{ 'virchau13/tree-sitter-astro', ft = "astro" },
		{ 'airblade/vim-gitgutter' },
		{
			'alvan/vim-closetag',
			ft = { "typescriptreact", "javascriptreact", "javascript", "jsx",
				"tsx" }
		},
		{ 'christoomey/vim-tmux-navigator' },
		{ 'lambdalisue/suda.vim',          lazy = true },
		{ 'mhinz/vim-signify',             lazy = true },
		{ 'ThePrimeagen/harpoon',          lazy = true },
		--Godot
		{ 'habamax/vim-godot',             ft = "gd" },
		--Development
		{
			'MunifTanjim/prettier.nvim',
			ft = { "javascript", "javascriptreact", "typescriptreact", "typescript", "jsx", "tsx",
				"html", "css", "md" }
		},
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

		-- LSP
		{
			'neovim/nvim-lspconfig',
			cmd = 'LspInfo',
			event = { 'BufReadPre', 'BufNewFile' },
			dependencies = {
				{ 'hrsh7th/cmp-nvim-lsp' },
				{ 'williamboman/mason-lspconfig.nvim' },
				{
					'williamboman/mason.nvim',
					build = function()
						pcall(vim.cmd, 'MasonUpdate')
					end,
				},
			},
			config = function()
				-- This is where all the LSP shenanigans will live

				local lsp = require('lsp-zero')

				lsp.on_attach(function(client, bufnr)
					lsp.default_keymaps({ buffer = bufnr })
				end)

				-- (Optional) Configure lua language server for neovim
				require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

				lsp.setup()
			end
		}

	})
