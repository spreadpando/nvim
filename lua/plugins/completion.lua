return { -- Blink completion configuration
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "enter" },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true } },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning", prebuilt_binaries = { force_version = "v1.6.0" } },
    },
    opts_extend = { "sources.default" },
  },
  { "github/copilot.vim" },
  -- {
  -- 	"milanglacier/minuet-ai.nvim",
  -- 	dependencies = {
  -- 		"nvim-lua/plenary.nvim",
  -- 		"saghen/blink.cmp",
  -- 	},
  -- 	config = function()
  -- 		require("minuet").setup({
  -- 			provider = 'gemini',
  -- 			virtualtext = {
  -- 				auto_trigger_ft = {'*'},
  -- 				auto_trigger_ignore_ft = {},
  -- 				keymap = {
  -- 					-- accept whole completion
  -- 					accept = "<A-A>",
  -- 					-- accept one line
  -- 					accept_line = "<A-a>",
  -- 					-- accept n lines (prompts for number)
  -- 					-- e.g. "A-z 2 CR" will accept 2 lines
  -- 					accept_n_lines = "<A-z>",
  -- 					-- Cycle to prev completion item, or manually invoke completion
  -- 					prev = "<A-[>",
  -- 					-- Cycle to next completion item, or manually invoke completion
  -- 					next = "<A-]>",
  -- 					dismiss = "<A-e>",
  -- 				},
  -- 			},
  -- 		})
  -- 	end,
  -- },
}
