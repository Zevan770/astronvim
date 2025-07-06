-- if true then return {} end
---@type LazySpec
return {
  {
    "Davidyz/VectorCode",
    version = "0.7.4", -- optional, depending on whether you're on nightly or release
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "VectorCode", -- if you're lazy-loading VectorCode
    opts = function()
      ---@module "vectorcode"
      ---@type VectorCode.Opts
      return {
        cli_cmds = {
          vectorcode = "vectorcode",
        },
        ---@type VectorCode.RegisterOpts
        async_opts = {
          debounce = 10,
          events = { "BufWritePost", "InsertEnter", "BufReadPost" },
          exclude_this = true,
          n_query = 1,
          notify = true,
          query_cb = require("vectorcode.utils").make_surrounding_lines_cb(-1),
          run_on_register = false,
        },
        async_backend = "lsp", -- or "lsp"
        exclude_this = true,
        n_query = 1,
        notify = true,
        timeout_ms = 5000,
        on_setup = {
          update = false, -- set to true to enable update when `setup` is called.
          -- lsp = true,
        },
        sync_log_env_var = false,
      }
    end,
    specs = {
      "olimorris/codecompanion.nvim",
      dependencies = {
        "Davidyz/VectorCode",
      },
      opts = {
        extensions = {
          vectorcode = {
            ---@diagnostic disable: missing-fields
            ---@type VectorCode.CodeCompanion.ExtensionOpts
            opts = {
              tool_group = {
                -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
                enabled = true,
                -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
                -- if you use @vectorcode_vectorise, it'll be very handy to include
                -- `file_search` here.
                extras = {},
                collapse = false, -- whether the individual tools should be shown in the chat
              },
              ---@type VectorCode.CodeCompanion.ToolOpts
              tool_opts = {
                ---@type VectorCode.CodeCompanion.LsToolOpts
                -- ls = {},
                ---@type VectorCode.CodeCompanion.VectoriseToolOpts
                vectorise = {},
                ---@type VectorCode.CodeCompanion.QueryToolOpts
                query = {
                  max_num = { chunk = -1, document = -1 },
                  default_num = { chunk = 50, document = 10 },
                  include_stderr = false,
                  -- use_lsp = true,
                  no_duplicate = true,
                  chunk_mode = false,
                  ---@type VectorCode.CodeCompanion.SummariseOpts
                  summarise = {
                    ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                    enabled = false,
                    adapter = nil,
                    query_augmented = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
