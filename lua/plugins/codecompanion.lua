return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "ravitemer/codecompanion-history.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "Davidyz/VectorCode" },
      { "j-hui/fidget.nvim" },
      { "ravitemer/mcphub.nvim" },
    },
    after = "mcphub.nvim", -- ensures setup runs after MCPHub
    keys = {
      {
        "<C-a>",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Format file",
        mode = { "n", "v", "i" },
      },
      {
        "<leader><leader>a",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "CodeCompanionChat Toggle",
        mode = "n",
      },
      {
        "<leader><leader>a",
        "<cmd>CodeCompanionChat Add<cr>",
        desc = "Add Selection to Chat Context",
        mode = "v",
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = {
            name = "openai",
            model = "gpt-5-mini",
          },
          tools = {
            opts = {
              auto_submit_errors = true, -- Send any errors to the LLM automatically?
              auto_submit_success = true, -- Send any successful output to the LLM automatically?
              default_tools = {
                -- TODO Add default tools for chat
                "mcp__filesystem",
                "mcp__neovim",
                "mcp__mcp_hub",
                "mcp__sequentialthinking",
                "mcp__memory",
                "mcp__context7",
                "vectorcode_toolbox",
                "next_edit_suggestions",
                "insert_edit_into_file",
                "grep_search",
              },
            },
          },
        },
        inline = {
          adapter = "copilot",
          keymaps = {
            accept_change = { modes = { n = "gda" } }, -- DiffAccept
            reject_change = { modes = { n = "gdr" } }, -- DiffReject
            always_accept = { modes = { n = "gdy" } }, -- DiffYolo
          },
        },
      },

      display = {
        chat = {
          window = {
            width = 0.25,
            position = "right",
            sticky = true,
          },
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface (auto resolved to a valid picker)
            picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
            ---Optional filter function to control which chats are shown when browsing
            chat_filter = nil, -- function(chat_data) return boolean end
            -- Customize picker keymaps (optional)
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              ---Adapter for generating titles (defaults to current chat adapter)
              adapter = nil, -- "copilot"
              ---Model for generating titles (defaults to current chat model)
              model = nil, -- "gpt-4o"
              ---Number of user prompts after which to refresh the title (0 to disable)
              refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
              ---Maximum number of times to refresh the title (default: 3)
              max_refreshes = 3,
              format_title = function(original_title)
                -- this can be a custom function that applies some custom
                -- formatting to the title.
                return original_title
              end,
            },
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,

            -- Summary system
            summary = {
              -- Keymap to generate summary for current chat (default: "gcs")
              create_summary_keymap = "gcs",
              -- Keymap to browse summaries (default: "gbs")
              browse_summaries_keymap = "gbs",

              generation_opts = {
                adapter = nil, -- defaults to current chat adapter
                model = nil, -- defaults to current chat model
                context_size = 90000, -- max tokens that the model supports
                include_references = true, -- include slash command content
                include_tool_outputs = true, -- include tool execution results
                system_prompt = nil, -- custom system prompt (string or function)
                format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
              },
            },

            -- -- Memory system (requires VectorCode CLI)
            memory = {
              -- Automatically index summaries when they are generated
              auto_create_memories_on_summary_generation = true,
              -- Path to the VectorCode executable
              vectorcode_exe = "/home/aphyd/.local/share/uv/tools/vectorcode/bin/vectorcode",
              -- Tool configuration
              tool_opts = {
                -- Default number of memories to retrieve
                default_num = 10,
              },
              -- Enable notifications for indexing progress
              notify = true,
              -- Index all existing memories on startup
              -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
              index_on_startup = false,
            },
          },
        },
        vectorcode = {
          enabled = true,
          opts = {
            cli_path = "/home/aphyd/.local/share/uv/tools/vectorcode/bin/vectorcode",
            tool_group = {
              enabled = true,
              extras = {},
              collapse = false,
            },
            tool_opts = {
              ["*"] = {},
              ls = {},
              vectorise = {},
              query = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = true,
                no_duplicate = true,
                chunk_mode = false,
                summarise = {
                  enabled = false,
                  adapter = nil,
                  query_augmented = true,
                },
              },
              files_ls = {},
              files_rm = {},
            },
          },
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = true, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true, -- Show tool results directly in chat buffer
            format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            -- MCP Resources
            make_vars = true, -- Convert MCP resources to #variables for prompts
            -- MCP Prompts
            make_slash_commands = true, -- Add MCP prompts as /slash commands
          },
        },
      },
    },

    init = function()
      vim.g.codecompanion_auto_tool_mode = true

      require("plugins.codecompanion.fidget-spinner"):init()
    end,
  },
}
