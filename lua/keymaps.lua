-- Set leader key
vim.g.mapleader = " "

-- Import windows module
local windows = require("windows")

-- Close Terminal mode with escape
vim.keymap.set("t", "<leader><ESC>", "<C-\\><C-n>", { noremap = true })

-- Global diagnostics (float under cursor)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

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

-- ============================================================================
-- WINDOW MANAGEMENT KEYMAPS
-- ============================================================================
vim.keymap.set("n", "<leader><leader>z", windows.toggle_bottom_panel, { desc = "Toggle bottom terminal panel" })
vim.keymap.set("n", "<leader><leader>b", windows.toggle_main_bottom, { desc = "Toggle focus between main and bottom panel" })
vim.keymap.set("n", "<leader><leader>t", windows.launch_terminal, { desc = "Launch terminal in pinned bottom panel" })
vim.keymap.set("n", "<leader><leader>c", windows.launch_claude, { desc = "Launch Claude in bottom panel" })
vim.keymap.set("n", "<leader><leader>n", windows.next_buffer, { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader><leader>p", windows.prev_buffer, { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader><leader>d", ":bdelete<CR>", { noremap = true, silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader><leader>D", ":bdelete!<CR>", { noremap = true, silent = true, desc = "Force delete buffer" })
