if vim.fn.has "win" or vim.fn.has "android" then return {} end

return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.bash" },
  },
}
