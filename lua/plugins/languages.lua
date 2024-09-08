if vim.fn.has "android" == 1 or vim.g.vscode == 1 then return {} end
return {
  { import = "languages" },
}
