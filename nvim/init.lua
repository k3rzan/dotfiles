local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
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
