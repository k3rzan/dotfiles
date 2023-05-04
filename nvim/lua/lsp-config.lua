--LSP Zero config
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

--Format on save
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.ts"}, command = "lua vim.lsp.buf.format({async = false})"})
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.tsx"}, command = "lua vim.lsp.buf.format({async = false})"})
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.js"}, command = "lua vim.lsp.buf.format({async = false})"})
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.jsx"}, command = "lua vim.lsp.buf.format({async = false})"})
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.py"}, command = "lua vim.lsp.buf.format({async = false})"})
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.rs"}, command = "lua vim.lsp.buf.format({async = false})"})
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.astro"}, command = "lua vim.lsp.buf.format({async = false})"})
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.lua"}, command = "lua vim.lsp.buf.format({async = false})"})

