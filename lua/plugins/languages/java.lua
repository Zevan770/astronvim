-- if vim.fn.has "win" or vim.fn.has "android" then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.java" },
    -- { import = "astrocommunity.lsp.nvim-java" },
  },
}
