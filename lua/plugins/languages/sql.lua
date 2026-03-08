if my_utils.is_windows then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.sql" },
  },
}
