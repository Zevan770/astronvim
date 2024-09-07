if vim.fn.has "android" == 1 then return {} end
return {
  { import = "languages" },
}
