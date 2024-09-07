if vim.fn.has "unix" or vim.fn.has "android" then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.ps1" },
  },
}
