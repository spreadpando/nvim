return {
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      vim.opt.relativenumber = true
      vim.opt.number = true
      vim.opt.termguicolors = true
      vim.cmd("colorscheme pando")
      -- get list of colorscheme files
      local colors_dir = vim.fn.stdpath("config") .. "/colors"
      local themes = {}

      for _, file in ipairs(vim.fn.readdir(colors_dir)) do
        if file:sub(-4) == ".vim" and not file:find("-light") then
          table.insert(themes, file:sub(1, -5)) -- strip ".vim"
        end
      end

      require("themery").setup({
        themes = themes,
      })
    end,
  },
}
