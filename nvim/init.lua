require("editor-config")
require("plugins")
require("lsp-config")
require("remaps")
require("nerdtree-commenter")
require("telescope-config")
require("treesitter")

-- Add this in your init.lua
vim.cmd [[
  augroup CustomConceal
    autocmd!
    autocmd VimEnter *.json setlocal conceallevel=0
  augroup END
]]
