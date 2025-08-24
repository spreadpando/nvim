return {
  -- Treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "sharkdp/fd",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader><leader>E",
        "<cmd>NvimTreeToggle<cr>",
        desc = "Toggle File Explorer",
        mode = { "n", "v", "i" },
      },
      {
        "<leader><leader>e",
        "<cmd>NvimTreeFocus<cr>",
        desc = "Focus File Explorer",
      },
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "slope",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
        },
      })
    end,
  },
  {
    "Davidyz/VectorCode",
    version = "*", -- v0.7.11, https://github.com/Davidyz/VectorCode/releases/tag/0.7.11
    build = "uv tool upgrade vectorcode", -- This helps keeping the CLI up-to-date
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "VectorCode", -- if you're lazy-loading VectorCode
    opts = {
      cli_path = "$HOME/.local/share/uv/tools/vectorcode/bin/vectorcode",
      -- other opts
    },
  },
}
