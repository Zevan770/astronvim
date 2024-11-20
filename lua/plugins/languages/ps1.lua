if vim.fn.has "unix" == 1 then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.ps1" },
  },
}
