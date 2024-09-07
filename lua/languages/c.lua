if vim.fn.has "win" == 1 or vim.fn.has "android" then return {} end

return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.cpp" },
  },
}
