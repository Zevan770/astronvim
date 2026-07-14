---@type LazySpec
return {
  {
    "mrjones2014/codesettings.nvim",
    -- enabled = false,
    -- these are the default settings just set `opts = {}` to use defaults
    lazy = false,
    opts = {
      ---Look for these config files
      config_file_paths = { ".vscode/settings.json", "codesettings.json", "lspsettings.json" },
      ---Integrate with jsonls to provide LSP completion for LSP settings based on schemas
      jsonls_integration = true,
      ---Set filetype to jsonc when opening a file specified by `config_file_paths`,
      ---make sure you have the jsonc tree-sitter parser installed for highlighting
      jsonc_filetype = true,
      lua_ls_integration = true,
      live_reload = true,
    },
    init = function()
      vim.lsp.config("*", {
        before_init = function(_, config)
          local codesettings = require "codesettings"
          -- Chainsaw(config)
          codesettings.with_local_settings(config.name, config)
          -- Chainsaw(config)
        end,
      })
    end,
    -- event = "VeryLazy",
  },

  -- {
  --   "AstroNvim/astrolsp",
  --   ---@type AstroLspOpts
  --   opts = {
  --     config = {
  --       ["*"] = {
  --         before_init = function(_, config)
  --           local codesettings = require "codesettings"
  --           vim.notify(config.name .. " before_init")
  --           Chainsaw(config)
  --           codesettings.with_local_settings(config.name, config)
  --           Chainsaw(config)
  --         end,
  --       },
  --     },
  --   },
  -- },
}
