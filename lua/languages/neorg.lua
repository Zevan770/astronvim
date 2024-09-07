if vim.fn.has "win" then return {} end

return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.note-taking.neorg" },
  },
}
