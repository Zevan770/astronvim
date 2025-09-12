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
                tools = { "cmd_runner", "editor", "files", "mcp" },
              },
            },
          },
          slash_commands = {
            ["buffer"] = {
              opts = {
                contains_code = true,
                provider = "snacks",
              },
            },
            ["fetch"] = {
              opts = {
                adapter = "jina",
              },
            },
            ["file"] = {
              opts = {
                contains_code = true,
                max_lines = 1000,
                provider = "snacks",
              },
            },
            ["help"] = {
              opts = {
                contains_code = false,
                provider = "snacks",
              },
            },
            ["now"] = {
              opts = {
                contains_code = false,
              },
            },
            ["symbols"] = {
              opts = {
                contains_code = true,
                provider = "snacks",
              },
            },
            ["terminal"] = {
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
                default = "gpt-4.1",
              },
            },
          })
        end,
        claude37 = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-3.7-sonnet",
              },
            },
          })
        end,
      },

      extensions = {
        spinner = {},
      },
    },
  },

}
