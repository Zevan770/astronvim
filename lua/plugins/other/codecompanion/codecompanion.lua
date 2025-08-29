---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
      "CodeCompanionCmd",
    },
    specs = {
      -- {
      --   -- Edgy integration
      --   "folke/edgy.nvim",
      --   optional = true,
      --   opts = function(_, opts)
      --     opts.left = opts.left or {}
      --     table.insert(opts.left, {
      --       ft = "codecompanion",
      --       size = { width = 50 },
      --     })
      --   end,
      -- },
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          maps.n["<Leader>c"] = { desc = " Copilot Chat" }
          maps.v["<Leader>c"] = maps.n["<Leader>c"]
        end,
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>cp", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion - Prompt Actions" },
      {
        "<leader>ca",
        function()
          vim.cmd "CodeCompanionChat Toggle"
          vim.cmd "startinsert"
        end,
        desc = "Code Companion - Toggle",
        mode = { "n", "v" },
      },
      -- Some common usages with visual mode
      { "<leader>ce", "<cmd>CodeCompanion /explain<cr>", desc = "Code Companion - Explain code", mode = "v" },
      { "<leader>cf", "<cmd>CodeCompanion /fix<cr>", desc = "Code Companion - Fix code", mode = "v" },
      { "<leader>cl", "<cmd>CodeCompanion /lsp<cr>", desc = "Code Companion - Explain LSP diagnostic", mode = { "n", "v" } },
      { "<leader>ct", "<cmd>CodeCompanion /tests<cr>", desc = "Code Companion - Generate unit test", mode = "v" },
      { "<leader>cm", "<cmd>CodeCompanion /commit<cr>", desc = "Code Companion - Git commit message" },
      -- Custom prompts
      { "<leader>cM", "<cmd>CodeCompanion /staged-commit<cr>", desc = "Code Companion - Git commit message (staged)" },
      { "<leader>cd", "<cmd>CodeCompanion /inline-doc<cr>", desc = "Code Companion - Inline document code", mode = "v" },
      { "<leader>cD", "<cmd>CodeCompanion /doc<cr>", desc = "Code Companion - Document code", mode = "v" },
      { "<leader>cr", "<cmd>CodeCompanion /refactor<cr>", desc = "Code Companion - Refactor code", mode = "v" },
      { "<leader>cR", "<cmd>CodeCompanion /review<cr>", desc = "Code Companion - Review code", mode = "v" },
      { "<leader>cn", "<cmd>CodeCompanion /naming<cr>", desc = "Code Companion - Better naming", mode = "v" },
      { "<leader>ci", ":CodeCompanion<CR>", desc = "Run CodeCompanion", mode = { "n", "v" }, remap = true, silent = true},
      { "<leader>co", "<cmd>CodeCompanionChat<CR>", desc = "Open chat", mode = { "n", "v" } },
      { "<leader>c;", ":CodeCompanionCmd ", desc = "Run command" },
      -- Quick chat
      {
        "<leader>cq",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then vim.cmd("CodeCompanion " .. input) end
        end,
        desc = "Code Companion - Quick chat",
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
      require("utils.codecompanion.signcolumn").setup()
    end,
    -- see /home/hw770/.local/share/nvim/lazy/codecompanion.nvim/lua/codecompanion/config.lua:10
    opts = {
      opts = { language = "Chinese" },
      display = {
        chat = {
          show_settings = false,
        },
      },
      strategies = {
        chat = {
          adapter = "copilot",
          tools = {
            opts = {
              default_tools = {
                -- "vectorcode_toolbox",
                "read_file",
              },
              folds = {
                enabled = false,
              },
            },
            groups = {
              ["all_in_one"] = {
                description = "Everything but the kitchen sink (we're working on that)",
                system_prompt = "You are an agent, please keep going until the user's query is completely resolved, before ending your turn and yielding back to the user. Only terminate your turn when you are sure that the problem is solved. If you are not sure about file content or codebase structure pertaining to the user's request, use your tools to read files and gather the relevant information: do NOT guess or make up an answer. You MUST plan extensively before each function call, and reflect extensively on the outcomes of the previous function calls. DO NOT do this entire process by making function calls only, as this can impair your ability to solve the problem and think insightfully.",
                tools = {
                  "cmd_runner",
                  "editor",
                  "files",
                  "mcp",
                },
              },
            },
          },
          slash_commands = {
            ["buffer"] = {
              callback = "strategies.chat.slash_commands.buffer",
              description = "Insert open buffers",
              opts = {
                contains_code = true,
                provider = "snacks",
              },
            },
            ["fetch"] = {
              callback = "strategies.chat.slash_commands.fetch",
              description = "Insert URL contents",
              opts = {
                adapter = "jina",
              },
            },
            ["file"] = {
              callback = "strategies.chat.slash_commands.file",
              description = "Insert a file",
              opts = {
                contains_code = true,
                max_lines = 1000,
                provider = "snacks",
              },
            },
            ["help"] = {
              callback = "strategies.chat.slash_commands.help",
              description = "Insert content from help tags",
              opts = {
                contains_code = false,
                provider = "snacks",
              },
            },
            ["now"] = {
              callback = "strategies.chat.slash_commands.now",
              description = "Insert the current date and time",
              opts = {
                contains_code = false,
              },
            },
            ["symbols"] = {
              callback = "strategies.chat.slash_commands.symbols",
              description = "Insert symbols for a selected file",
              opts = {
                contains_code = true,
                provider = "snacks",
              },
            },
            ["terminal"] = {
              callback = "strategies.chat.slash_commands.terminal",
              description = "Insert terminal output",
              opts = {
                contains_code = false,
              },
            },
          },
          roles = {
            llm = function(adapter)
              local model_name = ""
              if adapter.schema and adapter.schema.model and adapter.schema.model.default then
                local model = adapter.schema.model.default
                if type(model) == "function" then model = model(adapter) end
                model_name = "(" .. model .. ")"
              end
              return "  " .. adapter.formatted_name .. model_name
            end,
            user = " User",
          },
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
        },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-5-mini",
              },
            },
          })
        end,
        claude35 = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-3.5-sonnet",
              },
            },
          })
        end,
      },

      extensions = {
        mcphub = {
          enabled = true,
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
            make_vars = true, -- make chat #variables from MCP server resources
            make_slash_commands = true, -- make /slash_commands from MCP server prompts
          },
        },
        spinner = {},
        history = {
          enabled = true,
          -- ~/.local/share/nvim/lazy/codecompanion-history.nvim/doc/codecompanion-history.txt:126
          ---@module "codecompanion._extensions.history"
          ---@type CodeCompanion.History.Opts
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "<localleader>h",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "<localleader>w",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface ("telescope" or "snacks" or "default")
            picker = "snacks",
            -- Automatically generate titles for new chats
            auto_generate_title = true,
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,

            --#region summary
            summary = {
              create_summary_keymap = "<localleader>sc",
              browse_summaries_keymap = "<localleader>sb",
              preview_summary_keymap = "<localleader>sp",

              generation_opts = {
                -- Use specific adapter for summaries (optional)
                adapter = nil, -- defaults to current chat adapter
                -- Use specific model for summaries (optional)
                model = nil, -- defaults to current chat model
                -- Context size for summarization (default: 90000)
                context_size = 90000,
                -- Include slash command content (default: true)
                include_references = true,
                -- Include tool outputs (default: true)
                include_tool_outputs = true,
                -- Custom system prompt (optional)
                system_prompt = nil,
              },
            },
            --#endregion
          },
        },
      },
    },
  },

  {
    "ravitemer/codecompanion-history.nvim",
    dependencies = {
      "olimorris/codecompanion.nvim",
    },
    keys = {
      {
        "<leader>ch",
        "<cmd>CodeCompanionHistory<cr>",
        desc = "Code Companion - History",
      },
    },
  },
}
