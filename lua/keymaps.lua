-- Set leader key
vim.g.mapleader = " "
vim.keymap.set("t", "<Leader><ESC>", "<C-\\><C-n>", { noremap = true })
-- Go to next buffer
vim.keymap.set("n", "<leader><leader>n", ":bnext<CR>", { noremap = true, silent = true })
-- Go to previous buffer (optional)
vim.keymap.set("n", "<leader><leader>p", ":bprevious<CR>", { noremap = true, silent = true })
