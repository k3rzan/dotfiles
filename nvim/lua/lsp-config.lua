--Format on save
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.ts" }, command = "lua vim.lsp.buf.format({async = false})" })
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.tsx" }, command = "lua vim.lsp.buf.format({async = false})" })
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.js" }, command = "lua vim.lsp.buf.format({async = false})" })
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.jsx" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*" }, command = "lua vim.lsp.buf.format({async = false})" })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
