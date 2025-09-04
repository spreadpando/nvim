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
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
        require("mcphub").setup({
          --- `mcp-hub` binary related options-------------------
          config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
          port = 37373, -- The port `mcp-hub` server listens to
          shutdown_delay = 5 * 60 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 5 minutes)
          use_bundled_binary = false, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
          mcp_request_timeout = 60000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks
          global_env = function(context)
            return {
              ALLOWED_DIRECTORY = context.cwd
            }
          end
          ,-- Global environment variables available to all MCP servers (can be a table or a function returning a table)
          workspace = {
              enabled = true, -- Enable project-local configuration files
              look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" }, -- Files to look for when detecting project boundaries (VS Code format supported)
              reload_on_dir_changed = true, -- Automatically switch hubs on DirChanged event
              port_range = { min = 40000, max = 41000 }, -- Port range for generating unique workspace ports
              get_port = nil, -- Optional function returning custom port number. Called when generating ports to allow custom port assignment logic
          },

          ---Chat-plugin related options-----------------
          auto_approve = false, -- Auto approve mcp tool calls
          auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
          extensions = {
              avante = {
                  make_slash_commands = true, -- make /slash commands from MCP server prompts
              }
          },

          --- Plugin specific options-------------------
          native_servers = {}, -- add your custom lua native servers here
          builtin_tools = {
              edit_file = {
                  parser = {
                      track_issues = true,
                      extract_inline_content = true,
                  },
                  locator = {
                      fuzzy_threshold = 0.8,
                      enable_fuzzy_matching = true,
                  },
                  ui = {
                      go_to_origin_on_complete = true,
                      keybindings = {
                          accept = ".",
                          reject = ",",
                          next = "n",
                          prev = "p",
                          accept_all = "ga",
                          reject_all = "gr",
                      },
                  },
              },
          },
          ui = {
              window = {
                  width = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                  height = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                  align = "center", -- "center", "top-left", "top-right", "bottom-left", "bottom-right", "top", "bottom", "left", "right"
                  relative = "editor",
                  zindex = 50,
                  border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
              },
              wo = { -- window-scoped options (vim.wo)
                  winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
              },
          },
          json_decode = nil, -- Custom JSON parser function (e.g., require('json5').parse for JSON5 support)
          on_ready = function(hub)
              -- Called when hub is ready
          end,
          on_error = function(err)
              -- Called on errors
          
          end,

          -- Auto-restart MCPHub when directory changes
          on_dir_changed = function()
            local hub = require("mcphub")
            if hub.is_running() then
              hub.stop_all_hubs()
            end
            hub.start_hub()
          end,
          
          log = {
              level = vim.log.levels.WARN,
              to_file = false,
              file_path = nil,
              prefix = "MCPHub",
          },

          -- Global environment variables available to all MCP servers
          -- Can be a table or a function(context) -> table
          global_env = {},
      })
    end,
  },
}
