if vim.fn.has "unix" == 1 then return {} end
return {
  -- {
  --   "AstroNvim/astrocommunity",
  --   { import = "astrocommunity.pack.ps1" },
  -- },
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
  { "PProvost/vim-ps1", ft = "ps1" },
}
