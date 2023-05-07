vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<n>", "nzzzv")
vim.keymap.set("n", "<n>", "nzzzv")
-- Toggle in VISUAL mode
vim.keymap.set('x', '<leader>cc', '<Plug>(comment_toggle_linewise_visual)')
