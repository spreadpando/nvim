-- Set leader key
vim.g.mapleader = " "
-- Close Terminal mode with escape
vim.keymap.set("t", "<leader><ESC>", "<C-\\><C-n>", { noremap = true })
-- Go to next buffer
vim.keymap.set("n", "<leader><leader>n", ":bnext<CR>", { noremap = true, silent = true })
-- Go to previous buffer (optional)
vim.keymap.set("n", "<leader><leader>p", ":bprevious<CR>", { noremap = true, silent = true })

-- Global diagnostics (float under cursor)
vim.keymap.set("n", "<leader><leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Buffer-local LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    -- Hover & signature
    bufmap("n", "K", vim.lsp.buf.hover, "Hover docs")
    bufmap("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Go-to navigation
    bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
    bufmap("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
    bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")

    -- Refactor & actions
    bufmap("n", "grn", vim.lsp.buf.rename, "Rename symbol")
    bufmap("n", "gra", vim.lsp.buf.code_action, "Code action")

    -- Diagnostics navigation
    bufmap("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    bufmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  end,
})
