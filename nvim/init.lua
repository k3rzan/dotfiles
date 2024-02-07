require("options")
require("plugins.init")
require("lsp-config")
require("remaps")

-- Add this in your init.lua
vim.cmd [[
  augroup CustomConceal
    autocmd!
    autocmd VimEnter *.json setlocal conceallevel=0
  augroup END
]]
