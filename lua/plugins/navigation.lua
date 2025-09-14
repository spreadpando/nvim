return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "sharkdp/fd",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>f", builtin.current_buffer_fuzzy_find, desc = "Fuzzy find in buffer" },
        { "<leader>ff", builtin.find_files, desc = "Find files" },
        { "<leader>fg", builtin.live_grep, desc = "Live grep project" },
        { "<leader>fb", builtin.buffers, desc = "Find buffers" },
        { "<leader>fh", builtin.help_tags, desc = "Help tags" },
        -- Diagnostics / LSP
        { "<leader>fd", builtin.diagnostics, desc = "Project diagnostics" },
        { "<leader>fs", builtin.lsp_document_symbols, desc = "Document symbols" },
        { "<leader>fS", builtin.lsp_dynamic_workspace_symbols, desc = "Workspace symbols" },
        { "<leader>fr", builtin.lsp_references, desc = "Find references" },
        { "<leader>fi", builtin.lsp_implementations, desc = "Find implementations" },
      }
    end,
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
        "<leader><leader>e",
        "<cmd>NvimTreeToggle<cr>",
        desc = "Toggle File Explorer",
        mode = { "n", "v", "i" },
      },
      {
        "<leader>e",
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
}
