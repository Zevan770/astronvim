if my_utils.is_windows then return {} end
vim.lsp.enable("ruff")
return {
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.basedpyright" },
  { import = "astrocommunity.pack.python.ty" },
  -- { import = "astrocommunity.pack.python.ruff" },
}
