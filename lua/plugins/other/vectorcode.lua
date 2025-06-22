if true then return {} end
---@type LazySpec
return {
  {
    "Davidyz/VectorCode",
    version = "*", -- optional, depending on whether you're on nightly or release
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "VectorCode", -- if you're lazy-loading VectorCode
    ---@module "vectorcode"
    ---@type VectorCode.Opts
    opts = {
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
        -- query_cb = function() return require("vectorcode.utils").make_surrounding_lines_cb(-1) end,
        run_on_register = false,
      },
      async_backend = "lsp", -- or "lsp"
      exclude_this = true,
      n_query = 1,
      notify = true,
      timeout_ms = 5000,
      on_setup = {
        update = false, -- set to true to enable update when `setup` is called.
        lsp = true,
      },
      sync_log_env_var = false,
    },
    specs = {
      "olimorris/codecompanion.nvim",
      opts = {
        extensions = {
          vectorcode = {
            opts = {
              add_tool = true,
              add_slash_command = true,
              ---@type VectorCode.CodeCompanion.ToolOpts
              tool_opts = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = true,
                auto_submit = { ls = true, query = true },
                ls_on_start = false,
                no_duplicate = true,
                chunk_mode = false,
              },
            },
          },
        },
      },
    },
  },
}
