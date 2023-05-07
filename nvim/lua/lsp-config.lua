--Format on save
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.ts" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.tsx" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.js" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.jsx" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.py" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.rs" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.astro" }, command = "lua vim.lsp.buf.format({async = false})" })
vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.lua" }, command = "lua vim.lsp.buf.format({async = false})" })
