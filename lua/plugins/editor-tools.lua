return {
  { "nvzone/volt", lazy = true },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        vue = {
          "<!-- %s -->",
          script_element = "// %s",
          style_element = "/* %s */",
        },
      },
    },
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      -- icons
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-icons.md
      require("mini.icons").setup()
      -- diff
      -- -- https://github.com/echasovski/mini.nvim/blob/main/readmes/mini-diff.md

      require("mini.diff").setup({
        -- Use Git for the diff source
        source = require("mini.diff").gen_source.git(),

        -- How to display the diff
        view = {
          style = "sign", -- show + / - in the sign column
          folds = true, -- optionally fold unchanged regions
        },

        -- Keymaps for diff navigation and preview
        mappings = {
          -- Jump to next/prev diff hunk
          goto_next = "]c",
          goto_prev = "[c",

          -- Show diff preview of the buffer
          show = "<leader>gd",
        },
      })

      -- git
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-git.md
      require("mini.git").setup()
      -- -- statusline
      -- -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md
      -- require("mini.statusline").setup()
      -- -- tabline
      -- -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-tabline.md
      -- require("mini.tabline").setup()
      -- move lines up and down
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
      require("mini.move").setup()
      -- comment lines
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
      require("mini.comment").setup({})
      -- pairs
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
      require("mini.pairs").setup()
      -- surround
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
      require("mini.surround").setup({
        mappings = {
          add = "gza", -- Add surrounding
          delete = "gzd", -- Delete surrounding
          find = "gzf", -- Find right surrounding
          find_left = "gzF", -- Find left surrounding
          highlight = "gzh", -- Highlight surrounding
          replace = "gzr", -- Replace surrounding
          update_n_lines = "gzn", -- Update n_lines
        },
      })
      -- use square brackets to move between sections
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
      require("mini.bracketed").setup()
      -- show next key clues
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-clue.md
      require("mini.clue").setup()
      -- indent scope
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md
      require("mini.indentscope").setup()
    end,
  },
}
