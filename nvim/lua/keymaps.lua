--spacebar leader key
vim.g.mapleader = " "
vim.keymap.set('i', '<S-Tab>', '<C-d>')
vim.keymap.set("n","<leader>n", ":bn<cr>")
vim.keymap.set("n","<leader>p", ":bp<cr>")
vim.keymap.set("n","<leader>x", ":bd<cr>")
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>v", '"+p')
vim.keymap.set("v", "<leader>v", '"+p')
