--Format on save
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.ts" }, command = "lua vim.lsp.buf.format({async = false})" })
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.tsx" }, command = "lua vim.lsp.buf.format({async = false})" })
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.js" }, command = "lua vim.lsp.buf.format({async = false})" })
-- vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.jsx" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.py" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.rs" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre",
	{ pattern = { "*.astro" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.lua" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_user_command('LspRename', function()
	vim.lsp.buf.rename()
end, {})
vim.keymap.set("n", "<leader>r", function()
	vim.cmd([[LspRename]])
	vim.cmd([[normal! <C-L>]])
end, { silent = true })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
