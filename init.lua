-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.termguicolors = true

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

-- Load native vim keymaps and overrides.
-- (plugin specific keymaps are in each plugin's keys array)
require("keymaps")
-- Load plugins
require("lazy").setup("plugins")
