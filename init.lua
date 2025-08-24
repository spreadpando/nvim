-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- LSP diagnostics configuration
vim.diagnostic.config({
  virtual_text = false, -- Don't show error text inline
  signs = true, -- Show error signs in gutter
  underline = true, -- Show underlines for errors
  update_in_insert = false,
  severity_sort = true,
})

--   -- Buffer-local LSP keymaps
-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(ev)
--       local bufmap = function(mode, lhs, rhs)
--         vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true })
--       end
--       bufmap("n", "K", vim.lsp.buf.hover)
--       bufmap("n", "gd", vim.lsp.buf.definition)
--       bufmap("n", "grn", vim.lsp.buf.rename)
--       bufmap("n", "gra", vim.lsp.buf.code_action)
--       bufmap("n", "[d", vim.diagnostic.goto_prev)
--       bufmap("n", "]d", vim.diagnostic.goto_next)
--     end,
--   })

-- Bootstrap lazy.nvim (package manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("keymaps")
-- Load plugins
require("lazy").setup("plugins")
