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
      require("nvim-tree").setup({
        view = {
          side = "left", -- left side
          width = 30, -- fixed width
          height = 30,
          preserve_window_proportions = true,
          number = false,
          relativenumber = false,
          git = {
            enable = true,
            ignore = true,
          },
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    keys = {
      {
        "zC",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds (ufo)",
      },
      {
        "zO",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds (ufo)",
      },
    },
    config = function()
      local ok, ufo = pcall(require, "ufo")
      if not ok then
        return
      end
      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          mode = "buffers",
          style_preset = bufferline.style_preset.no_italic, -- or bufferline.style_preset.minimal,
        },
      })
    end,
  },
}
