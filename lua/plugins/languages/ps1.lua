---@diagnostic disable: missing-fields
if vim.fn.has "unix" == 1 then return {} end
return {
  { import = "astrocommunity.pack.ps1" },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      servers = {
        -- "powershell_es",
      },
    },
  },
  {
    "TheLeoP/powershell.nvim",
    -- ft = "ps1",
    ---@type powershell.user_config
    opts = {
      capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
      bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
      init_options = {
        enableProfileLoading = false,
      },
      settings = {
        enableProfileLoading = false,
      },
    },
  },
}
