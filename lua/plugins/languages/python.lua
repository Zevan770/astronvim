if vim.fn.has "win32" == 1 then return {} end
return {
  { import = "astrocommunity.pack.python-ruff" },
}
