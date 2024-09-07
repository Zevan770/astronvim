if vim.fn.has "win" == 1 then return {} end

return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.cpp" },
  },
}
