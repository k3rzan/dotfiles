--Nvim Tree
require "nvim-tree".setup({})

vim.keymap.set("n", "<Leader>nf", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<Leader>nt", ":NvimTreeToggle<CR>")
