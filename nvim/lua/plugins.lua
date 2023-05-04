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
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
	{'nvim-lua/plenary.nvim'},
	{'jose-elias-alvarez/null-ls.nvim'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-path'},
	--Colors
	{ 'navarasu/onedark.nvim'},
	--IDE
	{ 'vim-airline/vim-airline'},
	{'nvim-telescope/telescope.nvim', tag = '0.1.1', },
	{'tpope/vim-surround'},
	{'vim-airline/vim-airline-themes'},
	{'jiangmiao/auto-pairs'},
	{'scrooloose/nerdtree'},
	{'Yggdroot/indentLine'},
	{'simrat39/rust-tools.nvim'},
	{'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate'},
	{'virchau13/tree-sitter-astro'},
	{'airblade/vim-gitgutter'},
	{'alvan/vim-closetag'},
	{'christoomey/vim-tmux-navigator'},
	{'lambdalisue/suda.vim'},
	{'preservim/nerdcommenter'},
	{'mhinz/vim-signify'},
	{'ThePrimeagen/harpoon'},
			--Godot
	{'habamax/vim-godot'},
			--Development
	{'MunifTanjim/prettier.nvim'},
	{'simrat39/rust-tools.nvim'},


  }
})


--colorscheme
require('onedark').setup({
	style= 'dark' ,
})
require('onedark').load()
