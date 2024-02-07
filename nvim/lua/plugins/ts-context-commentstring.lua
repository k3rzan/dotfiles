-- Toggle in VISUAL mode
vim.keymap.set('x', '<leader>cc', '<Plug>(comment_toggle_linewise_visual)')
require('ts_context_commentstring').setup {}
