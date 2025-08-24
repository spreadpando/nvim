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

-- Load keymaps
require("keymaps")
-- Load plugins
require("lazy").setup("plugins")
