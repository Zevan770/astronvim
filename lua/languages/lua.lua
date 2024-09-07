if vim.fn.has "android" then return {} end
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.neovim-lua-development.lazydev-nvim" },
  },
}
