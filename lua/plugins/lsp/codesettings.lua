return {
  {
    "mrjones2014/codesettings.nvim",
    enabled = false,
    -- these are the default settings just set `opts = {}` to use defaults
    opts = {
      ---Look for these config files
      config_file_paths = { ".vscode/settings.json", "codesettings.json", "lspsettings.json" },
      ---Integrate with jsonls to provide LSP completion for LSP settings based on schemas
      jsonls_integration = true,
      ---Set filetype to jsonc when opening a file specified by `config_file_paths`,
      ---make sure you have the jsonc tree-sitter parser installed for highlighting
      jsonc_filetype = true,
      lua_ls_integration = false,
    },
    ft = { "json", "jsonc", "lua" },
    -- event = "VeryLazy",
  },
}
