if vim.fn.has "win32" == 1 then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.sql" },
  },
}
