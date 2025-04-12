if vim.fn.has "unix" == 1 then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.ps1" },
  },
  {
    "TheLeoP/powershell.nvim",
    ft = "ps1",
    ---@type powershell.user_config
    opts = {
      bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
    },
  },
}
