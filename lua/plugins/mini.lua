return {
  {
    "nvim-mini/mini.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "lewis6991/gitsigns.nvim",
    },
    version = false,
    lazy = VeryLazy,
    config = function()
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })
      require("mini.move").setup()
      require("mini.statusline").setup()
      require("mini.indentscope").setup({
        symbol = "│",
      })
      require("mini.diff").setup()
      -- 🔧 FIX: define mini_map before using it
      local mini_map = require("mini.map")

      mini_map.setup({
        symbols = {
          encode = mini_map.gen_encode_symbols.dot("4x2"),
        },
        integrations = {
          mini_map.gen_integration.builtin_search(),
          mini_map.gen_integration.diff(),
          mini_map.gen_integration.diagnostic(),
          mini_map.gen_integration.gitsigns(),
        },
        window = {
          focusable = false,
          side = "right",
          width = 10,
          winblend = 15,
        },
      })
    end,
    keys = {
      {
        "<leader><leader>m",
        function()
          require("mini.map").toggle()
        end,
        desc = "Toggle MiniMap",
      },
    },
  },
}
