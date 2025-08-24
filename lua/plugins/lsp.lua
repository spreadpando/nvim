return {
  -- Mason LSP configuration
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "eslint",
        "lua_ls",
        "vtsls",
        "vue_ls",
        "cssls",
        "css_variables",
        "cssmodules_ls",
        "html",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("plugins.lsp.config-vue-lsp")()
    end,
  },
  -- Conform formatter configuration
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader><leader>f",
        function()
          require("conform").format({ bufnr = 0 })
        end,
        desc = "Format file",
        mode = "n",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "eslint_", "prettierd" },
          typescript = { "eslint_d", "prettierd" },
          javascriptreact = { "eslint_d", "prettierd" },
          typescriptreact = { "eslint_d", "prettier" },
          vue = { "eslint_d", "prettier" },
          json = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          html = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}
