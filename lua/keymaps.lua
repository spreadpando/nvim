-- Set leader key
vim.g.mapleader = " "
-- Close Terminal mode with escape
vim.keymap.set("t", "<Leader><ESC>", "<C-\\><C-n>", { noremap = true })
-- Go to next buffer
vim.keymap.set("n", "<leader><leader>n", ":bnext<CR>", { noremap = true, silent = true })
-- Go to previous buffer (optional)
vim.keymap.set("n", "<leader><leader>p", ":bprevious<CR>", { noremap = true, silent = true })
-- Show diagnostics for current line
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float()
end, { desc = "Show line diagnostics" })

  -- Buffer-local LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local bufmap = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true })
      end
      bufmap("n", "K", vim.lsp.buf.hover)
      bufmap("n", "gd", vim.lsp.buf.definition)
      bufmap("n", "gt", vim.lsp.buf.type_definition)
      bufmap("n", "gD", vim.lsp.buf.declaration)
      bufmap("n", "<C-k>", vim.lsp.buf.signature_help)
      bufmap("n", "grn", vim.lsp.buf.rename)
      bufmap("n", "gra", vim.lsp.buf.code_action)
      bufmap("n", "[d", vim.diagnostic.goto_prev)
      bufmap("n", "]d", vim.diagnostic.goto_next)
    end,
  })
